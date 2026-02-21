-- Aggregated AI quality/performance per session
CREATE OR REPLACE VIEW stg_voice_ai_metrics AS
SELECT
  session_id,
  CAST(avg_asr_confidence AS DOUBLE) AS avg_asr_confidence,
  CAST(avg_intent_confidence AS DOUBLE) AS avg_intent_confidence,
  CAST(misunderstanding_rate AS DOUBLE) AS misunderstanding_rate,
  CAST(silence_rate AS DOUBLE) AS silence_rate,
  CAST(recovery_success AS DOUBLE) AS recovery_success,
  LOWER(TRIM(CAST(escalation_flag AS VARCHAR))) AS escalation_flag
FROM src_voice_ai_metrics;