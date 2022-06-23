/*
     @odiyan_dev

░█████╗░██████╗░██╗██╗░░░██╗░█████╗░███╗░░██╗
██╔══██╗██╔══██╗██║╚██╗░██╔╝██╔══██╗████╗░██║
██║░░██║██║░░██║██║░╚████╔╝░███████║██╔██╗██║
██║░░██║██║░░██║██║░░╚██╔╝░░██╔══██║██║╚████║
╚█████╔╝██████╔╝██║░░░██║░░░██║░░██║██║░╚███║
░╚════╝░╚═════╝░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚══╝

DISCORD: 
                                      ROLEPLAY SERVER : https://discord.gg/nexalrp
                                        SERVER  HOSTING & SCRIPTS : https://discord.gg/nexalhost

╭━╮╱╭╮╱╱╱╱╱╱╱╱╭╮
┃┃╰╮┃┃╱╱╱╱╱╱╱╱┃┃
┃╭╮╰╯┣━━┳╮╭┳━━┫┃
┃┃╰╮┃┃┃━╋╋╋┫╭╮┃┃
┃┃╱┃┃┃┃━╋╋╋┫╭╮┃╰╮
╰╯╱╰━┻━━┻╯╰┻╯╰┻━╯
╱╱╭╮╱╱╱╱╱╱╱╱╭╮╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭╮
╱╱┃┃╱╱╱╱╱╱╱╱┃┃╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭╯╰╮
╭━╯┣━━┳╮╭┳━━┫┃╭━━┳━━┳╮╭┳━━┳━╋╮╭╯
┃╭╮┃┃━┫╰╯┃┃━┫┃┃╭╮┃╭╮┃╰╯┃┃━┫╭╮┫┃
┃╰╯┃┃━╋╮╭┫┃━┫╰┫╰╯┃╰╯┃┃┃┃┃━┫┃┃┃╰╮
╰━━┻━━╯╰╯╰━━┻━┻━━┫╭━┻┻┻┻━━┻╯╰┻━╯
╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱┃┃
╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╰╯
*/

ADD THIS CMDS TO YOUR PWN

DCMD:plyrs(user, channel, params[]) {

    new szDialog[(1024 * 2)], title[128];

	foreach(new i : Player)
	{
		format(szDialog, sizeof(szDialog), "%s(%d) - %s - %d - %s\n", szDialog, i, GetRPName(i), GetPlayerPing(i), IsPlayerAndroid(i) ? ("Mobile") : ("PC/Desktop"));
	}

	format(title, sizeof(title), "> %s (%d/%d)", SERVER_NAME, Iter_Count(Player), MAX_PLAYERS);
	DCC_SendChannelMessage(channel, title);
	DCC_SendChannelMessage(channel, szDialog);
    return 1;
}
DCMD:admins(user, channel, params[]) {

    new szDialog[(1024 * 2)], title[128];

	foreach(new i : Player)
	{
		if(pData[i][pAdmin] > 0)
		{
			new division[5];
			strcpy(division, GetAdminDivision(i));
            if(strlen(division) < 1) division = "None";
			if(!strcmp(pData[i][pAdminName], "None", true))
			format(szDialog, sizeof(szDialog), "(ID: %i) %s %s - Division: %s - Status: %s - Reports Handled: %i{C8C8C8} - Tabbed: %s/n", i, GetAdminRank(i), pData[i][pUsername], division, (pData[i][pAdminDuty]) ? ("On Duty") : ("Off Duty"), pData[i][pReports], (pData[i][pAFK]) ? ("Yes") : ("No"));
		}
	}
	DCC_SendChannelMessage(channel, title);
	DCC_SendChannelMessage(channel, szDialog);
    return 1;
}
DCMD:ip(user, channel, params[])
{
	//DCC_SendChannelMessage(channel, "> Original IP:``178.128.216.41:8999");
	new chan[500], str[1500];
    format(str, sizeof(str), "Nexal Roleplay V6/nServer IP :20.235.1.19:7777", chan);
    new DCC_Embed:embed = DCC_CreateEmbed("Original IP Address", str);
    DCC_SetEmbedColor(embed, 0xFFFF00);
    return DCC_SendChannelEmbedMessage(channel, embed);
}

DCMD:say(user, channel, params[]) {

    if(isnull(params)) {
        DCC_SendChannelMessage(channel, "SYNTAX: !say [msg]");
    } else {

        new str[144], username[33];
        DCC_GetUserName(user, username, sizeof(username));
        format(str, sizeof(str), "**[DISCORD] %s says: %s**", username, params);
        SendClientMessageToAll(-1, str);
    }
    return 1;
}

DCMD:asay(user, channel, params[]) {
    new i;
    
    if(isnull(params)) {
        DCC_SendChannelMessage(channel, "SYNTAX: !asay [msg]");
    } else {

        new str[144], username[33];
        DCC_GetUserName(user, username, sizeof(username));
        format(str, sizeof(str), "**[DISCORD] %s says: %s**", username, params);
        SendAdminMessage(i, str);
            }
    return 1;
}

DCMD:checkstats(user, channel, params[])
{
        if(channel != DCC_FindChannelById("843901075080740945")) // Admin channel
        {
            DCC_SendChannelMessage(channel, "[ERROR] You can only use this command in Admin channels only!");
            return 1;
        }
        new playerid, level, pIP[128], Float:health, Float:armour;
        if(sscanf(params, "us[128]", playerid))
            {
                DCC_SendChannelMessage(channel, "Usage: !spec [ID]");
            }
        if (sscanf(params, "d", playerid))
        {
                return 1;
        }
        if(IsPlayerConnected(playerid))
        {
                new msg[128], name[MAX_PLAYER_NAME];
                GetPlayerName(playerid, name, sizeof(name));
                GetPlayerIp(playerid, pIP, 128);
                GetPlayerHealth(playerid, health);
                GetPlayerArmour(playerid, armour);
                new ping;
                ping = GetPlayerPing(playerid);
                format(msg, sizeof(msg), "``%s``'s info: **PLAYER-IP**: ``%s`` |n**PLAYER-Health**: ``%d`` |n**PLAYER-level**: ``%d`` |n**PLAYER-Armour**: ``%d`` |n**PLAYER-Ping**: ``%d``", name, pIP, floatround(health), floatround(level), floatround(armour), ping);
                DCC_SendChannelMessage(channel, msg);
        }
        return 1;
}