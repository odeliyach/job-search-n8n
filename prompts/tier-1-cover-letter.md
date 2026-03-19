# Tier 1 — Cover Letter Generation Prompt

## Cover Letter Prompt

```
Write a compelling cover letter for [COMPANY_NAME] [JOB_TITLE] position.
Show genuine interest in the company and role. Be personal, specific, and professional.
Keep to 3-4 paragraphs. Explain why you are interested in this specific company and role,
not a generic application letter.

Structure:
- Paragraph 1: Hook — why this specific company excites you (reference their products, values, recent news)
- Paragraph 2: Your most relevant achievements with metrics that directly address their needs
- Paragraph 3: How your specific background uniquely qualifies you for this role
- Paragraph 4: Call to action and next steps
```

## Variables

| Variable | Source |
|---|---|
| `[COMPANY_NAME]` | Parsed from job details |
| `[JOB_TITLE]` | Parsed from job details |

## Output File

`cover_letter.md`

## Usage Notes

- Used in the **Tier 1 - Core Application** N8N code node alongside resume generation
- Generated cover letter is stored as `cover_letter.md` in the vault
- Should be personalized for each company — avoid generic language
