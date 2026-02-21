CREATE OR REPLACE VIEW src_users AS
SELECT * FROM read_csv_auto('data/users.csv');

CREATE OR REPLACE VIEW src_voice_sessions AS
SELECT * FROM read_csv_auto('data/voice_sessions.csv');

CREATE OR REPLACE VIEW src_voice_turns AS
SELECT * FROM read_csv_auto('data/voice_turns.csv');

CREATE OR REPLACE VIEW src_voice_ai_metrics AS
SELECT * FROM read_csv_auto('data/voice_ai_metrics.csv');

CREATE OR REPLACE VIEW src_applications AS
SELECT * FROM read_csv_auto('data/applications.csv');