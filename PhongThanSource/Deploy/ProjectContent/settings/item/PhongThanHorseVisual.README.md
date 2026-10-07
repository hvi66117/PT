# Reviewed mount appearance overrides

`PhongThanHorseVisual.txt` is an explicit project override, not an original VNG table.
Columns: one-based horse item record, one-based SPR group, original HorsePart palette.
The resolver converts the SPR group to a zero-based CRESINFO row exactly once.

Current coverage: 572 of 1150 item records mapped by inspected icon families.
578 records retain VNG_HorsePart pending identification of profession-specific
and shared-icon variants. Do not describe those records as verified.

Verified icon families select jsx01 (horse), jsx02 (unicorn), jsx03 (wolf),
jsx04 (tiger), jsx05 (jade qilin), jsx06 (armored/Nghich family).
User-confirmed Lang Thien Phong records select jsx12 explicitly.
Nghich Lan record 250 selects group 6, palette retained from VNG_HorsePart.

Additional inspected families: Di Nhan wing icons map to groups 1,2,3,4,5,
11,12; Dao Si Ung Long icon maps to group 6 (ssx06). Rendering uses the
profession/sex component table: these group numbers are not jsx overrides.
Visual comparison uses base palettes; every recolor/sex/action remains
subject to gameplay acceptance. yrx06 is a distinct shared skeleton-wing
resource and must not be inferred from the Phong Loi icon without evidence.

Publish-NativeRuntime.ps1 copies this table to both runtime roles.
Restart the server to reload the table; existing equipment appearance must be
recomputed through equipment loading/equipping. Do not rewrite saved inventory.
Client mount layers with invalid SPRs are omitted instead of drawing stale data.

Build and data validation passed; gameplay visual acceptance remains pending.
