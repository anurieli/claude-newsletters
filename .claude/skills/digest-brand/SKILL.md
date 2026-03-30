# Skill: digest-brand

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
