# AI Newsletter Kit

A Claude Code skill system that writes newsletters in your voice. Open Claude Code, paste one line, start publishing.

---

## Quick Start

### For Non-Devs (No Terminal Required)

1. **Install Claude Code** — download the desktop app from [claude.ai/download](https://claude.ai/download)
2. **Open Claude Code** and paste this message:

```
Set up my newsletter workspace using the guide at https://raw.githubusercontent.com/anurieli/ai-newsletter-kit/main/newsletter-setup.md
```

3. **Claude sets everything up** and walks you through onboarding — your brand, your voice, your sources, and a test draft.

4. **When setup is done**, Claude tells you to open **Claude Cowork** (the desktop app) and open a project pointing to your new folder. That's your newsletter studio from now on.

### For Devs

```bash
git clone https://github.com/anurieli/ai-newsletter-kit.git ~/ai-newsletter-kit
cd ~/ai-newsletter-kit
claude
```

Say hi — onboarding kicks in. After setup, open the folder as a project in Claude Cowork for day-to-day use.

---

## What You Get

When setup finishes, you have a folder on your computer called `ai-newsletter-kit`. This folder is your newsletter — it holds everything Claude needs to write in your voice:

- **Your brand profile** — who you are, who you serve, what you stand for
- **Your writing voice** — how you sound on the page, captured from your own writing
- **Your inspiration sources** — the thinkers, authors, and newsletters you draw from
- **Your drafts** — every newsletter Claude writes, automatically saved
- **The skills** — the instructions that tell Claude how to research, write, and edit for you

You can **rename this folder to anything you want** at any time. Call it `leadership-weekly`, `my-newsletter`, your brand name — whatever makes sense to you. Nothing will break. Claude doesn't care what the folder is called. It reads the files inside, not the folder name.

---

## Creating Another Newsletter (Different Brand / Voice)

Want a second newsletter with a completely different brand, voice, or audience? Paste the same setup line into Claude Code again:

```
Set up my newsletter workspace using the guide at https://raw.githubusercontent.com/anurieli/ai-newsletter-kit/main/newsletter-setup.md
```

Here's what happens:

1. Your existing `ai-newsletter-kit` folder gets **backed up automatically** (renamed with a timestamp — nothing is lost)
2. A fresh `ai-newsletter-kit` folder is created
3. Claude walks you through onboarding again — new brand, new voice, new sources
4. When you're done, **rename the folder** to tell them apart

**Example:** After two setups, you might have:

```
~/leadership-weekly/        ← your first newsletter (renamed from ai-newsletter-kit)
~/wellness-monthly/         ← your second newsletter (renamed from ai-newsletter-kit)
```

Each folder is completely independent. Different brand, different voice, different sources, different drafts. Open Claude Cowork, point it at whichever folder you want to work in.

---

## What This Does

You talk to Claude. It writes newsletters that sound like you.

The system learns your brand, your writing voice, and your inspiration sources. Then when you say "write a newsletter about delegation," it researches, drafts, self-edits, and delivers — all in your voice, aligned to your brand.

### The Skills

| Skill | What it does |
|-------|-------------|
| `/digest-brand` | Ingests your brand document (or interviews you) → generates your brand profile |
| `/style-capture` | Analyzes your writing samples (or interviews you) → captures your writing voice |
| `/add-source` | Manages your inspiration sources — thought leaders, newsletters, websites |
| `/newsletter` | The main pipeline: topic → research → draft → self-edit → deliver |

You don't need to memorize these. Just talk to Claude naturally — "write a newsletter about X", "add Seth Godin to my sources", "update my brand to focus more on leadership." Claude figures out which skill to use.

### Newsletter Templates

- **Standard Weekly** — One main story + quick takes (default)
- **Deep Dive** — Long-form, single topic
- **Curated Links** — Commentary on 5-7 links
- **Announcement** — Short, one message + CTA

### The Agent

`newsletter-writer` — An autonomous agent that can run on a schedule. Picks a topic from your sources, drafts a newsletter, saves it for review. Hands-off mode.

---

## How It Works

### Two Profiles

1. **Brand Profile** (`identity/brand-profile.md`) — What your brand stands for: audience, values, messaging pillars, tone, topics to cover/avoid
2. **Style Profile** (`identity/style-profile.md`) — How you write: sentence patterns, vocabulary, rhythm, rhetorical devices, voice characteristics

Every draft is filtered through both. Brand governs *what* you say. Style governs *how* you say it.

### Sources Library

`sources.yaml` — Your curated thought leaders, business figures, newsletters, and websites. The `/newsletter` skill draws from these during research. Managed conversationally via `/add-source`.

### Onboarding

When you first open Claude Code in this folder, it detects empty profiles and walks you through setup:

1. Brand profile (from a document or conversation)
2. Writing voice (from samples or conversation)
3. Inspiration sources
4. Newsletter config (name, audience, frequency)
5. Test draft

After setup, you just talk to it. "Write this week's newsletter about X."

---

## File Structure

```
ai-newsletter-kit/                                  ← rename this to anything
├── .claude/                                         ← the brain (don't touch)
│   ├── CLAUDE.md
│   ├── skills/
│   │   ├── digest-brand/SKILL.md
│   │   ├── style-capture/SKILL.md
│   │   ├── add-source/SKILL.md
│   │   └── newsletter/
│   │       ├── SKILL.md
│   │       └── templates/
│   └── agents/
│       └── newsletter-writer.md
├── identity/                                        ← your brand + voice
│   ├── brand-profile.md
│   ├── style-profile.md
│   ├── brand-document-original/
│   └── writing-samples/
├── newsletters/                                     ← your content
│   └── my-newsletter/
│       ├── config.yaml
│       ├── drafts/
│       └── published/
├── sources.yaml                                     ← your inspiration sources
├── QUICKSTART.md                                    ← plain-language guide
└── README.md                                        ← this file
```

---

## For Developers / Service Providers

### Setting Up for a Client

1. Have the client install Claude Code
2. Give them the one-liner to paste into Claude Code (see Quick Start above)
3. Walk them through onboarding (or let them do it solo — it's fully guided)
4. Calibrate brand + style profiles until the test draft sounds right
5. Have them rename the folder to their newsletter's name

### Deploying for Multiple Clients

The skills are reusable. Client-specific data stays separate:

| Reusable (same for everyone) | Client-specific |
|------------------------------|----------------|
| `.claude/skills/*` | `identity/brand-profile.md` |
| `.claude/agents/*` | `identity/style-profile.md` |
| Newsletter templates | `identity/writing-samples/*` |
| `setup.sh`, `newsletter-setup.md` | `sources.yaml` |
| `QUICKSTART.md` | `newsletters/` contents |

### Updating Skills Across Clients

Push updates to this repo. Clients re-run the setup one-liner — existing profiles and content are backed up automatically before reinstalling.

---

## Context Management

All heavy processing (document analysis, style capture, research, drafting) is delegated to sub-agents. This keeps the main conversation lightweight so clients can do full onboarding + first draft in a single session without hitting context limits.

---

## No Dependencies

This is pure Claude Code. No packages, no APIs, no build steps, no databases. The entire system is markdown files that Claude reads. If you have Claude Code, you have everything you need.
