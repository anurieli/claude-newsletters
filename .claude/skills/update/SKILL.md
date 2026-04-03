# /update

Check for and install updates to your newsletter tool. This updates the skills, templates, and system files while leaving all your personal files (brand profile, style profile, writing samples, sources, and drafts) untouched.

## Trigger

Activate when the user says `/update` or asks to update, upgrade, or check for new features.

## Instructions

### 1. Check if this is a git repo

Run `git status` to confirm the project is a git repository with a remote configured.

If it is NOT a git repo (no `.git` folder), tell the client:

> "It looks like your newsletter folder isn't connected to the update system. This can happen if the folder was copied instead of cloned. I can connect it now — this won't change any of your files. Want me to go ahead?"

If they say yes:
1. Run `git init`
2. Run `git remote add origin https://github.com/anurieli/ai-newsletter-kit.git`
3. Run `git fetch origin`
4. Run `git reset --mixed origin/main` — this aligns the history without touching any local files
5. Continue to Step 2

If they say no, stop.

### 2. Check for updates

Run:
```
git fetch origin
git log HEAD..origin/main --oneline
```

If there are no new commits, tell the client:

> "You're all up to date! No new changes available."

Stop here.

If there ARE new commits, read the commit messages to understand what changed.

### 3. Protect user files

Before pulling, verify that the user's personal files won't be affected. Run:
```
git diff origin/main -- identity/brand-profile.md identity/style-profile.md sources.yaml newsletters/
```

If this diff is empty (it should be — these files should be gitignored), proceed safely.

If for any reason user files WOULD be affected, stop and warn the client:

> "I found an update that would change some of your personal files. I'm going to skip this update to keep your stuff safe. Let me know if you want to look into this together."

Do NOT proceed with the pull.

### 4. Pull the updates

Run:
```
git pull origin main
```

If there are merge conflicts, do NOT attempt to resolve them automatically. Tell the client:

> "There's a conflict between your local changes and the update. This is unusual — let me know and we can sort it out together."

### 5. Summarize what changed

Read the new commit messages and summarize the changes in plain, friendly language. Group by what the client cares about:

- **New features** — new skills, new templates, new capabilities
- **Improvements** — better drafting, smarter voice matching, etc.
- **Fixes** — bugs that were squashed

Example:

> "Updated! Here's what's new:
>
> - **Smarter voice learning** — I'm now better at picking up on your style preferences when you give feedback on drafts.
> - **New deep dive template** — a longer-form option for when you want to go deep on a single topic.
>
> All your personal files (brand, voice, sources, drafts) are exactly as you left them."

Always end by reassuring them their personal files are untouched.

## Rules

- **Never touch user files.** Brand profile, style profile, writing samples, sources, drafts, and newsletter configs are sacred. This skill only updates system files (skills, templates, agents, docs).
- **Plain language only.** Never show git output, diffs, or technical details unless the client asks. They should hear "you're updated" not "git pull origin main succeeded."
- **When in doubt, don't pull.** If anything looks risky — merge conflicts, user files in the diff, unexpected state — stop and explain rather than forcing it.
- **Be brief.** This should feel like a 5-second check, not a process. Get in, update, summarize, done.
