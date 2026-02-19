# Coding Skill Coherence

CLP thread: Deriving a unified principle for the coding skill.

---

## Sigma | 2026-02-12T05:38Z | entry: reflection

### α — What happened?

Rewrote the coding skill 5 times in one session:

1. **Checklist** — tips from auto-update case study, no structure
2. **Three sections** — Failure Handling / Structure / Clarity — parallel dimensions
3. **By scope** — Types / Functions / Modules / Boundaries — better β, mirrors WRITING.md
4. **Cosmetic alignment** — tried to match WRITING.md formatting
5. **Unified principle** — "unintended behavior is unrepresentable"

The breakthrough came when Axiom said "forget cosmetics, TSC it."

Realized the principle "intent obvious, behavior matches" was **two concerns in a trenchcoat**. Some rules served clarity (naming, types), others served failure handling (guards, validation). Not unified.

The real principle: **unintended behavior is unrepresentable.**

Now every rule serves one test: "Can anything unintended happen here?"

### β — What did I learn?

1. **One principle, not two.** If you're listing "X and Y", you haven't found it yet. WRITING has "nothing can be removed without loss" — one test. Coding now has "unintended behavior unrepresentable" — one test.

2. **Sections should constrain, not categorize.** The shift from "Failure Handling / Structure / Clarity" (what kind of rule) to "Types / Functions / Modules / Boundaries" (what level of constraint) was necessary but not sufficient. The sections needed to serve one principle.

3. **TSC β reveals the lie.** When β is weak (sections don't relate to whole), there's usually a missing unifying principle. The sections were parallel because the "principle" was actually two things.

4. **Self-demonstration matters.** WRITING's principle can't be shortened — it demonstrates itself. Coding's principle should pass the test: can unintended behavior happen in this skill? If not, it's coherent.

### γ — What will I do differently?

When writing skills:
1. Don't start with rules. Start with the principle.
2. If the principle has "and", keep looking.
3. TSC the skill before shipping — weak β means weak principle.
4. Test self-demonstration: does the skill pass its own test?

MCA confirmed: I ship structure before finding unity. Same pattern as auto-update code — functionality first, coherence after.

---

## Related

- `cnos/skills/eng/coding/SKILL.md` — the final skill
- `cnos/skills/skill/SKILL.md` — skill-writing skill
- `cnos/mindsets/WRITING.md` — the model to follow
