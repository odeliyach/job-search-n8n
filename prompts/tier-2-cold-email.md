# Tier 2 — Cold Email Prompts

## Introduction Email Prompt

```
Create a professional introduction email to [COMPANY_NAME] for [JOB_TITLE] position.
Make it compelling, personalized, and specific. Under 150 words.
Include: your value proposition, specific interest in company, call to action.
Be authentic, not generic.

Format:
- Subject line suggestion
- Opening: Reference something specific about the company
- Body: Your key value in 2-3 sentences
- CTA: Request a 15-minute call or reply
```

## Follow-Up Email Prompt

```
Create a follow-up email for [COMPANY_NAME] [JOB_TITLE] position.
Show genuine interest, reference previous contact or application. Build on introduction.
Under 100 words. Be professional but personable.

Include:
- Reference to previous email/application
- One new piece of value or insight
- Clear, low-friction call to action
```

## Company Research Prompt

```
Research and provide detailed information about [COMPANY_NAME].
Include: industry/sector, recent news and achievements, company size and growth,
key decision-makers if known, company culture indicators, recent funding/partnerships,
growth metrics, hiring trends. Format as comprehensive bullet-point analysis.
```

## Personal Connection Angles Prompt

```
Identify personal connection angles for contacting [COMPANY_NAME] for [JOB_TITLE].
Look for: alumni connections, shared interests or values, industry events,
mutual LinkedIn connections, shared projects or open source, content they published,
hiring manager information. Suggest specific outreach strategy for each angle.
```

## Variables

| Variable | Source |
|---|---|
| `[COMPANY_NAME]` | Parsed from job details |
| `[JOB_TITLE]` | Parsed from job details |

## Output Files

- `cold_email.md` — Introduction and follow-up email templates
- `company_research.md` — Company research analysis
- `personal_angle.md` — Personal connection strategy
