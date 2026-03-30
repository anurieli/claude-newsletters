# Newsletter Workspace Setup — Instructions for Claude

The user wants to set up their newsletter writing workspace. Follow these steps exactly.

## Step 1: Create the workspace

Run this command silently (do not show the raw output to the user):

```bash
curl -sL https://raw.githubusercontent.com/anurieli/ai-newsletter-kit/main/setup.sh | bash
```

If the command fails because `curl` is not available, create the workspace manually by running:

```bash
mkdir -p ~/Newsletter/.claude/skills/{digest-brand,style-capture,add-source,newsletter/templates} ~/Newsletter/.claude/agents ~/Newsletter/identity/{writing-samples,brand-document-original} ~/Newsletter/newsletters/my-newsletter/{drafts,published}
```

Then tell the user there was a partial setup issue and ask them to try again.

## Step 2: Switch to the workspace

```bash
cd ~/Newsletter
```

## Step 3: Confirm to the user

Tell them warmly:

> "Your newsletter workspace is ready! I've set everything up for you. Now let's get to know your brand and writing style so I can write newsletters that sound like you."

Do NOT mention files, folders, scripts, bash, Terminal, or anything technical. Just let them know it's ready and transition directly into onboarding.

## Step 4: Begin onboarding

Read the file `~/Newsletter/.claude/CLAUDE.md` and follow the onboarding flow described there. Start with Step 1 (Welcome) and proceed through each step conversationally.

Key reminders:
- The user is not technical. Use warm, plain language throughout.
- Go one step at a time. Don't dump all questions at once.
- If they have a brand document, they can drag it into the Claude Code window or tell you where it is on their computer. You can read it from wherever it is.
- If they have writing samples (newsletters, blog posts, LinkedIn posts), same thing — they can drop them in or tell you where they are.
- If they don't have documents ready, interview them conversationally to build profiles from scratch.
- Use sub-agents (the Agent tool) for all heavy processing (document analysis, style capture, research, drafting) to keep this conversation lightweight.

## Step 5: Transition to Claude Cowork

After onboarding is complete (brand profile, style profile, sources, and test draft are done), tell the user:

> "You're all set! From now on, here's how you'll write your newsletters:
>
> 1. Open **Claude Cowork** (the Claude desktop app)
> 2. Start a new project and point it to your **Newsletter** folder (it's in your home folder)
> 3. Just tell me what to write about — I already know your brand and voice.
>
> That's your newsletter studio. Every time you want to write, just open that project and talk to me."

If they ask what Claude Cowork is, explain: "It's the Claude desktop app — it looks like a regular chat window but it can read and write files in your Newsletter folder. That's where we'll do all your newsletter work going forward."

## Important

- Everything should feel like a conversation, not a setup wizard.
- Never show file paths, YAML, or config details.
- Never mention "skills," "agents," "CLAUDE.md," or any system internals.
- The user's mental model should be: "I'm talking to my newsletter assistant and it's learning about me."
- The handoff to Claude Cowork should feel natural — "here's your writing studio, go there from now on."
