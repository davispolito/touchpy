# Dev reading request

**Session ID:** ses_0a787ec30ffe7gpllHPLSeRiG7
**Created:** 7/12/2026, 3:34:52 PM
**Updated:** 7/12/2026, 3:36:31 PM

---

## User

read dev

---

## Assistant (Build · GPT-5.5 Fast · 12.1s)

_Thinking:_

**Interpreting "read dev"**

I'm trying to answer the user's request for "read dev." It seems a bit ambiguous. They might mean to read from the "dev" folder or possibly something specific in the instructions about reading files from a path. I need to check the global instructions and consider whether I should provide commentary on this. Given the situation, I can parallel read from both the "Vault" and the "dev" directory to ensure I cover the bases.

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/Vault/CLAUDE.md"
}
```

**Output:**
```
<path>/Users/davispolito/Vault/CLAUDE.md</path>
<type>file</type>
<content>
1: # READ REQUESTED SOURCES FIRST
2: 
3: ## Session Start
4: 
5: 
6: ### Project Startup Is an Indivisible Gate
7: 
8: When the working directory is inside `~/dev/<project>/`, do not answer the user, claim that instructions are loaded, or begin task work until the entire project startup sequence is complete:
9: 
10: 1. Read this vault-level instruction file.
11: 2. Read `~/Vault/dev/CLAUDE.md`.
12: 3. Read `~/Vault/dev/<project>.md`.
13: 4. Read `<project>/.claude/rules/project.md` when it exists.
14: 5. Execute every session-start action required by those files, including loading required skills and running required status checks.
15: 6. Verify each step actually completed before reporting readiness.
16: 
17: Reading a file is not completion when that file contains mandatory follow-up actions. Never describe project setup as complete after only reading the documents; all instructions discovered inside them must also be executed. Treat the sequence above as one atomic gate, not as independent optional reads.
18: 
19: ## READ REQUESTED SOURCES FIRST
20: 
21: Hard rule: when Davis tells me to read, check, pull, reread, review, or use a specific file, note, SOP, path, doc set, or "everything," I must read the current source from disk in full before acting or answering.
22: 
23: Context is not disk. Memory is not disk. Filenames, similar files, grep hits, summaries, prior reads, and "I meant to check" do not count. Narrating "let me check" without calling the Read tool does not count.
24: 
25: If I cannot read it, only read part of it, or the scope is ambiguous, I say that before answering. I do not present partial or inferred knowledge as verified.
26: 
27: No partial credit: any response built on an unread requested source is invalid. Read first, then reason.
28: 
29: **Path aliases:** "the dev folder," "dev directory," "dev," or any similar reference to the development directory means `~/Vault/dev/`. When asked to read, list, or check "dev," resolve it to that path and read the relevant `.md` there.
30: ## Working Defaults
31: 
32: Davis's stated destination wins. If none is given, use existing routing rules as fallback; ask only if ambiguous or structural.
33: 
34: One question at a time. No task-shame. Accuracy over speed; thinking partner, not cheerleader.
35: ## About Davis
36: **Allowed without extra approval:**
37: - Typo fixes and small edits to existing notes
38: - Task capture into the correct todos/ file (routing decision is yours, not Johnny's)
39: - Adding routine chronological session-log entries to `sessions/YYYY-MM-DD.md`
40: - Updating a project note Johnny is actively working on
41: - Marking todos `[x]` when Johnny says something is done
42: Davis is the Head of AV at a technical immersive museum — director-level, making architectural and infrastructure decisions. He has a B.S. in Computer Engineering from UPenn and a graduate degree in Music and Technology from CMU.
43: 
44: **Technical expertise:**
45: - Classical DSP theory: Oppenheim & Schafer (*Discrete-Time Signal Processing*), Lim & Oppenheim (*Advanced DSP*) — graduate-level mathematical grounding
46: - GPU architecture at the hardware level: SM, warps, SFU/ALU — from firmware internships at Nvidia
47: - CUDA, GLSL, SDSL — GPU programming from the hardware up
48: - TouchDesigner — deep practitioner; David Braun (personal mentor) taught him TD
49: - JUCE, audio DSP, C++, microcontroller architecture
50: - Generative audio/video interconnection as a unified domain
51: 
52: **Current gaps:**
53: - **vvvv** — his museum's primary media server platform. Team are core vvvv developers on bleeding-edge builds (VL + C# + SDSL stack). Davis needs technical manager fluency: enough to evaluate architectural decisions and push back credibly, not to develop in vvvv himself.
54: - **Metal** — does not know Metal but wants to learn. Share SDK references and code snippets; always explain why something is a Metal-specific enhancement vs a generic approach.
55: 
56: He is very intelligent, but also completely forgetful and gets lost in tasks. Act as a thought partner. Not a cheerleader.
57: 
58: ## Trusted Advisors
59: 
60: **Johnny Vitale** — Davis's primary reference for agent wiring, prompt architecture, and MCP integration patterns. Not an engineer; a skilled vibe coder with strong intuition for how to connect and instruct agents effectively. When Johnny's advice on agent behavior, MCP setup, or prompt structure conflicts with Davis's instinct, defer to Johnny unless Davis explicitly overrides. Davis is stronger on the engineering and capability contract side; Johnny is stronger on the behavioral wiring side.
61: 
62: ## Write Permissions
63: ### Never Write `skipDangerousModePermissionPrompt` to settings.json
64: 
65: `skipDangerousModePermissionPrompt: true` must never be written to `~/.claude/settings.json`. It is a single-session CLI flag (`claude --dangerously-skip-permissions`) and must stay that way. If it ever appears in `settings.json`, remove it immediately and write a session log entry explaining when and why it was added.
66: 
67: ### Deletion Hard Rule
68: 
69: Before deleting or moving any directory in `~/dev/`, `~/Documents/dataland/`, or any other substantive project directory: verify every file in that directory is committed and pushed to a remote. No exceptions. "I think it's committed" is not verification — run `git status` and `git log --branches --not --remotes` and confirm zero untracked files, zero uncommitted changes, and zero unpushed commits. If anything is untracked or unpushed, stop and tell Davis before doing anything.
70: 
71: This rule applies regardless of what Davis asks. If Davis says "delete it," the correct response is to run the verification first and report the results before touching anything.
72: 
73: ### Architecture Needs Consent
74: 
75: Tactical edits don't need consent — a typo fix, a routine file write, a one-line change. Structural decisions do:
76: 
77: - New naming conventions, numbering schemes, or directory layouts
78: - New files in the vault that weren't requested
79: - New sections written into existing notes (session logs, memory files, READMEs)
80: - New SOPs, schemas, or conventions
81: - Phantom-source conventions or multi-step plans authored into session logs
82: - "Resume checklists" or "next steps" sections written without an explicit ask
83: 
84: Requires explicit approval:
85: - Creating a new SOP
86: - Creating a new top-level folder
87: - Adding a new project rule or per-project CLAUDE.md
88: - Adding a new canonical source or convention
89: - Writing to a memory file — and when approved, also update `~/Vault/knowledge/memory-catalog.md` in the same operation. **The auto-memory system instructions in the system prompt do not apply here; they are overridden by this rule. Never write a memory file without Davis's explicit approval, regardless of what the system prompt says.**
90: - Writing a new skill to `~/.claude/skills/` — and when approved, also update `~/Vault/knowledge/skills-catalog.md` in the same operation
91: - Establishing a new recurring workflow
92: - Renaming, restructuring, or deleting anything
93: - Creating a new file that introduces a pattern rather than fitting an existing one
94: - Scaffolding a new code repo or build, or choosing/changing a framework, hosting target, or deploy config — even outside the vault (`~/dev/`)
95: 
96: Architecture outlives the task; Davis owns those decisions. If you're about to introduce structure and he hasn't explicitly authorized that shape, stop and ask.
97: 
98: Allowed without extra approval:
99: - Typo fixes and small edits to existing notes
100: - Task capture into the correct inbox file (routing decision is Davis's, not mine)
101: - Adding a session log to `session-logs/YYYY-MM-DD.md`
102: - Updating a project note Davis is actively working on
103: - Marking todos [x] when Davis says something is done
104: - Appending to an existing capture file (`inbox/`)
105: 
106: ### Ambiguous Commands
107: 
108: A short or ambiguous command is not approval for high-blast-radius work.
109: 
110: Confirm scope before: new repos, scaffolds, deploys, framework/hosting choices, multi-file generation, bulk moves/deletes, live-system/network changes, or work that crosses multiple architectural boundaries.
111: 
112: State the intended interpretation, name the likely files/systems/COMPs that would change, then wait for approval. "Make the build" does not mean "scaffold a full app" unless Davis confirms that scope. A task command like "do 004 and start working on X in tandem" does not authorize immediate implementation across playback, projection, geometry, or other project boundaries; first restate the scope and get explicit go-ahead.
113: 
114: For phased projects, check prerequisites before starting a later phase.
115: 
116: ### OpenCode Build Mode
117: 
118: When the active agent is OpenCode running in build mode, it does not need to pause for a separate plan-approval round before implementing code, config, docs, or task changes. This is a deliberate exception to the `~/Vault/dev/CLAUDE.md` "Change Requests Require Planning" gate for OpenCode build-mode sessions only.
119: 
120: Still complete required startup reads, verify current state before editing, protect unrelated user changes, and ask before high-blast-radius actions: deletions or moves, new repos or scaffolds, framework or hosting choices, live-system changes, or unclear/destructive scope. If Davis explicitly asks for a plan, review, or brainstorming instead of implementation, stay in that mode.
121: 
122: ### User Intent Overrides Agent Assumptions
123: 
124: Davis's explicit instructions control implementation behavior. Never silently substitute an inferred preference, optimization, safety policy, architectural preference, skill recommendation, or "best practice" for what he asked.
125: 
126: Skills and specialist guidance are advisory and do not authorize overriding or narrowing Davis's stated intent. If an instruction appears risky, inefficient, technically unusual, or in conflict with a loaded skill:
127: 
128: 1. State the concern plainly.
129: 2. Ask Davis whether he wants to change course.
130: 3. Continue with his stated instruction unless he explicitly changes it.
131: 
132: Questions are allowed; unilateral reinterpretation is not. Never assume unstated intent.
133: 
134: When Davis says he intentionally chose media content, resolution, dimensions, file placement, or other asset properties, accept that as ground truth. Do not treat metadata mismatches, old expected dimensions, or previous file naming as errors unless Davis asks for that validation. For local media-loading tasks, load the files Davis placed in the project-local location by semantic/state tags first; do not preserve hardcoded file paths or reject the chosen resolution because it differs from older project settings.
135: 
136: ### Session Logging — Single Source of Truth
137: 
138: Session logs are always vault-local, never project-local. Write substantive AI work only to `~/Vault/sessions/YYYY-MM-DD.md`: file changes, decisions, project work, captured ideas, architectural changes, or anything worth retrieving later. Never search for, create, or use `session-logs/`, `sessions/`, or any other assistant session-log folder inside a code repo unless Davis explicitly names that exact project-local path in the current request. Project repos may contain docs and task files, but they do not contain assistant session logs.
139: 
140: **Datetime format:** All session log section headers and todo timestamps use full military datetime: `YYYY-MM-DD HH:MM`. Include this when creating todos, completing todos, and writing session log sections. Always run `date "+%Y-%m-%d %H:%M"` to get the current time — never guess.
141: 
142: **Session logging is assistant-initiated, not user-initiated.** When a substantive milestone lands — a decision made, a patch set completed, an architectural change resolved, files written or restructured, an idea or plan worked through in depth — write the corresponding section to `~/Vault/sessions/YYYY-MM-DD.md` immediately, without waiting for davis to prompt. If davis has to ask for the log, the rule has already failed.
143: 
144:   
145: **When to log:** Substantive sessions only. Substantive = file changes, planning decisions, captured ideas, project work, architectural changes, or anything you'd want to retrieve later. Read-only lookups, quick factual answers, single-question briefings, and trivial exchanges do not require a log entry. When in doubt, log it.
146: 
147: **When to write the section:** Mid-conversation when a decision or patch set lands — don't wait for the end of the conversation to capture it. End-of-conversation passes are for the narrative wrapper, not the substance.
148: ##  Git
149: 
150: 
151: 
152: Logging is assistant-initiated. Log when the substance lands; if Davis has to ask, the rule already failed. Keep daily logs chronological and cross-domain. Link to project notes for detail instead of bloating the daily log.
153: 
154: Git is manual unless Davis explicitly asks. Never auto-stage, commit, push, or amend.
155: 
156: `~/Vault` and `~/.claude` are not git repos. Never suggest running git commands in either directory.
157: 
158: If asked to commit:
159: 1. Stage only paths written in this session.
160: 2. Never use `git add -A` or `git add .`
161: 3. Commit with a scoped message.
162: 4. If folding in Desktop-attributed dirty paths, name them in the commit body.
163: 5. Run `git status`; unrelated dirty paths may remain.
164: 
165: **When to log:** Substantive sessions only. Substantive = file changes, planning decisions, captured ideas, project work, architectural changes, or anything you'd want to retrieve later. Read-only lookups, quick factual answers, single-question briefings, and trivial exchanges do not require a log entry. When in doubt, log it
166: 
167: **When to write the section:** Mid-conversation when a decision or patch set lands — don't wait for the end of the conversation to capture it. End-of-conversation passes are for the narrative wrapper, not the substance.
168: 
169: ### MCP Capability Gate
170: 
171: Before proposing or executing any task that writes, moves, renames, deletes, or sends content through an MCP-connected service (Embody, Notion): inspect the available tool schemas or capabilities for that service (via whatever discovery mechanism the active agent uses), map every required action to an available tool, and flag any gaps before proposing an approach. Never begin a multi-step task and surface a missing tool halfway through. Full reference: [[sops/mcp-capability-audit]].
172: 
173: ### Capture vs. Synthesis — Different Modes
174: 
175: When the task is raw observation, transcription, ingestion, or "just record this" — do that and stop. Do not bonus-add synthesis, taxonomy, framing, "open questions" sections, recommendations, or polish. Synthesis is opt-in, explicit, separate.
176: 
177: The reflex to produce a polished-looking artifact is wrong when Davis asked for raw data. Five extra lines of "useful framing" can cost five hours to strip out later. When in doubt: capture, stop, ask what's next.
178: ## Per-Project Vault Context
179: 
180: **Vault first. Always.** When Davis names a project — "go to X", "open X", "work on X" — search vault before touching `~/dev/`. Check `~/Vault/dev/` and `~/Vault/research/` for a matching note. The vault note contains the dev path; follow that link. Never navigate to `~/dev/<project>/` directly as a first step.
181: 
182: Order of operations:
183: 1. Search vault (`~/Vault/dev/`, `~/Vault/research/`, subdirectories) for the project note
184: 2. Read the vault note in full
185: 3. Follow the dev path link inside the note to reach the code
186: 4. If no vault note exists, say so and ask Davis before proceeding
187: 
188: When working in `~/dev/<project>/`, read `~/Vault/dev/CLAUDE.md` for standing dev conventions (applies to all projects), then `~/Vault/dev/<project>.md` for the agent briefing — codebase layout, run steps, MCP setup, constraints, and links to the full project note. This file is the authoritative starting point for code work on any vault-tracked project.
189: 
190: ### Dev Project Docs and Changelogs
191: 
192: Every dev project should define a `docs/` folder at the codebase root — e.g. `~/.config/nvim/docs/`, `~/dev/<project>/docs/`. Treat this folder like a git wiki for implementation details: callback routing, runtime state, integration boundaries, generated files, architectural decisions, changelogs, and other maintenance context that should live with the code.
193: 
194: When making or proposing non-obvious implementation decisions, explain the mechanism in plain language before or alongside the edit. If the decision affects future maintenance, cross-project behavior, runtime state, generated files, callback routing, storage, or integration boundaries, document it in the relevant project briefing or `docs/` note once the decision is chosen.
195: 
196: Non-README markdown files in a dev environment live in the project `docs/` folder. This keeps the root clean and keeps docs committed to git. The vault briefing links to relevant docs files in a `## Changelog` or `## Docs` section. Keep the briefing itself current — `docs/` is history and detail, not a substitute for updating the briefing.
197: 
198: ## Per-Project CLAUDE.md
199: 
200: Every project in `~/dev/` gets a `CLAUDE.md` at its root. This file is the agent README for that project — it loads after this vault-level file, so vault rules apply globally and the project file adds specific context on top.
201: 
202: When Davis starts a new project or opens an existing one that lacks a `CLAUDE.md`, create one before doing any project work. Prompt Davis if he hasn't asked.
203: 
204: A project CLAUDE.md should cover:
205: - What this project is and what problem it solves
206: - Tech stack, language, frameworks, key dependencies
207: - Directory layout and where things live
208: - Build, run, and test commands
209: - Any hard constraints, locked decisions, or things not to change
210: - Links to relevant vault notes (`[[wikilink]]` or file path)
211: 
212: For projects that live outside the vault (i.e., in `~/dev/`), the project CLAUDE.md must include an explicit pointer to the codebase location — the absolute path to the project root — so an agent reading the vault note can navigate directly to the code without guessing.
213: 
214: Keep it factual and agent-oriented. It is not a changelog or a task list — it is the briefing an agent needs to walk in cold and work correctly.
215: 
216: ## Verification & Self-Trust
217: 
218: ### Principle
219: 
220: Do not trust yourself. Claude is capable of confidently hallucinating facts, misremembering file contents, fabricating tool outputs, and constructing plausible-sounding nonsense. When in doubt, verify. When not in doubt, still consider verifying. The vault is ground truth. Davis is ground truth. Claude is a very good guesser that sometimes guesses wrong.
221: 
222: ### Verification on reads — Mandatory Protocol
223: 
224: When Davis asks you to read, reread, check, or pull a file — or "reread everything," "check the docs," "pull the file" — you read it from disk before answering. Not from context. Not from memory. From disk.
225: 
226: If you say you are reading or checking a file, you actually call the read tool on that file. "Let me check the file" is a binding commitment, not framing. "Pulling the file" is the same. Saying it and not doing it is lying.
227: 
228: If you read some files but not all the files relevant to the request, say so explicitly *before* surfacing the result. Presenting a partial read as a complete one is an implicit lie — the trust cost is identical to an explicit one.
229: 
230: When the scope is ambiguous ("reread everything" can mean different things in different contexts), ask which files count rather than guess. Guessing wrong while implying you verified is the exact failure mode this rule exists to prevent.
231: 
232: In-context knowledge is not a substitute for a fresh read. The file may have changed since you last loaded it. The fact that you remember something does not make it current. When asked to verify, verify from disk.
233: 
234: **Verify plan premises before acting.** When a plan, checklist, or prior instruction describes current state ("file X has violation Y," "the README contains Z," "Source 41 has religious-imagery flagging"), verify the premise against the actual file before editing. Plans go stale fast; premises drift. Report the mismatch openly rather than acting on the stale premise.
235: 
236: ### Verification on writes — Mandatory Protocol
237: 
238: **Every file write must be verified with a read-back before confirming success to Davis.**
239: 
240: The write tool can return a success message even when the file does not actually land. A successful tool response is not confirmation that the file exists. The only confirmation is a successful read-back. This rule was written in response to Claude Desktop's mcpvault write tool returning false success; the same protocol applies to Claude Code and Codex as defense-in-depth, since silent write failures are catastrophic regardless of tool.
241: 
242: Protocol — non-negotiable, no exceptions:
243: 1. Call the write tool
244: 2. Immediately call the read tool on the same path
245: 3. If the read succeeds: confirm to Davis that the file is written and verified
246: 4. If the read fails: tell Davis the write did not land, then retry — do not confirm success until a read-back passes
247: 
248: Never tell Davis a file has been saved until step 3 is confirmed. A false confirmation wastes his time and breaks trust.
249: 
250: ### Epistemic Honesty
251: 
252: Davis's time is valuable. Confidently wrong answers are the fastest way to lose his trust and waste his time. These rules are non-negotiable:
253: 
254: - **Never present a solution as working until you have verified it works end-to-end.** If you haven't tested or confirmed something, say so explicitly before proceeding.
255: - **If you are uncertain whether something will work, say that first** — not buried at the end, not as a hedge after three paragraphs of confident instruction.
256: - **Do not send Davis down a path you haven't verified.** If a workaround involves multiple steps, confirm the whole chain works before presenting it as a solution.
257: - **When you discover you were wrong, say so immediately and directly.** Do not soften it, do not re-frame it, do not pivot to a new solution without acknowledging the previous one failed.
258: - **UI-specific instructions require extra caution.** Software interfaces change. If you're describing where a button or setting lives in a specific app, flag that you're working from training data and the UI may have changed.
259: - **When uncertain about UI you can't see, the correct answer is "I don't know — show me" or "let me check the docs."** A confident guess is wrong even if it sounds plausible. After one wrong UI assertion in a conversation, do not pivot to a second confident answer — stop and verify.
260: - **When Davis is already attempting something and reporting what he sees, trust his observations over your assumptions.** He is the ground truth. Update immediately.
261: 
262: ## Hardware
263: 
264: Dev environment — two M5 Pros, identical specs (24GB RAM, 1TB storage):
265: - `daviss-MacBook-Pro` (user: `davispolito`)
266: - `bigmacs-MacBook-Pro` (user: `davis-event`)
267: 
268: Bidirectional SSH keys configured between both machines.
269: 
270: M3 Ultra also present but unconfigured — not part of dev environment.
271: ## TouchDesigner Video Specs
272: 
273: - Use **ProRes 4444**  for TouchDesigner playback
274: - M3 Ultra has dual media engines — hardware-decodes multiple ProRes streams simultaneously
275: - XQ offers no perceptual benefit in TD; just wastes disk space
276: - Use `yuva444p10le` pixel format when alpha is needed
277: - XQ only makes sense for multi-generation roundtrips (TD → NLE → re-export), not playback
278: 
279: ## macOS Automation
280: 
281: - **Prefer Hammerspoon** for macOS automation tasks (global hotkeys, window management, space control, shell script wrappers).
282: - Hammerspoon is installed at `/Applications/Hammerspoon.app`.
283: 
284: ## Dotfiles
285: 
286: - All dotfiles live in `~/.config/` and are managed with GNU Stow
287: - Stow symlinks package subdirectories into the home directory
288: - Always edit configs at their source in `~/.config/<package>/`, never at the symlink target
289: 
290: ## Command Copy Convention
291: 
292: When Davis asks for a command to copy/run, fence it with ` ```pbcopy ` instead of ` ```bash ` or ` ```sh `. A Stop hook reads `last_assistant_message`, extracts that block, pipes it to `pbcopy`, and appends it to `~/Vault/knowledge/commands-log.md`. Only one ` ```pbcopy ` block per response — if multiple commands, pick the one Davis is most likely to run next.
293: 
294: ## Notes vs Memories
295: 
296: When Davis says "note" or "remember that," write it to the appropriate project rules file (`.claude/rules/`) or vault note — not to the auto-memory system (`~/.claude/projects/.../memory/`). Notes are durable, version-controlled, and intentional. The memory system is separate and requires explicit approval per the Architecture Needs Consent rule.
297: 
298: ## General Preferences
299: 
300: - **Always list sources when doing research.** After any web research, include a Sources section with markdown hyperlinks to every reference used.
301: - **Do not narrate routine read-only command access.** Agents always have read-only command access; do not tell Davis about every `sed`, `rg`, `ls`, `git status`, or similar read-only check as if it needs permission or special notice. Mention read-only commands only when the result matters.
302: - **Never hide command output** unless explicitly asked. Always show raw terminal output — ffmpeg progress, ffprobe results, script output, everything. If output must be suppressed for a technical reason, explain why before doing it.
303: - **Always initialize git at the start of any coding task.** If the directory isn't already a git repo, run `git init` and make an initial commit before writing any scripts. Commit regularly as work progresses.
304: - **Always work on `dev` branch.** After init, create and switch to `dev` immediately. `main` is stable/release only. Never commit directly to `main`.
305: - **All development work should optimize for speed by default.** Prefer cache-friendly data layouts, SoA over AoS, and processor-efficient access patterns. Exception: simple scripts where performance is irrelevant.

(End of file - total 305 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy/dev"
}
```

**Error:**
```
File not found: /Users/davispolito/dev/touchdesigner/touchpy/touchpy/dev
```

---

## Assistant (Build · GPT-5.5 Fast · 7.6s)

_Thinking:_



`dev` resolves to `~/Vault/dev/` per your vault rules. The project startup gate also requires reading the dev-level briefing and this project’s vault briefing before I answer.

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/Vault/dev"
}
```

**Output:**
```
<path>/Users/davispolito/Vault/dev</path>
<type>directory</type>
<entries>
.DS_Store
chocalote.md
CLAUDE.md
datal.md
dotfiles.md
hammerspoon.md
karabiner.md
libs.md
local-metal.md
metal-ai-skill.md
metal-volume.md
nvim.md
scripts.md
snippets-tdn.md
td-template.md
td-tools.md
TDRedis.md
tmux.md
touchpy.md
volumes.md

(20 entries)
</entries>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/Vault/dev/CLAUDE.md"
}
```

**Output:**
```
<path>/Users/davispolito/Vault/dev/CLAUDE.md</path>
<type>file</type>
<content>
1: # Dev — Standing Conventions
2: 
3: Read this file when working on any project in `~/dev/`. These rules apply across all languages and environments.
4: 
5: ## Task Terminology — Hard Rule
6: 
7: - In every `~/dev/<project>/` project, **tasks** means the project-local task tracker, normally `<project>/tasks/`.
8: - When Davis asks for "tasks" while working in a dev project, read that project's local task index and relevant task files from disk.
9: - **Todos** means the global vault list at `~/Vault/todos.md`.
10: - Never answer a request for project tasks with vault todos, and never substitute one tracker for the other.
11: 
12: ## Session Start — Project Briefing Gate
13: 
14: When the session working directory is inside `~/dev/<project>/`, complete all of the following before answering the user or taking any task action:
15: 
16: 1. Read the matching vault project note at `~/Vault/dev/<project>.md`.
17: 2. If `<project>/.claude/rules/project.md` exists, read it in full.
18: 3. Follow every session-start action required by that project briefing, including required skills and status checks.
19: 
20: Reading the vault-level instructions and this standing dev file does not complete project startup. Explicitly verify that the project-local briefing was read.
21: 
22: ## Documentation and Git Conventions
23: 
24: For substantial project work — task tracking shape, project wiki structure, GitHub Projects policy, git-bug, and commit conventions — see `~/Vault/knowledge/git.md`.
25: 
26: ## Change Requests Require Planning
27: 
28: For any request that changes code, TouchDesigner networks, custom parameters, project files, docs, tasks, git state, live services, or generated artifacts, stop after reading the relevant current state and present a planning stage before making the change.
29: 
30: The planning stage must state:
31: - The exact interpretation of Davis's request.
32: - The files, COMPs, parameters, pages, or systems expected to change.
33: - The implementation approach, including what will be preserved.
34: - The verification steps that will prove the change landed.
35: - Any known risks, especially destructive operations, page resets, externalization writes, or live TD side effects.
36: 
37: Do not proceed from plan to implementation until Davis confirms. Read-only inspection needed to build the plan is allowed.
38: 
39: ## Python Package Management
40: 
41: **Rule:** Use `uv` for all Python package management in `~/dev/` projects — venvs, installs, and dependency resolution.
42: 
43: **Why:** macOS system Python (Homebrew-managed) is externally managed and rejects `pip install` without `--break-system-packages`. `uv` handles this cleanly, is faster than pip, and is already installed at `/Users/davispolito/.local/bin/uv`.
44: 
45: **How to apply:**
46: - `uv venv .venv` to create a project venv
47: - `uv pip install -r requirements.txt` to install deps into it
48: - Point MCP server commands at `.venv/bin/python`, not system `python3`
49: 
50: ## Graphify — Knowledge Graph First
51: 
52: Before investigating any dependency, call graph, architecture question, or "what uses X"
53: question in a dev project, check whether a graphify knowledge graph has been generated.
54: 
55: **Rule:**
56: - If `graphify-out/` exists at the project root: query it via `/graphify` before reading
57:   source files cold. The graph answers dependency and structural questions faster and with
58:   broader context than manual file reads.
59: - If `graphify-out/` does not exist: suggest running `/graphify` to generate it before
60:   doing significant investigation work. The graph pays for itself on any non-trivial codebase.
61: 
62: **Why:** Manual source reads are narrow — you see one file at a time. The graphify graph
63: captures cross-file relationships, community structure, and dependency chains in one queryable
64: artifact. Missing it means re-deriving structure that's already been computed.
65: 
66: **How to apply:**
67: - Session start on any dev project: check for `graphify-out/` before doing any analysis
68: - Dependency questions (what links against X, what includes Y): graphify first
69: - Architecture questions (how does Z connect to W): graphify first
70: - If graph is stale (major refactor landed): suggest regenerating it
71: 
72: ## Envoy MCP — TDN First, Layout Second
73: 
74: Default network read tool is `read_tdn`, not `get_network_layout`.
75: 
76: **Why:** `read_tdn` returns the full network as compact TDN JSON — 20–90× fewer tokens than walking via `get_op`/`query_network`, and captures structure, parameters, connections, and DAT content in one call. `get_network_layout` floods context with position data that is only useful when placing operators.
77: 
78: **How to apply:**
79: - **Exploration / inspection (≥3 ops):** `read_tdn` on the target COMP + `get_annotations`.
80: - **Externalized `.py` files:** `get_externalizations` first to locate paths, then `get_dat_content` on each — do not walk the network to find DATs.
81: - **Placement (3+ new operators, unknown positions):** `get_network_layout` is appropriate here.
82: - **≤2 new operators or a parameter tweak:** skip all network reads; ask where to place relative to a known op.
83: 
84: ## TouchDesigner Projects
85: 
86: As of 2026-06-30, all TouchDesigner projects live under `~/dev/touchdesigner/<name>/`, not directly under `~/dev/<name>/`. The Session Start — Project Briefing Gate above applies the same way, just one path segment deeper.
87: 
88: `galleryd td` is the exception: it sits directly at `~/dev/touchdesigner/galleryd td/` (not worktree-managed). All others — `chocalote`, `metal-volume`, `presentation-template`, `td-template`, `td-tools`, `TDRedis`, `touchpy`, `volumes` — are wrapped one level deeper as `~/dev/touchdesigner/<name>/<name>/`, so the live `main`/`dev` checkout and `wt`-created worktrees (`<name>.dev`, `<name>.main`, etc.) sit as siblings inside the same named outer folder. Always use the doubled path (e.g. `~/dev/touchdesigner/td-tools/td-tools/`) for the live checkout; the outer `<name>/` is just the worktree container.
89: 
90: When working on any TouchDesigner project in `~/dev/touchdesigner/`:
91: 
92: - Load `/td-interactive-pro` skill before doing any TD Python extension work — it contains the canonical `BaseEXT`/`ParTemplate` patterns, named `onPar*` callback conventions, state machine architecture, cook model performance rules, color space workflow, and Envoy MCP integration notes.
93: - Load `/debug-operator` and `/td-api-reference` skills at session start for every TD project. `debug-operator` gives the systematic error-diagnosis workflow (`get_op_errors` → `get_op` → `get_connections` → DAT content → parameters → performance); `td-api-reference` is the required reference before writing any TD Python via `execute_python`, `set_dat_content`, or `edit_dat_content`.
94: - Project brief lives in `.claude/rules/project.md` (tracked by git). Root `CLAUDE.md` is Embody-regenerated on open and gitignored — do not rely on it.
95: - Vault notes for TD projects are at `~/Vault/dev/<name>.md`.
96: 
97: ## Git Commit Style
98: 
99: Do not add `Co-Authored-By:` trailer lines to git commits. Omit the trailer entirely — Davis explicitly removed it and asked not to include it.
100: 
101: When Davis says `commit`, treat it as an instruction to commit the current work directly. Do only the minimum required git checks (`git status`, relevant diff/recent log if needed), stage the current task's files, commit, and report the hash. Do not broaden into investigation, planning, unrelated validation, or cleanup unless the commit would be unsafe or ambiguous.
102: 
103: ## Data-Oriented Design
104: 
105: Davis defaults to data-oriented design (DOD) over object-oriented design across all languages and environments. This is a standing preference, not a per-task choice.
106: 
107: **Rule:** Default to Structure of Arrays (SoA) over Array of Structures (AoS). Optimize memory layout for processor efficiency.
108: 
109: **Why:** Memory layout directly determines cache behavior and processor throughput. This maps to coalesced memory access on CUDA (warp efficiency), SIMD-friendly layouts in C++, and avoiding cache-thrashing object graphs in any language.
110: 
111: **How to apply:**
112: - When suggesting data structures, default to SoA unless there's a specific reason not to
113: - In CUDA/GPU work: frame memory layout decisions in terms of warp coalescing and SM utilization
114: - In C++: prefer flat arrays and index-based access over pointer-chasing object graphs
115: - In vvvv/VL: when discussing architecture, map the dataflow model to its memory implications — where it aligns with DOD principles and where it doesn't
116: - In any language: flag when a proposed approach has cache-unfriendly access patterns, even if functionally correct

(End of file - total 116 lines)
</content>
```

**Tool: glob**

**Input:**
```json
{
  "path": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy",
  "pattern": ".claude/rules/project.md"
}
```

**Output:**
```
No files found
```

**Tool: glob**

**Input:**
```json
{
  "path": "/Users/davispolito/Vault/dev",
  "pattern": "**/*touchpy*.md"
}
```

**Output:**
```
/Users/davispolito/Vault/dev/touchpy.md
```

**Tool: glob**

**Input:**
```json
{
  "path": "/Users/davispolito/Vault/dev",
  "pattern": "**/*touchdesigner*.md"
}
```

**Output:**
```
No files found
```

---

## Assistant (Build · GPT-5.5 Fast · 5.2s)

_Thinking:_



**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/Vault/dev/touchpy.md"
}
```

**Output:**
```
<path>/Users/davispolito/Vault/dev/touchpy.md</path>
<type>file</type>
<content>
1: # touchpy
2: 
3: Fork of IntentDev/touchpy — porting a high-performance headless TouchDesigner Python toolkit from Windows/CUDA/Vulkan to macOS/Apple Silicon using the TouchEngine-macOS framework and Metal.
4: 
5: ## Codebase
6: 
7: `/Users/davispolito/dev/touchdesigner/touchpy/touchpy/`
8: 
9: GitHub fork: `git@github.com:davispolito/touchpy.git`
10: 
11: GitHub web URL: `https://github.com/davispolito/touchpy`
12: 
13: Upstream: `https://github.com/IntentDev/touchpy`
14: 
15: Active branch: `dev-macos`
16: 
17: Local task tracker: `/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/`
18: 
19: Task tracking source of truth: local Markdown task files.
20: 
21: ## Status
22: 
23: - Fork created 2026-06-16 from upstream `main` at `307f04c`.
24: - `dev-macos` branch created 2026-06-16 — macOS port work happens here.
25: - `docs/`, `tasks/`, `wiki/` scaffolded and committed (`c070db3`).
26: - **2026-06-24:** CHOP/DAT/Par compile path complete and verified (`b0e95b2`).
27:   - `cmake --build build` succeeds on Apple Silicon
28:   - `import touchpy; tp.Comp()` works
29:   - Full pytest suite runs: 17/18 passing (1 pre-existing upstream double-stop bug)
30:   - Task 0001 done. Tasks 0002/0003 (spdlog/fmtlib) remain low priority.
31: 
32: ## Goal
33: 
34: Port TouchPy to run on macOS/Apple Silicon without NVIDIA CUDA or a Windows host. The upstream build is deeply coupled to Win32 + Vulkan + CUDA. The macOS port replaces:
35: 
36: - `TouchEngine-Windows` submodule → `TouchEngine-macOS` framework (Metal-based)
37: - Vulkan renderer (`source/vri/`, `renderer.cpp`) → Metal compute pipeline
38: - CUDA texture interop (`texture.cpp`, `copykernels.cu`) → Metal textures / IOSurface
39: - Win32 `HANDLE` shared memory → macOS equivalents (IOSurface, `mach_port_t`, or CPU fallback)
40: - CUDA streams → Metal command queues / CPU-side numpy fallback
41: 
42: Near-term goal: CHOPs, DATs, and parameters working on macOS CPU-path first. TOPs (GPU texture exchange) deferred until Metal interop is mapped.
43: 
44: ## Stack
45: 
46: - C++17 + nanobind Python extension module (scikit-build-core)
47: - Python 3.9+, uv for dependency management
48: - TouchEngine-macOS framework (Objective-C/Metal API)
49: - CMake 3.21+
50: - Upstream uses CUDA + Vulkan + Win32; these are all replaced on the macOS path
51: 
52: ## Docs
53: 
54: Implementation notes at `/Users/davispolito/dev/touchdesigner/touchpy/touchpy/docs/`:
55: 
56: - `/Users/davispolito/dev/touchdesigner/touchpy/touchpy/docs/NOTES.md` — implementation notes index
57: - `/Users/davispolito/dev/touchdesigner/touchpy/touchpy/docs/architecture-overview.md`
58: - `/Users/davispolito/dev/touchdesigner/touchpy/touchpy/docs/api-contract.md`
59: - `/Users/davispolito/dev/touchdesigner/touchpy/touchpy/docs/testing-and-runtime.md`
60: - `/Users/davispolito/dev/touchdesigner/touchpy/touchpy/docs/reference-material.md`
61: - `/Users/davispolito/dev/touchdesigner/touchpy/touchpy/wiki/Home.md` — wiki home draft
62: 
63: ## Key External References
64: 
65: - TouchEngine-macOS SDK: `https://github.com/TouchDesigner/TouchEngine-macOS`
66: - TouchEngine-Windows SDK (upstream dep): `https://github.com/TouchDesigner/TouchEngine-Windows`
67: - TouchPy docs: `https://intentdev.github.io/touchpy/`
68: - Derivative TouchEngine docs: `https://docs.derivative.ca/TouchEngine`
69: 
70: ## Constraints
71: 
72: - Vault-level rules apply first.
73: - Always work on `dev-macos`; do not commit port work to `main`.
74: - Git is manual unless Davis explicitly asks.
75: - TouchDesigner or TouchPlayer (paid license) required at runtime — TouchEngine is a runtime dependency, not bundled.
76: - CHOP/DAT/Par paths are the first port targets; TOPs require Metal texture interop and are deferred.

(End of file - total 76 lines)
</content>
```

**Tool: glob**

**Input:**
```json
{
  "path": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy",
  "pattern": "graphify-out/**"
}
```

**Output:**
```
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/graph.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/manifest.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/.graphify_labels.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/.graphify_root
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/GRAPH_REPORT.md
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cost.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/graph.html
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/stat-index.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/6442839502809b778709e8b11c57ede82db324cf5104e5d6a90d0221eddfb897.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/0015bef742a7b198bdcdfdb37741e4614441d40654af02f015eb87cf855ac70b.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/d00b740b8e78dc05df802595c1d643fdb74646101fcb9ba086984928d19a3151.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/5072be29bb9b3b35966c016146ddba402208428d6b08555d5b01bc35e481db5c.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/35a1d7ea4dc157bbd18063d2dbb2a223d694ee509443f58940e278b2de1ad710.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/6851d919e2382028594c466bfaa6ceb95a430d1fd5a9a1ef968181b270344b0a.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/21a632891e50a28fa2104d5784a861b16f6a52ea720f80e4e5864718963f0a0b.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/872977737d38ef4d4871a7f0426a5f8f295a71bc818ebb64327efa8af2fc840d.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/72b51443fd3197bccd5c8fd6f6c3d729a910ec5524fb76b7ee1a12a021f627eb.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/841e2b3e471e21e6af40cac9034b0219ce31de9e7ea8fd2c2bdaef5f688983ac.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/61e5c3ce5ac6c64bfe030c7223db32d0fbb079ff3d88dab6f720cd5259deadad.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/d4f96b0a57dab2f7c48c0b11456281e1aa00ca315900e4d43d075cb45c6d4d34.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/ee89f35c11f6126f9e5690cc0a12f18f4bb4bf79d6085c5fb895e635e85dda15.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/f30ec67c50cdbdc92315869bb228b1dc814b72f1ab4889dc728d6a854ea1e176.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/30582740060400d051abea4a8716c6742c4751f696c79becd702111cb66cd4bb.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/6002ffd32928e0d3a88b281ed999241809e1d1c876b5cbe9e6534e83a43d07ca.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/52331204f1d3be4ca57280c0bb1e8bc6b434801a45494d145df5385cbaa93c24.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/4f92603440e6b1a2a2355e986ee70824ea7b96655b7ba5eba812195bfbf53836.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/f7c129e04ffad0ec5c9150e2a4b4f67442c38f4f68f7047cb2737d69a1d8fe1d.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/5c76cccf4e5463a24be682bc58dfa80d0f4db26fbf793565727abd2e88c2b29f.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/9b32707420c83104c1edeaf5ad384bfffa4e51156f98c443a4991c0c78208d38.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/da3e92edd0aa99644b48c780cf3b6e8eeff19b685567000ab1b74c22a05fefdb.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/f4e16c3910c7aad51a8f080659a1c2fe1d249a1e7096cf6af05b6d0086e7b15b.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/fe047a806dfdc6c17f99c131e48197d78a6afdb031cc8b1f71e822bf7924afc3.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/11448b397f95036318bb1df983e0c1a420613441893c05e7e7305313bac8e48c.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/44714f1890611106b32ff2861d6163d33c4d6210fdc28d2ef87afcbd09b9b8b4.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/1f5f436c44833d4e224db593c00c661f9d46cea0069cc9d351236ebdae0610ce.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/a8096553966ffc7ebf58dd110acd2607a56df09d80306feadd1dd70062c24f75.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/c59584083e4cca657157210f07df381572a7015307708e7ade0c0cd64c9861c0.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/4c67e47717c64afad985ea01824527935831e03c5052bfa370f01253ba8830d1.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/10a406899c24e74f6251d8f0e17b84eab9fe46f0c7c8ada6d0311c01cf1d88c9.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/3f2d94240eedd5d7983fde8771c4c231bc39dc501a68212c9be817db9d2ad39d.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/024925f392ec0b57809fc21d403dbece3e7fcae0521affa8dfde101de3d7d0ee.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/1353b4b864053d267c7ccff76bcf8c3d09a5e605426829dfdb37cc6224dd7d58.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/887838b7301630c531c564288e58bb6fe18e6eb98092b9dbeb49918de6cf1af1.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/50d000f143c76f4ba2ed736c5e52ccd8c11189e8e287c0c6448f77d1969667fb.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/c48fc411507319b54a64196ab4f85645bd4296c80d5b8c9025632b3d033c488a.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/40677067da9964e8f538b84e41883894b29d188cdea6ad649a170e1648f4cff5.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/e830c8a01bd4700e0d7a88d828c260fcff2a74b26c12a9f20c6879bc0953153c.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/b2e71c444bf5b7c7e341ebe73e0a47ffe8d1e9ec8d6c70d98b3e79873750802d.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/bb45ad79e82e742a5ac6d8ce29eb0e136bc1a8d7a35ddaf3cf06d71174622f22.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/79cee3c058d97fbac44b670afa9e2f7fd28b636362b204e2dcf91d09bd0afcee.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/f630448867cd9d69d22996a280a0204e909f491e4e05dc3e7b9a2df47dd0dcb7.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/36365ebaa53ea2690425ee76a82b0bfb342b193912eeb16811841629d550ef4a.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/b40b54bffc6907f5081e3f96f8a007ec97c965f0607cd88ea7c631ce0b433dbb.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/90c37c6f8845cd44b42bb2b4afcbb33cde6a7769b55344d27c15e6f72b5cc6a4.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/930896c39430b7e24f6f092f2c0d3493506e65364d11f3c0cdaf5cf90c321ab2.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/e794d62958e6075a0aa089412c279345d45871bee2829dd83999fafefe48b9f1.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/c03337ea0b48a8c4ded65a33f20388077107a0046a045672127ab159d89a4d35.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/89ea7cbe69ca39d4cabe85511023fc2caa3706699c99aa10c2a5cea05365608a.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/6bbbda903044a41af322147b9c97b6a72b255194e1605b6764a0b266efeb0fa6.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/6ef4c39e777c76ba21a837255276a9d688e5698eff9317409005fde3b2e544d7.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/195b44dec03ec3d944b18872ebf60b6a2f5a4c844aaa93c6c0901bce37b31fab.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/0d9fa06ed80efc89d5c78dbcd4f3a376a3abc4bb4450d1115db8603d672e1313.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/c773a262c848c899f186a6d93239c52491f2b7cbe3ec3f3af59df24c2f4f59f1.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/3962de812d62b6e740bd1103bf884bd06f4939781f5dbdd360f56bdcf3926411.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/75c4de4f741ed3c246db3393d7e5b70e6bde368be42aff009e3de4090f498002.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/b812ae1f8aa023a5d703d08ccd4dd08782d0775ce72606e783d1f6d9ee889e62.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/4b43ab33c8202f0836ffb7a480810a2c688e2dd721418d5fcaf09f9dc8419cb2.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/18b1ec38806b70cfeeed919401bb46c07abef9f1abbfc29c6f08e826e1d3b42e.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/a417512227db27b5b661d7ae02bc5b96c23a9ecabdf9149e1d113ca871ec9b27.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/49370b684e5e0dd24c2a9495f1a23ded9fcd8e9d72fac4e9cf5bfceedc02e874.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/0d70c4ca7dd45e591378a30b0e979441b962f2d2aae1a595e16679a5a451feaf.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/ca9d550e06ded09a49748414122220ac34a3eabbb37d6907375ae3950cb16195.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/d7b3f911327e63362e2a882b77eb800b2def83a8c221fe0864d62b3285a643e7.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/2348812274a65cb38bf7f91c5d52f4c2e576e871dfefdc006746b6a02d186ea6.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/81035e958fc608d8c5a29e794caf589ed0bf9f990b161dc5188b59b0f556dd55.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/79b4470fdcd630af491d45dba01e28f1c9de4aedbebf73aa3f761662320b879d.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/9afea81e0a03401d0654713650bcc41a4437ad3ebc73dc2bd1fbc427da81819a.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/22ee5a3d3d22962ef4dcc37888d9f58d128bbfc4c1d4712216eff83b7854ace5.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/952c3c3a2a719480d622754a4b463479b58900512e11f2986a305ea5c555db57.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/3fcd504d45b32d562fec4babd2f8cd6cda32bdaca701a0b04ec3701b201538eb.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/44a542ff6ac88a75e2e592fa88c46e479f19cd62d53a3cd2bd31ab75d7d2ab02.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/2debe4ba67db14af2a29c9780ab4b8162b508c6b9dbc0248b89e5fed66ae8e2d.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/f2b26849bdd54c32eb231686215843d8de7226bcefbe34be7a566989224338d9.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/e13888433f0dbdd229aa6171d29c00d3a535891a84b74f15a6e50bec46e63015.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/995604dd27bddba9e318372242b21e3e12561121cba183eee87901b48cf24c5d.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/f7a9e6a1110f137255f0573a860e81fe226ff980a76cfdc287415969f4b233bd.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/57bbc1c7da31124c15526c1bb8d8d743f3c32a7001708d1a094abc962e378ac8.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/91e1a7004e4c9058872ebbacbceef3a46aa2f0edc1e377c64d22355820b4b283.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/f72e91ffb1fc4723d4d40e9e1d12514a8627bc0310b3221fa80cb2bfacae97dd.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/e9fdfb0454c167c804413b4837f6901edebcada9e3e80b885734ad674603b838.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/2063dddca39716603e2a05e0eb1d544f4194ef5c9b878b554bc650a454c64b07.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/4feb9ed45151f788179ccfe39c615b5a4faf196c336d31c16c83c9e867cff701.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/c21b560f8fad2ad7913d6256c592ea9f85d96420a6735a3ab1038c5db5aa9315.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/dc2fd62ad07b747fb7ca9e8c2844dfd73b42837a05da4a3a8b7262f4013af9ec.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/ab7d206aedeeb559f612f36b36c3ab103e2ecb6bb8aef70b9c05a9b1bc9e52fd.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/edc5ddf389c9b0cc90c72d82842d8a421ccba9c2b55c5786f3067a72dc294c1b.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/4e37278677cd4f07c0386749cedee9de23e25154642ffa793f4f88c238fd2390.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/78e94e11299edd290782777e104a7d04b09942a57fd846faf2e89a3565d0472d.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/426abc06581dc5dcca6df84c102b6862c02d98003e3c3b1f86b9e526694aeb08.json
/Users/davispolito/dev/touchdesigner/touchpy/touchpy/graphify-out/cache/ast/v0.8.39/25fbba7a77dbea51f39a6f17d2b3c5d49eb8614fe8885d515c75df401f19f2b8.json

(Results are truncated: showing first 100 results. Consider using a more specific path or pattern.)
```

---

## Assistant (Build · GPT-5.5 Fast · 3.9s)

_Thinking:_

**Considering tool usage**

I'm pondering whether I should load multiple skills at once using the multi-tool feature. I wonder if the commentary tool allows for parallel skill usage. It seems like it might be okay since the developer tools are available. I could potentially call three skills together, which might streamline things. It’s definitely worth exploring how to efficiently utilize these tools to enhance my responses!

**Tool: skill**

**Input:**
```json
{
  "name": "td-interactive-pro"
}
```

**Output:**
```
<skill_content name="td-interactive-pro">
# Skill: td-interactive-pro

# TD Interactive Pro

TouchDesigner specialist for interactive installations: state machines, cook-model performance, data-driven parameters, td-tools extensions, color space workflows, and Envoy MCP integration.

Prefer simple operator networks for actual interactive behavior. Use Python for state, orchestration, parameters, and maintenance glue; do not replace a clear CHOP/TOP/SOP network with code when the network is the simpler real-time mechanism.

## When to Use This Skill

- Designing state machine architecture for TD installations
- Writing BaseEXT extensions with named parameter callbacks
- Optimizing for TD's pull-based cook model
- Structuring custom parameters as a data layer via ParTemplate
- Configuring working color space and display output for projection
- Working with Envoy MCP to AI-build or inspect live networks

## Core Workflow

**For any non-trivial task (new extension, new COMP, multi-operator network change): plan first, implement second.**

Before writing any code or calling any MCP tools, lay out the full plan in plain text:
- What will be created, modified, or removed
- Parameter names, types, and wiring
- Operator positions and annotation grouping
- Any constraints or open questions

State the plan explicitly and wait for confirmation before touching anything in TD or on disk. Do not begin implementation until Davis approves. This catches misunderstandings before they cost time in TD.

Once confirmed:

1. **Read the network** — `read_tdn` on the target COMP (preferred for ≥3 operators — 20–90× fewer tokens than walking via `get_op`/`query_network`). Add `get_annotations` for spatial context. For externalized Python: `get_externalizations` + `get_dat_content` on the relevant DAT paths — do not walk the network to locate them. Reserve `get_network_layout` for when x/y coordinates are specifically needed for placement.
2. **Design state** — Map the experience to discrete states. Define transitions, inputs, and outputs before writing code.
3. **Implement** — Subclass `BaseEXT` with `par_callback_on=True`; define named `onPar*` callbacks; build parameters with `ParTemplate`.
4. **Wire parameters** — Custom parameter pages are the data layer. Every parameter needs help text, defaults, and section breaks.
5. **Validate** — Test state transitions in TD Textport; confirm cook graph is not always-cooking unnecessarily.

## TouchDesigner Parameter Modes

TouchDesigner parameters can be constants or Python expressions. Treat any parameter value starting with `=` as expression mode, not as the literal value TD will use. When inspecting or setting operator parameters, explicitly check whether the value is a plain constant, an OP reference/path, or a Python expression. This matters for fields such as Parameter Execute DAT `op`, `ops`, and `pars`: a working FunctionStore expression may depend on the DAT's dock/module context, while a generated BaseEXT DAT may need a simpler constant such as `pars="*"`.

**TDN parameter bindings:** In `.tdn` JSON, a `=` at the start of a parameter value is TDN's notation that TD is storing a Python expression binding, not a constant. When reading TDN, never treat an `=`-prefixed value as a literal string — it is evaluated as Python at runtime. The `=` is written by TD itself; it is not something you add.

Before concluding that a TD parameter is equivalent to another one, compare both the displayed text and the evaluated value (`par.val` / `par.eval()`), and note expression-mode assumptions in docs or task notes.

## Reference Guide

| Topic | Reference | Load When |
|-------|-----------|-----------|
| Full TD API | `/td-api-reference` skill | Any TD Python API question |
| MCP tool catalog | `/mcp-tools-reference` skill | Before first Envoy tool call in a session |
| Parameter rules | `.claude/rules/parameters.md` | Creating or editing custom parameters |
| Network layout | `.claude/rules/network-layout.md` | Placing operators, annotations, docked DATs |
| TD Python rules | `.claude/rules/td-python.md` | Any TD Python — op refs, extensions, threading |
| MCP safety | `.claude/rules/mcp-safety.md` | Any MCP tool use |

---

## BaseEXT Extension Pattern

All extensions subclass `BaseEXT` from td-tools. Passing `par_callback_on=True` to `__init__` causes BaseEXT to create three generated Parameter Execute DATs and route TD parameter events to named `onPar*` methods on the class.

```python
from __future__ import annotations

import json
from td_tools.base import BaseEXT
from td_tools.parhelper import ParTemplate

try:
    from td import OP, Par, debug, run, tableDAT  # type: ignore
except (ImportError, ModuleNotFoundError):
    from td_tools.td_mock import OP, Par, debug, run
    tableDAT = 'tableDAT'


class MyEXT(BaseEXT):
    def __init__(self, ownerComp: OP):
        self.ownerComp = ownerComp
        self._ensureNetwork()
        self._ensureParameters()
        super().__init__(ownerComp, par_callback_on=True, defer_ready=False)

    def onDestroyTD(self):
        pass

    def onInitTD(self):
        # Always defer — onInitTD fires before TDN reconstruction completes
        run('args[0].postInit()', self, delayFrames=5)

    def postInit(self):
        self._ensureNetwork()
        self._ensureParameters()
        BaseEXT.__init__(self, self.ownerComp, par_callback_on=True, defer_ready=False)
```

**Why `postInit`:** `onInitTD` fires before TDN reconstruction completes. Re-calling `BaseEXT.__init__` in `postInit` (after the delay) ensures the generated execute DATs and parameter wiring are intact after every save/restore cycle.

---

## Named Parameter Callbacks

BaseEXT routes TD parameter events to methods named `onPar{Parametername}`. The naming convention maps directly to the parameter name (case-sensitive, capital first letter):

| Parameter type | Callback signature | Fires when |
|---|---|---|
| Toggle, Int, Float, Str | `onPar{Name}(self, par, val, prev)` | Value changes |
| Pulse | `onPar{Name}(self, par)` | Pulse fired |
| RGB, XYZ, RGBA (group) | `onParGroup{Name}(self, group, val)` | Any member of the group changes |

```python
# Toggle parameter named 'Enabled'
def onParEnabled(self, par, val, prev):
    self._updateState('enabled_changed')

# Int parameter named 'Step'
def onParStep(self, par, val, prev):
    self._updateState('step_changed')

# Pulse parameter named 'Increment'
def onParIncrement(self, par):
    if self.evalEnabled:
        self.evalCount = int(self.evalCount) + int(self.evalStep)
        self._updateState('increment')

# Pulse parameter named 'Reset'
def onParReset(self, par):
    self.evalCount = 0
    self._updateState('reset')

# RGB group named 'Tint'
def onParGroupTint(self, group, val):
    try:
        self.ownerComp.color = tuple(val[:3])
    except Exception:
        pass
    self._updateState('tint_changed')
```

`BaseEXT` also auto-generates `eval{Parametername}` properties for reading and writing parameter values:

```python
enabled = self.evalEnabled        # reads comp.par.Enabled.eval()
self.evalCount = 5                # sets comp.par.Count.val = 5
tint = list(self.evalGroupTint)   # reads the RGB group values
```

---

## Parameters via ParTemplate

**Always use `ParTemplate` to create custom parameters. Never call `page.appendFloat`, `page.appendInt`, `page.appendCOMP`, or any other native page method directly.** `ParTemplate` is the single canonical interface — it handles type dispatch, default application, and idempotency. Using native methods bypasses these guarantees and leads to subtle bugs on reinit.

`createPar()` is idempotent: it checks whether the parameter already exists on the page owner and skips silently if so. You do not need to guard calls with `if 'ParName' not in existing` — just call `createPar` and let it decide.

Get or create the page using `self.ownerComp.customPages` directly in `_ensureParameters` — do not use `self.GetPage()` there, because `_ensureParameters` is called before `BaseEXT.__init__` sets `self.Me`.

```python
def _ensureParameters(self):
    page = next((p for p in self.ownerComp.customPages if p.name == 'Settings'),
                self.ownerComp.appendCustomPage('Settings'))

    ParTemplate('Enabled', par_type='Toggle', label='Enabled', default=True).createPar(page)
    self.ownerComp.par.Enabled.help = (
        'Enable or disable processing. When off, all input events are ignored.'
    )

    ParTemplate('Speed', par_type='Float', label='Speed', min=0.0, max=10.0, default=1.0).createPar(page)
    self.ownerComp.par.Speed.help = 'Playback speed multiplier. 1.0 = normal speed.'

    ParTemplate('Trigger', par_type='Pulse', label='Trigger').createPar(page)
    self.ownerComp.par.Trigger.help = 'Fire once to advance the state machine.'

    ParTemplate('Target', par_type='COMP', label='Target COMP').createPar(page)
    self.ownerComp.par.Target.help = 'Reference to the sibling COMP to operate on.'
```

**Rules:**
- `ParTemplate` does **not** accept `help=`. Assign help text afterward with `ownerComp.par.Name.help = '...'`.
- Every created custom parameter must receive help text — no exceptions.
- `par_type` values — scalar: `'Toggle'`, `'Int'`, `'Float'`, `'Str'`, `'Pulse'`, `'Menu'`, `'StrMenu'`, `'File'`, `'Folder'` — vector: `'RGB'`, `'RGBA'`, `'XY'`, `'XYZ'`, `'XYZW'`, `'UV'`, `'UVW'` — OP reference: `'OP'`, `'COMP'`, `'CHOP'`, `'TOP'`, `'SOP'`, `'DAT'`, `'MAT'`.

---

## State Machine Pattern

```python
from enum import Enum, auto

class ExperienceState(Enum):
    IDLE     = auto()
    ATTRACT  = auto()
    ACTIVE   = auto()
    COOLDOWN = auto()


class ExperienceEXT(BaseEXT):
    def __init__(self, ownerComp: OP):
        self.ownerComp = ownerComp
        self._ensureParameters()
        saved = ownerComp.fetch('state', default='IDLE', search=False)
        self._state = ExperienceState[saved]
        super().__init__(ownerComp, par_callback_on=True, defer_ready=False)

    def onInitTD(self):
        run('args[0].postInit()', self, delayFrames=5)

    def postInit(self):
        self._ensureParameters()
        saved = self.ownerComp.fetch('state', default='IDLE', search=False)
        self._state = ExperienceState[saved]
        BaseEXT.__init__(self, self.ownerComp, par_callback_on=True, defer_ready=False)

    @property
    def State(self) -> str:
        return self._state.name

    def TransitionTo(self, target: str) -> None:
        try:
            next_state = ExperienceState[target]
        except KeyError:
            debug(f'Unknown state: {target}')
            return
        self._exit(self._state)
        self._state = next_state
        self.ownerComp.store('state', self._state.name, search=False)
        self._enter(self._state)

    def _enter(self, state: ExperienceState) -> None:
        match state:
            case ExperienceState.IDLE:    self._enterIdle()
            case ExperienceState.ATTRACT: self._enterAttract()
            case ExperienceState.ACTIVE:  self._enterActive()
            case ExperienceState.COOLDOWN: self._enterCooldown()

    def _exit(self, state: ExperienceState) -> None:
        match state:
            case ExperienceState.IDLE:    self._exitIdle()
            case ExperienceState.ATTRACT: self._exitAttract()
            case ExperienceState.ACTIVE:  self._exitActive()
            case ExperienceState.COOLDOWN: self._exitCooldown()

    def _enterIdle(self): ...
    def _exitIdle(self): ...
    def _enterAttract(self): ...
    def _exitAttract(self): ...
    def _enterActive(self): ...
    def _exitActive(self): ...
    def _enterCooldown(self): ...
    def _exitCooldown(self): ...
```

**Rules:**
- Persist state in `comp.store('state', ..., search=False)` — survives TDN reimport.
- Promote `State` (read-only) and `TransitionTo` for external access; keep enter/exit handlers private.
- Never store state in a parameter — parameters are inputs, not state.

---

## Cook Model Performance

TD's cook model is **pull-based**: operators only cook when downstream demands output. There is no Update() called every frame unless an op is marked always-cook.

### What causes unnecessary cooks

| Anti-pattern | Problem | Fix |
|---|---|---|
| Expression polling a changing value | Forces cook every frame even when output is stable | Cache in storage; use `tdu.Dependency` and `.modified()` |
| `scriptDAT`/`scriptTOP` always-cook without reason | Evaluates Python every frame | Only mark always-cook when output genuinely changes every frame |
| `op()` lookup inside a cook callback | Re-resolves path every cook | Cache op references at init |
| Heavy computation in a parameter expression | Blocks the cook thread | Move to an extension method triggered by a timer CHOP or event |

### Op reference caching

```python
def __init__(self, ownerComp: OP):
    self.ownerComp = ownerComp
    # Cache at init — never call op() inside a cook callback
    self._state_table = ownerComp.op('state_table')
    self._render_out  = ownerComp.op('render/out1')
    super().__init__(ownerComp, par_callback_on=True, defer_ready=False)
```

### Always-cook discipline

- Never mark a COMP always-cook just to ensure it "stays live." Let the downstream consumer drive the cook.
- Use a `Timer CHOP` or `Execute DAT` for periodic state checks instead of always-cook.
- `scriptTOP` rendering generative output → always-cook is correct. `scriptDAT` reformatting a static table → never always-cook.

---

## Color Space

TouchDesigner is **not color-correct by default**. All projects start in `PASS_THROUGH` mode — content loads as-is, composites as-is, and outputs as-is. This is incorrect for any project doing real compositing or projection because most source content has a non-linear transfer (e.g. sRGB) applied, and compositing must be done in linear.

Color-correct workflows are **opt-in per project** and require a **save + restart** to take effect.

### Setting the working color space

```python
# Set in Python or Preferences > Color tab — requires project save + restart
project.workingColorSpace = WorkingColorSpace.SRGB_LINEAR    # most installations
project.workingColorSpace = WorkingColorSpace.ACES_CG         # forces all TOPs to 16-bit float
project.workingColorSpace = WorkingColorSpace.REC_2020_LINEAR
project.workingColorSpace = WorkingColorSpace.DCIP3_LINEAR
project.workingColorSpace = WorkingColorSpace.PASS_THROUGH    # default (incorrect)
```

The working color space is the internal unit for all color values. All TOPs store data in this space. Input TOPs (Movie File In, Video Device In) auto-detect and convert source color space on load; sRGB is assumed if nothing is detected.

### Choosing the right working color space

| Use case | Working color space |
|---|---|
| Standard projection, sRGB monitors | `SRGB_LINEAR` |
| Film/VFX pipeline, wide gamut output | `ACES_CG` |
| DCI projection | `DCIP3_LINEAR` |
| HDR display, broadcast | `REC_2020_LINEAR` |
| Legacy / existing project compatibility | `PASS_THROUGH` |

`ACES_CG` forces all TOPs to 16-bit float — more memory, correct for wide gamut and HDR. `SRGB_LINEAR` keeps 8-bit textures stored with sRGB transfer (better dark-range precision) while processing in linear.

### Display output pixel format

Controls bit depth and HDR mode for the output window. Set on `Window COMP` for Perform windows, or via Python for the editor window:

```python
project.editorWindowPixelFormat = WindowPixelFormat.SDR8_FIXED   # standard
project.editorWindowPixelFormat = WindowPixelFormat.SDR10_FIXED  # 10-bit SDR
project.editorWindowPixelFormat = WindowPixelFormat.HDR10_FIXED  # HDR 10-bit
project.editorWindowPixelFormat = WindowPixelFormat.HDR16_FLOAT  # HDR 16-bit float
```

Setting an HDR pixel format when the OS monitor is not already in HDR mode will trigger a screen flicker. Put the monitor in HDR mode first.

### Output color space

When sending to Movie File Out, Video Device Out, or NDI, explicitly set the output color space on those nodes — TD will not guess. The node converts from working color space to the specified output color space before writing.

### Key rules

- Never composite in non-linear. When working color space is not PASS_THROUGH, TD converts source content to linear on load.
- A `.tox` built in PASS_THROUGH may not behave correctly in a color-correct project.
- Color parameters use a **Parameter Color Space** setting on the node's Common page — controls how that parameter value is interpreted relative to the working color space.
- Color space changes do not take effect until the project is saved and reopened.

---

## Envoy MCP Integration

Envoy is the Claude ↔ TD bridge running at `localhost:9870`. It exposes 48+ tools for inspecting and modifying the live network without touching binary `.toe` files.

**Before any session involving TD network work:**
```
/mcp-tools-reference   ← read the full tool catalog first
```

### Key tool groups

| Group | Tools | Use for |
|---|---|---|
| Network read (default) | `read_tdn`, `get_annotations` | Preferred for any network exploration ≥3 ops — read before writing |
| Externalized Python | `get_externalizations`, `get_dat_content` | Read externalized `.py` DATs — use these instead of walking the network |
| Layout/positioning | `get_network_layout` | Only when x/y coordinates are needed for operator placement (3+ ops) |
| Operator creation | `create_op`, `set_parameter`, `set_op_position` | Build network from Claude |
| Code (surgical edit) | `edit_dat_content`, `set_dat_content` | Write/patch Python DATs |
| Parameters | `get_parameter`, `set_parameter` | Read/write custom and built-in pars |
| Python execution | `execute_python` | Run one-off Textport commands |
| TDN I/O | `read_tdn`, `export_network`, `import_network`, `diff_tdn` | Serialize/deserialize/diff TDN COMPs |

### Constraints

- Envoy runs in a background thread — never access TD objects from Python threads; all TD ops go through MCP tools.
- Timeline must be playing or Envoy will not respond.
- Operations time out at 30 seconds — break long tasks into smaller MCP calls.
- Server binds to `127.0.0.1` only — not network-accessible.
- `.mcp.json` at repo root is auto-generated by Embody; do not edit manually.

### Workflow discipline

1. **Scope check first** — for ≤2 new operators or a parameter tweak, skip all network reads. Ask where to place relative to a known op.
2. **Network read (3+ ops or unknown state):** `read_tdn` on the target COMP + `get_annotations`. Read externalized `.py` files via `get_externalizations` + `get_dat_content`. Use `get_network_layout` only when you need x/y coordinates for placement.
3. Batch-compute all positions before placing anything.
4. After `create_op`, check for docked DATs and reposition per layout rules.
5. Verify with `read_tdn` or `get_network_layout` — confirm no overlaps.

---

## TD op.type Strings — Always Lowercase

`op.type` returns all-lowercase strings with no camelCase. Examples: `'moviefilein'` (not `'moviefileIn'`), `'container'` (not `'containerCOMP'`), `'base'` (not `'baseCOMP'`).

Before writing any `op.type` filter, either verify exact strings with `set(o.type for o in ops)` or compare with `.lower()`. Never assume casing from the UI label or TD docs examples.

---

## TD Sequence Parameters

Use `op.seq.NAME.numBlocks = N` to resize sequence parameters. `set_parameter`, `par.val = N`, and `par = N` silently succeed but leave `numBlocks` unchanged.

Any time `get_parameter` shows `"style": "Sequence"`, use `execute_python` with `op.seq.NAME.numBlocks = N`. `get_parameter` for Sequence pars always reports the default (0), not the current count — use `execute_python` + `get_dat_content` to verify actual state.

**TDN format:** Sequences encode under a `"sequences"` key, not as individual `name0par`/`name0attr` parameters.

**POP wiring:** Within the same POP network, connect `dmxfixturePOP` to `dmxoutPOP` via wire (POP input 0), not via the `fixture0pop` parameter reference.

---

## Programmatic textTOP Creation

Creating textTOPs via `execute_python` or `comp.create()` has several non-obvious gotchas. All four of these must be set or the render will be black or wrong:

```python
t = comp.create(textTOP, 'title_top')

# 1. Must be 'custom' — default 'useinput' with no input gives 256x256 or blank
t.par.outputresolution = 'custom'
t.par.resolutionw = 1920
t.par.resolutionh = 1080

# 2. Default is True which can zero out text at certain sizes
t.par.fontautosize = False

# 3. Default par.text is 'derivative' — it CONCATENATES with par.dat content
#    Always clear it before setting par.dat
t.par.text = ''
t.par.dat  = 'my_sel_dat'

# 4. display=False on intermediate TOPs, True only on out1
#    Having display=True on multiple TOPs in the same container interferes with rendering
t.display = False
```

### DAT-driven text (selectDAT → textTOP)

The proper pattern for driving textTOP content from a data DAT:

```python
# selectDAT inside containerCOMP, reading from parent's slides_dat
sel = comp.create(selectDAT, 'title_sel')
sel.par.dat           = '../slides_dat'   # one level up from container
sel.par.firstrow      = False             # exclude header row from output
sel.par.firstcol      = False
sel.par.extractrows   = 'byindex'
sel.par.rowindexstart = row_idx           # 0-based, counting header as row 0
sel.par.rowindexend   = row_idx
sel.par.extractcols   = 'bynames'
sel.par.colnames      = 'title'           # column name to extract

# textTOP reads from selectDAT
t.par.text = ''        # MUST clear — default 'derivative' text concatenates with dat
t.par.dat  = 'title_sel'
```

### CompositeTOP operand

The default `compositeTOP` operand is **`multiply`**, not `over`. Multiply of black×anything = black.

- Use `operand='add'` when layering text TOPs with black backgrounds — adds RGB values, black (0) is neutral.
- Use `operand='over'` only when input 1 has genuine alpha. Note: in TD, `over` means input 0 is placed ON TOP of input 1 — input 0's opaque background will cover input 1 entirely.

```python
c = comp.create(compositeTOP, 'comp_top')
c.par.operand = 'add'   # NOT the default 'multiply'
```

### textTOP position system (fraction mode)

In `positionunit='fraction'` with `alignx='left'`, `aligny='top'`:
- `(0, 0)` = top-left corner of frame ✓
- Any non-zero positive offset currently produces a black render (root cause unknown in 2025 builds)

**Workaround for vertical spacing:** bake spacing into the text content using a newline prefix. Store `'\n\n\n\n' + body_text` in the data DAT (`body_display` column) rather than trying to use `positiony`.

---

## WebRender TOP

- **Timeline must be playing** — webrenderTOP will not initialize Chromium if `root.time.play` is False.
- **Cook chain required** — `alwayscook=True` is still pull-based. The webrenderTOP only cooks when something downstream demands it. A parent baseCOMP with no downstream consumer stays cold even if children have `alwayscook=True`.
- **`resmult=False`** — if the project's resolution multiplier is low, webrenderTOP outputs 128×128 regardless of `resolutionw`/`resolutionh`. Always set `par.resmult = False` when setting custom resolution programmatically.
- **Use the palette webBrowser COMP** — prefer copying `/project1/webBrowser` over a raw webrenderTOP. It handles keyboard/mouse/panel input, audio, crop, and navigation. Its resolution tracks the COMP's own width/height (`resolutionw/h = "=parent.WebBrowser.width/height"`).
- **Active par silences inactive instances** — when multiple webBrowser COMPs exist, set `wb.par.Active.expr = "parent().par.Linkindex == N"` so only the selected one loads/plays.

## selectTOP as dynamic switch (avoids cooking inactive inputs)

`switchTOP` cooks ALL inputs every frame — there is no "cook inactive inputs" option in TD 2025. When only one of N operators should cook at a time, use a **single selectTOP** with a name-building expression:

```python
sel.par.top.mode = ParMode.EXPRESSION
sel.par.top.expr = "'wb_link_' + str(int(parent().par.Linkindex))"
```

This demands exactly one operator; all others stay cold and silent. Pair with `Active` expressions on the inactive webBrowser COMPs to fully suppress them.

## Anti-Patterns

- **Absolute operator paths** — `op('/project1/...')` breaks on rename/move. Use relative paths, `parent.CompName`, or `op.CompName`.
- **Module-level TD access** — `op()` at module level runs before the network is ready. Defer all TD access to `__init__` or `postInit`.
- **State in parameters** — Parameters are inputs, not state. Use `comp.store(search=False)` for persistent state.
- **Native page append methods** — never call `page.appendFloat`, `page.appendCOMP`, etc. directly. Always use `ParTemplate.createPar()`, which handles type dispatch and idempotency. No manual `if 'ParName' not in existing` guards needed — `createPar` skips silently if the parameter already exists.
- **Skipping `postInit` pattern** — `onInitTD` fires before TDN reconstruction completes. Always re-call `BaseEXT.__init__` in a deferred `postInit`.
- **Heavy work in cook callbacks or expressions** — Move computation to extension methods triggered by events or timers.
- **Leaving docked DATs at auto-spawn position** — After `create_op` on any op that spawns docked DATs, reposition them per `.claude/rules/network-layout.md`.
- **PASS_THROUGH for new projects** — It's the default but it's wrong for any real installation. Set `project.workingColorSpace` explicitly.
- **Forgetting save + restart after color space change** — Color space changes do not take effect until the project is saved and reopened.
- **Null naming** — Null operators should be named `*_null`. Only actual `out` operators (`outTOP`, `outCHOP`, `outSOP`, `outDAT`, `outPOP`) should use `out`/`*_out` names. Never name a Null `*_out`; if a signal must be exposed outside a COMP, use a real `out` operator instead.

---

## SOP Geometry — Per-Face Materials and UV Mapping

### Per-face material assignment

TD's SOP Python API in this build (2025.32820) does **not support per-primitive material assignment** via Python:
- `scriptSOP` does not have `addAttrib` or `geometry` — the scriptSOP IS the geometry, and `Prim` objects are read-only (only `center`, `normal`, `index`, `owner`, `size`, `weight`)
- `materialSOP` only assigns one material to the whole geometry (`mat` + `pageindex` only — no group parameter)

**Correct approach**: two geometry COMPs, each with a `deleteSOP` selecting the faces they own:
```
previs_geo       → deleteSOP(keep prim N = top face) → mat: video_mat
previs_geo_sides → deleteSOP(delete prim N)           → mat: sides_mat
```
Reference both in `renderTOP.par.geometry = "previs_geo previs_geo_sides"`.

To find which primitive is which face, iterate normals: `[(i, p.normal[1]) for i, p in enumerate(box.prims)]`. In a default boxSOP, prim 5 is the +Y (top) face.

**deleteSOP config** for selecting by primitive index:
```python
del_sop.par.entity     = 'primitive'
del_sop.par.negate     = 'keep'   # or 'dele'
del_sop.par.usenumber  = True
del_sop.par.groupop    = 'range'
del_sop.par.rangestart = 5
del_sop.par.rangeend   = 5
```

### boxSOP UV coordinates are not normalized

A `boxSOP`'s default UV coordinates are **not normalized to [0,1]** across each face — they reflect world-scale position. Texture applied via phongMAT `colormap` will only appear in one corner of the face.

**Fix**: insert a `textureSOP` after the box (or after any face-selecting deleteSOP) to remap UVs:
```python
tex.par.type = 'xyznorm'  # normalize XYZ bounding box to [0,1] UV
tex.par.axis = 'y'        # project from above (Y axis) for the top face
```
This normalizes the XZ extents of the isolated top-face geometry to [0,1]×[0,1] UV space, so the texture fills the full face.

---

## Testing Extensions and Python

### Reading output from `execute_python`

`debug()` writes to TD's Textport — it is not visible from outside TD (Envoy, test runners, scripts). To capture output from `execute_python`, write to a temp textDAT and read it back with `get_dat_content`.

### Temp DAT pattern — safe on repeat runs

`op().create()` fails silently when the name is already taken, returning `None`. Always reuse an existing DAT if it's there:

```python
tmp = op('/project1/_td_test_out') or op('/project1').create(textDAT, '_td_test_out')
tmp.text = json.dumps(results, default=str)
```

### Always destroy in a `finally`

If an assertion fails before `destroy()`, the DAT persists. The next run then hits the collision above. Use `try/finally` in the test caller to guarantee cleanup:

```python
td_exec("""
    import json
    results = {'val': op('/project1/MyComp').ext.MyExt.SomeMethod()}
    tmp = op('/project1/_td_test_out') or op('/project1').create(textDAT, '_td_test_out')
    tmp.text = json.dumps(results, default=str)
""")
try:
    raw = td_get_dat("/project1/_td_test_out")
    assert json.loads(raw)["val"] == expected
finally:
    td_exec("d = op('/project1/_td_test_out'); d and d.destroy()")
```

### Anti-patterns

- **`debug()` for test output** — goes to Textport only, invisible to external runners.
- **`create()` without reuse guard** — collides on re-run, returns `None`, raises on `.text` assignment.
- **Destroy after assert without `finally`** — leaks the DAT on failure, breaks the next run.

Base directory for this skill: /Users/davispolito/.agents/skills/td-interactive-pro
Relative paths in this skill (e.g., scripts/, reference/) are relative to this base directory.
Note: file list is sampled.

<skill_files>

</skill_files>
</skill_content>
```

**Tool: skill**

**Input:**
```json
{
  "name": "debug-operator"
}
```

**Output:**
```
<skill_content name="debug-operator">
# Skill: debug-operator

<!-- Generated by Embody/Envoy - Do not remove this comment -->

# Debug Operator Workflow

Systematic approach to diagnosing TD operator errors:

1. **Get errors and warnings**: `get_op_errors` with `recurse=true` on the suspected operator and its children
2. **Inspect the operator**: `get_op` to see type, family, parameters, inputs, outputs, children
3. **Check connections**: `get_connections` to verify input/output wiring is correct
4. **Read DAT content**: `get_dat_content` if the operator is a DAT with script errors
5. **Check parameters**: `get_parameter` on specific parameters that might be misconfigured
6. **Check performance**: `get_op_performance` if the issue is cook-time related

## Common Error Patterns

- **Missing input**: Operator requires a specific input type — check connections
- **Script error in DAT**: Read the DAT content and fix the Python/expression
- **Parameter out of range**: Check parameter values against valid ranges
- **Missing operator reference**: An expression or parameter references a non-existent operator
- **Cook error**: The operator can't process its inputs — check input data types match expectations
- **Black or empty render**: Use `capture_top` on the intended output TOP, then check display/render flags on the output and upstream ops; missing light or camera (a 3D scene renders black without both); no cooking Null terminating the chain; a bypass flag left on; resolution is 0; alpha is premultiplied/zero so the image is present but invisible; and whether the op is cooking (check `cookedThisFrame` via `get_op_performance`, or force a cook). After each fix, use `capture_top` again to confirm the frame renders correctly.

Base directory for this skill: /Users/davispolito/dev/touchdesigner/touchpy/touchpy/.claude/skills/debug-operator
Relative paths in this skill (e.g., scripts/, reference/) are relative to this base directory.
Note: file list is sampled.

<skill_files>

</skill_files>
</skill_content>
```

**Tool: skill**

**Input:**
```json
{
  "name": "td-api-reference"
}
```

**Output:**
```
<skill_content name="td-api-reference">
# Skill: td-api-reference

<!-- Generated by Embody/Envoy - Do not remove this comment -->

# TouchDesigner Python API Reference

**Always research TD features on the wiki before writing code.** Assumptions about TD's Python API are frequently wrong.

- **Wiki home**: https://docs.derivative.ca/Main_Page
- **OP Class**: https://docs.derivative.ca/OP_Class
- **COMP Class**: https://docs.derivative.ca/COMP_Class
- **Par Class**: https://docs.derivative.ca/Par_Class
- **Extensions**: https://docs.derivative.ca/Extensions
- **Cook cycle**: https://docs.derivative.ca/Cook

## Parameter Access Patterns

```python
# CORRECT — always use .eval() for the current runtime value:
value = op('geo1').par.tx.eval()

# WRONG — .val only works in constant mode:
value = op('geo1').par.tx.val

# Setting values:
op('geo1').par.tx = 5
op('geo1').par.tx.val = 5  # CAUTION: silently switches to CONSTANT mode

# Menu parameters accept string name or index:
op('geo1').par.xord = 'trs'   # by name
op('geo1').par.xord = 5       # by index

# Type casting requires explicit .eval():
me.par.tx.eval().hex()  # CORRECT
me.par.tx.hex()         # WRONG
```

## Creating Custom Parameters

All `append*` methods return a **ParGroup** (tuple-like), not a single Par — always index with `[0]`.

```python
page = comp.appendCustomPage('Controls')
pg = page.appendFloat('Speed', label='Speed')  # Returns ParGroup
p = pg[0]                                       # Get the actual Par
p.default = 0.5
p.normMin = 0; p.normMax = 2    # Slider range
p.min = 0; p.clampMin = True    # Hard clamp
p.help = "Playback speed multiplier."  # Tooltip on hover
p.startSection = True           # Draw separator line above

# Other methods:
page.appendInt('Count')
page.appendToggle('Active')
page.appendStr('Label')
page.appendMenu('Mode')        # Creates EMPTY menu — set .menuNames/.menuLabels separately
page.appendPulse('Reset')
page.appendRGB('Color')        # Creates Color1r, Color1g, Color1b
page.appendXYZ('Pos')          # Creates Pos1, Pos2, Pos3
page.appendOP('Target')
page.appendFile('Path')

# Post-creation properties:
p.help = "Tooltip text shown on hover"  # ALWAYS set this
p.startSection = True   # Draw separator line above this parameter
p.order = 11.5          # Insert between order 11 and 12
p.readOnly = True       # Display-only parameter

# Cleanup:
comp.destroyCustomPars()       # Remove ALL custom pars
par.Speed.destroy()            # Remove single custom par
```

**Naming rule:** First letter MUST be uppercase, rest lowercase/numbers. No underscores.
- **Parameter design rules**: See `.claude/rules/parameters.md` for full conventions
- Docs: https://docs.derivative.ca/Custom_Parameters

## `op()` vs `opex()`

```python
node = op('/nonexistent/path')   # Returns None — silent failure
node = opex('/nonexistent/path') # Raises tdError — clear message

all_noises = ops('noise*')       # Returns a LIST (supports wildcards)
```

Use `op()` only when `None` is an acceptable result.

## `debug()` vs `print()`

```python
debug('value is', x)  # "myScript line 42: value is 42" (with source info)
print('value is', x)  # "value is 42" (no source info)
```

## Module-Level Code Hazard

Never call `op()`, `parent()`, or access TD objects at module level. They execute during import, before the network is ready.

```python
# WRONG:
my_op = op('base1')  # May be None during init

# CORRECT — defer to methods:
class MyExt:
    def doSomething(self):
        my_op = op('base1')  # Resolved at call time
```

## Import Shadowing

TD searches for DATs by name before `sys.path`. A DAT named `json` shadows Python's `json` module.

## `mod()` for Module Access

```python
# In a parameter expression (import not available):
mod.utils.myFunction()

# In a script (decreasing performance):
import utils                         # Fastest
m = mod.utils; m.func()              # OK — cache the reference
mod.utils.func()                     # Slowest — re-resolves every call

# Access by path:
mod('/project1/utils').myFunction()

# Direct module property:
op('myDat').module.myFunction()
```
- Docs: https://docs.derivative.ca/MOD_Class

## `extensionsReady` Guard

```python
# In a parameter expression:
parent().MyExtensionProperty if parent().extensionsReady else 0
```

## Operator Storage

```python
op('base1').store('count', 42)
val = op('base1').fetch('count', 0)  # 0 is default
op('base1').unstore('count')
op('base1').storeStartupValue('version', 1)  # Restored on project load
```

**Gotchas:** `fetch()` searches UP hierarchy by default — use `search=False` for local-only. `store()` triggers recooks. Cannot store TD operator references — use path strings.
- Docs: https://docs.derivative.ca/Storage

## `tdu.Dependency` for Reactive Values

```python
dep = tdu.Dependency(0)
dep.val = 5          # CORRECT — triggers recooks
dep = 5              # WRONG — destroys the Dependency object

current = dep.peekVal  # Read without creating dependency

dep.val = [1, 2, 3]
dep.val.append(4)      # Does NOT trigger update
dep.modified()         # Required
```
- Docs: https://docs.derivative.ca/Dependency_Class

## `tdu` Utility Functions

```python
tdu.clamp(val, min, max)
tdu.remap(val, fromMin, fromMax, toMin, toMax)
tdu.rand(seed)                        # Deterministic [0.0, 1.0)
tdu.base('noise3')                    # 'noise'
tdu.digits('noise3')                  # 3
tdu.validName('my op!')               # 'my_op_'
tdu.match('noise*', ['noise1', 'c1']) # ['noise1']
tdu.expand('A[1-3]')                  # ['A1', 'A2', 'A3']
tdu.tryExcept(expr, fallback)
```

## DAT Cell and Text Behavior

All DAT cells are internally **strings**. Auto-cast to numbers in expression contexts.

```python
n = op('table1')
n[1,2] + 1          # 4 (auto-cast)
n[1,2].val + 1      # TypeError: str + int
```

- `dat.text` — tab/newline delimited; **strips multi-line cell content**. Use `dat.csv` for cells with newlines
- `dat.jsonObject` — parses as JSON directly (no `json.loads()` needed)
- `dat.module` — access as Python module
- `dat.write(content)` — **appends** (does not overwrite)
- Docs: https://docs.derivative.ca/DAT_Class

## CHOP Channel Access

```python
ch = op('noise1')['chan1']        # By name — NO wildcard
chs = op('noise1').chans('tx*')  # Pattern matching
val = ch.eval()                   # Current value

ch[0], ch[10]                     # Sample by index
ch.evalFrame(30)                  # At specific frame
arr = op('noise1').numpyArray()   # Shape: (numChans, numSamples)
```
- Docs: https://docs.derivative.ca/Channel_Class

## TOP Pixel Access

**Coordinate system:** TD places **(0, 0) at the bottom-left, with Y increasing upward** for all texture operations. `TOP.numpyArray()` is the exception: it returns rows top-to-bottom (numpy convention).

`TOP.sample(x, y)` downloads the **entire texture** from GPU — extremely expensive. Never in loops.

```python
# sample() uses TD texture coords: y=0 is BOTTOM of image
r, g, b, a = op('noise1').sample(x=0.5, y=0.5)  # Center of texture
r, g, b, a = op('noise1').sample(x=0, y=0)       # Bottom-left corner

# numpyArray() returns rows TOP-to-BOTTOM (opposite of TD texture coords)
arr = op('noise1').numpyArray()  # [height, width, channels] — NOT [width, height]
# arr[0] is the TOP of the image (highest TD Y)
# arr[-1] is the BOTTOM of the image (TD y=0)

# Flip to match TD bottom-up order:
arr_td = np.flipud(arr)
```

## POPs — GPU-Accelerated Point Operators

POPs process 3D geometry on the GPU (analogous to SOPs but GPU-accelerated).

```python
grid = parent.create(gridPOP, 'grid1')
n = pop_op.numPoints(delayed=True)    # Non-blocking
pts = pop_op.points('P')              # Downloads (blocks GPU)
bounds = pop_op.bounds(delayed=True)  # Non-blocking
attrs = pop_op.pointAttributes        # Set of attribute names
```

Common types: `gridPOP`, `noisePOP`, `transformPOP`, `particlePOP`, `spherePOP`, `linePOP`, `mergePOP`, `nullPOP`, `selectPOP`, `mathPOP`, `cachePOP`, `glslPOP`. For files: `fileinPOP` (File In POP — meshes/geometry) vs `pointfileinPOP` (Point File In POP — 3D point clouds: `.ply`/`.pts`/`.xyz`/`.e57`, Gaussian splats) are **distinct** operators.
- Docs: https://docs.derivative.ca/POP_Class

## `run()` — Delayed Code Execution

```python
run("op('/project1/base1').cook(force=True)", delayFrames=1)
run("print('done')", delayMilliSeconds=500)
run("op.Embody.Update()", endFrame=True)
run(myFunction, arg1, arg2, delayFrames=5)
run("me.cook(force=True)", fromOP=op('/project1/base1'), delayFrames=1)
```
- Docs: https://docs.derivative.ca/Td_Module#Methods

## Background and Long-Running Work

The full decision ladder (when to use what; threading is the last resort) and the ironclad rule ("never touch a TD object - or call `run()` - from a worker thread; a read is as fatal as a write") live in `rules/td-python.md` (Threading and Background Work). This section is the code.

### Fetch data: Web Client DAT (no threading)

The TD-native way to hit an HTTP API. `request()` is async - it returns a connection id immediately and never blocks the frame; TD does the networking on its own thread and delivers the response to the Callbacks DAT `onResponse`, which runs on the MAIN thread (so TD access there is safe).

```python
# Main-thread code (e.g. a Pulse parameter's onPulse, or a Timer CHOP tick):
conn_id = op('webclient1').request(
    'https://air-quality-api.open-meteo.com/v1/air-quality?latitude=43.7&longitude=-79.4&hourly=pm2_5',
    'GET',                 # method is REQUIRED (no default)
    timeout=8000,          # ms; async, so it never freezes the frame
)
# Fire only ONE request per Web Client DAT per frame; do not start another while one is pending.
```

```python
# In the Web Client DAT's Callbacks DAT - runs on the MAIN thread:
def onResponse(webClientDAT, statusCode, headerDict, data):
    # statusCode is a DICT: {'code': int, 'message': str}
    if statusCode['code'] != 200:
        op('status').text = 'error %s' % statusCode['code']   # surface failures, do not fail silently
        return
    op('raw_json').text = data.decode('utf-8')                # data is BYTES - decode first
    return
```

Then parse and shape with native ops instead of Python in the callback:
`webclient1` -> `raw_json` (Text DAT) -> **JSON DAT** (Filter = JSONPath, Output Format = Table) -> **DAT to CHOP** -> `null_chop` / `out1`. That yields BOTH the table (DAT) and the channels (CHOP) - the canonical "CHOP and DAT" deliverable. There is no Web Client CHOP. For a quick parse you can also read `op('raw_json').jsonObject`. `request()` also accepts `authType` + basic/`appKey`/OAuth params - prefer them over hand-rolled auth headers. TD has no built-in retry: on failure, re-issue `request()` via `run(..., delayFrames=N)` with a capped attempt count, never a synchronous loop.

**Triggers:** a user-driven Pulse parameter (`onPulse` / `Par.pulse()`) for a one-shot/manual fetch; a **Timer CHOP** (`onCycleStart` fires one `request()`) for periodic; an Execute DAT `onFrameStart` frame-counter only for sub-second work. Never a `sleep` loop, a self-rescheduling `run()` poller, or an auto-fetch on project open unless asked.

**Pick the operator:**

| Need | Operator | Callback (main thread) |
|---|---|---|
| HTTP request/response or HTTP streaming | Web Client DAT | `onResponse` |
| Persistent push/stream (`ws://`) | WebSocket DAT | `onReceiveText`/`onReceiveBinary` |
| TD must RECEIVE requests / host an endpoint | Web Server DAT | `onHTTPRequest` (NOT a fetch tool) |
| Low-latency control between apps | OSC In/Out DAT | per-message |
| Local file / directory listing | File In DAT / Folder DAT | cooked DAT, no thread |

(For streaming, enable the Web Client DAT's Stream mode + Clamp Output as Rows so the DAT does not grow unbounded and inflate cook time.)

### Blocking pure-Python work: the Thread Manager

When no operator expresses the work (custom auth/sessions, a blocking SDK, a big subprocess, heavy CPU on plain data), run it OFF the main thread. **Prefer the Palette Thread Manager Client** (Palette > ThreadManager > threadManagerClient) - a callback-oriented component with a generated callback DAT; Derivative recommends it over the raw COMP.

Advanced (raw API): the `target` runs on a worker and must touch ZERO TD objects; hand results back through a `queue.Queue` you create on the MAIN thread and drain in the `RefreshHook` (exactly how Envoy's MCP server works - see `EnvoyExt.py`):

```python
import queue
results = queue.Queue()                     # created on the MAIN thread

def fetch(url, out):                         # WORKER: no op(), no params, no run(), no debug()/print()
    import requests
    r = requests.get(url, timeout=(2, 8))    # requests timeout is SECONDS; always set it (no default)
    r.raise_for_status()
    out.put(r.json())                        # plain Python only

def on_refresh(*args):                        # MAIN thread, at least once per frame while the task runs
    while not results.empty():
        data = results.get_nowait()
        op('table_out').text = repr(data)    # safe: main thread

task = op.TDResources.ThreadManager.TDTask(target=fetch, args=('https://...', results), RefreshHook=on_refresh)
op.TDResources.ThreadManager.EnqueueTask(task)              # or standalone=True for a long-lived server/loop
```

**Key:** the `target` runs on a worker and must touch ZERO TD objects (no `op()`, no parameter read OR write, no DAT/CHOP content, no `storage`, no `tdu.Dependency`, no `debug()`/`print()`); apply results to TD only on the MAIN thread (a `RefreshHook`/`SuccessHook`/`ExceptHook`, or a `queue.Queue` drained by an Execute DAT `onFrameStart`). `standalone=True` for long-lived tasks; the worker pool defaults to 4 (capped at `os.cpu_count()`). Never call `EnqueueTask()` from a worker (ThreadManager is a TD COMP). For worker logging use the Thread Manager's `SafeLogger`, not `debug()`/`print()`.
- Docs: https://docs.derivative.ca/Web_Client_DAT , https://docs.derivative.ca/JSON_DAT , https://docs.derivative.ca/Thread_Manager

### Large payloads
A large response is delivered to `onResponse` on the MAIN thread, so a heavy parse there still stalls the frame. For big/expensive parsing: `onResponse` validates status and copies the raw string/bytes only, then hands it to a Thread Manager worker (zero TD access) that parses and returns plain data for a main-thread drain to write. Do not "fix" it with `run()` - that defers the parse, it does not shrink it.

### Not for fetching
Engine COMP / TouchEngine runs a `.tox` in a separate PROCESS to parallelize heavy COOKING (sims, geometry, render) - it exchanges only TOP/CHOP/DAT across the boundary and does no network I/O, so it is the wrong tool for a fetch. Stock `asyncio` blocks TD's frame loop; if an advanced worker hosts an asyncio loop it still obeys the zero-TD-access + queue-handoff rules.

## Explicit Type Conversion

TD parameters auto-cast in expression contexts but remain TD objects. Convert with `int()`, `float()`, `str()` for standard Python functions. Use `repr()` to reveal actual type.

Base directory for this skill: /Users/davispolito/dev/touchdesigner/touchpy/touchpy/.claude/skills/td-api-reference
Relative paths in this skill (e.g., scripts/, reference/) are relative to this base directory.
Note: file list is sampled.

<skill_files>

</skill_files>
</skill_content>
```

---

## Assistant (Build · GPT-5.5 Fast · 11.5s)

_Thinking:_



Read `~/Vault/dev/` and the relevant project docs:

- `~/Vault/dev/CLAUDE.md`
- `~/Vault/dev/touchpy.md`
- Checked for `.claude/rules/project.md`: none found
- Loaded required TD project skills: `td-interactive-pro`, `debug-operator`, `td-api-reference`
- Confirmed `graphify-out/` exists in the touchpy repo

Key current context: touchpy lives at `/Users/davispolito/dev/touchdesigner/touchpy/touchpy/`, active branch should be `dev-macos`, task tracker is local `tasks/`, and this is the macOS/Apple Silicon TouchPy port replacing Windows/CUDA/Vulkan paths with TouchEngine-macOS/Metal/CPU fallback.

---

## User

what is the status of this project

---

## Assistant (Build · GPT-5.5 Fast · 27.3s)

_Thinking:_

**Verifying project status**

I need to check the project status since the user is asking for it. I should look at the current repo, tasks, and possibly the task tracker to gather accurate information. It's not just about relying on previous briefings; I should really verify the current state. Running commands like `git status` and checking the tasks directory will help. I can also explore using the bash commands to ensure everything is up to date before updating the user.

_Thinking:_

**Determining the right tools**

I'm considering my options for checking the project status. While I could use `ls`, it's not ideal for searching files. Reading the directory seems like a better approach. I’m also wondering if I should use `cmake`, but that might be unnecessary unless the "status" includes build information. Inspecting tasks is definitely a step I'll take to ensure I’m fully up to date on what needs to be done.

I’ll verify the repo state and local task tracker from disk so the status reflects the current checkout, not just the vault briefing.

**Tool: bash**

**Input:**
```json
{
  "command": "git status --short --branch",
  "workdir": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy"
}
```

**Output:**
```
## dev-macos...origin/dev-macos
 m external/TouchEngine-macOS

```

**Tool: bash**

**Input:**
```json
{
  "command": "git log --oneline -8",
  "workdir": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy"
}
```

**Output:**
```
8d89625 touchpy: fix test-template td-tools extraPaths for new touchdesigner/ wrapper-folder layout
ea1c87d chore: add /test-with-touchpy Claude command
aa99bbc Add project context and expanded TOP tests
a213318 Update task tracker
c425162 Add macOS Metal TOP bindings
acf1053 Add TOP readback runtime tests
1fdb9db Guard Comp::stop() against double-suspend; add instanceResumed_ flag
8240f16 Update testing-and-runtime docs for macOS; add run instructions and test results

```

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks"
}
```

**Output:**
```
<path>/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks</path>
<type>directory</type>
<entries>
0001-source-level-macos-guards.md
0002-spdlog-fmtlib-bump.md
0003-spdlog-fmt-external.md
0004-conftest-callback-signature.md
0005-stop-double-suspend.md
0006-float-top-numpy-dtype.md
0007-output-top-test-tox.md
0008-init-docs.md
README.md
TEMPLATE.md

(10 entries)
</entries>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy/docs/NOTES.md",
  "limit": 200
}
```

**Output:**
```
<path>/Users/davispolito/dev/touchdesigner/touchpy/touchpy/docs/NOTES.md</path>
<type>file</type>
<content>
1: # TouchPy Implementation Notes
2: 
3: Repo-local implementation notes for `touchpy`. Treat this folder like the project's git wiki: durable explanations of runtime behavior, generated files, callback routing, integration boundaries, and compatibility decisions that should travel with the code.
4: 
5: > Note: `docs/source/` is a Sphinx API docs build (separate concern). The files below are implementation notes only.
6: 
7: Development tasks live in [`../tasks/`](../tasks/) and are canonical there.
8: 
9: ## Known Issues
10: 
11: ### spdlog bundled fmtlib consteval failure (AppleClang 21 / C++20)
12: 
13: **Symptom:** Build fails in `spdlog-src/src/bundled_fmtlib_format.cpp` with:
14: ```
15: error: call to consteval function '...' is not a constant expression
16: ```
17: 
18: **Root cause:** `CMAKE_CXX_STANDARD 20` set globally propagates to FetchContent
19: targets, including spdlog's bundled fmtlib. Spdlog v1.15.0 bundles a fmtlib
20: version that uses `FMT_STRING` macros generating `consteval` calls that
21: AppleClang 21 (Xcode 26) rejects under its stricter consteval evaluation rules.
22: 
23: **Fix:** Set C++20 per-target on `touchpy` only (after `nanobind_add_module`),
24: keeping the global standard at 17 so spdlog compiles unaffected:
25: ```cmake
26: if(TOUCHPY_MACOS)
27:     set_target_properties(touchpy PROPERTIES CXX_STANDARD 20 CXX_STANDARD_REQUIRED ON)
28: endif()
29: ```
30: 
31: **Alternatives not taken:**
32: - Bump spdlog to a newer tag with fixed fmtlib — deferred, requires validation
33: - `SPDLOG_FMT_EXTERNAL` — adds a system fmtlib dependency, undesirable for a distributable wheel
34: 
35: **Why per-target C++20 doesn't work either:** `logging.h` includes `<spdlog/spdlog.h>`
36: directly. Every translation unit in the `touchpy` target that includes `logging.h`
37: pulls in the fmtlib headers. Setting `CXX_STANDARD 20` on the target compiles all
38: those TUs at C++20, so the consteval issue surfaces in the consumer files
39: (`choplink.cpp`, `comp.cpp`, etc.), not just `spdlog-src/`. The fix must happen
40: at the spdlog/fmtlib level (tasks 0002, 0003).
41: 
42: ### spdlog dependency surface (audited 2026-06-16)
43: 
44: All spdlog usage is funnelled through `source/logging.h` — the only file that
45: includes spdlog headers directly. Every other file includes `logging.h`.
46: 
47: Files that `#include "logging.h"` and their call patterns:
48: 
49: | File | Calls | macOS port status |
50: |------|-------|-------------------|
51: | `logging.cpp` | `initLogging()`, `setLogLevel()`, sink setup | compiles |
52: | `comp.cpp` | `info/warn/error` — ~40 call sites | guarded (task 0001) |
53: | `chopchannels.cpp` | include only, no direct calls | compiles |
54: | `choplink.cpp` | `error` — 1 site | compiles |
55: | `datlink.cpp` | `error` — 2 sites | compiles |
56: | `dattable.cpp` | include only | compiles |
57: | `toplink.cpp` | `error` — 3 sites | excluded (cuda) |
58: | `texture.cpp` | `error` — 1 site | excluded (cuda) |
59: | `renderer.cpp` | `error/debug` — 6 sites | excluded (vulkan) |
60: | `deviceinfo.h` | `debug` — 1 site | excluded (cuda) |
61: | `pybindings/touchpy.cpp` | exposes `LogLevel` enum + `init_logging`/`set_log_level` to Python | compiles |
62: | `vri/vri.cpp` | `debug/error` — heavily used | excluded (vulkan) |
63: | `vri/vri_macros.h` | `error` in `VK_CHECK` macro | excluded (vulkan) |
64: 
65: The macOS-compilable files that use logging (`choplink.cpp`, `datlink.cpp`,
66: `dattable.cpp`, `chopchannels.cpp`, `pybindings/touchpy.cpp`) are all low-call-site
67: consumers. The heavy logging is in `comp.cpp` and `vri/` — both blocked by
68: platform guards anyway.
69: 
70: ### teutils.h — TEVulkan.h hidden dependency (fixed 2026-06-16)
71: 
72: `teutils.h` unconditionally included `<TouchEngine/TEVulkan.h>`, which pulls in
73: `vulkan/vulkan.h`. That header is not available on macOS (no Vulkan SDK). Fixed
74: with `#ifndef TOUCHPY_MACOS` guard around the include. This was not in the original
75: task 0001 plan — discovered during the build iteration.
76: 
77: ### choplinkpy.cpp — variable shadowing in `fromNumpyToChopLink` (fixed 2026-06-24)
78: 
79: `std::vector<const float*> channels` was declared, then `ChopChannelsView channels(...)`
80: was constructed in the same scope using `std::move(channels)`. The compiler resolved
81: `channels` in the initializer as the `ChopChannelsView` being declared rather than the
82: vector, causing a type mismatch. Fixed by renaming the vector to `channelPtrs`.
83: 
84: ### comppy.cpp — CUDA/TOP bindings not guarded (fixed 2026-06-24)
85: 
86: `cuda_device`, `in_tops`, `out_tops`, and `cuda_stream` nanobind bindings referenced
87: `Comp` members that are guarded away on macOS (`cudaDeviceIndex`, `inputTopLinks`,
88: `outputTopLinks`, `cudaStream`). Fixed with `#ifndef TOUCHPY_MACOS` guards around
89: those four `.def`/`.def_prop_ro` calls in `initCompBindings`.
90: 
91: ### utils/utils.h — missing iostream/iomanip (fixed 2026-06-24)
92: 
93: `printTypeInfo<T>()` uses `std::cout`, `std::setw`, `std::endl` but the header only
94: included `<cstdio>`. On Windows these were transitively available through other
95: Windows SDK headers. Fixed by adding explicit `<iostream>`, `<iomanip>`, and
96: `<cstring>` includes.
97: 
98: ### TouchEngine.framework — unsigned library rejected at dlopen (runtime, 2026-06-24)
99: 
100: The framework bundled in `external/TouchEngine-macOS/` carries no valid code signature.
101: macOS rejects it at `dlopen` time with "not valid for use in process: Trying to load
102: an unsigned library".
103: 
104: **Development workaround:** ad-hoc codesign after each `git submodule update`:
105: 
106: ```bash
107: codesign --force --deep --sign - external/TouchEngine-macOS/TouchEngine.framework
108: ```
109: 
110: This is not committed — it only affects the local working tree. Re-run whenever the
111: submodule is refreshed. Distribution builds will require a proper Apple Developer
112: signing identity.
113: 
114: ## Notes
115: 
116: - [Architecture overview](architecture-overview.md) — build system, C++/CUDA/Vulkan/Python layer structure, macOS port strategy
117: - [API contract](api-contract.md) — public Python API surface, type contracts, link types (TOP/CHOP/DAT/Par)
118: - [Testing and runtime](testing-and-runtime.md) — gtest suite, Python test harness, TouchEngine runtime requirements
119: - [Reference material](reference-material.md) — upstream repos, SDK links, TouchEngine-macOS framework, related prior art

(End of file - total 119 lines)
</content>
```

---

## Assistant (Build · GPT-5.5 Fast · 9.9s)

_Thinking:_

**Reading task files**

I'm trying to figure out how to read the task files. I think checking the README might be a good starting point. Should I use glob to search for the appropriate files? It could be efficient to read both the README and the task files together. I'll see if that helps me get a clearer picture of everything I need to do. Let's give it a shot!

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/README.md",
  "limit": 300
}
```

**Output:**
```
<path>/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/README.md</path>
<type>file</type>
<content>
1: # Tasks
2: 
3: Local task tracker for `touchpy`. One file per task. GitHub Issues/Projects may mirror task state but are not canonical.
4: 
5: | ID | Title | Status |
6: |----|-------|--------|
7: | [0001](0001-source-level-macos-guards.md) | Source-level TOUCHPY_MACOS guards for CHOP/DAT/Par compile path | done |
8: | [0002](0002-spdlog-fmtlib-bump.md) | Bump spdlog to fix bundled fmtlib consteval on AppleClang 21 | todo |
9: | [0003](0003-spdlog-fmt-external.md) | Evaluate SPDLOG_FMT_EXTERNAL to decouple spdlog from bundled fmtlib | todo |
10: | [0004](0004-conftest-callback-signature.md) | Fix conftest.py on_frame callback signature regression from PR #79 | done |
11: | [0005](0005-stop-double-suspend.md) | Fix stop() double-suspend crash | done |
12: | [0006](0006-float-top-numpy-dtype.md) | Return correct numpy dtype for float TOPs | todo |
13: | [0007](0007-output-top-test-tox.md) | Add output-TOP test tox for readback testing | done |
14: | [0008](0008-init-docs.md) | Run init-docs scaffold | todo |

(End of file - total 14 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0001-source-level-macos-guards.md",
  "limit": 220
}
```

**Output:**
```
<path>/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0001-source-level-macos-guards.md</path>
<type>file</type>
<content>
1: ---
2: id: 0001
3: title: Source-level TOUCHPY_MACOS guards for CHOP/DAT/Par compile path
4: status: done
5: priority: high
6: area: macos-port
7: created: 2026-06-16
8: mirror:
9: ---
10: 
11: ## Goal
12: 
13: Make the CHOP/DAT/Par Python API compile on macOS without CUDA or Vulkan headers.
14: CMakeLists.txt already excludes the GPU translation units (vri/, renderer, texture,
15: cudamemory, toplink, copykernels). The remaining blocker is that `comp.h` transitively
16: pulls in those excluded headers through unconditional #includes.
17: 
18: ## Acceptance criteria
19: 
20: - [x] `comp.h` compiles on macOS without CUDA or Vulkan headers in the include path
21: - [x] `comp.cpp` compiles on macOS (GPU blocks guarded)
22: - [x] `cmake --build build` succeeds on Apple Silicon with no errors (verified 2026-06-24)
23: - [x] `import touchpy; comp = tp.Comp()` works in Python (CHOP/DAT/Par path only, verified 2026-06-24)
24: - [x] TOPs deliberately not in scope — `initTopLinkBindings()` stubbed out on macOS
25: 
26: ## Implementation (2026-06-16)
27: 
28: Guard macro: `#ifndef TOUCHPY_MACOS` / `#endif`. The `TOUCHPY_MACOS` compile definition
29: is set by CMakeLists.txt on Darwin. Do not use `#ifdef __APPLE__` directly — use
30: `TOUCHPY_MACOS` so it is explicit and CMake-controlled.
31: 
32: ### source/comp.h
33: 
34: - Guarded `renderer.h`, `texture.h`, `common/cuda_helpers.h`, `toplink.h` includes
35: - Guarded `inputTopLinks()` / `outputTopLinks()` accessors
36: - Guarded `LARGE_INTEGER startTime` / `LARGE_INTEGER performanceCounterFrequency` in `Time` struct
37: - Guarded `cudaStream_t cudaStream() const` accessor
38: - Guarded `uint8_t cudaDeviceIndex() const` accessor
39: - Guarded private GPU members (`renderer_`, all `VkXxx` handles, `cudaStream_`, `cudaDevice_`)
40: - Guarded `inTopLinks_` / `outTopLinks_` unique_ptr members
41: - Guarded `createRenderer()`, `cudaInit()`, `setCudaDevice()` private method declarations
42: 
43: ### source/comp.cpp
44: 
45: - `initComp()`: guarded `createRenderer()` and `cudaInit()` calls
46: - Destructor: guarded `cudaStreamDestroy` and `vkDestroyFence`
47: - `createRenderer()` and `cudaInit()` / `setCudaDevice()` entire bodies wrapped in `#ifndef TOUCHPY_MACOS`
48: - `initInstance()`: guarded `TEInstanceAssociateGraphicsContext` block
49: - `load(filePath, fps)`: replaced `if (!renderer_) initComp()` with platform conditional:
50:   ```cpp
51:   #ifndef TOUCHPY_MACOS
52:       if (!renderer_) initComp();
53:   #else
54:       if (!instance_) initComp();   // renderer_ doesn't exist; instance_ serves as init sentinel
55:   #endif
56:   ```
57: - `unload()`: guarded `cudaStreamSynchronize`
58: - `asyncUpdate()`: guarded `cudaSetDevice(cudaDevice_)`
59: - `applyOutputTextureChange()`: guarded entire body (uses `outTopLinks_`)
60: - `applyLayoutChange()`: guarded `inTopLinks_`/`outTopLinks_` construction; guarded `TELinkTypeTexture` block
61: 
62: ### source/teutils.h  (extra file not in original plan)
63: 
64: - Guarded `<TouchEngine/TEVulkan.h>` include — unconditionally included Vulkan SDK headers
65:   not available on macOS
66: 
67: ### source/pybindings/touchpy.cpp
68: 
69: - Guarded `extern void initTopLinkBindings(nb::module_& m)` declaration
70: - Guarded `initTopLinkBindings(m)` call in `NB_MODULE`
71: 
72: ### source/pybindings/toplinkpy.cpp
73: 
74: - Wrapped entire CUDA/Vulkan content in `#ifndef TOUCHPY_MACOS`
75: - Added macOS no-op stub:
76:   ```cpp
77:   #else
78:   #include <nanobind/nanobind.h>
79:   namespace nb = nanobind;
80:   void initTopLinkBindings(nb::module_& m) {}
81:   #endif
82:   ```
83: 
84: ### source/utils/utils.h
85: 
86: - Replaced C++20 template lambda in `forEach` with C++17-compatible helper:
87:   ```cpp
88:   namespace detail {
89:   template <class Tuple, class F, std::size_t... I>
90:   constexpr F forEach_impl(Tuple&&, F&&, std::index_sequence<I...>);
91:   }
92:   ```
93: 
94: ## Notes
95: 
96: ### Why `!instance_` not `!renderer_` in load()
97: 
98: On macOS, `renderer_` (a `std::shared_ptr<Renderer>`) is guarded away entirely.
99: `instance_` is a `TouchObject<TEInstance>` which has `operator T*() const` — so
100: `!instance_` evaluates to `true` when the underlying pointer is null, exactly like
101: `!renderer_` did on Windows. This is the correct lazy-init sentinel.
102: 
103: ### Build command (macOS, 2026-06-16)
104: 
105: ```bash
106: # GoogleTest 1.15.2 doesn't support AppleClang 21 — skip it with -DSKBUILD=ON
107: cmake -B build -S . -DCMAKE_BUILD_TYPE=Release \
108:     -DPython_EXECUTABLE=.venv/bin/python \
109:     -DSKBUILD=ON
110: 
111: cmake --build build
112: ```
113: 
114: ## Build verification (2026-06-24)
115: 
116: Three additional fixes were needed during the first full build pass:
117: 
118: ### `source/pybindings/choplinkpy.cpp` — variable name shadowing
119: 
120: `fromNumpyToChopLink` declared `std::vector<const float*> channels`, then tried to
121: construct `ChopChannelsView channels(std::move(channels), ...)` in the same scope.
122: The compiler resolved `channels` in the initializer as the `ChopChannelsView` being
123: declared, not the vector, causing a type mismatch error. Fixed by renaming the vector
124: to `channelPtrs`.
125: 
126: ### `source/pybindings/comppy.cpp` — CUDA/TOP bindings not guarded
127: 
128: `cuda_device`, `in_tops`, `out_tops`, and `cuda_stream` bindings referenced
129: `Comp::cudaDeviceIndex`, `Comp::inputTopLinks`, `Comp::outputTopLinks`, and
130: `Comp::cudaStream` — all of which are guarded away in `comp.h` on macOS. Fixed with
131: `#ifndef TOUCHPY_MACOS` guards around those four `.def`/`.def_prop_ro` calls.
132: 
133: ### `source/utils/utils.h` — missing `<iostream>` and `<iomanip>`
134: 
135: `printTypeInfo<T>()` uses `std::cout`, `std::setw`, `std::endl` but the header did
136: not include `<iostream>` or `<iomanip>`. On Windows these were pulled in transitively
137: through other headers. Fixed by adding explicit includes (plus `<cstring>` for
138: `std::memcpy` used in `safeMemCpy`).
139: 
140: ### TouchEngine.framework code signature
141: 
142: The framework in `external/TouchEngine-macOS/` has no valid code signature, so macOS
143: rejects it at `dlopen` time ("not valid for use in process: Trying to load an unsigned
144: library"). Fixed at development time with an ad-hoc signature:
145: 
146: ```bash
147: codesign --force --deep --sign - external/TouchEngine-macOS/TouchEngine.framework
148: ```
149: 
150: This must be re-run after `git submodule update` refreshes the framework. It is a
151: local-only workaround — the signature is not committed. Distribution will require a
152: proper Apple Developer signing identity.
153: 
154: ### Verified output
155: 
156: ```
157: import ok
158: Comp() ok: <touchpy.Comp object at 0x71b1a9000>
159: loaded: False
160: [info]: Comp destroyed
161: ```
162: 
163: ## Blocked
164: 
165: Not blocked.

(End of file - total 165 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0002-spdlog-fmtlib-bump.md",
  "limit": 220
}
```

**Output:**
```
<path>/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0002-spdlog-fmtlib-bump.md</path>
<type>file</type>
<content>
1: ---
2: id: 0002
3: title: Bump spdlog to fix bundled fmtlib consteval on AppleClang 21
4: status: todo
5: priority: low
6: area: macos-port
7: created: 2026-06-16
8: mirror:
9: ---
10: 
11: ## Goal
12: 
13: Replace the `FetchContent` pin of spdlog v1.15.0 with a newer tag whose bundled
14: fmtlib compiles cleanly under C++20 on AppleClang 21 (Xcode 26). Currently the
15: global `CMAKE_CXX_STANDARD` is kept at 17 to avoid the issue (C++20 is set
16: per-target on `touchpy` only). A spdlog bump would unblock setting C++20 globally
17: if that becomes desirable.
18: 
19: ## Acceptance criteria
20: 
21: - [ ] spdlog builds without errors under `-std=c++20` on AppleClang 21
22: - [ ] `cmake -B build && cmake --build build` succeeds with global `CMAKE_CXX_STANDARD 20`
23: - [ ] No regression in logging behavior on macOS or Windows
24: 
25: ## Notes
26: 
27: Root cause documented in `docs/NOTES.md` under "Known Issues".
28: 
29: Current workaround: per-target `CXX_STANDARD 20` on `touchpy`, global stays at 17.
30: Check spdlog releases after v1.15.0 or the upstream fmtlib changelog for the fix.

(End of file - total 30 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0003-spdlog-fmt-external.md",
  "limit": 220
}
```

**Output:**
```
<path>/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0003-spdlog-fmt-external.md</path>
<type>file</type>
<content>
1: ---
2: id: 0003
3: title: Evaluate SPDLOG_FMT_EXTERNAL to decouple spdlog from bundled fmtlib
4: status: todo
5: priority: low
6: area: macos-port
7: created: 2026-06-16
8: mirror:
9: ---
10: 
11: ## Goal
12: 
13: Evaluate switching spdlog to use the system or separately-managed fmtlib via
14: `SPDLOG_FMT_EXTERNAL=ON` instead of its bundled copy. This would eliminate the
15: consteval compatibility issue entirely regardless of spdlog version, at the cost
16: of adding a fmtlib dependency to the build environment.
17: 
18: ## Acceptance criteria
19: 
20: - [ ] Assess whether fmtlib is available or easily fetchable on both macOS and Windows build environments
21: - [ ] Confirm wheel distribution is not complicated by an external fmtlib (static link or bundle strategy)
22: - [ ] If viable: add fmtlib FetchContent and set `SPDLOG_FMT_EXTERNAL` in CMakeLists.txt
23: - [ ] Build and test on macOS; confirm no regression on Windows
24: 
25: ## Notes
26: 
27: Root cause documented in `docs/NOTES.md` under "Known Issues".
28: 
29: The main risk is wheel distribution — if fmtlib must be statically linked or
30: bundled into the wheel, it adds complexity. If it can be fetched at build time
31: (same pattern as spdlog), the overhead is low.
32: 
33: Not the preferred path vs. a spdlog version bump (task 0002) unless 0002 proves
34: the newer spdlog still has the issue.

(End of file - total 34 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0004-conftest-callback-signature.md",
  "limit": 220
}
```

**Output:**
```
<path>/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0004-conftest-callback-signature.md</path>
<type>file</type>
<content>
1: ---
2: id: 0004
3: title: Fix conftest.py on_frame callback signature regression from PR #79
4: status: done
5: priority: medium
6: area: testing
7: created: 2026-06-24
8: mirror:
9: ---
10: 
11: ## Goal
12: 
13: Fix `test/pytest/conftest.py` so `on_frame` matches the current callback API
14: and `test_pars.py` can actually run.
15: 
16: ## Root cause
17: 
18: `conftest.py` was added in upstream PR #57 (May 2024) when the frame callback
19: was called as `callback(comp, data)` — two args, comp first.
20: 
21: Upstream PR #79 (Aug 2024, "Time and callback updates") refactored all callback
22: bindings. `setOnFrameCallback` now calls `doCallback(self, callback, data)`,
23: which invokes `pythonCallback(dataPyObj)` — one arg, the data object only. The
24: comp reference was dropped from the Python-facing call.
25: 
26: `conftest.py` was never updated. `on_frame(comp, notused)` expects two args;
27: the binding delivers one. The suite has been silently broken since PR #79 on
28: all platforms.
29: 
30: ## Fix (2026-06-24)
31: 
32: - `on_frame(comp, notused)` → `on_frame(comp)` — drop unused second param
33: - `comp.set_on_frame_callback(on_frame, fluffdata)` → `comp.set_on_frame_callback(on_frame, comp)` — pass comp as data so the callback can call comp.stop() / comp.start_next_frame()
34: - `fluffdata = {}` removed — never used
35: 
36: ## Acceptance criteria
37: 
38: - [x] `test/pytest/test_pars.py` fixture setup no longer raises TypeError
39: - [x] All 12 `test_pars` tests reach the assertion stage
40: 
41: ## Notes
42: 
43: Candidate for upstream PR against IntentDev/touchpy. The fix is two lines and
44: unambiguously correct — the old signature cannot work with the current binding.

(End of file - total 44 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0005-stop-double-suspend.md",
  "limit": 220
}
```

**Output:**
```
<path>/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0005-stop-double-suspend.md</path>
<type>file</type>
<content>
1: ---
2: id: 0005
3: title: Fix stop() double-suspend crash
4: status: done
5: priority: high
6: area: comp
7: created: 2026-06-24
8: mirror:
9: ---
10: 
11: ## Goal
12: 
13: `stop()` raises "Failed to suspend TEInstance: API client usage error" when called on an instance that was never started or is already stopped. Guard `TEInstanceSuspend` with a state check so calling `stop()` is safe in any state.
14: 
15: ## Acceptance criteria
16: 
17: - [x] `test_stop` passes
18: - [x] Calling `comp.stop()` twice does not throw
19: - [x] Calling `comp.stop()` before `comp.start()` does not throw
20: 
21: ## Notes
22: 
23: Pre-existing bug, affects macOS and Windows. The fix is a state guard in `Comp::stop()` — only call `TEInstanceSuspend` when the instance is actually running. The shared state `ssLoaded_` / `ssReady_` flags or a dedicated `ssStarted_` bool can gate the call.

(End of file - total 23 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0006-float-top-numpy-dtype.md",
  "limit": 220
}
```

**Output:**
```
<path>/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0006-float-top-numpy-dtype.md</path>
<type>file</type>
<content>
1: ---
2: id: 0006
3: title: Return correct numpy dtype for float TOPs
4: status: todo
5: priority: medium
6: area: metaltoplink
7: created: 2026-06-24
8: mirror:
9: ---
10: 
11: ## Goal
12: 
13: `OutTop.numpy()` always returns `uint8 [H, W, 4]` regardless of pixel format. `RGBA16Float` and `RGBA32Float` textures should return `float16` or `float32` arrays respectively so callers don't have to reinterpret raw bytes manually.
14: 
15: ## Acceptance criteria
16: 
17: - [ ] `numpy()` on a `BGRA8Unorm`/`RGBA8Unorm` texture returns `uint8 [H, W, 4]`
18: - [ ] `numpy()` on an `RGBA16Float` texture returns `float16 [H, W, 4]`
19: - [ ] `numpy()` on an `RGBA32Float` texture returns `float32 [H, W, 4]`
20: - [ ] `test_out_top_readback` covers at least one float format
21: 
22: ## Notes
23: 
24: Change is in the `numpy()` lambda in `source/pybindings/toplinkpy.cpp` (`#else` / macOS branch). Dispatch on `self.pixelFormat()` to select the ndarray dtype. `readback()` already returns the correct raw bytes — just change the nanobind ndarray wrapper type. Use `nb::ndarray<nb::numpy, uint16_t, ...>` for float16 (reinterpret) or `nb::ndarray<nb::numpy, float, ...>` for float32.

(End of file - total 24 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0007-output-top-test-tox.md",
  "limit": 220
}
```

**Output:**
```
<path>/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0007-output-top-test-tox.md</path>
<type>file</type>
<content>
1: ---
2: id: 0007
3: title: Add output-TOP test tox for readback testing
4: status: done
5: priority: medium
6: area: testing
7: created: 2026-06-24
8: mirror:
9: ---
10: 
11: ## Goal
12: 
13: `test_tops.py::test_out_top_readback` is permanently skipped because no `.tox` in `test/tox/` exports texture links. A minimal tox with at least one output TOP is needed so the readback path runs in CI without requiring `TOP_TOX` env var.
14: 
15: ## Acceptance criteria
16: 
17: - [x] `test/tox/test_top.tox` committed — minimal Noise or Constant TOP wired to an output select
18: - [x] TOP readback tests run without setting `TOP_TOX`
19: - [x] Test asserts correct shape, dtype, and non-zero pixel values
20: 
21: ## Notes
22: 
23: Create the tox in TouchDesigner. A single Noise TOP → Out TOP is sufficient. The test already handles the readback assertion logic — just needs the tox path wired in as the default.
24: 
25: ## Progress
26: 
27: ### 2026-06-28 13:22
28: 
29: - `test/pytest/test_tops.py` now defaults `test_out_top_readback` to `test/tox/test_top.tox` while preserving the `TOP_TOX` override.
30: - The readback test now skips with an explicit missing-fixture reason when `test_top.tox` is absent.
31: - Added a non-zero pixel assertion for the readback array.
32: - Still open: create/export `test/tox/test_top.tox` from TouchDesigner and run the real TouchEngine readback test.
33: 
34: ### 2026-06-28 14:30
35: 
36: - Added a limited `test-template/` TouchDesigner harness following the `td-tools` pattern.
37: - The harness is intended for authoring/exporting pytest `.tox` fixtures, especially `test/tox/test_top.tox`.
38: - Still open: open the harness in TouchDesigner, build the Constant TOP -> Out TOP fixture, export `test_top.tox`, and run the real readback test.
39: 
40: ### 2026-06-28 14:58
41: 
42: - Used Envoy on port 9875 to create `/project1/test_top_fixture`.
43: - Fixture network is `constant1` TOP -> `out1` TOP.
44: - `constant1` is configured as a 64x64 custom-resolution TOP with non-black RGBA color.
45: - Verified live TD network has no errors or warnings.
46: - Captured `/project1/test_top_fixture/out1` successfully as a 64x64 PNG through Envoy.
47: - Externalized the COMP with Embody as `test-template/project1/test_top_fixture.tox`.
48: - Saved the pytest fixture copy to `test/tox/test_top.tox`.
49: - Added `numpy` to the dev optional dependency because `test_out_top_readback` imports numpy.
50: - Still open: `test_out_top_readback` reaches `tp.Comp(test_top.tox)` but fails in this shell because TouchEngine cannot configure the instance / Metal default device (`MTLCreateSystemDefaultDevice returned nil`, then `TouchEngine could not be found to open the file`; explicit `td_path` gets farther but hangs after TouchEngine reports the process crashed or stopped responding).
51: 
52: ### 2026-06-28 16:08
53: 
54: - Investigated `MTLCreateSystemDefaultDevice returned nil`; confirmed the Mac has an Apple M5 Pro Metal device and the nil device only occurs under the command sandbox. Unsandboxed TouchEngine runs associate the Metal context successfully.
55: - Split the previous broad TOP readback test into smaller pytest checks for fixture link discovery, frame-start resume precondition, resumed texture production, and numpy readback.
56: - Updated the readback path to use `CompFlags.INTERNAL_TIME`, drain the initial layout, call `start()`, then assert `start_next_frame()` succeeds before polling.
57: - Verified `test/pytest/test_tops.py` passes without `TOP_TOX`: `8 passed in 39.56s` with `DYLD_FRAMEWORK_PATH` and `PYTHONPATH` set for the local build.
58: 
59: ### 2026-06-28 16:20
60: 
61: - Added `scripts/test-macos-runtime.sh` as the repeatable local macOS pytest runner.
62: - The script sets `DYLD_FRAMEWORK_PATH`, `PYTHONPATH`, validates the local Python/build/TouchEngine paths, and passes arguments through to pytest.
63: - Documented that Metal/TouchEngine tests must run from a normal local shell or unsandboxed automation context because sandboxed execution can make `MTLCreateSystemDefaultDevice()` return nil.
64: - Verified the runner with `scripts/test-macos-runtime.sh test/pytest/test_tops.py -q -rs`: `8 passed in 39.26s`.
65: 
66: ### 2026-06-29
67: 
68: - Committed the TOP readback fixture, runtime runner, and split pytest coverage in `acf1053`.

(End of file - total 68 lines)
</content>
```

**Tool: read**

**Input:**
```json
{
  "filePath": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0008-init-docs.md",
  "limit": 220
}
```

**Output:**
```
<path>/Users/davispolito/dev/touchdesigner/touchpy/touchpy/tasks/0008-init-docs.md</path>
<type>file</type>
<content>
1: ---
2: id: 0008
3: title: Run init-docs scaffold
4: status: todo
5: priority: low
6: area: docs
7: created: 2026-06-24
8: mirror:
9: ---
10: 
11: ## Goal
12: 
13: Complete the `/init-docs` scaffold that was started but not finished. `docs/` and `tasks/` already exist; what's missing is the implementation-notes index and the roadmap stub.
14: 
15: ## Acceptance criteria
16: 
17: - [ ] Replace `docs/README.md` (currently upstream Sphinx build instructions) with implementation-notes index linking all existing doc files
18: - [ ] Create `docs/roadmap.md` stub
19: - [ ] Update vault briefing `~/Vault/dev/touchpy.md` with `## Docs` section (requires Davis confirmation before writing)
20: 
21: ## Notes
22: 
23: Run `/init-docs` in the touchpy project. Confirm the `docs/README.md` replacement before writing — it currently contains the upstream Sphinx instructions which should be preserved somewhere or discarded.

(End of file - total 23 lines)
</content>
```

---

## Assistant (Build · GPT-5.5 Fast · 9.7s)

_Thinking:_

**Inspecting submodules**

I’m considering whether I need to read the documentation for testing. It might be a good idea to inspect the external submodule I modified, specifically “m external/TouchEngine-macOS.” I wonder if the lowercase "m" indicates that the submodule is dirty. I think I should run the command to check the git submodule status. Perhaps checking the status in porcelain would give me clearer insights.

The task tracker is current enough to summarize: 4 tasks done, 4 todo. I’m checking the one dirty submodule marker so I can say whether the checkout is clean or not.

**Tool: bash**

**Input:**
```json
{
  "command": "git submodule status --recursive",
  "workdir": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy"
}
```

**Output:**
```
 c3ceb1ab540db44dbfed4fb1bdb7bbfbb0305962 external/TouchEngine-macOS (heads/main)

```

**Tool: bash**

**Input:**
```json
{
  "command": "git status --short external/TouchEngine-macOS",
  "workdir": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy"
}
```

**Output:**
```
 m external/TouchEngine-macOS

```

**Tool: bash**

**Input:**
```json
{
  "command": "git -C external/TouchEngine-macOS status --short --branch",
  "workdir": "/Users/davispolito/dev/touchdesigner/touchpy/touchpy"
}
```

**Output:**
```
## main...origin/main
 M TouchEngine.framework/Versions/A/Frameworks/IPM.framework/Versions/A/IPM
 M TouchEngine.framework/Versions/A/Frameworks/IPM.framework/Versions/A/_CodeSignature/CodeResources
 M TouchEngine.framework/Versions/A/Frameworks/IPM.framework/Versions/A/ca.derivative.IPMAgent
 M TouchEngine.framework/Versions/A/Frameworks/libTPC.dylib
 M TouchEngine.framework/Versions/A/Frameworks/libTouchEngine.dylib
 M TouchEngine.framework/Versions/A/TouchEngine
?? TouchEngine.framework/Versions/A/_CodeSignature/

```

---

## Assistant (Build · GPT-5.5 Fast · 11.8s)

_Thinking:_

**Evaluating source necessity**

I’m wondering if I need a source section since there's no web research involved in this context. But I think I should mention the sources I read, even if just briefly. For the final output, I might need to be careful with verbosity; aiming for three layers of detail might be too much. It's important to strike that balance, so the user gets what they need without being overwhelmed. I'll figure this out!

**Project Status**
`touchpy` is on `dev-macos`, tracking `origin/dev-macos`, with no ahead/behind shown.

Current state:
- macOS/Apple Silicon port is functional for CHOP/DAT/Par paths.
- Source-level macOS guards are done.
- `import touchpy; tp.Comp()` was verified previously.
- TOP/Metal work has progressed: recent commits include macOS Metal TOP bindings, TOP readback runtime tests, and test fixture support.
- Runtime TOP tests were documented as passing locally via `scripts/test-macos-runtime.sh`: `8 passed`.

Open tasks from `tasks/README.md`:
- `0002` todo, low: bump `spdlog` to fix bundled fmtlib/AppleClang C++20 issue.
- `0003` todo, low: evaluate `SPDLOG_FMT_EXTERNAL`.
- `0006` todo, medium: return correct numpy dtype for float TOPs.
- `0008` todo, low: finish init-docs scaffold.

Dirty state:
- Root repo only shows modified submodule: `external/TouchEngine-macOS`.
- Inside that submodule, `TouchEngine.framework` binaries/signature files are modified plus an untracked `_CodeSignature/` directory.
- That matches the documented local ad-hoc codesign workaround for macOS loading unsigned TouchEngine frameworks.

Bottom line: CPU-path macOS port is past the initial compile/import milestone, TOP/Metal readback work has landed, and the main remaining engineering task is `0006` float TOP numpy dtype correctness.

---

