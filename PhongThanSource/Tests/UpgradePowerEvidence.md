# Enhancement power: screenshot and PAK evidence

User-supplied screenshots in `PhongThanRuntime-Staging` dated 2026-09-08:

| Filename prefix | Item | Level | Displayed power | Physical damage low/high |
|---|---|---:|---:|---|
|1788847693071|Khai Thien Phu|0|270|104/228|
|1788847693054|Khai Thien Phu|1|283|114/238|
|1788847693036|Khai Thien Phu|2|299|124/248|
|1788847693000 and 1788847693018|Khai Thien Phu|3|318|134/258|
|1788847692960|Diem Tuong Kich|1|145|100/196|
|1788847692910|Diem Tuong Kich|2|161|110/206|

The yellow label is garbled but numeric values are legible. Screenshots are a reference server, not proof of every VNG version. They confirm marginal power deltas +13/+16/+19 for weapon steps 1/2/3 and +10 to each physical damage endpoint for these steps. No supplied image proves step 4. Original PAK power table gives +24, not +21, for weapon step 4.

Source: `\settings\powervalue\装备升级功力表.txt`, original CP936 PAK path. Read it by equipment ID, NOT appearance row, SetID or item detail type.

|EquipID|Category verified from item tables|Step 1/2/3/4|Sum steps 1..12|
|---|---|---|---:|
|1|armor|12/15/18/21|431|
|2|belt|2/3/4/5|115|
|3|helm|2/3/4/5|115|
|4|boots|2/3/4/5|115|
|5|pendant/cloak|6/8/10/13|320|
|6|melee weapon|13/16/19/24|540|
|7|amulet (phap bao), NOT horse|10/12/14/17|368|

`KItem::GetUpgradePower` sums the source cells up to UpgradeLevel. Both Core builds use the same accessor; tooltip shows this enhancement contribution separately. Zero level yields zero; unknown IDs, missing cells and unsupported levels fail rather than extrapolate. `UpgradePowerTests` checks all seven rows at 0..12, screenshot deltas and integer overflow.

This is only the enhancement contribution, not a finished total-power evaluator for `*a,b*`. Item stats need their separate upgrade-rule mapping. Horse has blank EquipID in the audited table and must not inherit code 7. Build passes; runtime deployment remains pending the broader equipment integration.

## Combat-rule reader

`Headers/PhongThanUpgradeStats.h` reads the explicit rule ID and sums per-step deltas from the original upgrade tables. `Tests/Native/UpgradeStatsTests.cpp` uses real Engine/KTabFile: weapon rule 1 at level 3 yields requirement +12 and damage endpoints +30/+30; armor rule 41 at level 4 yields defense +42. Unknown rule, unavailable level and insufficient output capacity fail. Test requires runtime Client directory on PATH for Engine.dll. Reader is not yet wired to gameplay: the operation's selected rule and refinement mode must be provided, not guessed from EquipID/SetID.

A screenshot/template-version warning: Khai Thien Phu screenshot has base 104/228, matching ordinary row 18 bounds; current quest row 288 fixes the base at 116/240. Do not copy screenshot base stats over the template.
