# CareerOS — LLM Prompts Reference

All prompts used in the n8n workflow nodes when calling the Groq API.  
Model: `llama-3.1-8b-instant` · Temperature: `0.7` · Max tokens: `2048` (except Tier 6: `4096`)

Each prompt is constructed in a Code node using string concatenation and injected into the Groq API call body. Variables shown as `+ d.variable_name +` are substituted at runtime from the parsed job data.

---

## Extract Job Fields

**Node:** `Extract Job Fields Prepare`  
**Purpose:** Parse raw job description into structured JSON (company, title, requirements, tech stack).

```
Extract structured job information from this job description. Return ONLY a valid JSON object
with these exact keys: company_name, job_title, location, job_requirements, tech_stack,
job_description_clean. Keep values concise.

Job Description:
{job_description_raw}
```

**System message:** none  
**Output:** JSON parsed in `Parse Job Fields` node — feeds all downstream tiers.

---

## Tier 1 — Resume Analysis

**Node:** `T1 Resume Analysis Prepare`  
**Purpose:** Senior architect assessment of CV against the specific role.

```
You are a Senior Software Architect with 15+ years in Israeli high-tech.

Analyze this CV against the job:
1. First impression: strong hire / promising with gaps / needs work
2. For each project: WHY that choice, what problem solved, trade-offs
3. Brutal truth: junior vs senior signals
4. Before/After reframing for each project
5. ATS keywords missing vs present
6. Gap analysis for Israeli market 2026
7. Priority improvements

Company: {company_name}
Job: {job_title}
Requirements: {job_requirements}

CV:
{cv_text (first 800 chars)}
```

---

## Tier 1 — Cover Letter

**Node:** `T1 Cover Letter Prepare`  
**Purpose:** Tailored cover letter with annotated structure.

```
Write a cover letter. Structure: Hook->Bridge->Proof->Close. Annotate each section.

Company: {company_name}
Job: {job_title}
Requirements: {job_requirements}

CV:
{cv_text (first 800 chars)}
```

---

## Tier 1 — Job Fit Score

**Node:** `T1 Job Fit Score Prepare`  
**Purpose:** Structured JSON fit score — used in dashboard and application file frontmatter.

```
You must respond with ONLY a raw JSON object, no explanation, no markdown, no text before or after.
The JSON must have exactly these keys:
  overall_score (integer 0-100)
  technical_match (integer 0-100)
  experience_match (integer 0-100)
  top_strengths (array of exactly 3 strings)
  critical_gaps (array of exactly 3 strings)
  recommendation (string)

Example format:
{"overall_score":75,"technical_match":80,"experience_match":70,
 "top_strengths":["a","b","c"],"critical_gaps":["x","y","z"],
 "recommendation":"text"}

Now calculate job fit for:
Requirements: {job_requirements}
Tech: {tech_stack}

CV:
{cv_text (first 800 chars)}
```

**System message:** `You are a JSON-only API. You never output anything except raw JSON. No markdown, no explanation.`  
**Note:** Response is parsed with JSON.parse after stripping markdown fences. Falls back to `{ overall_score: 0 }` on parse failure.

---

## Tier 2 — Intro Email

**Node:** `T2 Intro Email Prepare`  
**Purpose:** Cold outreach email to hiring manager, peer tone.

```
Write a cold intro email to a hiring manager. Max 5 sentences.
Specific company reference, one credibility proof, 15min chat ask, easy out.
Output: email + 2 alternatives + notes.

Company: {company_name}
Role: {job_title}
Background: {cv_text (first 400 chars)}
```

---

## Tier 2 — Follow-Up Email

**Node:** `T2 Follow Up Prepare`  
**Purpose:** Short 7-day follow-up email.

```
Write a follow-up email under 100 words. Professional, personable.

Company: {company_name}
Role: {job_title}
```

---

## Tier 2 — Company Research

**Node:** `T2 Company Research Prepare`  
**Purpose:** Quick company intel for personalizing outreach.

```
Research {company_name}. Bullet points: industry, recent achievements,
culture, tech stack, hiring trends.
```

---

## Tier 2 — LinkedIn Messages

**Node:** `T2 LinkedIn Message Prepare`  
**Purpose:** Connection request + follow-up message, FROM the candidate TO a recruiter/engineer.

```
I am a software engineering student applying for a job.
Write outreach messages FROM ME to a recruiter or engineer at {company_name}.

1) LinkedIn connection request (max 300 chars):
Brief, specific, mentions one thing about {company_name} or the {job_title} role
that genuinely interests me. Not generic. Reference one of my projects if relevant.

2) LinkedIn follow-up message (max 500 chars):
Sent after they accept. Reference my most relevant project, ask one specific question
about their engineering work. Peer tone, not desperate.

My background: {cv_text (first 500 chars)}
Target role: {job_title} at {company_name}
```

---

## Tier 3 — Skills Gap

**Node:** `T3 Skills Gap Prepare`  
**Purpose:** Hiring manager evaluation of profile vs role.

```
Senior Technical HM evaluation.
1. First impression
2. Skills audit per area
3. Gaps: MUST/SHOULD/NICE
4. Priority matrix
5. Action plan

Job: {job_title} at {company_name}
Requirements: {job_requirements}
CV: {cv_text (first 2000 chars)}
```

---

## Tier 3 — Interview Questions

**Node:** `T3 Interview Questions Prepare`  
**Purpose:** Role-specific technical and behavioral questions with model answers.

```
Generate 10 interview questions for {job_title} at {company_name}.
Include: 5 technical depth questions, 3 behavioral (STAR), 2 company culture.
Add follow-up prompts. Add model answer structure for each.

Tech stack: {tech_stack}
```

---

## Tier 3 — Talking Points

**Node:** `T3 Talking Points Prepare`  
**Purpose:** Structured bullet points for interview preparation.

```
Create talking points for interviewing at {company_name} for {job_title}.
Include: relevant projects with metrics, technical achievements, industry insights,
company-specific angles, answers to likely questions, questions to ask.
Format for easy reference during interviews.

CV: {cv_text (first 800 chars)}
```

---

## Tier 3 — Salary Guide

**Node:** `T3 Salary Guide Prepare`  
**Purpose:** Market salary research and negotiation tactics for Israeli market 2026.

```
Research salary standards for {job_title} in {location}.
Provide: median, range (25th-75th percentile), negotiation tactics,
benefits breakdown (salary/bonus/equity), market trends, comparable companies.
Include negotiation scripts and red flags.
```

---

## Tier 4 — Portfolio Analysis

**Node:** `T4 Portfolio Analysis Prepare`  
**Purpose:** Match GitHub repos to job requirements — runs after live GitHub API fetch.

```
You are a Senior Technical Recruiter. Analyze these GitHub repositories for relevance
to the role below. For each: relevance score, key talking points, suggested framing
for the application, technical signals visible from the repo metadata.

Repositories (fetched from GitHub API):
{repo_list with name, language, stars, description}

Role: {job_title} at {company_name}
Requirements: {job_requirements}
```

---

## Tier 6 — Tailored Resume

**Node:** `Tailored Resume Prepare`  
**Purpose:** Full CV rewrite. Most token-intensive call (max_tokens: 4096).

```
You are a Senior Technical Recruiter & Hiring Manager with 15+ years at Google,
Meta, and NVIDIA Israel. Your task: write a COMPLETE tailored resume ready to send.

=== JOB TARGET ===
Company: {company_name}
Role: {job_title}
Requirements: {job_requirements}

=== ORIGINAL CV (keep this exact structure and format) ===
{cv_text (first 4000 chars)}

=== ALL GITHUB REPOS (source of truth for projects) ===
{repo_list}

=== PORTFOLIO ANALYSIS (relevance ranking + resume bullet guidance) ===
{portfolio_analysis_clean}

=== RULES ===
1. Keep the EXACT same structure and sections as the original CV.
2. Same format per project: Name — Domain | Tech1 · Tech2 · Tech3, then bullet points.
3. Rewrite bullet points using Google XYZ formula: Accomplished [X] as measured by [Y], by doing [Z].
4. NEVER invent numbers. Keep all original metrics: 258x, 37-point, 55%, 5.5x, etc.
5. Rewrite the summary as a SENIOR ENGINEER would write it — not as a student applying.
   Lead with the single most impressive quantified achievement for THIS role.
   Second sentence: what you build and what problem domain you work in.
   Third sentence: why {company_name} specifically (one concrete technical reason).
   BANNED phrases: excited to apply, confident in my ability, looking forward,
   dynamic environment, passionate about, would love to, strong fit.
6. Reorder projects: most relevant to this role first.
7. For ATS gaps not in actual skills: add warning comment only, never fabricate.
8. If a GitHub repo is relevant but NOT in original CV: add it as a new project entry.
9. Output: clean Markdown in the same visual style as the original CV.
10. End with: ## ✏️ What Changed — bullet list of every rewrite and why.
```

---

## Follow-Up Scheduler — Email Drafts

**Node:** `Prepare Follow-Up Prompts`  
**Purpose:** Generates one draft per follow-up type. Four variants below.

### Day 3 Check-In
```
Write a follow-up email to a recruiter at {company} for the {role} position.
It has been 3 days since I applied. Tone: confident, concise, not desperate. Maximum 4 sentences.
Rules:
1. Open with ONE specific, recent (2025-2026) thing {company} has done — product launch,
   technical achievement, or engineering decision. Be specific, not vague.
2. From my CV below, pick the ONE project most relevant to {role} at {company} and
   reference it with a specific metric or technical detail.
3. Ask about next steps.
4. Banned phrases: excited to apply, passionate about, would love the opportunity,
   looking forward to hearing from you.
5. Sound like a peer, not a job seeker.
6. Write 2 alternative versions with different opening hooks but same structure.
7. Add a short note: what makes each version likely to get a response.
Sign off: Odeliya Charitonova

My CV:
{cv_text (first 1500 chars)}
```

### Day 7 Follow-Up
```
Write a 7-day follow-up email to a recruiter at {company} for the {role} position.
No response yet. Tone: self-assured, brief. Maximum 4 sentences.
Rules:
1. From my CV below, pick the ONE project most relevant to {role} and mention one
   specific technical detail or metric that proves I can do this job.
2. Reference something technically specific about {company} — a system they run at scale,
   a technical blog post, or a recent engineering decision.
3. Ask directly: is the role still active, and would it make sense to connect?
4. Banned phrases: excited, passionate, would love, looking forward.
   Sound like someone with options, not someone waiting by the phone.
5. Write 2 alternative versions with different hooks.
6. Add a note on what makes each version likely to get a response.
Sign off: Odeliya Charitonova

My CV:
{cv_text (first 1500 chars)}
```

### Day 30 Check-In
```
Write a 30-day check-in email to a recruiter at {company} for the {role} position.
Tone: warm but direct. 3 sentences maximum.
Rules:
1. From my CV, pick the most impressive project relevant to {role} and mention it
   with a specific detail.
2. Reference one real thing about {company}'s engineering culture or tech that genuinely appeals.
3. Ask if the role is still active or if there are similar openings.
4. No filler, no desperation.
5. Write 2 alternative versions with different hooks, plus a note on what makes each effective.
Sign off: Odeliya Charitonova

My CV:
{cv_text (first 1500 chars)}
```

### 90-Day Reconnection
```
Write a 90-day reconnection email to someone at {company} for the {role} position.
Tone: confident and curious, not desperate. 3 sentences maximum.
Rules:
1. Do not mention the rejection or the wait. Reconnect naturally.
2. From my CV, lead with the most impressive project relevant to {role} —
   pick based on relevance, not recency.
3. Ask if there are openings that might fit, or if they would be open to a quick conversation.
4. Sound like someone who has grown, not someone still waiting.
5. Write 2 alternative versions plus notes on effectiveness.
Sign off: Odeliya Charitonova

My CV:
{cv_text (first 1500 chars)}
```

---

## Design Notes

**Why Groq over local Ollama:** Groq's hosted inference runs at ~200 tokens/sec with no local GPU requirement. The free tier (6000 TPM) is sufficient when requests are spaced with wait nodes.

**Why LLaMA 3.1 8B:** Fast enough for structured outputs, handles JSON mode reliably, free. The 70B model is overkill for these tasks and would exhaust rate limits faster.

**Rate limit strategy:** 14 Groq calls per job submission. 30-second wait nodes between consecutive calls. Follow-up scheduler split across 4 daily triggers (9:00/9:30/10:00/10:30) so each run handles one follow-up type — max ~5 calls per trigger instead of 20.

**JSON safety pattern:** Every JSON-only prompt (e.g. Fit Score) strips markdown fences before parsing:
```js
const clean = content.replace(/```json/g, '').replace(/```/g, '').trim();
```
And wraps `JSON.parse` in try/catch with a sensible fallback object.
