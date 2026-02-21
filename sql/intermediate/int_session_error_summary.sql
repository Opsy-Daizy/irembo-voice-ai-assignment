-- Error signals at session level (for Part 4 error definition too)
CREATE OR REPLACE VIEW int_session_error_summary AS
SELECT
  session_id,
  MAX(CASE WHEN error_type IS NOT NULL THEN 1 ELSE 0 END) AS has_any_turn_error,
  SUM(CASE WHEN error_type IS NOT NULL THEN 1 ELSE 0 END) AS total_turn_errors,
  SUM(CASE WHEN speaker = 'user' AND error_type IS NOT NULL THEN 1 ELSE 0 END) AS user_turn_errors
FROM stg_voice_turns
GROUP BY 1;