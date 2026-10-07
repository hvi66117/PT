$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$enc = [Text.Encoding]::GetEncoding(28591)
$list = [IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KSkillList.cpp'), $enc)
$start = $list.IndexOf('BOOL KSkillList::IncreaseLevel(')
$end = $list.IndexOf('BOOL KSkillList::IncreaseExp(', $start)
$increase = $list.Substring($start, $end-$start)
if ($increase.IndexOf('if (!pOrdinSkill)') -gt $increase.IndexOf('SkillLevel += nLvl')) { throw 'Level mutation precedes validation' }
if (!$increase.Contains('nLvl > maxLearned - m_Skills[nIdx].SkillLevel')) { throw 'Missing VNG MaxLevel bound' }
$player = [IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KPlayer.cpp'), $enc)
if (!$player.Contains('PhongThanProfessionOwnsSkill(m_cProfession.GetProfession(), pAdd->SkillId)')) { throw 'Missing profession authorization' }
$skill = [IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KSkills.cpp'), $enc)
if (!$skill.Contains('else switch(pTempSkill->m_nSeries)') -or !$skill.Contains('g_Profession.GetName(profession)')) { throw 'Missing profession tooltip' }
'PASS: skill migration source guards (not combat runtime acceptance).'
