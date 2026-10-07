# P2 item icon policy

The runtime accepts only byte-original item icons resolved by the VNG PAK
chain declared in the client `package.ini`. It must not synthesize icons and
must not fall back to unverified loose files.

The locked P2.2 baseline contains 3,886 unique SPR references: 3,393 resolve
from PAK and 493 remain an explicit source backlog. The incomplete entries are
mostly old event/IBItem rows in `magicscript.txt`, plus a smaller set in
`material.txt`, `questkey.txt`, `rangeweapon.txt`, `ring.txt`, `cuff.txt`, and
two repeated melee-weapon icons.

The VNG armor, helm, boot, belt, amulet, pendant, and horse tables are mandatory
zero-missing groups. Any regression in those groups fails the build gate.

Run `Tests\Test-VngItemIconPolicy.ps1` after changing item tables, `package.ini`,
or PAK content. Detailed catalogs and the JSON report are generated under
`Output\ItemIconPolicy`.
