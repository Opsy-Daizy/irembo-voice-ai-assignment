-- Session-level Voice AI interactions
CREATE OR REPLACE VIEW stg_voice_sessions AS
SELECT
  session_id,
  user_id,
  LOWER(TRIM(channel)) AS channel,            
  LOWER(TRIM(language)) AS language,
  CAST(total_duration_sec AS DOUBLE) AS total_duration_sec,
  CAST(total_turns AS BIGINT) AS total_turns,
  LOWER(TRIM(final_outcome)) AS final_outcome,      
  NULLIF(LOWER(TRIM(transfer_reason)), '') AS transfer_reason,
  CAST(created_at AS TIMESTAMP) AS session_created_at
FROM src_voice_sessions;