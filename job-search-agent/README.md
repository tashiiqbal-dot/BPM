# AI Job Search Agent 🤖

An intelligent AI-powered job search agent that automatically finds, filters, and ranks job opportunities tailored to your profile.

## Features

- 🔍 **Multi-source job scraping** - Aggregates listings from LinkedIn, Indeed, GitHub Jobs
- 🤖 **AI-powered matching** - Uses GPT to rank jobs by fit score
- 📧 **Daily digest** - Get top 5 matched jobs emailed daily
- 📝 **Auto-generated cover letters** - AI creates personalized cover letters
- 📊 **Application tracking** - Monitor your job applications
- ⚙️ **Configurable criteria** - Set your job preferences, salary range, tech stack
- 🔐 **Privacy-first** - All data stored locally

## Quick Start

### Prerequisites
- Python 3.10+
- OpenAI API key
- LinkedIn, Indeed accounts (optional)

### Installation

```bash
cd job-search-agent
pip install -r requirements.txt
cp .env.example .env
# Edit .env with your API keys and preferences
```

### Usage

```bash
# Find jobs matching your profile
python main.py search

# Generate cover letter for a job
python main.py cover-letter job-123

# View your application history
python main.py history

# Schedule daily job digest
python main.py schedule
```

## Configuration

Edit `config/job_preferences.json`:

```json
{
  "job_titles": ["Software Engineer", "Full Stack Developer"],
  "locations": ["Remote", "San Francisco", "New York"],
  "min_salary": 120000,
  "max_salary": 200000,
  "experience_level": "mid-level",
  "tech_stack": ["Python", "JavaScript", "React", "PostgreSQL"],
  "industries": ["Tech", "SaaS", "FinTech"]
}
```

## Architecture

```
job-search-agent/
├── main.py              # CLI entry point
├── agent/               # AI agent logic
│   ├── job_matcher.py   # AI matching engine
│   ├── cover_letter.py  # Cover letter generation
│   └── scheduler.py     # Background job runner
├── scrapers/            # Job source integrations
│   ├── linkedin.py
│   ├── indeed.py
│   └── github_jobs.py
├── db/                  # Database layer
│   └── models.py        # SQLite schemas
├── config/              # Configuration files
│   └── job_preferences.json
└── requirements.txt
```

## API Keys Required

- **OpenAI** - For AI matching and cover letter generation
- **LinkedIn** - For job scraping
- **Indeed** - For job listings

## How It Works

1. **Scraping** - Agent scrapes job listings from multiple sources
2. **Filtering** - Initial filter based on your criteria
3. **AI Ranking** - GPT analyzes each job against your profile
4. **Matching** - Returns jobs ranked by fit score
5. **Notifications** - Sends daily digest of top matches
6. **Applications** - Tracks applications and generates follow-ups

## Next Steps

- [ ] Implement LinkedIn scraper
- [ ] Implement Indeed scraper
- [ ] Test GPT job matching
- [ ] Deploy scheduler
- [ ] Add interview prep module

## License

MIT
