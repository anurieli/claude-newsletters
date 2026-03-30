# Skill: add-source

Manage the client's inspiration sources — the thought leaders, business figures, newsletters, and websites she draws ideas from for her newsletter content.

## Trigger

This skill activates when the user invokes `/add-source` or asks to add, remove, update, or list their inspiration sources.

## Inputs

- **With arguments:** A natural language description of what to do (add someone, remove someone, update details, etc.)
- **No arguments:** List all current sources in a readable format.

## Instructions

### 1. Determine the action

Parse the user's input to figure out the intent:

| Intent | Signal words / patterns |
|--------|------------------------|
| **Add** | "add", a name with context, "start following", "I want to include" |
| **Remove** | "remove", "delete", "drop", "stop following" |
| **Update** | "update", "change", "add X to Y", "edit" |
| **List** | No arguments, "list", "show", "what sources do I have" |

If the intent is ambiguous, ask one short clarifying question before proceeding.

### 2. Read sources.yaml

Read `sources.yaml` from the project root (`sources.yaml`).

If the file does not exist, create it with this skeleton:

```yaml
thought_leaders: []

business_figures: []

newsletters: []

websites: []

research_instructions: |
  When researching for a newsletter:
  1. Check if any thought leader has a relevant framework for the topic
  2. Look for recent posts/articles from business figures on the topic
  3. Cross-reference with newsletters for trending angles
  4. Pull philosophical depth from thought leaders, practical angle from business figures
  5. Never copy — synthesize. The client's voice and brand come first.
  6. Always attribute ideas when drawing heavily from a specific thinker
```

### 3. Execute the action

#### Adding a source

1. **Categorize** the source based on context clues:
   - **thought_leaders** — philosophers, authors, researchers, thinkers known for ideas and frameworks
   - **business_figures** — entrepreneurs, executives, marketers, creators with active social/content presence
   - **newsletters** — email publications, Substack, etc.
   - **websites** — blogs, media sites, resource hubs

2. **Research briefly** to fill in missing fields. Use web search if available, otherwise use your own knowledge. The goal is to populate the entry so it is useful for future newsletter research, not to write an exhaustive bio.

3. **Build the entry** following the schema for that category:

   **thought_leaders:**
   ```yaml
   - name: "Full Name"
     type: "philosopher/author/researcher"  # pick the best fit
     key_ideas: ["idea1", "idea2"]
     works: ["Book or Work 1", "Book or Work 2"]
     notes: "Optional — how their ideas relate to the client's content"
   ```

   **business_figures:**
   ```yaml
   - name: "Full Name"
     platforms: [linkedin, youtube, twitter]  # where they are active
     topics: ["topic1", "topic2"]
     newsletter_url: "https://... (if they have one)"
     notes: "Optional"
   ```

   **newsletters:**
   ```yaml
   - name: "Newsletter Name"
     url: "https://..."
     topics: ["topic1", "topic2"]
   ```

   **websites:**
   ```yaml
   - name: "Site Name"
     url: "https://..."
     topics: ["topic1", "topic2"]
   ```

4. Append the new entry to the correct category list.

5. If a source spans categories (e.g., a thought leader who also has a newsletter), add the primary entry in the best-fit category and note the other asset in `notes` or add a separate `newsletters` entry for the publication. Use judgment — avoid duplication that adds no value.

#### Removing a source

1. Search all categories for a name match (case-insensitive, partial match is fine).
2. If multiple matches, ask the user which one to remove.
3. Remove the entry from the list.

#### Updating a source

1. Find the existing entry (case-insensitive, partial match).
2. Apply the requested change — add a work, change topics, update a URL, etc.
3. Preserve all other fields as-is.

#### Listing sources

Present all sources in a clean, readable format grouped by category. Use this layout:

```
Thought Leaders
  - Ryan Holiday — Stoic philosophy, discipline, ego
    Key works: The Obstacle Is the Way, Ego Is the Enemy, Stillness Is the Key
  - [next person...]

Business Figures
  - Alex Hormozi — business growth, offers, leads
    Platforms: YouTube, Twitter, LinkedIn
  - [next person...]

Newsletters
  - Daily Stoic — stoicism, daily wisdom
    URL: https://dailystoic.com/newsletter
  - [next person...]

Websites
  - Farnam Street — mental models, decision-making
    URL: https://fs.blog
```

Do NOT show raw YAML. Do NOT show the `research_instructions` block. Just the sources, organized and human-readable.

### 4. Write back to sources.yaml

Write the updated YAML back to `sources.yaml`. Always preserve the `research_instructions` block at the end of the file exactly as it was (or as defined in the skeleton above if creating a new file).

### 5. Confirm the change

Tell the user what you did in plain, conversational language. Examples:

- "Done — I added Ryan Holiday under Thought Leaders. I filled in his key works and tagged him for stoic philosophy, discipline, and ego. I also added Daily Stoic as a separate newsletter entry."
- "Removed Morning Brew from your newsletters list."
- "Updated Hormozi's entry — added '$100M Leads' to his key works."
- "Here are all your current sources:" (followed by the formatted list)

## Rules

- **Never show raw YAML to the client.** She is not technical. All communication is plain language.
- **Always preserve `research_instructions`** when writing to `sources.yaml`. Never modify or remove that block.
- **Alphabetize entries** within each category to keep the file tidy.
- **Deduplicate.** Before adding, check if the source already exists. If it does, suggest updating instead.
- **Be opinionated about categorization.** If someone is clearly an author/philosopher, put them under `thought_leaders` even if they also have a business. Use the dominant identity.
- **Omit optional fields** (`notes`, `newsletter_url`) rather than leaving them as empty strings. Only include them when there is meaningful content to put there.
- **Handle edge cases gracefully:**
  - If the user gives a name you genuinely cannot identify, say so and ask for more context rather than guessing.
  - If the user tries to remove a source that does not exist, let them know rather than failing silently.
  - If `sources.yaml` has unexpected structure, read it carefully, preserve what is there, and make the minimal change needed.
