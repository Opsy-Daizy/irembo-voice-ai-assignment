#  Voice AI Impact Evaluation  
### Accessibility, Efficiency & Error Reduction Analysis

---

##  Project Overview

This project evaluates the performance of a Voice AI system designed to improve accessibility and digital service adoption.

The analysis focuses on three core objectives:

1. **Accessibility** : Are underserved users succeeding?
2. **Efficiency** : Where does conversational friction occur?
3. **Error Reduction** : How do we measure and reduce high-severity degradation by 40%?

The analysis is built using DuckDB with a dbt-style layered modeling approach.

---

##  Data Model Architecture

Grain: **One row per voice session**

`fact_voice_ai_sessions` integrates:

- Voice session metadata  
- User segmentation (rural/urban, first-time digital user, disability flag)  
- AI performance metrics (ASR/intent confidence, misunderstanding rate, silence rate)  
- Turn-level error density  
- Linked application outcomes  
- Derived KPI flags  

This enables end-to-end impact evaluation from conversation → application completion.

---

## 📈 Key Findings

### 1️⃣ Voice Adoption Is Strong, But Completion Lags

| Channel | Completion Rate |
|----------|----------------|
| Voice    | 55.8% |
| Web      | 62.8% |
| USSD     | 62.8% |

Voice trails structured digital channels by **~7 percentage points**, indicating optimization opportunity.

---

### 2️⃣ High-Severity AI Degradation Reduces Completion

Using severity-calibrated thresholds:

- Low-error sessions: **41.1% completion**
- High-error sessions: **34.6% completion**

Impact: **–6.5 percentage points** (~16% relative decline)

High-severity conversational degradation materially reduces service completion.

---

### 3️⃣ Core Intents Drive Friction

High-volume intents exhibit elevated error rates:

- `repeat` → 41.9%
- `start_application` → 40.0%
- `service_lookup` → 39.0%
- `unknown` → 38.9%

Friction occurs at foundational journey steps, not edge cases.

---

### 4️⃣ Rural Users Experience Slightly Lower Completion

| Region | Completion |
|--------|------------|
| Urban  | 38.9% |
| Rural  | 35.5% |

Gap: –3.4 percentage points

Voice is functioning across regions, but ASR robustness improvements may close equity gaps.

---

### 5️⃣ First-Time Digital Users Do Not Perform Better on Voice

| Channel | First-Time Completion |
|----------|---------------------|
| USSD     | 66.2% |
| Web      | 61.4% |
| Voice    | 56.3% |

Voice has the highest error rate (71.4%) among first-time users.

Conversational simplification may improve accessibility impact.

---

## 🎯 40% Error Reduction Framework

### Error Definition (Severity-Based)

A session is classified as high-error if:

- `turn_error_rate ≥ 0.30`
- `misunderstanding_rate ≥ 0.30`
- `avg_intent_confidence < 0.60`
- `silence_rate ≥ 0.25`
- `escalation_flag = 'yes'`

Baseline error rate: **65%**

Target error rate (40% reduction): **39%**

Improvement is measured as relative reduction:


Success must be validated via:

- Improved completion rates  
- Reduced core intent error density  
- Stable channel and regional mix  

---

## 📊 Dashboard Structure

The executive dashboard includes:

- Voice vs Web/USSD completion gap  
- Error severity impact  
- Rural vs Urban comparison  
- Core intent error rates  
- 40% reduction progress tracker  

This enables Product and AI teams to:

- Monitor degradation trends  
- Prioritize high-impact intents  
- Track accessibility performance  

---

## 🧪 Data Quality & Governance

### Data Quality Controls

- Enforced session-level uniqueness  
- Range validation for confidence & rate metrics (0–1 bounds)  
- Error threshold calibration to avoid over-classification  
- Channel and segment distribution monitoring  

### Privacy Safeguards

- Only aggregated reporting  
- No transcript exposure  
- Anonymized user identifiers  
- Small-cohort suppression  

---

## 🗂 Repository Structure

Data files are excluded from version control.

---

## 🚀 How to Reproduce

1. Place required CSV files into `/data` directory (not committed).  
2. Open DuckDB in VS Code.  
3. Run SQL models in order:
   - sources  
   - staging  
   - intermediate  
   - marts  
   - analysis  
4. Query `fact_voice_ai_sessions` for KPI analysis.  

---

## 📌 Strategic Takeaways

- Voice AI is widely adopted but underperforms structured channels.  
- High-severity degradation is the clearest lever for improvement.  
- Core intents represent the highest ROI optimization opportunity.  
- Accessibility gaps are measurable but addressable.  
- A severity-calibrated 40% reduction target is measurable and actionable.  

---

## 👤 Author

Data modeling, KPI design, and product-focused analytical interpretation performed using DuckDB and SQL.
