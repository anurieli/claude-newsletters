# Roadmap

Features planned for future releases.

---

## Publishing Integration

Connect directly to newsletter platforms so drafts can be published without copy-pasting.

**How it would work:** During onboarding, the user tells Claude which platform they use. Claude walks them through setting up an API key. From then on, `/newsletter` can publish directly after the user approves a draft.

**Platforms to support:**
- **Beehiiv** — has a REST API for creating and sending posts
- **ConvertKit** — has an API for broadcasts and sequences
- **Mailchimp** — has an API for campaigns
- **Substack** — no public API (would require browser automation or manual copy-paste)

**Priority:** Beehiiv and ConvertKit first (clean APIs, common among solo creators).

---

## RSS / Feed Ingestion

Automatically pull recent content from configured sources via RSS feeds instead of relying solely on web search during research.

---

## Analytics Feedback Loop

Pull open rates, click rates, and engagement data from the publishing platform. Use it to inform topic selection and refine the style profile over time.

---

## LinkedIn Content Monitoring

Monitor configured business figures' LinkedIn posts for recent ideas and trending takes. Feed into the research phase.

---

## Browser-Based Research

Use Claude-in-Chrome to actively browse source websites, read full articles, and gather richer research material during the newsletter pipeline.

---

## Voice Import (`/import-voice`)

Import voice/style data from formats beyond plain text — audio transcripts, podcast episodes, video transcripts. Expand the sources that can feed into style capture.

---

## Scheduled Drafting

Set up the `newsletter-writer` agent on a recurring schedule (e.g., every Tuesday). It picks a topic, drafts, and saves — the user just reviews and publishes.
