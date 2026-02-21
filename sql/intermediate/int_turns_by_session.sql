-- Turn count + averages (used for efficiency + friction KPIs)
CREATE OR REPLACE VIEW int_turns_by_session AS
SELECT
  session_id,
  COUNT(*) AS turn_count,
  AVG(intent_confidence) AS avg_turn_intent_confidence,
  AVG(asr_confidence) AS avg_turn_asr_confidence,
  SUM(CASE WHEN error_type IS NOT NULL THEN 1 ELSE 0 END) AS turn_error_count,
  SUM(CASE WHEN error_type IS NOT NULL THEN 1 ELSE 0 END)::DOUBLE / NULLIF(COUNT(*), 0) AS turn_error_rate
FROM stg_voice_turns
GROUP BY 1;