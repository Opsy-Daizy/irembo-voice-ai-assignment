# Irembo Voice AI Impact Analysis
### Project Overview

This repository contains analysis, data modeling, and impact evaluation of Irembo’s Voice AI assistant, focused on assessing:

* Accessibility impact

* Operational efficiency

* Adoption behavior

* Error reduction performance

The analysis supports measurement of whether Voice AI improves access to public services, particularly for first-time and rural users.

### Data Sources

* Five datasets were used:

* users.csv

* voice_sessions.csv

* voice_turns.csv

* voice_ai_metrics.csv

* applications.csv

All identifiers are anonymized.

### Data Model
fact_voice_ai_sessions

Grain: One row per voice session.

Includes:

* User attributes
  
* AI performance metrics

* Application outcomes

* Derived KPI flags

See /models/fact_voice_ai_sessions.sql.

### Key Findings

* Voice channel shows higher completion rates than non-voice channels.

* Error density significantly reduces completion likelihood.

* Voice AI narrows the rural to urban completion gap.

* First-time digital users perform significantly better using Voice.

### How to Run

* Load CSVs into your SQL environment.

* Run staging models in /models/staging/.

* Run fact_voice_ai_sessions.sql.

* Execute KPI analysis scripts in /analysis/.

### Methodology Notes

* Error defined using composite metric.

* Completion measured at session-level.

* Pre/post error reduction methodology included.

* Data quality checks implemented before KPI reporting.
