# Custom Track Example: Growth & Experimentation

This directory demonstrates how to create a custom learning track. You can copy these files as a starting point for your own tracks.

## What This Track Covers

Growth strategy, A/B testing, experimentation design, funnel analysis, and growth modeling. A good addition for PMs focused on growth roles.

## How to Use

1. Copy this entire directory to `learning/tracks/`:
   ```bash
   cp -r examples/custom-track-example learning/tracks/growth-experimentation
   ```

2. Regenerate the dashboard:
   ```bash
   ./scripts/update-dashboard.sh
   ```

3. The track will appear in your next session prep as due for review.

## Files

- `track.json` — Track state with scores, spaced repetition config, and pedagogy settings
- `lesson-plan.md` — Initial lesson plan for the first few sessions
- `history.jsonl` — Empty session log (will populate as you practice)

## Customization Points

In `track.json`:
- Change `pillar` to match your pillar structure
- Adjust `mastery.dimensions` to track different sub-skills
- Set `pedagogy.approach` to match the teaching style you want
- Set `next_review_date` to today so it's immediately due
