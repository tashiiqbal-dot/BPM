# GETTING STARTED GUIDE - AI Job Search Agent

## 🚀 Installation & Setup (10 minutes)

### Step 1: Clone & Navigate
```bash
git clone https://github.com/tashiiqbal-dot/BPM.git
cd BPM/job-search-agent
```

### Step 2: Run Setup Script
```bash
# On macOS/Linux
bash setup.sh

# On Windows
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
copy .env.example .env
```

This will:
- ✅ Create Python virtual environment
- ✅ Install all dependencies
- ✅ Initialize SQLite database
- ✅ Create `.env` configuration file

---

## 🔑 Step 3: Configure API Keys

Edit `.env` file with your credentials:

### OpenAI API Key (Required for AI matching)
1. Go to https://platform.openai.com/api/keys
2. Create a new API key
3. Paste into `.env`:
```
OPENAI_API_KEY=sk-proj-xxxxxxxxxxxx
```

### Gmail Setup (For daily email digest)
1. Enable 2-Factor Authentication on your Gmail
2. Create App Password: https://myaccount.google.com/apppasswords
3. Update `.env`:
```
SMTP_EMAIL=your-email@gmail.com
SMTP_PASSWORD=xxxx-xxxx-xxxx-xxxx
RECIPIENT_EMAIL=your-email@gmail.com
```

### LinkedIn (Optional - for LinkedIn job scraping)
```
LINKEDIN_EMAIL=your-email@linkedin.com
LINKEDIN_PASSWORD=your-password
```

### Indeed (Optional)
```
INDEED_API_KEY=your-indeed-api-key
```

---

## 📋 Step 4: Set Your Job Preferences

Edit `config/job_preferences.json`:

```json
{
  "job_titles": [
    "Software Engineer",
    "Full Stack Developer",
    "Backend Engineer"
  ],
  "locations": [
    "Remote",
    "San Francisco, CA",
    "New York, NY"
  ],
  "min_salary": 120000,
  "max_salary": 200000,
  "experience_level": "mid-level",
  "tech_stack": [
    "Python",
    "JavaScript",
    "React",
    "Node.js",
    "PostgreSQL",
    "Docker",
    "AWS"
  ],
  "industries": [
    "Tech",
    "SaaS",
    "FinTech"
  ]
}
```

---

## ▶️ Step 5: Run the Agent

### Option A: One-Time Job Search
```bash
python main.py search
```

Output:
```
🔍 Searching for jobs matching your profile...

✅ Found 5 matching jobs:

1. Senior Software Engineer at Google
   Location: Mountain View, CA | Salary: $180,000 - $240,000
   Match Score: 92.5%
   URL: https://careers.google.com/...

2. Full Stack Developer at Stripe
   Location: Remote | Salary: $160,000 - $210,000
   Match Score: 88.3%
   ...
```

### Option B: Generate Cover Letter
```bash
python main.py cover-letter job-id-123
```

### Option C: View Application History
```bash
python main.py history
```

### Option D: Start 24/7 Scheduler (Recommended) ⭐
```bash
bash run.sh
# or
python main.py schedule
```

This will:
- 🔄 Run job search daily at 9:00 AM
- 📧 Email you top 5 matches
- 💾 Track all applications
- 🤖 Generate cover letters on demand

---

## 🎯 Common Commands

```bash
# Search jobs now
python main.py search --limit 10

# Generate cover letter
python main.py cover-letter job-123

# View your applications
python main.py history --limit 20

# Show current configuration
python main.py config

# Start scheduler (runs 24/7)
python main.py schedule
```

---

## 🚀 Deploy as Background Service

### Option 1: Keep Terminal Running (Simplest)
```bash
bash run.sh
```
Keep this terminal window open. Agent runs until you close it.

### Option 2: macOS/Linux (systemd - Runs forever)

Create `/etc/systemd/system/job-search-agent.service`:
```ini
[Unit]
Description=AI Job Search Agent
After=network.target

[Service]
Type=simple
User=your-username
WorkingDirectory=/home/your-username/BPM/job-search-agent
ExecStart=/home/your-username/BPM/job-search-agent/venv/bin/python main.py schedule
Restart=always
RestartSec=60

[Install]
WantedBy=multi-user.target
```

Then run:
```bash
sudo systemctl enable job-search-agent
sudo systemctl start job-search-agent
sudo systemctl status job-search-agent

# View logs
sudo journalctl -u job-search-agent -f
```

### Option 3: Windows Task Scheduler

1. Open Task Scheduler
2. Create Basic Task → "AI Job Search Agent"
3. Trigger: Daily at 9:00 AM
4. Action: Start program
5. Program: `C:\Users\YourName\BPM\job-search-agent\venv\Scripts\pythonw.exe`
6. Arguments: `C:\Users\YourName\BPM\job-search-agent\main.py schedule`
7. Check "Run whether user is logged in or not"

### Option 4: Docker (Cloud-Ready)

Create `Dockerfile`:
```dockerfile
FROM python:3.10-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
CMD ["python", "main.py", "schedule"]
```

Build and run:
```bash
docker build -t job-search-agent .
docker run -d --name job-agent \
  -e OPENAI_API_KEY=sk-proj-xxx \
  -e SMTP_EMAIL=your@email.com \
  -e SMTP_PASSWORD=xxxx-xxxx-xxxx-xxxx \
  -e RECIPIENT_EMAIL=your@email.com \
  job-search-agent
```

### Option 5: Cloud Deployment (Heroku - Free)

```bash
# Install Heroku CLI
brew install heroku

# Login and deploy
heroku login
heroku create job-search-agent
heroku config:set OPENAI_API_KEY=sk-proj-xxx
heroku config:set SMTP_EMAIL=your@email.com
git push heroku feature/job-search-agent:main

# View logs
heroku logs --tail
```

### Option 6: AWS Lambda (Serverless - Cheapest)

1. Package code as ZIP
2. Create Lambda function (Python 3.10)
3. Add CloudWatch Events trigger (daily)
4. Set environment variables
5. Deploy

---

## 📊 Monitoring & Logs

Check the agent is running:
```bash
# View processes
ps aux | grep python | grep main.py

# Check database of tracked jobs
sqlite3 job_search.db "SELECT * FROM applications;"

# View application logs
tail -f job_search.log
```

---

## 🐛 Troubleshooting

### "ModuleNotFoundError: No module named 'openai'"
```bash
pip install --upgrade -r requirements.txt
```

### "OpenAI API key not found"
- Check `.env` file exists
- Verify `OPENAI_API_KEY=sk-proj-xxx` is set
- Restart the agent after editing `.env`

### "Email not sending"
- Enable Gmail 2FA: https://myaccount.google.com/security
- Use App Password (not regular password)
- Check firewall allows SMTP port 587

### "No jobs found"
- Check `config/job_preferences.json` syntax (valid JSON)
- Expand job_titles and locations list
- Lower min_salary requirement
- Run `python main.py config` to verify settings

### "Database locked error"
- Only one instance should access DB
- Stop other running instances: `killall python`
- Or delete `job_search.db` to reset

---

## 📚 What Happens Next

Once running, the agent will:

1. **Daily at 9 AM** - Search all job sources
2. **AI Processing** - Score each job 0-100%
3. **Top 5 Selected** - Best matches identified
4. **Email Sent** - Digest arrives in inbox
5. **Cover Letters** - Generate on demand for any job
6. **Track Progress** - View application status anytime
7. **Continuous Learning** - Agent improves matches

---

## 🎓 Advanced Usage

### Customize Scoring Logic
Edit `agent/job_matcher.py` and modify `_score_job()` method to weight factors differently:
- Title match
- Salary fit
- Tech stack alignment
- Company size preference

### Add New Job Sources
Create scraper in `scrapers/custom_scraper.py` and register in `job_aggregator.py`

### Setup Interview Prep
Extend agent to generate AI interview questions for matched companies

### Integrate with Calendar
Export matched jobs to Google Calendar for interview scheduling

---

## ❓ FAQ

**Q: How often does it search?**
A: Daily at configured time (default 9 AM). Edit `DAILY_DIGEST_TIME` in `.env`

**Q: Does it apply to jobs automatically?**
A: No, it finds jobs and generates cover letters. You apply manually (staying in control)

**Q: Can I run multiple profiles?**
A: Yes, create different config files and run separate instances

**Q: Is my data secure?**
A: Yes, all data stored locally. Only OpenAI API calls leave your machine

**Q: How much does this cost?**
A: Mainly OpenAI usage (~$0.01-0.10 per search). Email/scraping are free

**Q: Can I run on my phone?**
A: Deploy to cloud and receive daily email digests

**Q: How do I stop the agent?**
A: Press `Ctrl+C` in terminal, or for systemd: `sudo systemctl stop job-search-agent`

---

## 🎉 You're Ready!

Your AI Job Search Agent is now ready to find your perfect job 24/7! 🚀

Questions? Check the README.md or raise an issue on GitHub.
