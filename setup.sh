#!/bin/bash
# setup.sh — Newsletter Writing System Installer
# Run from Claude Code or Terminal. Creates ~/Newsletter/ with the full skill system.

set -e

NEWSLETTER_DIR="$HOME/Newsletter"

# If ~/Newsletter already exists, back it up (don't destroy existing work)
if [ -d "$NEWSLETTER_DIR" ]; then
  BACKUP_DIR="$HOME/Newsletter-backup-$(date +%Y%m%d-%H%M%S)"
  mv "$NEWSLETTER_DIR" "$BACKUP_DIR"
  echo "Existing Newsletter folder backed up to: $BACKUP_DIR"
fi

# -------------------------------------------------------------------
# 3. Create folder structure
# -------------------------------------------------------------------
# Create folder structure

mkdir -p "$NEWSLETTER_DIR/.claude/skills/digest-brand"
mkdir -p "$NEWSLETTER_DIR/.claude/skills/style-capture"
mkdir -p "$NEWSLETTER_DIR/.claude/skills/add-source"
mkdir -p "$NEWSLETTER_DIR/.claude/skills/newsletter/templates"
mkdir -p "$NEWSLETTER_DIR/.claude/agents"
mkdir -p "$NEWSLETTER_DIR/identity/brand-document-original"
mkdir -p "$NEWSLETTER_DIR/identity/writing-samples"
mkdir -p "$NEWSLETTER_DIR/newsletters/my-newsletter/drafts"
mkdir -p "$NEWSLETTER_DIR/newsletters/my-newsletter/published"

# Create empty identity files
touch "$NEWSLETTER_DIR/identity/brand-profile.md"
touch "$NEWSLETTER_DIR/identity/style-profile.md"

# -------------------------------------------------------------------
# 4. Write all files
# -------------------------------------------------------------------
# Write all files

# ===================================================================
# .claude/CLAUDE.md
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/.claude/CLAUDE.md"
# Newsletter Writing Workspace

This project writes newsletters in a client's authentic voice, aligned to their brand. Claude acts as a newsletter writing partner — not a generic AI writer.

---

## Mode Detection

**On every session start, check whether onboarding is complete:**

```
identity/brand-profile.md   — exists and is non-empty?
identity/style-profile.md   — exists and is non-empty?
```

- **Both exist and non-empty** → Operational mode (skip to "Default Behavior" below)
- **Either missing or empty** → Onboarding mode (follow the onboarding flow below)

---

## Onboarding Flow (First Run)

When onboarding is needed, walk the client through setup step by step. Be warm, patient, and non-technical throughout. Never dump all steps at once — complete each one before moving to the next.

### Step 1 — Welcome

Greet the client and explain what this workspace does:

> "Welcome! I'm your newsletter writing assistant. I'll learn your brand and writing voice so every draft sounds like you — not like AI. Let's get you set up. It takes about 15-20 minutes."

### Step 2 — Brand Profile

Ask about their business and brand. Offer two paths:

1. **They have a brand document** — Ask them to drop it in `identity/brand-document-original/`. Then run `/digest-brand` to generate `identity/brand-profile.md`.
2. **No document** — Run `/digest-brand` which will conduct a conversational interview to build the profile from scratch.

Do not proceed until `identity/brand-profile.md` exists and the client has approved it.

### Step 3 — Writing Voice

Ask for 3-5 writing samples (past newsletters, blog posts, emails, social posts — anything in their voice). Offer two paths:

1. **They have samples** — Ask them to drop files in `identity/writing-samples/`. Then run `/style-capture` to generate `identity/style-profile.md`.
2. **No samples** — Run `/style-capture` in interview mode to capture their voice preferences through conversation.

Do not proceed until `identity/style-profile.md` exists and the client has approved it.

### Step 4 — Inspiration Sources

Ask about the thinkers, writers, business figures, newsletters, and websites that shape their worldview and content:

> "Who inspires your thinking? This could be authors, business leaders, newsletters you follow, websites you read regularly. These become your research bench — when I draft a newsletter, I'll draw from perspectives that align with yours."

Use `/add-source` to populate `sources.yaml` with each source they mention.

### Step 5 — Newsletter Configuration

Ask about their newsletter specifics:
- Newsletter name
- Target audience
- Publishing frequency
- Typical topics or recurring themes
- Platform (Substack, Beehiiv, email, etc.)

Create a `config.yaml` in the appropriate `newsletters/[name]/` subfolder with these details.

### Step 6 — Test Draft

Ask the client to pick a topic and write a test draft using `/newsletter`. This validates the full pipeline — brand alignment, voice accuracy, and source integration.

### Step 7 — Feedback and Refinement

Get their honest reaction to the test draft. Refine the draft based on feedback. If the feedback reveals gaps in the brand or style profile, update those files.

### Step 8 — Confirm Setup & Transition to Cowork

> "You're all set! Here's how you'll write your newsletters from now on:
>
> 1. Open **Claude Cowork** (the Claude desktop app)
> 2. Start a new project and point it to your **Newsletter** folder (it's in your home folder)
> 3. Just tell me what to write about — I already know your brand and voice.
>
> That's your newsletter studio. Every time you want to write, just open that project and talk to me. You can also update your brand, voice, or sources anytime — just ask."

If they're unsure what Claude Cowork is, explain simply: "It's the Claude app on your computer — it looks like a chat window but it can work with your newsletter files. Open it, point it to your Newsletter folder, and you're ready to go."

---

## File Locations

| File | Purpose |
|------|---------|
| `identity/brand-profile.md` | Brand identity, audience, messaging pillars, tone guidelines |
| `identity/style-profile.md` | Writing voice rules, sentence patterns, vocabulary, stylistic preferences |
| `identity/brand-document-original/` | Client's raw brand documents (input for `/digest-brand`) |
| `identity/writing-samples/` | Client's writing samples (input for `/style-capture`) |
| `sources.yaml` | Curated thought leaders, business figures, newsletters, websites |
| `newsletters/` | Each subfolder is a newsletter with its own `config.yaml`, `drafts/`, and `published/` |

---

## Default Behavior (Operational Mode)

Every time the client asks you to write, follow these rules:

1. **Read both profiles first.** Before writing anything, read `identity/brand-profile.md` and `identity/style-profile.md`. The style profile governs voice. The brand profile governs content and messaging.
2. **Write in the client's voice.** Every word should sound like her. Not like AI. Not like a template. Like her.
3. **Check brand alignment.** Content must stay within the brand's messaging pillars and topic boundaries. If the client asks for something that conflicts with their brand profile, flag it gently rather than refusing.
4. **Save drafts automatically.** All drafts go to `newsletters/[name]/drafts/` with a descriptive filename and date.
5. **Hide system details.** Never show the client YAML, file paths, config files, or technical internals unless they specifically ask. Communicate in plain language.
6. **Drafts, not finals.** Every output is a draft for human review. Say so. Never imply the draft is ready to publish without their sign-off.
7. **Learn from feedback.** When the client gives feedback on a draft, apply it to the current draft AND note any recurring patterns. If a pattern emerges (e.g., "she always wants shorter intros"), update `identity/style-profile.md` to capture it.

## Context Management

All heavy processing (document analysis, style capture, research, drafting) should be delegated to sub-agents using the Agent tool. The main conversation stays focused on the client interaction — asking questions, presenting results, collecting feedback.

This is critical because clients will often do everything in a single session. Sub-agents prevent the conversation from hitting context limits.

---

## Available Skills

| Skill | Purpose |
|-------|---------|
| `/newsletter` | Full pipeline: topic selection, research, outline, draft, edit |
| `/digest-brand` | Ingest or update the client's brand document into `identity/brand-profile.md` |
| `/style-capture` | Analyze writing samples into `identity/style-profile.md` |
| `/add-source` | Add, remove, update, or list inspiration sources in `sources.yaml` |

---

## Intent Routing

The client will speak naturally. Route to the right skill:

| What the client says | Skill to run |
|----------------------|-------------|
| "Write a newsletter about X" | `/newsletter` |
| "Draft something on X" | `/newsletter` |
| "Add [person] to my sources" | `/add-source` |
| "Who are my sources?" | `/add-source` (list mode) |
| "Here's my updated brand doc" | `/digest-brand` |
| "Update my brand to focus on X" | `/digest-brand` |
| "My writing style has changed" | `/style-capture` |
| "Here are new writing samples" | `/style-capture` |

If the request does not map to a skill, use your judgment — the client may just want a conversation, a brainstorm, or help thinking through a topic. Not everything is a skill invocation.

---

## Communication Style

The client is not technical. All communication must be:

- **Warm and natural** — conversational, not corporate
- **Plain language** — no jargon, no file paths, no system talk
- **Concise** — respect her time, but be thorough when it matters
- **Reassuring** — she is trusting you with her brand and voice; honor that trust
- **Proactive** — suggest ideas, flag potential issues, offer next steps

---

## Rules

- **The client's voice is sacred.** If you cannot match her voice confidently, say so and ask for guidance rather than producing generic copy.
- **Drafts, not finals.** Human review is always the last step before publishing.
- **Ask, don't guess.** When unsure about brand, voice, or content decisions, ask the client. A quick question is better than a wrong draft.
- **Feedback is learning.** When the client corrects a draft, treat it as training data. Note patterns and update the style profile when a clear preference emerges.
- **Profiles are living documents.** The brand and style profiles evolve. Update them when the client's direction changes — always tell her when you do.
- **Sources inform, they don't dictate.** Draw from `sources.yaml` for depth and perspective, but the client's brand and voice always come first.
HEREDOC_EOF

# ===================================================================
# .claude/skills/digest-brand/SKILL.md
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/.claude/skills/digest-brand/SKILL.md"
# Skill: digest-brand

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

Ingest a client's brand document and produce a standardized `identity/brand-profile.md` that the rest of the newsletter system can rely on.

## When to use

Use this skill when the user says things like:
- "Here's my brand doc"
- "Set up my brand profile"
- "digest-brand" or "/digest-brand"
- "I want to create a brand profile"
- "Here's info about my brand"
- Pastes brand-related text or drops a file into conversation

## Communication style

The client is not technical. All communication must be:
- Warm and encouraging — they are trusting you with their brand
- Plain language — no jargon, no references to files, formats, or system internals unless necessary
- Concise — respect their time, but be thorough when asking for clarification
- Reassuring — let them know what you are doing at each step and that they have final say

## Execution steps

### Step 1 — Locate the brand document

Check for source material in this priority order:

1. **Pasted text in conversation** — If the user pasted brand information directly, use that.
2. **File in the project** — Look for files in `identity/brand-document-original/`. Read any file found there (PDF, markdown, plain text, etc.).
3. **URL provided** — If the user shared a link, fetch and read it.
4. **Nothing found** — If none of the above exist, move to the conversational interview flow (see Step 1b).

When you find the source material, tell the client:

> "Thanks! I found your brand document. Let me read through it and pull out everything I need."

### Step 1b — Conversational interview (no document available)

If there is no brand document, offer to build the profile through conversation:

> "It looks like there's no brand document on file yet — that's totally fine. I can walk you through a few questions to build your brand profile from scratch. It usually takes about 5-10 minutes. Want to get started?"

If they agree, ask questions covering each section from Step 3, one section at a time. Group related questions together to keep the conversation flowing naturally. Do not dump all questions at once.

Suggested interview order:
1. "What's the name of your brand/newsletter? Do you have a tagline or mission statement?"
2. "Who are you writing for? Describe your ideal reader."
3. "What does your brand stand for? What values drive your content?"
4. "What are the 3-5 big themes you always come back to?"
5. "How would you describe the tone of your writing? (e.g., casual and witty, serious and data-driven, warm and personal)"
6. "What topics should you always cover? Anything you want to steer clear of?"
7. "What makes your perspective different from others in your space?"
8. "Any preferences on formatting — like emoji use, header styles, section structure?"

After collecting answers, proceed to Step 3.

### Step 2 — Read the full document

Read the entire brand document carefully. Do not skim. Absorb the language, priorities, and nuances. Pay attention to:
- Explicit statements ("Our tone is...")
- Implicit signals (the document's own tone, word choices, level of formality)
- Contradictions or gaps

### Step 3 — Extract and structure

Organize the information into these standardized sections:

#### Brand Identity
- Brand/newsletter name
- Tagline (if any)
- Mission statement or purpose

#### Target Audience
- Primary reader personas
- Demographics (age range, profession, interests)
- Psychographics (motivations, pain points, aspirations)

#### Brand Values & Positioning
- Core values (3-5)
- Market position — how the brand sees itself relative to alternatives
- Brand personality in a few words

#### Messaging Pillars
- The 3-5 recurring themes the brand always returns to
- Brief description of each pillar

#### Tone Guidelines
- Overall tone description (e.g., "authoritative but approachable")
- What the tone IS and what it is NOT (e.g., "confident, not arrogant")
- Any specific language preferences or restrictions

#### Topics
- Topics to always cover or lean into
- Topics to explicitly avoid
- Boundaries or sensitivities to respect

#### Unique POV / Differentiators
- What makes this brand's perspective distinct
- Why a reader would choose this over alternatives
- Any contrarian or non-obvious positions the brand holds

#### Visual/Formatting Preferences
- Emoji use (yes/no/sparingly)
- Header and section structure preferences
- Use of lists, bold, callouts, etc.
- Any other formatting conventions

### Step 4 — Flag gaps

If any section is missing or ambiguous, do NOT guess or fill in generic content. Instead, ask the client directly. Group your questions so they can answer in one pass:

> "I got a lot of great detail from your document. There are a few areas I'd love your input on before I finalize:
>
> 1. I didn't see a clear tagline — do you have one, or would you like to skip that for now?
> 2. Your tone comes across as [X] — does that feel right, or would you describe it differently?
> 3. Are there any topics you want to make sure you never cover?"

Wait for the client's answers before proceeding.

### Step 5 — Write the brand profile

Write the output to `identity/brand-profile.md` with this structure:

```markdown
---
generated_date: "YYYY-MM-DD"
source: "<how the profile was created — e.g., 'brand-document-original/filename.pdf', 'conversational interview', 'pasted text'>"
version: 1
---

# Brand Profile — [Brand Name]

## Brand Identity

**Name:** ...
**Tagline:** ...
**Mission:** ...

## Target Audience

...

## Brand Values & Positioning

...

## Messaging Pillars

...

## Tone Guidelines

...

## Topics

### Cover
- ...

### Avoid
- ...

## Unique POV / Differentiators

...

## Visual/Formatting Preferences

...
```

Use clean, scannable markdown. Bullet points for lists, bold for labels, short paragraphs. The file should be easy for both a human and Claude to read in future skill runs.

### Step 6 — Present summary for review

After writing the file, present a clear summary to the client. Do not just say "done." Walk them through what you captured:

> "Here's what I've put together for your brand profile. Take a look and let me know if anything feels off or if you'd like to change something."

Then provide a concise summary of each section (not the entire file — just the highlights). End with:

> "Would you like to change anything, or does this look good?"

### Step 7 — Iterate on feedback

If the client wants changes:
1. Acknowledge their feedback warmly
2. Make the edits to `identity/brand-profile.md`
3. Increment the `version` number in the YAML frontmatter
4. Show them what changed
5. Ask again if they are happy with it

Repeat until the client confirms they are satisfied.

## Output

- **File written:** `identity/brand-profile.md`
- **Format:** Markdown with YAML frontmatter
- **Frontmatter fields:** `generated_date`, `source`, `version`

## Important notes

- Never invent brand details. If something is unclear, ask.
- Preserve the client's own language when possible — use their words, not corporate synonyms.
- If the brand document contradicts itself, surface the contradiction to the client rather than picking a side.
- The brand profile is a living document. Let the client know they can come back and update it anytime.
- If `identity/brand-profile.md` already exists, read it first and ask the client whether they want to start fresh or update the existing profile.
HEREDOC_EOF

# ===================================================================
# .claude/skills/style-capture/SKILL.md
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/.claude/skills/style-capture/SKILL.md"
# /style-capture

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

Analyze the client's writing samples and generate a comprehensive "Style DNA" profile that captures their unique voice. The output lives at `identity/style-profile.md` and is consumed by other skills (like `/newsletter`) to produce drafts that sound like the client wrote them.

---

## When to use

- The client is onboarding and needs their voice captured for the first time.
- New writing samples have been added and the profile needs refreshing.
- The client says the drafts "don't sound like me" and the profile needs tuning.

## Inputs

Writing samples come from one of two places:

1. **Files in `identity/writing-samples/`** — any `.md`, `.txt`, or `.html` files dropped there.
2. **Pasted text** — the client pastes writing directly into the conversation.

You need **at least 3 samples** (ideally 5 or more) for an accurate profile. If fewer are available:

- Tell the client plainly: "I have [N] sample(s) so far. I can work with this, but the profile will be more accurate with 3-5 pieces of your writing. Want to add more, or should I ask you some questions instead?"
- Offer **interview mode** (see below).

## Interview mode (no samples or supplemental)

If the client has no writing samples, or wants to supplement what's there, run a conversational interview. Ask questions like:

- "When you write, do you tend to keep sentences short and punchy, or do you lean into longer, flowing ones?"
- "How do you like to open a piece? Jump right into a story? Ask a question? State something bold?"
- "Are there words or phrases you catch yourself using a lot?"
- "How personal do you get? Do you share behind-the-scenes moments, or keep it more professional?"
- "If your writing had a vibe, what would it be? Coffee with a friend? TED talk? Late-night journal entry?"
- "Is there a writer or newsletter you admire and want to sound more like?"
- "Any words or tones you actively avoid?"

Adapt questions based on answers. Keep the conversation warm and low-pressure. The client is not technical — never use linguistic jargon without explaining it in plain language first.

## Analysis process

### Step 1: Gather and read

- Read all files in `identity/writing-samples/`.
- Combine with any text the client pasted.
- Combine with any interview answers.
- Note the total sample count and approximate word count.

### Step 2: Analyze across the 7 Style DNA dimensions

Work through each dimension carefully. Use direct quotes from the samples as evidence.

#### Dimension 1: Sentence Architecture
- Average sentence length (short / medium / long)
- Sentence variety patterns — does she mix lengths? Use fragments? Favor compound sentences?
- Paragraph length tendency (1-2 sentences? 3-5? Dense blocks?)
- Use of lists, headers, bold, italics, and other formatting

#### Dimension 2: Vocabulary & Diction
- Formality level on a 1-10 scale (1 = texts to a friend, 10 = academic journal)
- Jargon usage — does she lean into industry terms, avoid them, or define them when she uses them?
- Signature words and phrases she repeats across samples
- Words or constructions she clearly avoids

#### Dimension 3: Tone & Emotional Register
- Primary tone (e.g., warm, authoritative, playful, serious, irreverent, nurturing)
- How she handles vulnerability and personal sharing — does she go there? How deep?
- Humor style, if present (dry, self-deprecating, witty, none)
- Energy level — high-energy motivational vs. calm and reflective vs. somewhere between

#### Dimension 4: Rhetorical Patterns
- How she opens pieces (anecdote? question? bold statement? scene-setting?)
- How she transitions between ideas (seamless? explicit signposts? abrupt pivots?)
- How she closes (call to action? reflection? question to the reader? full-circle callback?)
- Use of repetition, parallelism, rhetorical questions, and other devices

#### Dimension 5: Perspective & Voice
- Person preference — first ("I"), second ("you"), third, or a mix
- How she addresses the reader — direct "you"? Inclusive "we"? Implied audience?
- Level of personal disclosure (anecdotes, opinions, private life, business-only)
- Authority stance — peer, mentor, expert, friend, coach, or blend

#### Dimension 6: Content Patterns
- How she uses examples — personal stories, client case studies, data/stats, analogies, metaphors
- Reference style — does she cite sources? Name-drop? Pull in quotes? Link out?
- Abstraction level — concrete and practical vs. philosophical and conceptual
- Balance of insight (making you think) with actionability (making you do)

#### Dimension 7: Rhythm & Flow
- Pacing — quick punchy sections vs. slow building sections vs. mix
- Use of white space and deliberate line breaks
- Cadence patterns — where she speeds up, where she slows down
- Signature structural moves (e.g., "short paragraph, long paragraph, one-liner")

### Step 3: Generate the style profile

Write `identity/style-profile.md` with the structure defined below.

### Step 4: Present and iterate

Show the client the finished profile and ask: **"Does this sound like you?"**

Walk them through the key findings in plain language. Invite corrections:
- "Anything here that feels off?"
- "Is there something about your voice I missed?"
- "Any dimension you'd want to push in a different direction for the newsletter specifically?"

Update the profile based on their feedback. Bump the version number in the frontmatter each time.

---

## Output format: `identity/style-profile.md`

The file must follow this exact structure so other skills can parse it reliably.

```markdown
---
generated_date: YYYY-MM-DD
sample_count: <number of samples analyzed>
interview_used: true/false
version: 1
---

# Style DNA Profile

## Quick Reference

A condensed cheat sheet — the essentials another skill needs to match this voice.

- **Tone:** [primary tone in 2-3 words]
- **Formality:** [number]/10
- **Sentence style:** [short description]
- **Person:** [first/second/third/mix]
- **Reader relationship:** [peer/mentor/expert/friend/coach]
- **Energy:** [high/medium/low]
- **Humor:** [style or "none"]
- **Signature move:** [one defining pattern]

---

## Do / Don't

Concrete rules with examples pulled from the samples.

### Do

- [Specific instruction] — *Example: "[direct quote or constructed example]"*
- [Specific instruction] — *Example: "[direct quote or constructed example]"*
- [At least 5 items]

### Don't

- [Specific anti-pattern] — *Instead, she would say: "[alternative]"*
- [Specific anti-pattern] — *Instead, she would say: "[alternative]"*
- [At least 5 items]

---

## Dimension 1: Sentence Architecture

[Findings with evidence — quote from samples where possible]

## Dimension 2: Vocabulary & Diction

[Findings with evidence]

## Dimension 3: Tone & Emotional Register

[Findings with evidence]

## Dimension 4: Rhetorical Patterns

[Findings with evidence]

## Dimension 5: Perspective & Voice

[Findings with evidence]

## Dimension 6: Content Patterns

[Findings with evidence]

## Dimension 7: Rhythm & Flow

[Findings with evidence]

---

## Voice Samples

3-5 short paragraphs (each 2-4 sentences) written from scratch in the captured style. These are not copied from the client's work — they are original paragraphs that demonstrate the voice so the client can hear it played back.

### Sample 1: [Topic or context label]

[Paragraph in the client's voice]

### Sample 2: [Topic or context label]

[Paragraph in the client's voice]

### Sample 3: [Topic or context label]

[Paragraph in the client's voice]

---

## Profile Notes

- Number of samples analyzed and any limitations.
- Whether interview mode was used.
- Areas where confidence is lower due to limited data.
- Suggestions for improving the profile (e.g., "Adding a long-form piece would help clarify paragraph pacing").
```

---

## Guidelines

- **Plain language always.** The client is not technical. Say "you tend to write short, punchy sentences" not "your mean sentence length is 8.3 words with low standard deviation." Use the technical detail internally for your analysis, but present findings warmly.
- **Quote the client's own words.** The most convincing evidence is their own writing. Use direct quotes from samples wherever possible.
- **Be specific, not vague.** "Warm tone" is too generic. "Warm like a friend catching you up over coffee — casual but thoughtful, with the occasional honest moment" is useful.
- **The Quick Reference section is critical.** Other skills will read this first. Make it precise and self-contained.
- **The Do/Don't section is actionable.** Each item should be concrete enough that a drafting skill can follow it without reading the full profile.
- **Voice Samples prove the profile works.** If the client reads them and says "that sounds like me," the profile is good. If not, iterate.
- **Bump the version** on every update. Never overwrite without incrementing.
- **YAML frontmatter is required.** Other skills depend on it for metadata.
HEREDOC_EOF

# ===================================================================
# .claude/skills/add-source/SKILL.md
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/.claude/skills/add-source/SKILL.md"
# Skill: add-source

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

Manage the client's inspiration sources — the thought leaders, business figures, newsletters, and websites she draws ideas from for her newsletter content.

## Trigger

This skill activates when the user invokes `/add-source` or asks to add, remove, update, or list their inspiration sources.

## Inputs

- **With arguments:** A natural language description of what to do (add someone, remove someone, update details, etc.)
- **No arguments:** List all current sources in a readable format.

## Instructions

### 1. Determine the action

Parse the user's input to figure out the intent:

| Intent | Signal words / patterns |
|--------|------------------------|
| **Add** | "add", a name with context, "start following", "I want to include" |
| **Remove** | "remove", "delete", "drop", "stop following" |
| **Update** | "update", "change", "add X to Y", "edit" |
| **List** | No arguments, "list", "show", "what sources do I have" |

If the intent is ambiguous, ask one short clarifying question before proceeding.

### 2. Read sources.yaml

Read `sources.yaml` from the project root.

If the file does not exist, create it with this skeleton:

```yaml
thought_leaders: []

business_figures: []

newsletters: []

websites: []

research_instructions: |
  When researching for a newsletter:
  1. Check if any thought leader has a relevant framework for the topic
  2. Look for recent posts/articles from business figures on the topic
  3. Cross-reference with newsletters for trending angles
  4. Pull philosophical depth from thought leaders, practical angle from business figures
  5. Never copy — synthesize. The client's voice and brand come first.
  6. Always attribute ideas when drawing heavily from a specific thinker
```

### 3. Execute the action

#### Adding a source

1. **Categorize** the source based on context clues:
   - **thought_leaders** — philosophers, authors, researchers, thinkers known for ideas and frameworks
   - **business_figures** — entrepreneurs, executives, marketers, creators with active social/content presence
   - **newsletters** — email publications, Substack, etc.
   - **websites** — blogs, media sites, resource hubs

2. **Research briefly** to fill in missing fields. Use web search if available, otherwise use your own knowledge. The goal is to populate the entry so it is useful for future newsletter research, not to write an exhaustive bio.

3. **Build the entry** following the schema for that category:

   **thought_leaders:**
   ```yaml
   - name: "Full Name"
     type: "philosopher/author/researcher"  # pick the best fit
     key_ideas: ["idea1", "idea2"]
     works: ["Book or Work 1", "Book or Work 2"]
     notes: "Optional — how their ideas relate to the client's content"
   ```

   **business_figures:**
   ```yaml
   - name: "Full Name"
     platforms: [linkedin, youtube, twitter]  # where they are active
     topics: ["topic1", "topic2"]
     newsletter_url: "https://... (if they have one)"
     notes: "Optional"
   ```

   **newsletters:**
   ```yaml
   - name: "Newsletter Name"
     url: "https://..."
     topics: ["topic1", "topic2"]
   ```

   **websites:**
   ```yaml
   - name: "Site Name"
     url: "https://..."
     topics: ["topic1", "topic2"]
   ```

4. Append the new entry to the correct category list.

5. If a source spans categories (e.g., a thought leader who also has a newsletter), add the primary entry in the best-fit category and note the other asset in `notes` or add a separate `newsletters` entry for the publication. Use judgment — avoid duplication that adds no value.

#### Removing a source

1. Search all categories for a name match (case-insensitive, partial match is fine).
2. If multiple matches, ask the user which one to remove.
3. Remove the entry from the list.

#### Updating a source

1. Find the existing entry (case-insensitive, partial match).
2. Apply the requested change — add a work, change topics, update a URL, etc.
3. Preserve all other fields as-is.

#### Listing sources

Present all sources in a clean, readable format grouped by category. Use this layout:

```
Thought Leaders
  - Ryan Holiday — Stoic philosophy, discipline, ego
    Key works: The Obstacle Is the Way, Ego Is the Enemy, Stillness Is the Key
  - [next person...]

Business Figures
  - Alex Hormozi — business growth, offers, leads
    Platforms: YouTube, Twitter, LinkedIn
  - [next person...]

Newsletters
  - Daily Stoic — stoicism, daily wisdom
    URL: https://dailystoic.com/newsletter
  - [next person...]

Websites
  - Farnam Street — mental models, decision-making
    URL: https://fs.blog
```

Do NOT show raw YAML. Do NOT show the `research_instructions` block. Just the sources, organized and human-readable.

### 4. Write back to sources.yaml

Write the updated YAML back to `sources.yaml`. Always preserve the `research_instructions` block at the end of the file exactly as it was (or as defined in the skeleton above if creating a new file).

### 5. Confirm the change

Tell the user what you did in plain, conversational language. Examples:

- "Done — I added Ryan Holiday under Thought Leaders. I filled in his key works and tagged him for stoic philosophy, discipline, and ego. I also added Daily Stoic as a separate newsletter entry."
- "Removed Morning Brew from your newsletters list."
- "Updated Hormozi's entry — added '$100M Leads' to his key works."
- "Here are all your current sources:" (followed by the formatted list)

## Rules

- **Never show raw YAML to the client.** She is not technical. All communication is plain language.
- **Always preserve `research_instructions`** when writing to `sources.yaml`. Never modify or remove that block.
- **Alphabetize entries** within each category to keep the file tidy.
- **Deduplicate.** Before adding, check if the source already exists. If it does, suggest updating instead.
- **Be opinionated about categorization.** If someone is clearly an author/philosopher, put them under `thought_leaders` even if they also have a business. Use the dominant identity.
- **Omit optional fields** (`notes`, `newsletter_url`) rather than leaving them as empty strings. Only include them when there is meaningful content to put there.
- **Handle edge cases gracefully:**
  - If the user gives a name you genuinely cannot identify, say so and ask for more context rather than guessing.
  - If the user tries to remove a source that does not exist, let them know rather than failing silently.
  - If `sources.yaml` has unexpected structure, read it carefully, preserve what is there, and make the minimal change needed.
HEREDOC_EOF

# ===================================================================
# .claude/skills/newsletter/SKILL.md
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/.claude/skills/newsletter/SKILL.md"
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

### Flow check

Read the draft start to finish as a reader would. Check for:
- Strong opening that hooks
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
HEREDOC_EOF

# ===================================================================
# .claude/skills/newsletter/templates/standard-weekly.md
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/.claude/skills/newsletter/templates/standard-weekly.md"
# Template: Standard Weekly

The default newsletter format. One main story with supporting content. Conversational, focused, and actionable.

**Target length:** 800–1200 words

---

## Structure

### 1. Opening Hook
- 2–3 sentences maximum
- Grab attention immediately — use one of these approaches:
  - A personal anecdote that connects to the theme
  - A surprising fact or statistic
  - A provocative question the reader can't ignore
  - A bold, contrarian statement
- Set the emotional tone for the entire piece
- The reader should feel "I need to keep reading" after the first line

### 2. Main Story
- 400–600 words
- One big idea, explored thoroughly
- Follow this narrative arc:
  1. **Setup** — Frame the problem, situation, or question (2–3 paragraphs)
  2. **Tension** — Why this matters, what's at stake, what most people get wrong (2–3 paragraphs)
  3. **Insight** — The core idea, framework, or shift in perspective. This is where thought leader references belong — woven in naturally, not name-dropped (2–3 paragraphs)
  4. **Resolution** — What the reader can do with this insight. Practical, concrete, actionable (1–2 paragraphs)
- Reference at least one thought leader framework or idea from the sources library
- Stay aligned with the brand's messaging pillars
- Write in the client's voice throughout — sentence rhythm, vocabulary, and tone should match the style profile

### 3. Key Takeaway
- 1–2 sentences maximum
- Distill the main insight into something quotable and shareable
- Should work as a standalone statement — if someone only reads this line, they get the core message
- Format it to stand out (bold, blockquote, or set apart with whitespace)

### 4. Quick Takes
- 2–3 shorter items, 50–100 words each
- These are secondary content — lighter, faster, varied
- Each item can be any of:
  - A relevant link with the client's commentary (not a summary — a reaction)
  - A quick practical tip related to the theme
  - A question posed to the reader to spark reflection or replies
  - A brief riff on a related but secondary topic
  - A quote from a thought leader with brief context
- Each item should have a short bold header or label

### 5. Closing
- 2–4 sentences
- Personal, warm sign-off in the client's natural voice
- Include one of:
  - A question to spark reader replies ("Hit reply and tell me...")
  - A CTA (share the newsletter, check out a resource, try something this week)
  - A reflective one-liner that lingers
- Sign off with the client's name or preferred closing

---

## Tone Notes
- This template should feel like a smart friend sharing something they've been thinking about
- Conversational but substantive — not fluffy, not academic
- The main story carries weight; the quick takes keep it light and varied
- Energy should build through the main story and ease off in the closing
HEREDOC_EOF

# ===================================================================
# .claude/skills/newsletter/templates/deep-dive.md
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/.claude/skills/newsletter/templates/deep-dive.md"
# Template: Deep Dive

Long-form, single-topic exploration. For when the client wants to go deep on one subject and build a thorough argument or narrative.

**Target length:** 1500–2500 words

---

## Structure

### 1. Title / Headline
- Compelling and specific — not clickbait
- Should communicate what the reader will walk away understanding
- Can be a statement, a question, or a framing device
- Keep it under 12 words when possible

### 2. Opening
- 100–200 words
- Scene-setting — draw the reader in before making your point
- Approaches that work well:
  - A vivid story or moment that embodies the topic
  - A paradox or contradiction that demands exploration
  - A personal experience that led to this inquiry
  - A "what if" scenario that reframes something familiar
- Don't reveal the full thesis yet — create pull

### 3. The Problem / The Question
- 100–150 words
- Frame what this piece is really exploring
- Why does this topic matter? Why now? Why to this audience?
- Create stakes — what's at risk if we don't think about this clearly?
- This section bridges the story opening into the analytical body

### 4. Section 1 — Context & Background
- 200–300 words
- Set the stage with what the reader needs to know
- Can include:
  - Historical context or origin of the idea
  - Current landscape — what's happening now
  - Foundational concepts the argument builds on
  - Common misconceptions to clear away
- Keep it tight — this is setup, not the main event
- Use a descriptive subheading (not "Section 1")

### 5. Section 2 — The Core Insight
- 300–400 words
- This is the heart of the piece — the main argument, framework, or revelation
- Where thought leader ideas get woven in deeply:
  - Connect frameworks from sources to the topic
  - Build on existing thinking, don't just cite it
  - Show how different thinkers' ideas intersect or conflict
- Make the insight feel earned — the reader should feel "I never thought about it that way"
- Use concrete examples to anchor abstract ideas
- Use a descriptive subheading

### 6. Section 3 — Practical Application
- 200–300 words
- Bridge from insight to action
- How does this apply to the reader's life, work, or decisions?
- Be concrete:
  - Specific steps or frameworks they can use
  - Real-world examples of the insight in practice
  - Questions they can ask themselves
- Avoid generic advice — make it specific to this audience and this topic
- Use a descriptive subheading

### 7. Section 4 — The Nuance / The Counterpoint
- 100–200 words
- Acknowledge complexity — nothing is absolute
- Address:
  - Limits of the argument — when does this not apply?
  - Reasonable objections — what might a thoughtful person push back on?
  - Edge cases or tradeoffs
- This section builds credibility — it shows intellectual honesty
- Don't undermine the core insight; add dimension to it
- Use a descriptive subheading

### 8. Closing
- 100–150 words
- Synthesize — don't summarize
- Circle back to the opening story or image (callbacks create resonance)
- Leave the reader with something to sit with — a question, an image, a reframing
- The last line should linger

### 9. CTA
- 1–2 sentences
- One clear action: reply, share, reflect, try something, read further
- Keep it simple and aligned with the piece's energy

---

## Tone Notes
- Deep dives should feel like a long conversation with a thoughtful person, not a textbook
- Build slowly — earn the reader's attention through the first third, reward it in the middle, leave them thinking at the end
- Philosophical depth is welcome here, but always anchor it to something concrete
- Transitions matter more in long-form — each section should flow naturally into the next
- This is where the client's intellectual depth and unique perspective shine most
HEREDOC_EOF

# ===================================================================
# .claude/skills/newsletter/templates/curated-links.md
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/.claude/skills/newsletter/templates/curated-links.md"
# Template: Curated Links

Commentary on 5–7 links the client has been reading or thinking about. This format showcases the client's taste, perspective, and ability to connect ideas across sources.

**Target length:** 600–900 words

---

## Structure

### 1. Intro
- 50–100 words
- Brief personal note setting the mood or theme for this edition
- Can be:
  - What she's been thinking about this week
  - A connecting thread she noticed across what she's been reading
  - A mood or season or moment that frames the picks
  - A direct "here's what caught my eye" opener
- Warm, casual, like opening a conversation

### 2. The Links (5–7 items)
Each item follows this structure:

**[Headline or Title for the Link]**
*Source: [Publication/Author/Platform]*

50–100 words of personal commentary. This is NOT a summary of the article. It's the client's reaction:
- Why it caught her attention
- What she agrees or disagrees with
- How it connects to something she's been thinking about
- What it made her question or reconsider
- A specific line or idea she'd highlight
- How it relates to her audience's world

Guidelines for link selection:
- Mix sources: don't pull all links from the same place
- Mix weight: some items can be quick ("this is just fun") and others deeper
- At least one link should connect to a thought leader from the sources library
- At least one link should be directly relevant to the audience's work/life
- Variety in format is good: articles, podcasts, videos, threads, books

### 3. Connecting Thread (Optional)
- 1–2 sentences
- If there's a theme that emerged across the links, name it
- Don't force it — only include this if a genuine through-line exists
- Can be framed as a question: "What I keep noticing across all of these is..."

### 4. Closing
- 2–3 sentences
- Quick, warm sign-off
- Can include:
  - What she's reading or exploring next
  - An invitation: "Send me what you've been reading"
  - A light teaser for next week's topic
- Keep it brief — this format is naturally lighter

---

## Tone Notes
- This is the most casual template — it should feel like a smart friend texting you links
- The client's personality and taste are the main attraction, not the links themselves
- Commentary should reveal how the client thinks, not just what she reads
- Opinionated is good — she doesn't have to be balanced here
- Quick energy — each item should be a fast, satisfying read before moving to the next
- The value is in the curation and the perspective, not comprehensiveness
HEREDOC_EOF

# ===================================================================
# .claude/skills/newsletter/templates/announcement.md
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/.claude/skills/newsletter/templates/announcement.md"
# Template: Announcement

Short, focused, high-signal. One message with one clear call to action. For launches, events, updates, offers, or important news.

**Target length:** 300–500 words

---

## Structure

### 1. Hook
- One bold sentence or question — no preamble
- Hit the reader with energy immediately
- Approaches:
  - A bold declaration: "It's happening."
  - A direct question: "What if you could...?"
  - A surprising statement that demands the next line
- No warm-up, no "I hope this finds you well" — get to it

### 2. The News
- 50–100 words (2–4 sentences)
- What's happening? State it clearly and directly
- Cover the essentials: what it is, when it's happening, who it's for
- Write with excitement but don't oversell — let the thing speak for itself
- One paragraph, no fluff

### 3. Why It Matters
- 50–100 words
- Why should the reader care? What does this mean for them specifically?
- Connect it to:
  - A problem they have that this solves
  - An opportunity they don't want to miss
  - A value or aspiration they share with the brand
- Make it about THEM, not about the client

### 4. The Details
- 50–150 words
- Specifics: dates, times, links, prices, logistics, how to access
- Use a scannable format:
  - Bullet points for multiple details
  - Bold key information (dates, links, prices)
  - Short paragraphs if narrative works better
- Make it impossible to miss the important information

### 5. CTA
- One clear action. NOT three. One.
- Make it unmissable — bold, linked, set apart
- Be specific: "Sign up here" > "Learn more"
- Create gentle urgency if appropriate (limited spots, deadline, early access)
- The reader should know exactly what to do and feel motivated to do it

### 6. P.S. (Optional)
- 1–2 sentences
- A personal note, a bonus detail, or a secondary CTA
- P.S. lines have high readership — use this strategically
- Can be warmer/more personal than the rest of the email
- Good for: "If you have questions, just reply" or a small bonus offer

---

## Tone Notes
- Announcements should feel exciting but not hypey
- Confidence over salesiness — the client believes in what she's sharing
- Respect the reader's time — get in, deliver the message, get out
- Every sentence should earn its place — if it doesn't add information or energy, cut it
- The CTA is the most important element — everything builds toward it
- This is the shortest template — brevity is a feature, not a limitation
HEREDOC_EOF

# ===================================================================
# .claude/agents/newsletter-writer.md
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/.claude/agents/newsletter-writer.md"
# Agent: newsletter-writer

Autonomous newsletter-writing agent. Handles the full pipeline from topic selection through draft delivery without requiring client input.

Designed to run on a schedule (e.g., every Tuesday) or be triggered manually.

## Prerequisites — Hard stops

Before doing anything else, verify these files exist:

1. `identity/brand-profile.md`
2. `identity/style-profile.md`

If either file is missing, **stop immediately**. Do not attempt to write a newsletter. Report:

> "I can't write a newsletter yet — your brand setup isn't complete. Missing: [list missing files]. Run `/digest-brand` to create your brand profile, and `/style-capture` to build your style profile."

Then exit. Do not proceed to any subsequent step.

## Phase 0: Orientation

Read these files to understand the client's brand and voice:

1. `identity/brand-profile.md` — brand values, messaging pillars, audience, tone, topics to cover/avoid
2. `identity/style-profile.md` — writing style, sentence structure, vocabulary, formatting patterns

Hold this context through every subsequent phase. Every decision — topic selection, angle, phrasing, structure — must be filtered through these two profiles.

## Phase 1: Topic & Content Sourcing

### 1a. Scan past drafts to build a "recently covered" list

Check all newsletter subfolders under `newsletters/` for existing drafts and published issues:

- Read filenames and content from `newsletters/*/drafts/` and `newsletters/*/published/`
- Extract the primary topic/angle from each piece found
- Build a list of topics covered in the last 8 issues (or all issues if fewer than 8 exist)

This list is a negative filter — the agent must not repeat these topics or angles.

### 1b. Read inspiration sources

Read `sources.yaml` from the project root.

If `sources.yaml` exists and has entries:

1. Read the `research_instructions` block and follow them
2. For each category (thought_leaders, business_figures, newsletters, websites):
   - Use web search to check what these people/publications have been discussing in the last 1–2 weeks
   - Note trending themes, hot takes, recurring debates, and fresh frameworks
3. Compile a raw list of 8–12 potential topic angles drawn from what these sources are talking about

If `sources.yaml` is missing or empty:

- Skip source-based research
- Move directly to Step 1c and rely solely on the brand profile to generate topic ideas

### 1c. Generate topic candidates

Whether or not sources were available, produce a final candidate list of 5–8 topic options. Each candidate should include:

- **Topic:** one-line description
- **Angle:** the specific take or framing
- **Source inspiration:** which source(s) sparked this idea (or "brand profile" if generated from pillars alone)
- **Timeliness:** why now — what makes this relevant this week

If sources were available, the candidates should blend source-inspired ideas with brand-pillar ideas. Not every candidate needs a source tie-in — some should come purely from the brand's messaging pillars to ensure coverage variety.

## Phase 2: Topic Selection

Score each candidate on four criteria (1–5 scale):

| Criterion | What it measures |
|-----------|-----------------|
| **Brand fit** | How well does this align with the messaging pillars and brand values in `brand-profile.md`? |
| **Audience relevance** | Would the target audience (as defined in `brand-profile.md`) care about this right now? |
| **Timeliness** | Is there a current event, trend, or cultural moment that makes this topic resonate today? |
| **Freshness** | Has this topic or a similar angle been covered in recent drafts? (Check the "recently covered" list from Phase 1a.) Lower score if it overlaps. |

Sum the scores. Pick the highest-scoring topic. In case of a tie, prefer the candidate with the higher freshness score.

Record the selected topic and its scores — this will be included in the completion report.

## Phase 3: Determine Target Newsletter

Check `newsletters/` for subfolders.

**Single newsletter:** If only one subfolder exists, use it. Done.

**Multiple newsletters:** If multiple subfolders exist:

1. Check each subfolder for a `config.yaml` file
2. Read each `config.yaml` to understand that newsletter's focus, audience, and cadence
3. Match the selected topic to the newsletter whose config best fits
4. If no config files exist, pick the newsletter whose name best matches the topic, or default to the first folder alphabetically

Record which newsletter was selected and why.

## Phase 4: Research & Fact Gathering

Now that the topic is locked, go deep:

1. **Web research** — Search for recent articles, data points, studies, quotes, and examples related to the chosen topic. Aim for:
   - 2–3 concrete data points or statistics
   - 1–2 real-world examples or case studies
   - Relevant quotes from credible sources
   - Any counterarguments or nuance worth acknowledging

2. **Source-specific research** — If the topic was inspired by a specific source from `sources.yaml`, dig deeper into that source's recent content on the subject. Pull specific frameworks, ideas, or language they used (to reference, not to copy).

3. **Brand-aligned framing** — Re-read the messaging pillars and unique POV section of `brand-profile.md`. Determine:
   - Which pillar(s) this topic connects to
   - What the brand's distinct take on this topic would be
   - How to frame the research through the brand's lens rather than just reporting facts

Compile all research into organized notes before drafting. Do not start writing until research is complete.

## Phase 5: Drafting

### Template selection

Default to the `standard-weekly` template from `.claude/skills/newsletter/templates/standard-weekly.md` unless:
- The newsletter's `config.yaml` specifies a different default template
- The topic clearly demands a different format

Read the selected template file for structural guidance.

### Writing rules

1. **Voice first.** Write in the voice defined by `style-profile.md`. Match sentence length, vocabulary level, punctuation habits, paragraph density, and personality. The draft should sound like the client wrote it.

2. **Brand lens.** Every paragraph should serve at least one messaging pillar. If a section does not connect back to the brand's core themes, cut it or reframe it.

3. **Formatting.** Follow the formatting preferences from `brand-profile.md` (emoji use, header style, list usage, etc.). When in doubt, keep it clean and minimal.

4. **Attribution.** When drawing heavily from a specific thinker or source, attribute the idea naturally (e.g., "As [Name] puts it..." or "A framework from [Name]'s work..."). Never present someone else's original framework as the client's own.

5. **Length.** Target 600–1000 words unless the newsletter's config specifies a different range. Quality over quantity — a tight 600-word piece beats a padded 1000-word one.

6. **Subject line.** Write 3 subject line options. The best one goes in the draft; the other two go in a comment block at the top of the file for the client to choose from.

## Phase 6: Self-Edit

Before saving, run through this editing checklist:

1. **Voice check** — Read the draft against `style-profile.md`. Flag and fix any sections that drift from the established voice.
2. **Brand check** — Does every section connect to a messaging pillar? Is the unique POV present?
3. **Tone check** — Does the tone match the guidelines in `brand-profile.md`? (e.g., if the brand says "confident, not arrogant," check for arrogance.)
4. **Topics check** — Does the draft touch any topics listed under "Avoid" in `brand-profile.md`? If so, rewrite or remove those sections.
5. **Freshness check** — Final confirmation that this topic/angle was not covered in recent drafts.
6. **Clarity pass** — Remove jargon, tighten sentences, cut filler. Every sentence should earn its place.
7. **Formatting pass** — Ensure consistent heading levels, proper spacing, and clean markdown.
8. **Fact check** — Verify any statistics, quotes, or claims included. If something cannot be verified, soften the language or remove it.

Make all edits. Do not present the first draft as the final output.

## Phase 7: Format & Deliver

### File naming

Save the draft as:

```
newsletters/[newsletter-name]/drafts/YYYY-MM-DD-[slug].md
```

Where:
- `YYYY-MM-DD` is today's date
- `[slug]` is a short kebab-case version of the topic (e.g., `why-boring-wins`, `leadership-in-uncertainty`)

### File structure

The saved file must include YAML frontmatter:

```markdown
---
date: "YYYY-MM-DD"
topic: "The topic in plain language"
newsletter: "[newsletter-name]"
template: "standard-weekly"
status: "draft"
source_inspiration: ["source1", "source2"]
---

<!-- SUBJECT LINE OPTIONS:
1. [selected subject line — used below]
2. [alternative subject line]
3. [alternative subject line]
-->

[Full newsletter content here]
```

### Save the file

Write the file to the appropriate drafts folder. Confirm the file was written successfully.

## Phase 8: Completion Report

After saving the draft, present a summary:

```
NEWSLETTER DRAFT COMPLETE

Topic: [selected topic]
Newsletter: [newsletter name]
File: [full path to saved draft]

Why this topic:
- Brand fit: [score]/5 — [one-line explanation]
- Audience relevance: [score]/5 — [one-line explanation]
- Timeliness: [score]/5 — [one-line explanation]
- Freshness: [score]/5 — [one-line explanation]

Sources used: [list of sources that informed the piece]

Needs attention:
- [Any uncertainties, e.g., "I referenced a statistic from [source] but couldn't verify the exact number — you may want to double-check."]
- [Any topic adjacencies, e.g., "This brushes up against [avoided topic] — I stayed clear but you might want to review the framing."]
- [Or: "None — draft looks clean."]
```

## Error Handling

- **No sources.yaml:** Proceed without source research. Rely on brand profile for topic generation.
- **Empty drafts folder:** No freshness concerns — all topics are fair game.
- **Multiple newsletters, no config.yaml files:** Default to the first newsletter folder alphabetically and note this in the completion report.
- **Web search unavailable:** Draft based on existing knowledge and the brand profile. Note in the completion report that research was limited.
- **Brand profile exists but is sparse:** Work with what is available. Note gaps in the completion report.

## Rules

- Never fabricate quotes, statistics, or sources. If you cannot find supporting evidence, write the piece without it or soften claims to opinions.
- Never cover topics listed under "Avoid" in `brand-profile.md`.
- Never copy language directly from sources. Synthesize and reframe through the client's voice.
- Never skip the self-edit phase. The first draft is never the final draft.
- Never save a draft without YAML frontmatter.
- Always attribute ideas when drawing from a specific thinker's framework.
- Always check for topic repetition against recent drafts before committing to a topic.
- Always use the client's voice as defined in `style-profile.md` — not a generic "newsletter" voice.
HEREDOC_EOF

# ===================================================================
# sources.yaml
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/sources.yaml"
# Inspiration Sources
# Managed by the /add-source skill — you don't need to edit this file directly.
# Just tell Claude: "Add [person/newsletter/website] to my sources"

thought_leaders: []

business_figures: []

newsletters: []

websites: []

research_instructions: |
  When researching for a newsletter:
  1. Check if any thought leader has a relevant framework for the topic
  2. Look for recent posts/articles from business figures on the topic
  3. Cross-reference with newsletters for trending angles
  4. Pull philosophical depth from thought leaders, practical angle from business figures
  5. Never copy — synthesize. The client's voice and brand come first.
  6. Always attribute ideas when drawing heavily from a specific thinker
HEREDOC_EOF

# ===================================================================
# newsletters/my-newsletter/config.yaml
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/newsletters/my-newsletter/config.yaml"
# Newsletter Configuration
# Updated automatically during onboarding or when you tell Claude to change settings.

name: ""
description: ""
audience: ""
frequency: "weekly"
default_template: "standard-weekly"
topics: []
HEREDOC_EOF

# ===================================================================
# QUICKSTART.md
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/QUICKSTART.md"
# Your Newsletter Tool -- Quick Start Guide

Welcome! This tool writes newsletter drafts for you, in your voice, based on your brand. You talk to it like a person, and it does the heavy lifting.

Here's everything you need to know.

---

## Opening the Tool

Open the **Claude Code** app on your computer. It automatically opens in your newsletter folder -- you don't need to navigate anywhere or set anything up. Just open it and start talking.

---

## Writing a Newsletter

You have several ways to kick off a new newsletter. Pick whichever feels most natural.

### Give it a topic

Just tell it what you want to write about:

```
/newsletter "topic: why vulnerability is a leadership superpower"
```

### Let it find a topic for you

Not sure what to write about this week? No problem. Just type:

```
/newsletter
```

It will research what's trending in your space, look at your sources and past newsletters, and suggest 3 topic options for you to pick from.

### Give it a link or idea

Found an article that sparked something? Paste the link:

```
/newsletter "based on this article: https://example.com/great-article"
```

### Reference a thinker

Want to riff on someone's ideas? Just say so:

```
/newsletter "riff on Taleb's idea of antifragility applied to small business"
```

### Or just talk naturally

You don't have to use any special format. Just say what you want in plain English:

```
Write this week's newsletter about delegation
```

```
I want to talk about why most founders are bad at hiring
```

```
Can you do something on the difference between being busy and being productive?
```

All of these work. The tool understands natural language -- just tell it what's on your mind.

---

## What Happens After You Start

Once you give it a direction, here's what happens behind the scenes:

1. **Research** -- It pulls from your sources (the thought leaders, newsletters, and websites you've set up) to find relevant ideas, frameworks, and angles.
2. **Draft** -- It writes a full draft in your voice, following your brand profile and style.
3. **Save** -- The draft is saved automatically in your newsletters folder. Nothing gets lost.
4. **Review** -- It shows you the draft and asks for your feedback.

You're always in control. It won't publish anything -- it just writes drafts for you to review, edit, and approve.

---

## Newsletter Templates

You can ask for different formats depending on what the newsletter calls for:

- **Standard Weekly** -- Your regular newsletter. One topic, your take, practical insight.
- **Deep Dive** -- A longer, more thorough exploration of a single idea.
- **Curated Links** -- A roundup of interesting links, articles, and resources with your commentary.
- **Announcement** -- When you have news to share (a launch, an event, a milestone).

You can request a specific format like this:

```
/newsletter "topic: pricing your services — use the deep dive template"
```

Or just tell it what you need and it will pick the right one.

---

## Other Things You Can Do

### Add or remove sources

Your sources are the thinkers, newsletters, and websites the tool draws from when researching. You can manage them anytime:

```
/add-source Ryan Holiday
```

```
/add-source "remove Morning Brew"
```

```
/add-source
```

That last one (with no name) shows you everything currently in your sources list.

### Update your brand profile

If your brand evolves -- new positioning, new audience, new values -- you can refresh your brand profile:

```
/digest-brand
```

It will walk you through updating it, or you can paste in a new brand document.

### Update your writing style

If the drafts don't quite sound like you, or your style has shifted, you can recalibrate:

```
/style-capture
```

It will ask you a few questions or look at new writing samples to fine-tune how it captures your voice.

---

## Tips for Getting the Best Results

- **Give feedback on drafts.** The more you tell it what you like and don't like, the better the next draft will be. "I love the opening but the ending feels generic" is exactly the kind of feedback that helps.

- **Ask for rewrites.** Don't settle. Say "rewrite the second section with more of a personal story" or "make the whole thing shorter and punchier." It's happy to iterate.

- **Reference specific thinkers.** If you want to bring in a particular framework or idea, name the person. "Tie in Brene Brown's work on courage" gives it a clear direction.

- **Share what's going on in your world.** Context helps. "I just had a frustrating client call about scope creep" can become a powerful newsletter angle.

- **Don't worry about being too specific or too vague.** It works with whatever you give it. A single sentence is enough to start. A full outline is great too.

---

## One Last Thing

**Your drafts are always saved automatically.** If your computer restarts, if you close the app, if you walk away for a week -- your work is still there. You'll never lose a draft.

If you ever get stuck or aren't sure what to do, just ask. Type "help" or "what can you do?" and it will walk you through your options.

Happy writing!
HEREDOC_EOF

# ===================================================================
# README.md
# ===================================================================
cat <<'HEREDOC_EOF' > "$NEWSLETTER_DIR/README.md"
# ai-newsletter-kit

A Claude Code skill system for automated newsletter creation. Designed to let non-technical clients produce on-brand newsletters through natural conversation with Claude Code.

## Overview

This project is a portable, client-specific newsletter automation kit. It runs entirely within Claude Code -- no external services, no databases, no build steps. The "application" is a structured folder with Claude Code skills, identity profiles, and source configurations that together enable a conversational newsletter workflow.

Each client gets their own copy of this kit, calibrated to their brand, voice, and sources. The skills handle everything from onboarding (brand + style profiling) to weekly newsletter drafting.

## Architecture

### Two Profiles

The system relies on two identity documents that skills read at runtime:

1. **`identity/brand-profile.md`** -- What the brand stands for: audience, values, messaging pillars, tone guidelines, topics to cover/avoid. Generated by the `/digest-brand` skill.

2. **`identity/style-profile.md`** -- How the client writes: sentence patterns, vocabulary, rhetorical devices, rhythm, voice characteristics. Generated by the `/style-capture` skill.

These profiles are the source of truth for all content generation. The `/newsletter` skill reads both before drafting.

### Sources Config

**`sources.yaml`** (project root) defines the thought leaders, business figures, newsletters, and websites the system draws from during research. Managed via the `/add-source` skill. Includes a `research_instructions` block that guides how sources are prioritized during newsletter research.

### Skills

All skills live in `.claude/skills/` and follow Claude Code's skill convention (each has a `SKILL.md`).

| Skill | Purpose | Output |
|-------|---------|--------|
| `/digest-brand` | Ingest brand document or run conversational interview to produce brand profile | `identity/brand-profile.md` |
| `/style-capture` | Analyze writing samples (or interview) to produce a 7-dimension style DNA profile | `identity/style-profile.md` |
| `/add-source` | Add, remove, update, or list inspiration sources | `sources.yaml` |
| `/newsletter` | Research, draft, and save a newsletter issue | `newsletters/<name>/drafts/<date>-<slug>.md` |
| `/import-voice` | (Planned) Import voice data from alternative formats | TBD |

### Newsletter Storage

```
newsletters/
  my-newsletter/              # One folder per newsletter series
    drafts/                    # Working drafts (auto-saved here)
    published/                 # Final versions moved here after approval
```

Each newsletter series gets its own subfolder. Multiple series per client are supported (see "Cloning for a second newsletter" below).

## File Structure

```
Newsletter/
|
|-- .claude/
|   |-- agents/
|   |   |-- newsletter-writer.md
|   |-- skills/
|       |-- add-source/
|       |   |-- SKILL.md
|       |-- digest-brand/
|       |   |-- SKILL.md
|       |-- newsletter/
|       |   |-- SKILL.md
|       |   |-- templates/
|       |       |-- standard-weekly.md
|       |       |-- deep-dive.md
|       |       |-- curated-links.md
|       |       |-- announcement.md
|       |-- style-capture/
|           |-- SKILL.md
|
|-- identity/
|   |-- brand-document-original/
|   |-- writing-samples/
|   |-- brand-profile.md
|   |-- style-profile.md
|
|-- newsletters/
|   |-- my-newsletter/
|       |-- config.yaml
|       |-- drafts/
|       |-- published/
|
|-- sources.yaml
|-- QUICKSTART.md
|-- README.md
```

### Client-Specific vs. Reusable

| Client-specific (unique per deployment) | Reusable (same across all clients) |
|-----------------------------------------|-------------------------------------|
| `identity/brand-profile.md` | `.claude/skills/*/SKILL.md` |
| `identity/style-profile.md` | `QUICKSTART.md` (mostly -- may need light personalization) |
| `identity/brand-document-original/*` | `README.md` |
| `identity/writing-samples/*` | `.claude/agents/` (when populated) |
| `sources.yaml` | Newsletter templates |
| `newsletters/` contents | |

## Setting Up for a New Client

### 1. Copy the folder

Duplicate the Newsletter folder to a new location. Rename if desired. Clean out any client-specific files:

```bash
# Clone the kit
cp -r ~/Newsletter/ ~/clients/<client-name>-newsletter/

# Remove previous client's identity and content
rm -f ~/clients/<client-name>-newsletter/identity/brand-profile.md
rm -f ~/clients/<client-name>-newsletter/identity/style-profile.md
rm -rf ~/clients/<client-name>-newsletter/identity/brand-document-original/*
rm -rf ~/clients/<client-name>-newsletter/identity/writing-samples/*
rm -f ~/clients/<client-name>-newsletter/sources.yaml
rm -rf ~/clients/<client-name>-newsletter/newsletters/my-newsletter/drafts/*
rm -rf ~/clients/<client-name>-newsletter/newsletters/my-newsletter/published/*
```

Rename the newsletter series folder if "my-newsletter" doesn't fit the new client:

```bash
mv ~/clients/<client-name>-newsletter/newsletters/my-newsletter \
   ~/clients/<client-name>-newsletter/newsletters/<series-name>
```

### 2. Install Claude Code on the client's machine

The client needs Claude Code installed and configured. Point their default project directory at the newsletter kit folder so it opens there automatically.

### 3. Walk through onboarding (or let auto-onboarding handle it)

Onboarding involves two steps that can happen in either order:

**Brand profile** -- Either:
- Drop the client's brand document into `identity/brand-document-original/` and run `/digest-brand`, or
- Run `/digest-brand` with no document and let the conversational interview guide them through it.

**Style profile** -- Either:
- Drop 3-5 writing samples into `identity/writing-samples/` and run `/style-capture`, or
- Run `/style-capture` with no samples and use the interview mode.

Both skills are designed to be client-friendly. The client can run them on their own if given the QUICKSTART guide.

### 4. Calibrate brand + style profiles

After initial generation, review both profiles:

- Read `identity/brand-profile.md` -- does it capture the brand accurately?
- Read `identity/style-profile.md` -- does the Quick Reference section match the client's voice?

Have the client review and iterate. Both skills support version bumping and re-runs.

### 5. Populate sources

Run `/add-source` to add the thought leaders, business figures, newsletters, and websites the client draws inspiration from. This populates `sources.yaml` and directly affects research quality during newsletter drafting.

Start with 5-10 sources across categories. The client can add more over time.

## Cloning for a Second Newsletter (Same Client)

If a client wants a second newsletter series (e.g., a monthly deep-dive in addition to their weekly):

1. Create a new series folder:

```bash
mkdir -p newsletters/<new-series-name>/drafts
mkdir -p newsletters/<new-series-name>/published
```

2. The identity profiles and sources are shared across series -- no duplication needed. The `/newsletter` skill should be told which series to target when invoked, or the skill can be extended to ask.

3. If the second newsletter has a different voice or brand angle, consider whether the existing profiles are sufficient or if additional profile variants are needed. For most clients, one brand profile and one style profile cover all their newsletters.

## Updating Skills Across Clients

Skills (`.claude/skills/*/SKILL.md`) are the reusable core. When you improve a skill:

1. Make the change in the canonical source (this repo or your template repo).
2. Copy the updated `SKILL.md` to each client's kit:

```bash
# Example: update the newsletter skill for all clients
for client_dir in ~/clients/*-newsletter/; do
  cp ai-newsletter-kit/.claude/skills/newsletter/SKILL.md \
     "$client_dir/.claude/skills/newsletter/SKILL.md"
done
```

3. Client-specific files (`identity/`, `sources.yaml`, `newsletters/`) are never touched during skill updates.

Consider version-tagging skill updates (in the SKILL.md frontmatter or a changelog) to track which clients are on which version.

## Development Notes

- **No runtime dependencies.** This is pure Claude Code skills + structured files. No packages, no build, no deploy.
- **Skills are the API.** Each skill's `SKILL.md` defines inputs, outputs, and behavior. Treat them as contracts.
- **Identity profiles have YAML frontmatter** with `version` fields. Always increment on update, never overwrite silently.
- **`sources.yaml` has a `research_instructions` block** that must be preserved on every write. Skills that modify sources must read and re-emit this block.
- **The `/import-voice` skill** is stubbed out but not yet implemented. Intended for importing voice data from formats beyond plain text samples.
- **Templates** (`newsletter/templates/`) define the structural scaffolding for Standard Weekly, Deep Dive, Curated Links, and Announcement formats.
HEREDOC_EOF

# -------------------------------------------------------------------
# 5. Done
# -------------------------------------------------------------------
echo "Newsletter workspace created at ~/Newsletter/"
