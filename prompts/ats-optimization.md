# ATS Keyword Optimization Reference

This document explains the ATS (Applicant Tracking System) keyword optimization
node added to the workflow, and provides guidance on maximizing ATS scores.

---

## What is ATS Optimization?

ATS systems automatically scan resumes for keywords before a human ever sees them.
Studies show that **75% of resumes are rejected by ATS before reaching a recruiter.**

The workflow's **ATS Keyword Optimization** node automatically:
1. Extracts all technical keywords from the job description
2. Compares them against your skills and resume content
3. Calculates an ATS match score (0–100%)
4. Identifies missing keywords to add to your resume

---

## ATS Score Interpretation

| Score | Status | Action |
|---|---|---|
| 70–100% | Strong Match | Proceed with application |
| 50–69% | Moderate Match | Add missing keywords where authentic |
| 0–49% | Low Match | Revise resume before applying |

---

## Keywords Tracked by the Optimization Node

The node scans for these categories of technical keywords:

### Languages & Frameworks
React, Angular, Vue, Node.js, Python, Java, TypeScript, JavaScript, Go, Rust, C++, C#, .NET, Spring, FastAPI, Django, Flask

### Cloud & Infrastructure
AWS, GCP, Azure, Docker, Kubernetes, Terraform, Ansible, Linux, Bash, Helm, ArgoCD

### Data & Databases
PostgreSQL, MySQL, MongoDB, Redis, Elasticsearch, Kibana, Spark, Kafka, RabbitMQ

### APIs & Architecture
REST, GraphQL, gRPC, Microservices, Serverless, Distributed Systems, System Design, Event Sourcing, CQRS, DDD

### DevOps & Monitoring
CI/CD, Jenkins, Prometheus, Grafana, Git

### Security & Identity
OAuth, JWT, SAML, RBAC

### Methodology
Agile, Scrum, TDD, BDD, Machine Learning, Deep Learning, NLP, Data Science

---

## How to Use ATS Optimization Results

### Step 1: Review the ATS Report
After running the workflow, check `ats_report` in the output data.

### Step 2: Add Missing Keywords Authentically
Only add keywords that you genuinely know. Ways to integrate them:
- **Skills section:** Add as a listed skill
- **Experience bullets:** Use the keyword in context with a metric
- **Summary:** Include in your professional summary
- **Certifications:** Add relevant certifications for missing skills

### Step 3: Avoid Keyword Stuffing
- Never add keywords you don't actually know
- Integrate keywords naturally into sentences
- ATS systems also check for context — not just keyword presence

### Step 4: Use Exact Match Terms
ATS systems often do exact matching:
- "Node.js" not "NodeJS" or "node js"
- "PostgreSQL" not "Postgres" or "psql"
- "CI/CD" not "CI-CD" or "continuous integration"

---

## Prompt for AI Resume Enhancement

If your ATS score is below 70%, use this prompt to improve your resume:

```
Review this resume content and job description. The current ATS keyword match score
is [ATS_SCORE]%. The following keywords are missing: [MISSING_KEYWORDS].

Rewrite the resume to authentically incorporate these missing keywords where relevant.
Do not add skills the candidate does not have. Focus on:
1. Adding keywords to the Skills section where appropriate
2. Rewording existing bullet points to use exact keyword terminology
3. Adding relevant context that demonstrates these skills

Resume content: [RESUME_CONTENT]
Missing keywords: [MISSING_KEYWORDS]
Job description: [JOB_DESCRIPTION]
```

---

## Output

The ATS Keyword Optimization node adds to the workflow data:
- `ats_score` — Match percentage (0–100)
- `ats_keywords_matched` — Array of matched keywords
- `ats_keywords_missing` — Array of missing keywords
- `ats_report` — Full formatted markdown report

The `ats_report` is also committed to the vault alongside other application files.
