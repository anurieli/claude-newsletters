# ai-newsletter-kit

> **Don't have a brand yet?** Start with the **[Brand Kit](../brand/)** first. It walks you through building your brand identity, voice, and visual style — the foundation that this kit reads from. You can also set up your brand directly inside this kit, but starting with the Brand Kit means every content kit stays in sync from day one.

**For bloggers, Substack writers, Beehiiv creators, Medium authors, and anyone who writes long-form content for an audience.** You have your voice. You have your brand. You just want to go from idea to a finished, publish-ready piece — without all the editing and finicking.

This kit captures how you write, learns your brand, and lets you go from "I want to write about X" to a polished draft in your voice. You review it, tweak what you want, and hit publish.

---

## Before You Start

You need three things installed before using this kit. None of them cost money.

### 1. Claude App

Download and install the Claude desktop app. This is where you'll interact with the kit — it's your writing partner interface.

- **Download:** [claude.ai/download](https://claude.ai/download)
- Install it and sign in with your Claude account
- That's it — no terminal commands, no configuration

### 2. Google Chrome

The kit uses Chrome to read newsletters, blogs, and websites when researching your content. It browses the web the same way you do — which means it can read anything you can, including newsletters you're subscribed to.

- **Download:** [google.com/chrome](https://www.google.com/chrome/) (skip if you already have it)

### 3. Connect Claude to Chrome

This is what lets Claude browse the web on your behalf — visiting your inspiration sources, reading articles, and pulling in real quotes and ideas for your newsletters.

**Setup steps:**

1. Install the **Claude in Chrome** extension from the Chrome Web Store
   <!-- TODO: Add direct Chrome Web Store link when available -->
2. Open the Claude desktop app
3. Go to **Settings** and find the **MCP Servers** section
4. Enable the **Chrome** connection
5. You should see a small connection indicator confirming Claude can talk to Chrome

<!-- If you'd like to add a screenshot of the settings screen here, drop it in and I'll reference it. -->

> **Why Chrome?** Other tools like Firecrawl exist for web scraping, but they require API keys, billing accounts, and technical setup. Chrome just works — you already have it, and Claude uses your actual browser session. If you're logged into a Substack or any newsletter platform, Claude can read it too.

---

## Overview

This project is a portable newsletter automation kit powered by Claude Code. No external services, no databases, no build steps. It's a structured folder with skills, identity profiles, and source configurations that together enable a conversational newsletter workflow.

Each user gets their own copy of this kit, calibrated to their brand, voice, and sources. The skills handle everything from onboarding (brand + style profiling) to weekly newsletter drafting.

## How It Works

When you say "write a newsletter about X," here's what actually happens:

1. **Claude reads your files.** It loads your brand profile, voice profile, and inspiration sources. This is how it knows who you are, how you write, and what thinkers and frameworks to draw from.

2. **It matches the topic to your brand.** Does this fit your messaging pillars? Which thought leaders have relevant frameworks? What angle would resonate with your audience? Claude builds a brief and confirms it with you.

3. **It researches.** If Chrome is connected, Claude visits your inspiration sources — the actual newsletters and websites you follow — and reads what they've published recently. It also runs web searches for current data, examples, and trending perspectives. Everything gets cross-referenced with your curated sources for depth. Attribution is tracked so references are woven in naturally.

4. **It drafts in your voice.** Using your chosen template (standard weekly, deep dive, curated links, or announcement) and your 7-dimension voice profile — matching your sentence rhythms, vocabulary, tone, and rhetorical patterns.

5. **It self-edits before you see it.** Checks against your voice profile (does this sound like them?), your brand (on-message? right audience?), source integrity (quotes accurate? claims verified?), and flow (strong opening? smooth transitions? ending that lands?).

6. **You review and iterate.** Claude presents the draft, you give feedback, it revises. Recurring corrections get saved to your voice profile so future newsletters improve.

The whole thing takes minutes. Your newsletter is saved as a draft file ready for your email platform.

### Keeping It Fresh

Your brand and voice aren't set in stone. Update them anytime:

- **"Update my brand"** or **"my positioning has shifted"** — Claude walks you through what's changed and updates your brand profile.
- **"My writing style has changed"** or **"here are new writing samples"** — Claude re-analyzes your voice or interviews you about what's different.
- **"Add [person] to my sources"** — Claude researches them and adds them to your sources file. If Chrome is connected, it visits their site to learn what they write about.
- **"What has [source] been writing about?"** — Claude opens your source's website in Chrome, reads their recent posts, and gives you a summary of themes and ideas. Great for finding inspiration before you write.

## What You Can Do (With Examples)

You don't need to memorize commands. Just talk naturally. Here's everything the kit can do:

### Write a newsletter

The main event. Tell it a topic and it handles research, drafting, and saving.

```
Write a newsletter about why most people overthink their first hire
```
```
Draft something about the difference between being busy and being productive
```
```
I want to write about pricing — riff on Hormozi's value equation
```

### Get topic ideas

Not sure what to write about this week? Just ask.

```
What should I write about this week?
```
```
I'm stuck — give me some ideas
```

### See what your sources are writing about

Claude opens their actual website or newsletter in Chrome and reads their latest posts — real content, not just a Google search.

```
What has Lenny's Newsletter been writing about lately?
```
```
Go check what Morning Brew published this week
```
```
Read Stratechery's latest and tell me the main ideas
```

### Add or manage inspiration sources

Your sources are the thinkers, newsletters, and websites Claude draws from during research.

```
Add Seth Godin to my sources
```
```
Add the Hustle newsletter
```
```
Who are my current sources?
```

### Add a TLDR / teaser

After you have a draft, you can add a one-sentence teaser to the top. This isn't a summary — it's a curiosity hook that makes readers need to start reading. Claude will analyze the whole piece, find the most interesting or surprising element, and craft a line that opens a curiosity gap. You get 3 options to pick from.

```
Write a TLDR for this draft
```
```
Add a teaser to the top
```
```
Give me a hook line for this piece
```

Claude will also offer to write one after every newsletter draft automatically.

### Update your brand

If your positioning, audience, or messaging shifts.

```
My audience is shifting more toward solopreneurs
```
```
Here's my updated brand doc
```

### Refine your voice

This is the secret weapon. Push back on drafts — not just word choices, but structure, tone, format, everything. Claude learns from every correction and permanently updates the voice profile.

```
That doesn't sound like me — I'd say it more like this: [your version]
```
```
The intro is too long. I always do one line then dive straight in.
```
```
I never open with the thesis. Tell a story first, then get to the point.
```
```
Too corporate. I write like I'm texting a smart friend.
```
```
I always end with a question to the reader, not a summary.
```
```
Here are some new blog posts I wrote
```

Every correction trains the voice profile. The third time Claude sees the same pattern, it becomes a permanent rule. Early feedback compounds — the more you push back in the first few drafts, the faster it nails your voice.

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
| `/add-source` | Add, remove, update, or list inspiration sources. Visits source URLs via Chrome for richer data | `sources.yaml` |
| `/read-source` | Browse a source's website/newsletter in Chrome and summarize recent topics and ideas | Conversation (optionally saved to `sources-research/`) |
| `/newsletter` | Research (including live Chrome browsing of sources), draft, and save a newsletter issue | `newsletters/<name>/drafts/<date>-<slug>.md` |
| `/tldr` | Generate a one-sentence curiosity hook for the top of any newsletter draft | TLDR added to draft file |
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
|       |-- read-source/
|       |   |-- SKILL.md
|       |-- style-capture/
|       |   |-- SKILL.md
|       |-- tldr/
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

Duplicate the ai-newsletter-kit folder to a new location. Rename if desired. Clean out any client-specific files:

```bash
# Clone the kit
cp -r ~/ai-newsletter-kit/ ~/clients/<client-name>-newsletter/

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
