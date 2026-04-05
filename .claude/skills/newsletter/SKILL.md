# Newsletter Skill

## Context Management

When executing this skill, use the Agent tool to spawn a sub-agent for the heavy processing work. This keeps the main conversation lightweight and preserves context for the client interaction.

The main conversation should:
- Handle the client interaction (questions, confirmations, presenting results)
- Spawn a sub-agent for document analysis, writing sample processing, research, or drafting
- Receive the sub-agent's output and present it to the client in a friendly way

The sub-agent handles:
- Reading and analyzing documents
- Writing profile files
- Research and fact-gathering
- Drafting newsletter content

Write a complete newsletter draft that sounds like the client wrote it herself.

## Trigger

Activate when the user says `/newsletter` or asks to write, draft, create, or start a newsletter.

## Important — Communication Style

The client is not technical. All communication must be warm, clear, and in plain language. Never show YAML contents, file paths, config details, or internal process mechanics unless she explicitly asks. Speak to her like a trusted creative collaborator, not a system.

## Entry Points

The user can kick things off in any of these ways. Detect which one and proceed accordingly:

1. **Topic-driven** — User gives a topic directly (e.g., `/newsletter "topic: the power of saying no"`)
2. **Inspiration-driven** — User references a thinker or concept (e.g., "riff on Brene Brown's vulnerability concept")
3. **Link/content-driven** — User provides a URL or pastes article text
4. **Auto-suggest** — No input given. Research trending topics from available sources, then propose 3 options with a one-line pitch for each. Wait for the client to pick one before proceeding.
5. **Conversational** — User describes what they want in natural language. Extract the core topic and confirm it back before proceeding.

The user can also specify a template inline: `/newsletter "template: deep dive, topic: ..."`. See Phase 1 for template selection.

---

## Phase 1: Topic & Content Sourcing

### 1a. Load project context

Read these files to ground yourself in the client's world:

- `identity/brand-profile.md` — her brand positioning, audience, messaging pillars, values
- `identity/style-profile.md` — her writing voice, sentence patterns, vocabulary, tone
- `sources.yaml` — curated thought leaders, business figures, newsletter sources, and their key ideas

**If `brand-profile.md` or `style-profile.md` do not exist**, stop and tell the client:

> "Before we write, I need your brand voice on file. Let's run a quick setup to capture that first."

Do not proceed without both identity files. Suggest running the onboarding/setup skill if one exists, or explain what's needed.

**If `sources.yaml` does not exist**, you can still proceed. Let the client know:

> "I don't have your curated sources yet, so I'll research independently. If you'd like to add preferred thought leaders and sources later, we can set that up."

### 1b. Match topic to brand and sources

- Confirm the topic fits within the brand's messaging pillars from `brand-profile.md`. If it's a stretch, flag it gently and suggest how to angle it so it aligns.
- Search `sources.yaml` for thought leaders and frameworks relevant to the topic. Note which thinkers and key ideas connect.
- Identify 2-4 key points or angles to explore in the newsletter.

### 1c. Select the template

Check the `templates/` folder at the project root for available newsletter templates. Standard options:

| Template | Use when |
|---|---|
| `standard-weekly.md` | Default for most newsletters |
| `deep-dive.md` | Longer, single-topic exploration |
| `curated-links.md` | Roundup of links/resources with commentary |
| `announcement.md` | Product launch, event, or news-driven piece |

Selection logic:
- If the user specified a template, use it.
- If not specified, default to `standard-weekly.md`.
- If the topic clearly suits a different template (e.g., a resource roundup), suggest the better fit and confirm.

### 1d. Determine the newsletter folder

Check `newsletters/` for subfolders. If only one exists, use it. If multiple exist, either infer from context or ask the client which newsletter this is for.

### 1e. Output

Before moving on, present a brief summary to the client:

> "Here's what I'm working with: [topic in plain language], drawing on [relevant thinkers/frameworks]. I'll use the [template name] format. Sound good?"

Wait for confirmation (or adjust based on feedback) before proceeding.

Internally, assemble a structured brief: key points, relevant thinker references, source material, chosen template, target newsletter folder.

---

## Phase 2: Research & Fact Gathering

### 2a. Live source research (when Chrome is available)

Before falling back to general web search, try to pull fresh content directly from the client's curated inspiration sources.

1. **Check for Chrome browser tools** — Determine whether the `mcp__claude-in-chrome__*` tools (navigate, get_page_text, etc.) are available in the current session. If they are not available, skip this entire sub-step gracefully and proceed to 2b. Do not surface an error to the client.

2. **Select relevant sources** — Read `sources.yaml` and pick 2-3 sources whose URLs are most relevant to the newsletter topic. Prioritize newsletters and websites (sources that publish regularly) over individual thought leaders who may not have a dedicated site.

3. **Visit each source URL** — For each selected source:
   - Use `navigate` to open the URL.
   - If a cookie banner, paywall modal, or popup appears, attempt to dismiss it (click dismiss/close/accept buttons).
   - Use `get_page_text` to extract the visible page content.
   - Scan for recent posts or articles related to the newsletter topic.
   - If the landing page is an index or homepage, look for links to recent relevant articles and navigate into 1-2 of them for full text.

4. **Extract research material** — From each visited page, pull out:
   - Relevant quotes and key phrases
   - Frameworks, models, or mental models the source uses
   - Recent data points, statistics, or examples
   - Unique angles or contrarian takes on the topic
   - Publication date (to confirm freshness)

5. **Why this matters** — This step produces real, current content from the sources the client actually follows and trusts, not generic web search results. It grounds the newsletter in the same intellectual ecosystem the client inhabits.

### 2b. Web research and source matching

For each key point from the brief, gather supporting material:

- **Current data and examples** — Use web search for recent statistics, case studies, news, or cultural moments that connect to the topic.
- **Thought leader frameworks** — Pull relevant ideas, quotes, and frameworks from the thinkers identified in `sources.yaml`. Note the specific work or concept being referenced.
- **Practical business angles** — Find concrete, actionable angles from business figures in the source list.
- **Trending perspectives** — Check newsletter sources from `sources.yaml` for recent takes on the topic.

### Attribution tracking

For every idea, quote, or framework you pull in, note:
- Who said it or where it comes from
- The specific work, talk, or publication (if applicable)
- Whether it's a direct quote, paraphrase, or inspired-by reference

This attribution feeds into Phase 3 for natural weaving and Phase 4 for accuracy checks.

### Cross-reference

If a statistic or claim seems surprising, verify it with a second source. Flag anything you cannot verify so the client can decide whether to include it.

### Output

Compile a research document organized by newsletter section, with source attribution attached to each item. This stays internal — do not show it to the client unless asked.

---

## Phase 3: Drafting

### Load both identity files

Read `identity/brand-profile.md` and `identity/style-profile.md` fresh before drafting. These are the two most important inputs.

- **Brand profile** governs what you say — topic framing, audience awareness, messaging alignment, values reinforcement
- **Style profile** governs how you say it — sentence structure, rhythm, vocabulary, tone, diction, rhetorical patterns, signature markers

The style profile is the most critical input. The newsletter must sound like the client wrote it, not like AI generated it.

### Follow the template

Read the selected template from `templates/`. Follow its structure: sections, headers, CTAs, structural elements. The template is the skeleton; the voice and content are the flesh.

### Weave in references naturally

Thought leader ideas should be integrated, not forced. Good: "As Brene Brown puts it, vulnerability isn't weakness — it's the birthplace of innovation." Bad: "According to renowned researcher Dr. Brene Brown, PhD, in her landmark 2012 book..."

Reference thinkers the way the client would in conversation — naturally, with attribution but without academic formality (unless the style profile says otherwise).

### Draft the full piece

Write the complete newsletter following the template structure, in the client's voice, incorporating research and references. Include every structural element the template calls for (headers, sections, CTAs, sign-offs, etc.).

### Output

The full newsletter draft, held internally for self-edit before showing to the client.

---

## Phase 4: Self-Edit

Before presenting anything, run the draft through these checks:

### Voice consistency (against style-profile.md)

- **Sentence length** — Do the sentence length patterns match? Short punchy sentences if that's her style, longer flowing ones if not. Check the mix.
- **Vocabulary and diction** — Are you using her words, not generic AI words? Check for corporate buzzwords, filler phrases, or language she would never use.
- **Tone and emotional register** — Does the emotional temperature match? Too formal? Too casual? Too motivational-poster?
- **Rhetorical patterns** — Are her signature moves present? (Questions to the reader, list patterns, callback structures, metaphor style, etc.)
- **Rhythm and pacing** — Read it mentally as if speaking aloud. Does it flow the way her writing flows?

### Brand alignment (against brand-profile.md)

- **Messaging pillars** — Does the piece reinforce at least one core messaging pillar?
- **Audience fit** — Is this written for her actual audience, at their level?
- **Brand values** — Are her values reflected in the framing and conclusions?
- **Guardrails** — No prohibited topics, off-brand language, or messaging that contradicts her positioning?

### Source integrity

- Attribution present where needed?
- No unverified claims stated as fact?
- Quotes accurate?

### Narrative grounding check (CRITICAL)

This is the most common failure mode in drafts. Check that the piece follows the principle: **concrete first, abstract second. Scene before thesis. Let the reader arrive.**

- **Opening** — Does the piece start with something concrete (a scene, moment, question, or observable detail)? The thesis or core insight should land as the payoff, not the premise. If the draft opens with "Here's why X matters..." or "The key to X is..." — it fails. Flip it: show X in action first, then name it.
- **Section openers** — Every section should ground the reader in something concrete before naming an abstract principle. If a section opens with "The important thing to understand is..." before showing the thing in action, flip the order.
- **The test:** For every abstract claim in the draft, ask: *has the reader seen this in action yet?* If not, flip the order. Show first, name second.

### Flow check

Read the draft start to finish as a reader would. Check for:
- Strong opening that hooks (must pass the narrative grounding check above — concrete first, not thesis-first)
- Smooth transitions between sections
- A clear throughline from start to finish
- An ending that lands (not a fizzle)

### Revise

Make all necessary revisions. Track what you changed so you can provide a brief edit summary if asked, but do not volunteer the edit summary to the client — she doesn't need to see the sausage-making.

### Output

The revised, polished draft ready for delivery.

---

## Phase 5: Format & Deliver

### Format the final draft

Format as clean markdown. Add a metadata header at the top of the file:

```
---
date: YYYY-MM-DD
topic: [topic in plain language]
template: [template filename used]
sources: [list of key sources/thinkers referenced]
status: draft
---
```

### Save the draft

Save to: `newsletters/[newsletter-folder]/drafts/[YYYY-MM-DD]-[topic-slug].md`

- `newsletter-folder` is the folder identified in Phase 1d.
- `topic-slug` is a short, lowercase, hyphenated version of the topic (e.g., `the-power-of-saying-no`).
- Always save automatically. Nothing should be lost.

### Offer a TLDR

After saving the draft, offer to generate a TLDR — a one-sentence curiosity hook for the top of the piece:

> "Want a TLDR for the top? It's a one-line teaser that hooks readers before they start — great for email previews and social sharing."

If the client says yes, run the `/tldr` skill on the draft. It will analyze the piece, generate 3 options using different hook strategies, and let the client pick one. The chosen TLDR gets placed at the top of the draft, right after the frontmatter.

If the client says no or wants to skip it, move on. Do not push.

### Present to the client

Share the draft with the client. For shorter pieces (under ~800 words), present the complete draft. For longer pieces, present it section by section with brief pauses, or ask the client how she'd like to see it.

Frame the delivery warmly:

> "Here's your draft! I drew on [brief mention of key sources/angles]. Take a look and let me know what you think — happy to revise anything."

Do not dump the draft without context. Always give her a short orientation before the content.

### Handle feedback and revisions

Be ready for any of these:
- "Make it punchier" — Tighten sentences, cut filler, sharpen the hook and transitions
- "Add a personal anecdote placeholder" — Insert a clearly marked `[PERSONAL ANECDOTE: brief suggestion of what could go here]` placeholder
- "Swap the opening" — Write 2-3 alternative openings and let her pick
- "Too long / too short" — Adjust length while preserving voice and key points
- "Change the tone" — Adjust emotional register while staying within brand guardrails
- Any other revision request — apply it, re-run the Phase 4 checks on the changed sections, and save the updated version

On every revision, save the updated draft to the same file path (overwriting the previous version). Confirm the save to the client.

---

## File Reference

| File | Purpose | Required? |
|---|---|---|
| `identity/brand-profile.md` | Brand positioning, audience, messaging pillars | Yes — stop without it |
| `identity/style-profile.md` | Writing voice, patterns, tone, vocabulary | Yes — stop without it |
| `sources.yaml` | Curated thought leaders and sources | No — works without it |
| `templates/` | Newsletter structure templates | Yes — needs at least one |
| `newsletters/` | Output folder for drafts and published pieces | Yes — must exist |

## Guiding Principle

The newsletter should feel like the client sat down and wrote it on a great writing day. The style profile is the contract. Every sentence should pass the test: "Would she actually say it this way?"
