# Tier 3 — Interview Questions Prompt

## Interview Questions Generation Prompt

```
Generate 10 interview questions for [JOB_TITLE] at [COMPANY_NAME].
Include:
- 5 technical depth questions specific to tech stack [TECH_STACK]
- 3 behavioral questions using STAR method
- 2 company-specific culture questions

For each question provide:
- The question itself
- Why this question is likely to be asked
- Key points to address in your answer
- Follow-up prompts for deeper discussion
```

## Skills Gap Analysis Prompt

```
Analyze skills gap for [JOB_TITLE] at [COMPANY_NAME].
Required skills: [JOB_REQUIREMENTS].
User current skills: [USER_SKILLS].

Create detailed gap analysis with:
- Missing skills ranked by importance
- Skill levels needed vs current level
- Learning priorities and timeline
- Estimated hours to close each gap
- Recommended resources (courses, books, projects)
Format as actionable 30/60/90-day learning plan.
```

## Talking Points Prompt

```
Create comprehensive talking points for interviewing at [COMPANY_NAME] for [JOB_TITLE].
Include:
- Your 3 most relevant projects with specific metrics (%, $, scale)
- Key technical achievements that match the role
- Industry insights relevant to the company
- Company-specific angles showing deep research
- Pre-prepared answers to common questions (tell me about yourself, biggest challenge, etc.)
- 5 thoughtful questions to ask the interviewer
Format for easy reference during interview preparation.
```

## Salary Guide Prompt

```
Research salary standards for [JOB_TITLE] in [LOCATION].
Provide:
- Median salary and typical range (25th-75th percentile)
- Negotiation tactics and scripts
- Benefits evaluation framework (equity, PTO, health, remote)
- Total compensation breakdown (salary, bonus, stock, benefits)
- Market trends for this role in 2024-2025
- Comparable companies and their comp ranges
- Red flags in job offers to watch for
Include specific negotiation strategies for this role level.
```

## Variables

| Variable | Source |
|---|---|
| `[COMPANY_NAME]` | Parsed from job details |
| `[JOB_TITLE]` | Parsed from job details |
| `[TECH_STACK]` | Set in "Set Job Details" node |
| `[JOB_REQUIREMENTS]` | Extracted from job description |
| `[USER_SKILLS]` | Set in "Set Job Details" node |
| `[LOCATION]` | Parsed from job details |

## Output File

`interview_prep.md`
