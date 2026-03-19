# Tier 4 — Portfolio Matching Prompt

> **Note:** Tier 4 uses the **real GitHub API** to fetch actual repositories from the `odeliyach` GitHub account,
> then uses Ollama to intelligently select and position the most relevant projects.

## Project Selection Prompt (using real GitHub data)

```
From the following real GitHub repositories by user odeliyach, select the 5 MOST RELEVANT
to this job: [JOB_TITLE] at [COMPANY_NAME].
Job description snippet: [JOB_DESCRIPTION_SNIPPET]

Available GitHub repositories:
[REPO_LIST_FROM_API]

For each selected project explain:
- Why it is relevant to this specific role
- Technical skills demonstrated
- Business impact or problem solved
- How to position it in interviews and on resume
Consider: technical skills match, complexity, business impact, recency, documentation quality.
```

## GitHub Visibility Strategy Prompt

```
Provide specific GitHub profile optimization strategies to attract [COMPANY_NAME]
for the [JOB_TITLE] role.
Include:
- README improvements for each selected project (structure, badges, demo links)
- How to highlight contribution stats
- Deployment links or live demo suggestions
- Relevant technology badges to add
- Documentation enhancement priorities
- Community engagement strategies (issues, PRs, stars)
- GitHub profile bio and pinned repos optimization
Be specific and actionable for each recommendation.
```

## GitHub API Integration

The Tier 4 node uses the GitHub REST API to fetch real repository data:

```
GET https://api.github.com/users/odeliyach/repos?sort=updated&per_page=30&type=public
```

Authentication uses `process.env.GITHUB_TOKEN` if available (increases rate limit from 60 to 5000 req/hr).

### Repository Data Fetched Per Repo
- `name` — Repository name
- `description` — Repository description
- `language` — Primary programming language
- `stargazers_count` — Stars count
- `updated_at` — Last updated timestamp
- `html_url` — Repository URL
- `topics` — Repository topics/tags

## Variables

| Variable | Source |
|---|---|
| `[COMPANY_NAME]` | Parsed from job details |
| `[JOB_TITLE]` | Parsed from job details |
| `[JOB_DESCRIPTION_SNIPPET]` | First 500 chars of job description |
| `[REPO_LIST_FROM_API]` | Fetched via GitHub API |

## Output File

`portfolio_matching.md`
