--description: ÆÕÍ¨Âí³µ¶Ô»°½Å±¾
--author: roc
--date: 2004/6/15

function main(sel)
	Say("Xin chän thao t¸c",3,"Ta muèn lªn xe/yes","Ta muèn xuèng xe/no","Ta muèn xem trong xe lµ ai/info")
end;

function yes()
	PlayerInOrOut(1);
end;

function no()
	PlayerInOrOut(0);
end;

--´òÓ¡³µÀïÃæµÄ³Ë¿ÍÁÐ±í
function info()
	local weaponIndex = IsPlayerInsideWeapon(PlayerIndex)
	if (weaponIndex==0) then
		return
	end;
	local weapon_npcIndex = GetSiegeWeaponNpcIndex(weaponIndex)
	local player_num = GetSiegeWeaponPlayerCount(weapon_npcIndex)
	local player_index = 0
	local name = ""
	for i=1,player_num do
		player_index = GetPlayerInSiegeWeapon(weapon_npcIndex,i-1)
		name = name.."["..GetNameByIdx(player_index).."]"
	end;
	Say("Hµnh kh¸ch cã: "..name,0)
end;
