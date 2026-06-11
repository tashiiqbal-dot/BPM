#!/bin/bash
# Start the AI Job Search Agent scheduler
# This runs 24/7 and sends daily job digests

echo "🤖 Starting AI Job Search Agent Scheduler"
echo "========================================"
echo ""
echo "The agent will:"
echo "  ✓ Search for jobs daily at configured time"
echo "  ✓ Send top 5 matches to your email"
echo "  ✓ Track all applications"
echo ""
echo "Press Ctrl+C to stop"
echo ""

# Activate virtual environment if it exists
if [ -d "venv" ]; then
    source venv/bin/activate
fi

# Run the scheduler
python main.py schedule
