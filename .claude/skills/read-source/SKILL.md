# Skill: read-source

## Context Management

When executing this skill, use the Agent tool to spawn a sub-agent for the heavy processing work. This keeps the main conversation lightweight and preserves context for the client interaction.

The main conversation should:
- Handle the client interaction (questions, confirmations, presenting results)
- Spawn a sub-agent for browsing, content extraction, and summarization
- Receive the sub-agent's output and present it to the client in a friendly way

The sub-agent handles:
- Chrome browsing and content extraction
- Reading and summarizing articles
- Compiling research summaries

Browse a source's website or newsletter and summarize what they've been writing about recently. This gives the client real, current inspiration from the people and publications they follow.

## Trigger

This skill activates when the user invokes `/read-source` or asks things like:

- "What has [source] been writing about?"
- "Go check [source]'s latest posts"
- "Read [source] for me"
- "What's trending on [newsletter]?"
- "What did [person] publish recently?"
- "I need inspiration — go read my sources"

## Inputs

- **With a specific source:** A name or URL of a source to check (e.g., `/read-source Lenny's Newsletter`)
- **No arguments or "all":** Browse 2-3 of the client's most relevant sources from `sources.yaml` and summarize across all of them
- **With a topic filter:** A source plus a topic to focus on (e.g., "What has Stratechery written about AI lately?")

## Instructions

### 1. Identify the source

Read `sources.yaml` from the project root. Find the source the client is asking about:

- Search across all categories (thought_leaders, business_figures, newsletters, websites) by name (case-insensitive, partial match)
- If a URL is found in the source entry (`url`, `newsletter_url`), use it
- If no URL is stored, use web search to find the source's main publication URL
- If the client gave a URL directly, use that

If no match is found and no URL was provided, tell the client:

> "I don't have that source on file. Want me to add them? Just give me a name or URL and I'll set them up."

If the client asks to read "all" or "my sources" without specifying, pick the 2-3 sources from `sources.yaml` that have URLs (prioritize newsletters and websites categories).

### 2. Check Chrome availability

Check if Chrome browser tools (`mcp__claude-in-chrome__*`) are available.

**If Chrome is NOT available**, tell the client:

> "I can't browse websites right now — Chrome isn't connected. I can still search the web for recent content from [source]. Want me to do that instead?"

If they say yes, use web search to find recent articles and summarize what you find. If they say no, stop.

**If Chrome IS available**, proceed to step 3.

### 3. Browse the source

Use Chrome browser tools to visit and read the source:

1. **Get tab context** — Call `tabs_context_mcp` to see available tabs
2. **Create a new tab** — Use `tabs_create_mcp` for a fresh tab
3. **Navigate** — Go to the source URL
4. **Handle popups** — Dismiss cookie banners, subscribe modals, and email signup popups:
   - Use `read_page` with `filter: "interactive"` and shallow depth to find close/dismiss buttons
   - Click "No thanks", "Close", "X", or similar dismiss buttons
   - If a popup can't be dismissed, proceed anyway — content may still be readable
5. **Extract the page** — Use `get_page_text` to read the page content
6. **Find recent articles** — If you landed on a homepage or archive:
   - Use `read_page` with `filter: "interactive"` to find article links
   - Identify 2-3 recent articles that look substantive (skip ads, navigation links, etc.)
   - Navigate to each article and extract text with `get_page_text`
   - If the client specified a topic, prioritize articles related to that topic
7. **If `get_page_text` fails** (page too heavy), use `read_page` at shallow depth to find article content, or try navigating to a specific article URL from the page

### 4. Compile the summary

From the content you extracted, compile a research summary covering:

- **Recent topics** — What themes and subjects has the source been covering?
- **Key ideas** — The most interesting or notable arguments, frameworks, or perspectives
- **Relevant angles** — Ideas that connect to the client's brand or could inspire newsletter content (reference `identity/brand-profile.md` for brand alignment if it exists)
- **Publishing cadence** — How often they seem to publish (if observable from dates)
- **Notable quotes or lines** — 2-3 short, striking phrases that capture the source's perspective (keep under 15 words each)

If the client specified a topic filter, focus the summary on content related to that topic.

### 5. Present to the client

Share the summary in warm, plain language. Frame it as inspiration and conversation, not as a research report. Example tone:

> "I just read through Lenny's Newsletter — here's what he's been focused on lately:
>
> **AI in product management** seems to be his big theme right now. He's been writing about how PMs should be using AI tools daily, not just theoretically...
>
> **Hiring and team building** keeps coming up too. His latest piece argues that...
>
> A few things jumped out that could work well for your newsletter: [specific angles tied to their brand]."

Do NOT:
- Show URLs, file paths, or technical details
- Dump raw extracted text
- Present it as a bulleted research document
- Use phrases like "I scraped" or "I extracted" — say "I read" or "I checked"

### 6. Optionally save for future reference

If the summary is substantive, save it to `sources-research/[source-slug]-[YYYY-MM-DD].md` for future reference during newsletter research. Create the `sources-research/` directory if it doesn't exist. Use this format:

```markdown
---
source: [Source Name]
url: [URL visited]
date: YYYY-MM-DD
topics: [list of topics covered]
---

[Summary content in markdown]
```

This step is silent — do not tell the client about the saved file unless they ask.

## Rules

- **Never show raw scraped content.** The client sees a curated, conversational summary — never raw text dumps.
- **Respect copyright.** Summarize and synthesize. Never reproduce full paragraphs from articles. Short quotes (under 15 words, in quotation marks) are fine for flavor.
- **If Chrome tools aren't available, fall back gracefully.** Offer web search as an alternative. Never error out.
- **If a site requires login the client doesn't have**, let them know plainly: "That content is behind a paywall I can't access. If you're subscribed, you can log into Chrome and I'll be able to read it."
- **Keep summaries concise.** The client wants inspiration, not a research paper. Aim for 200-400 words per source.
- **Frame everything as inspiration.** The goal is to spark ideas for their newsletter, not to report on what someone else wrote.
- **Never show YAML, file paths, or system details** unless the client specifically asks.
- **Always tie back to the client's world** when possible — "This could be a great angle for your newsletter because..." connects the research to action.
