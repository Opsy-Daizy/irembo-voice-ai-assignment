-- One row per voice session; links users + AI metrics + application outcome + KPI flags
CREATE OR REPLACE TABLE fact_voice_ai_sessions AS
SELECT
  vs.session_id,
  vs.user_id,

  -- session timing: dataset provides created_at + total_duration_sec
  vs.session_created_at AS session_start_ts,
  vs.session_created_at + (vs.total_duration_sec * INTERVAL '1 second') AS session_end_ts,
  vs.total_duration_sec AS session_duration_seconds,

  vs.channel AS session_channel,        -- voice
  vs.language,
  vs.final_outcome,
  vs.transfer_reason,
  CASE WHEN vs.final_outcome = 'transferred' THEN 1 ELSE 0 END AS is_transferred,

  -- user attributes (accessibility segments)
  u.region,                             -- rural / urban
  u.disability_flag,                    -- yes / no
  u.first_time_digital_user,            -- yes / no
  CASE WHEN u.disability_flag = 'yes' THEN 1 ELSE 0 END AS is_user_with_disability,
  CASE WHEN u.first_time_digital_user = 'yes' THEN 1 ELSE 0 END AS is_first_time_digital_user,

  -- AI metrics
  m.avg_asr_confidence,
  m.avg_intent_confidence,
  m.misunderstanding_rate,
  m.silence_rate,
  m.recovery_success,
  m.escalation_flag,
  CASE WHEN m.escalation_flag = 'yes' THEN 1 ELSE 0 END AS is_escalated,

  -- turns (from turn table)
  COALESCE(t.turn_count, vs.total_turns) AS turn_count,
  t.avg_turn_intent_confidence,
  t.avg_turn_asr_confidence,
  t.turn_error_count,
  t.turn_error_rate,

  -- application outcome (if linked by session_id)
  a.application_id,
  a.service_code,
  a.channel AS application_channel,      -- voice/web/ussd
  a.status AS application_status,
  a.time_to_submit_sec,
  a.submitted_at,

  -- Core KPI flags
  CASE WHEN vs.final_outcome = 'completed' THEN 1 ELSE 0 END AS is_session_completed,
  CASE WHEN a.application_id IS NOT NULL THEN 1 ELSE 0 END AS is_application_created,
  CASE WHEN a.status = 'completed' THEN 1 ELSE 0 END AS is_application_completed,

  -- Drop-off definition (practical for dashboards)
  CASE
    WHEN vs.final_outcome IN ('abandoned','transferred') AND a.application_id IS NULL THEN 1
    ELSE 0
  END AS dropoff_flag,

  -- "Error" definition field (Part 4-ready; can be tuned)
  CASE
    WHEN COALESCE(se.has_any_turn_error, 0) = 1 THEN 1
    WHEN COALESCE(m.misunderstanding_rate, 0) >= 0.20 THEN 1
    WHEN COALESCE(m.avg_intent_confidence, 1) < 0.60 THEN 1
    WHEN COALESCE(m.silence_rate, 0) >= 0.20 THEN 1
    ELSE 0
  END AS is_error_session

FROM stg_voice_sessions vs
LEFT JOIN stg_users u
  ON vs.user_id = u.user_id
LEFT JOIN stg_voice_ai_metrics m
  ON vs.session_id = m.session_id
LEFT JOIN int_turns_by_session t
  ON vs.session_id = t.session_id
LEFT JOIN int_session_error_summary se
  ON vs.session_id = se.session_id
LEFT JOIN stg_applications a
  ON vs.session_id = a.session_id;