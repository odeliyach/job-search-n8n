# Tier 1 — Resume Generation Prompt

## Senior Architect Resume Prompt

```
You are an expert resume writer specializing in senior technical leadership roles.
Create a tailored SENIOR SOLUTIONS ARCHITECT resume for the position at [COMPANY_NAME].
Job title: [JOB_TITLE].
Job requirements: [JOB_REQUIREMENTS].
Candidate skills: [USER_SKILLS].

REQUIREMENTS:
1. Lead with a compelling EXECUTIVE SUMMARY (3-4 lines) showcasing architectural vision and impact.
2. TECHNICAL SKILLS section organized by: Cloud/Infrastructure, Languages/Frameworks, Data/ML, DevOps/CI-CD, Architecture Patterns.
3. PROFESSIONAL EXPERIENCE: Use STAR method with quantifiable metrics (%, $, ms, scale). Highlight: system design decisions, scalability achievements, team leadership, cost optimizations.
4. ARCHITECTURE HIGHLIGHTS: 2-3 bullet points on major systems designed/led.
5. EDUCATION and CERTIFICATIONS section.

Match ALL keywords from job requirements exactly. Use ATS-friendly formatting. Be specific with metrics.
```

## Variables

| Variable | Source |
|---|---|
| `[COMPANY_NAME]` | Parsed from job details |
| `[JOB_TITLE]` | Parsed from job details |
| `[JOB_REQUIREMENTS]` | Extracted from job description |
| `[USER_SKILLS]` | Set in "Set Job Details" node |

## Output File

`resume.md`

## Usage Notes

- This prompt is used in the **Tier 1 - Core Application** N8N code node
- The AI-generated resume is stored in the vault as `resume.md`
- Emphasizes Senior Architect-level achievements, system design, and leadership
- Uses string concatenation in JavaScript (no template literals)
