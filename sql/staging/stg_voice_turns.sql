-- Turn-level interaction table
CREATE OR REPLACE VIEW stg_voice_turns AS
SELECT
  turn_id,
  session_id,
  CAST(turn_number AS BIGINT) AS turn_number,
  LOWER(TRIM(speaker)) AS speaker,                 -- user / system (expected)
  NULLIF(LOWER(TRIM(detected_intent)), '') AS detected_intent,
  CAST(intent_confidence AS DOUBLE) AS intent_confidence,
  CAST(asr_confidence AS DOUBLE) AS asr_confidence,
  NULLIF(LOWER(TRIM(error_type)), '') AS error_type,
  CAST(turn_duration_sec AS DOUBLE) AS turn_duration_sec,
  CAST(created_at AS TIMESTAMP) AS turn_created_at
FROM src_voice_turns;