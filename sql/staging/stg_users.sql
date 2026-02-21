-- Clean and standardize user attributes
CREATE OR REPLACE VIEW stg_users AS
SELECT
  user_id,
  LOWER(TRIM(region)) AS region,                     -- values: rural / urban
  LOWER(TRIM(CAST(disability_flag AS varchar))) AS disability_flag,   -- values: yes / no
  LOWER(TRIM(CAST(first_time_digital_user AS varchar))) AS first_time_digital_user
FROM src_users;