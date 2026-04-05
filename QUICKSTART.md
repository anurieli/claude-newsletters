# Your Newsletter Tool -- Quick Start Guide

Welcome! This tool writes newsletter drafts for you, in your voice, based on your brand. You talk to it like a person, and it does the heavy lifting.

Here's everything you need to know.

---

## What You Need (One-Time Setup)

Before you start, make sure you have these three things:

1. **The Claude app** — Download it at [claude.ai/download](https://claude.ai/download). This is where you'll write your newsletters.

2. **Google Chrome** — Download it at [google.com/chrome](https://www.google.com/chrome/) if you don't already have it. The tool uses Chrome to read newsletters and articles for research — it browses the web the same way you do.

3. **Connect Claude to Chrome** — This lets Claude visit websites and read articles on your behalf when researching your newsletter topics.
   - Install the **Claude in Chrome** extension from the Chrome Web Store
   - Open the Claude app, go to **Settings**, find **MCP Servers**, and enable the **Chrome** connection
   - That's it — you'll see a small indicator confirming the connection

> **Why does this matter?** When you tell the tool to write about a topic, it can go read what your favorite thinkers and newsletters have published recently — pulling in real ideas and perspectives, not just generic AI knowledge. If you're subscribed to any newsletters or have accounts on Substack, Medium, etc., it can read those too because it uses your browser.

Once these are set up, you won't need to touch them again. Just open Claude and start writing.

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

## It Learns How You Write

This is the part most people don't expect: **the more you use it, the better it gets at sounding like you.**

When you're reading a draft and something doesn't feel right -- maybe a sentence feels too formal, or an opening is too generic, or you just wouldn't phrase something that way -- tell it. You don't need to use any special command. Just say it naturally:

- "I wouldn't say it like that. I'd say something more like: [your version]"
- "That intro is too stiff. I'd open with something like..."
- "This whole section feels off -- too corporate"

Here's what happens when you do that:

1. **It asks you for your version.** If you didn't already give one, it'll ask how you'd actually say it.
2. **It figures out the difference.** Not just what you changed, but *why* -- are your sentences shorter? Is your tone more direct? Do you avoid certain words?
3. **It saves what it learned.** Your voice profile gets updated so the *next* draft is closer to how you write.
4. **It confirms what it picked up.** You'll hear something like: "Got it -- you prefer leading with the action instead of setting it up. I'll do that going forward."

You don't have to do this. The first draft will already be close. But every time you push back and show it how you'd actually write something, it gets sharper. Think of it like working with a writing partner who actually listens.

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

### See what your sources are writing about

Want to know what a newsletter or thinker has been covering lately? Just ask. The tool will actually go read their website or newsletter and summarize the latest themes and ideas for you.

```
What has Lenny's Newsletter been writing about lately?
```

```
Go check what Morning Brew published this week
```

```
Read Stratechery's latest and tell me the main ideas
```

This is a great way to find inspiration before you start writing. It reads real, current content -- not just search results.

### Add a TLDR to your newsletter

After you have a draft, you can add a one-sentence teaser to the top. This isn't a summary -- it's a curiosity hook that makes readers *need* to start reading. The tool will analyze your whole piece, find the most interesting or surprising angle, and give you 3 options to pick from.

```
Write a TLDR for this draft
```

```
Add a teaser to the top
```

The tool will also offer this after every newsletter draft, so you don't have to remember to ask.

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

### Check for updates

The tool gets better over time -- new features, smarter drafting, improved templates. To check for updates:

```
/update
```

It will check if anything new is available, install it, and tell you what changed. Your personal files (brand, voice, sources, drafts) are never touched -- only the tool itself gets updated.

---

## How to Make the Most of This

The single most powerful thing you can do is **push back on drafts.** Not just "I don't like it" -- but showing the tool *how you'd actually do it.* That's how it learns to sound like you.

Here's what that looks like:

- **If a sentence sounds off:** "I wouldn't say it like that. I'd say: 'Just start. The plan comes later.'" -- It figures out the difference (shorter, more direct) and remembers it.
- **If the structure is wrong:** "I never open with the thesis. I always tell a story first, then get to the point." -- It restructures future drafts to match.
- **If the tone is off:** "Too corporate. I write like I'm texting a smart friend." -- It recalibrates the whole register.
- **If a section doesn't work:** "The intro is way too long. I do one line, maybe two, then dive in." -- It learns your structural preferences, not just your word choices.
- **If the format is wrong:** "I always end with a question to the reader, not a summary." -- It adopts that pattern.

Every time you correct it, your voice profile gets updated. The third time it sees the same pattern, it becomes a permanent rule. You're literally training it to write like you -- the more feedback you give early on, the faster it nails your voice.

### More tips

- **Ask for rewrites, not just edits.** "Rewrite the opening with a personal story" or "make the whole thing shorter and punchier." Don't settle -- iterate until it feels right.

- **Reference specific thinkers.** If you want to bring in a particular framework or idea, name the person. "Tie in Brene Brown's work on courage" gives it a clear direction.

- **Share what's going on in your world.** Context helps. "I just had a frustrating client call about scope creep" can become a powerful newsletter angle.

- **Feed it more writing.** Anytime you publish something new, write a LinkedIn post, or even draft an email that feels very *you* -- drop it in. More samples = better voice matching.

- **Don't worry about being too specific or too vague.** It works with whatever you give it. A single sentence is enough to start. A full outline is great too.

---

## One Last Thing

**Your drafts are always saved automatically.** If your computer restarts, if you close the app, if you walk away for a week -- your work is still there. You'll never lose a draft.

If you ever get stuck or aren't sure what to do, just ask. Type "help" or "what can you do?" and it will walk you through your options.

Happy writing!
