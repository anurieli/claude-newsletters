# TLDR Skill

Generate a single-sentence teaser that makes readers *need* to read the full piece. Not a summary — a curiosity hook.

## Trigger

Activate when the user says `/tldr` or asks for a TLDR, teaser, preview line, or hook sentence for a newsletter or article.

## Important — Communication Style

The client is not technical. All communication must be warm, clear, and in plain language. Never show file paths, config details, or internal process mechanics unless she explicitly asks.

---

## What a TLDR Is (and Isn't)

A TLDR in this system is **not a summary.** It's the opposite — it's a curiosity engine. The reader should finish the TLDR sentence and feel an itch they can only scratch by reading the full piece.

**What it is:**
- One sentence (occasionally two short ones)
- Opens a curiosity gap — gives enough to hook, not enough to satisfy
- Captures the core *tension* or *surprise* of the piece, not the conclusion
- Written in the client's voice

**What it is NOT:**
- A summary of the article's main points
- A thesis statement
- A table of contents ("In this issue, I cover...")
- A generic teaser ("You won't believe what happened next")

### Examples of good vs. bad

**Bad:** "This newsletter is about why most founders struggle with hiring." (Summary — no gap)

**Bad:** "In this issue, I discuss three frameworks for better hiring decisions." (Table of contents — no pull)

**Bad:** "Hiring is one of the most important things a founder does." (Obvious statement — no tension)

**Good:** "Most founders think their hiring problem is finding talent — it's actually something they're doing in the first 5 minutes of every interview."

**Good:** "I spent 3 years hiring for culture fit before I realized culture fit was the thing destroying my culture."

**Good:** "There's a question I ask in every interview now that has nothing to do with the job — and it's the only one that actually predicts success."

The pattern: **specific enough to be intriguing, incomplete enough to demand the full read.**

---

## Process

### Step 1: Load voice

Read `identity/style-profile.md` fresh. The TLDR must sound like the client wrote it — same rhythm, same vocabulary, same tone. A perfectly crafted hook in the wrong voice is useless.

### Step 2: Deep analysis

Read the full piece carefully. Do not skim. Identify:

1. **The core argument** — What is this piece actually saying? Not the topic, the *point*. Strip away all supporting material and find the one sentence that everything else serves.

2. **The surprise** — What's the most counterintuitive, unexpected, or contrarian element? This is often the best hook material. Look for:
   - Conventional wisdom being challenged
   - An unexpected cause-and-effect relationship
   - A paradox or contradiction
   - A specific detail that reframes the whole topic

3. **The tension** — What's the central conflict, question, or unresolved problem? What makes someone care about this *before* they know the answer?

4. **The specificity** — Find the most concrete, vivid detail in the piece. Specificity creates credibility and curiosity simultaneously. A TLDR that says "a surprising thing about hiring" is weaker than one that says "something that happens in the first 5 minutes of every interview."

### Step 3: Craft the TLDR

Using the analysis above, write one sentence that:

- **Opens a curiosity gap** — Gives the reader enough to understand the territory, but withholds the resolution
- **Uses the surprise or tension** as the hook mechanism
- **Includes at least one specific detail** — a number, a timeframe, a named thing, a concrete action
- **Matches the client's voice** — sentence length, vocabulary, tone, and rhythm from the style profile
- **Stands alone** — Makes sense without any context. Someone seeing just this sentence (in an email preview, a social post, an RSS feed) should feel pulled to read more

### Step 4: Generate alternatives

Produce 3 TLDR options using different hook strategies:

1. **The gap** — States something surprising but withholds the key detail ("There's one question I stopped asking in interviews — and it doubled my retention rate.")
2. **The flip** — Inverts an assumption ("The best hire I ever made was the person who failed my interview.")
3. **The specificity** — Leads with a vivid, concrete detail that raises questions ("It took exactly 11 minutes for me to realize I'd been hiring wrong for a decade.")

Not every strategy works for every piece. If one feels forced, replace it with a natural alternative. The goal is variety in approach, not forced adherence to a formula.

### Step 5: Present to the client

Show all 3 options with brief context on why each works differently:

> "Here are three TLDR options for the top of your piece:"
>
> 1. [Option 1]
> 2. [Option 2]
> 3. [Option 3]
>
> "I'd go with #[N] — [one-line reason]. But pick whichever sounds most like you."

Wait for the client to choose. If they want to tweak one, help them refine it.

### Step 6: Place it

Once chosen, add the TLDR to the top of the newsletter draft, immediately after the frontmatter and subject line block, before the content begins:

```markdown
**TLDR:** [chosen teaser line]

---

[Newsletter content starts here]
```

Save the updated draft file.

---

## Standalone Mode

When invoked on its own (`/tldr` or "write a TLDR for my latest draft"):

1. Find the most recent draft in `newsletters/*/drafts/` (by date in filename)
2. If multiple newsletters exist and it's unclear which one, ask the client
3. Run the full process above
4. Save the updated draft with the TLDR added

If the client pastes or references a specific piece of text (not a saved draft), run the analysis on that text and present the options without saving.

---

## Integration with Newsletter Skill

When called as part of the `/newsletter` flow (Phase 5), the process is the same but the interaction is streamlined:

> "Want a TLDR for the top? It's a one-line teaser that hooks readers before they start — great for email previews and social sharing."

If yes, generate and present options. If no, skip and move on. Do not push — some clients prefer to jump straight into the piece.

---

## Self-Edit

Before presenting TLDR options, check each one against:

1. **Curiosity test** — Does this make you want to read the piece? If the TLDR satisfies the reader's curiosity, it failed. It should *create* curiosity, not resolve it.
2. **Specificity test** — Is there at least one concrete detail? Vague teasers feel generic.
3. **Voice test** — Does this sound like the client? Check against `style-profile.md`.
4. **Standalone test** — Does it make sense without any surrounding context?
5. **Honesty test** — Does the TLDR accurately represent what the piece delivers? It should hook without misleading.

If any option fails a test, revise it before presenting.

---

## Rules

- Never summarize the article. The TLDR replaces nothing — it adds pull.
- Never reveal the main conclusion or punchline. The TLDR opens a door; the article walks through it.
- Never use clickbait formulas ("You won't believe...", "This one weird trick..."). The hook should feel like the client's voice, not a content mill.
- Never use the word "TLDR" in the teaser itself. The label is in the formatting; the sentence is pure content.
- Always match the client's voice. A great hook in the wrong voice is worse than no hook at all.
- Always offer options. Different readers respond to different hook types. Give the client choice.
