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

You need **at least 2-3 samples** (ideally 5 or more) for an accurate profile. This is a hard minimum — do NOT silently proceed with just 1 sample, even if it was already shared during another step (like brand setup).

**If you have only 1 sample:**
- Do NOT proceed to analysis. Instead, return to the caller (the main conversation) and tell them: "I have one sample so far. I need at least 1-2 more pieces to build a reliable voice profile. Ask the client for more writing samples before I proceed."
- If the caller insists on proceeding with 1 sample, you may do so but you MUST: (a) supplement heavily with interview questions, (b) mark the profile as low confidence in the Profile Notes section, and (c) include a prominent note recommending the client add more samples.

**If you have 2 samples:**
- You can proceed, but note in the Profile Notes that confidence would improve with more samples.

**If you have 3+ samples:**
- Proceed with full confidence.

In all cases, if fewer than 3 are available:
- Tell the client plainly: "I have [N] sample(s) so far. I can work with this, but the profile will be more accurate with 3-5 pieces of your writing. Want to add more, or should I ask you some questions to fill in the gaps?"
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
