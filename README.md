# Claude Newsletters

A Claude Code skill system that writes newsletters in your voice. Open Claude Code, say hi, start publishing.

---

## Quick Start

### For Non-Devs (No Terminal Required)

1. **Install Claude Code** — download the desktop app from [claude.ai/download](https://claude.ai/download)
2. **Open Claude Code** and paste this message:

```
Set up my newsletter workspace using the guide at https://raw.githubusercontent.com/anurieli/ai-newsletter-kit/main/newsletter-setup.md
```

3. **Claude sets everything up** and walks you through onboarding — brand, voice, sources, test draft.

4. **When setup is done**, Claude will tell you to open **Claude Cowork** (the desktop app) and open a project pointing to your `Newsletter` folder. That's where you'll write newsletters from now on.

### For Devs

```bash
git clone https://github.com/anurieli/ai-newsletter-kit.git ~/Newsletter
cd ~/Newsletter
claude
```

Say hi — onboarding kicks in. After setup, open the `~/Newsletter` folder as a project in Claude Cowork for day-to-day use.

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
ai-newsletter-kit/
├── .claude/
│   ├── CLAUDE.md                              # Project brain (onboarding + operations)
│   ├── skills/
│   │   ├── digest-brand/SKILL.md              # Brand profiling
│   │   ├── style-capture/SKILL.md             # Voice cloning
│   │   ├── add-source/SKILL.md                # Source management
│   │   └── newsletter/
│   │       ├── SKILL.md                       # Main newsletter pipeline
│   │       └── templates/                     # 4 newsletter format templates
│   └── agents/
│       └── newsletter-writer.md               # Autonomous drafting agent
├── identity/
│   ├── brand-profile.md                       # [Generated] Your brand identity
│   ├── style-profile.md                       # [Generated] Your writing voice
│   ├── brand-document-original/               # Drop your brand doc here
│   └── writing-samples/                       # Drop your writing samples here
├── newsletters/
│   └── my-newsletter/
│       ├── config.yaml                        # Newsletter settings
│       ├── drafts/                            # Auto-saved drafts
│       └── published/                         # Approved finals
├── sources.yaml                               # Your inspiration sources
├── setup.sh                                   # One-command installer
├── newsletter-setup.md                        # Setup instructions for Claude
├── QUICKSTART.md                              # Plain-language user guide
└── README.md                                  # This file
```

---

## For Developers / Service Providers

### Setting Up for a Client

1. Have the client install Claude Code
2. Give them the one-liner to paste into Claude Code (see Quick Start above)
3. Walk them through onboarding (or let them do it solo — it's guided)
4. Calibrate brand + style profiles until the test draft sounds right

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

### Adding a Second Newsletter (Same Client)

Create a new folder under `newsletters/`:

```bash
mkdir -p newsletters/monthly-deep-dive/{drafts,published}
```

Identity and sources are shared across all newsletters. Each newsletter gets its own `config.yaml`, drafts, and archive.

---

## Context Management

All heavy processing (document analysis, style capture, research, drafting) is delegated to sub-agents. This keeps the main conversation lightweight so clients can do full onboarding + first draft in a single session without hitting context limits.

---

## No Dependencies

This is pure Claude Code. No packages, no APIs, no build steps, no databases. The entire system is markdown files that Claude reads. If you have Claude Code, you have everything you need.
