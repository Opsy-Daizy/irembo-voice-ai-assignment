-- Friction 1: error bucket vs completion
SELECT
  CASE
    WHEN is_error_session = 0 THEN 'no_error_session'
    ELSE 'error_session'
  END AS error_bucket,
  COUNT(*) AS sessions,
  AVG(is_application_completed) AS application_completion_rate
FROM fact_voice_ai_sessions
GROUP BY 1;

-- Friction 2: duration bucket vs completion
SELECT
  CASE
    WHEN session_duration_seconds < 300 THEN '<5m'
    WHEN session_duration_seconds < 480 THEN '5-8m'
    ELSE '8m+'
  END AS duration_bucket,
  COUNT(*) AS sessions,
  AVG(is_application_completed) AS application_completion_rate
FROM fact_voice_ai_sessions
GROUP BY 1
ORDER BY 1;

-- Friction 3: top error-producing intents
SELECT
  detected_intent,
  COUNT(*) AS turns,
  SUM(CASE WHEN error_type IS NOT NULL THEN 1 ELSE 0 END) AS error_turns,
  SUM(CASE WHEN error_type IS NOT NULL THEN 1 ELSE 0 END)::DOUBLE / NULLIF(COUNT(*),0) AS error_rate
FROM stg_voice_turns
GROUP BY 1
ORDER BY error_rate DESC, error_turns DESC
LIMIT 10;