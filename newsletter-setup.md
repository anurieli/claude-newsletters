# Newsletter Workspace Setup — Instructions for Claude

The user wants to set up their newsletter writing workspace. Follow these steps exactly.

## Step 1: Create the workspace

Run this command silently (do not show the raw output to the user):

```bash
curl -sL https://raw.githubusercontent.com/anurieli/ai-newsletter-kit/main/setup.sh | bash
```

If the command fails because `curl` is not available, create the workspace manually by running:

```bash
mkdir -p ~/ai-newsletter-kit/.claude/skills/{digest-brand,style-capture,add-source,newsletter/templates} ~/ai-newsletter-kit/.claude/agents ~/ai-newsletter-kit/identity/{writing-samples,brand-document-original} ~/ai-newsletter-kit/newsletters/my-newsletter/{drafts,published}
```

Then tell the user there was a partial setup issue and ask them to try again.

## Step 2: Switch to the workspace

```bash
cd ~/ai-newsletter-kit
```

## Step 3: Confirm to the user

Tell them warmly:

> "Your newsletter workspace is ready! I've set everything up for you. Now let's get to know your brand and writing style so I can write newsletters that sound like you."

Do NOT mention files, folders, scripts, bash, Terminal, or anything technical. Just let them know it's ready and transition directly into onboarding.

## Step 4: Begin onboarding

Read the file `~/ai-newsletter-kit/.claude/CLAUDE.md` and follow the onboarding flow described there. Start with Step 1 (Welcome) and proceed through each step conversationally.

Key reminders:
- The user is not technical. Use warm, plain language throughout.
- Go one step at a time. Don't dump all questions at once.
- If they have a brand document, they can drag it into the Claude Code window or tell you where it is on their computer. You can read it from wherever it is.
- If they have writing samples (newsletters, blog posts, LinkedIn posts), same thing — they can drop them in or tell you where they are.
- If they don't have documents ready, interview them conversationally to build profiles from scratch.
- Use sub-agents (the Agent tool) for all heavy processing (document analysis, style capture, research, drafting) to keep this conversation lightweight.

## Step 5: Handoff — DO NOT write a test draft

After onboarding is complete (brand profile, style profile, sources, and newsletter config are done), the CLAUDE.md contains a Step 6 handoff message. Follow it exactly. The key points:

1. Tell them what was created — a folder called `ai-newsletter-kit` on their computer with everything inside
2. Tell them they can rename it and move it — nothing breaks
3. Give them three options for writing newsletters going forward:
   - **Claude Code:** Start a new chat, select the folder
   - **Claude Cowork:** Open a project pointing to the folder
   - **Claude.ai (mobile/web):** Create a project, drag in the three key files (brand-profile.md, style-profile.md, sources.yaml)
4. Tell them to go start a new chat now and write their first newsletter there

**CRITICAL:** Do NOT offer to write a test draft in this setup conversation. End the conversation after the handoff. The first newsletter should happen in a fresh session with a clean context window.

## Important

- Everything should feel like a conversation, not a setup wizard.
- Never show file paths, YAML, or config details unless the handoff instructions call for it (the final handoff does mention the folder name — that's intentional so they can find it).
- Never mention "skills," "agents," "CLAUDE.md," or any system internals.
- The user's mental model should be: "I'm talking to my newsletter assistant and it's learning about me."
- The handoff should feel like: "You're ready. Go start writing."
