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

#include <a_samp>
#include <bcolors>
#include <discord-connector>
#include <zcmd>
#include <foreach>
#include <sscanf>
#include <BCMD1>

new DCC_Channel:Server_Connect; // Server connection
new DCC_Channel:Player_Connect; // Player connection
new DCC_Channel:Player_Disconnect; //Player disconnection
new DCC_Channel:Command_Logs; //Command Logs
new DCC_Channel:Player_Chat; //Player chats
new DCC_Channel:Admin_Channel; //Admins Channel
new DCC_Channel:Security_Channel; // Security Channel

stock DCC_SendChannelMessageFormatted( DCC_Channel: channel, const format[ ]) 
{
    #pragma unused channel
    #pragma unused format
    return 1;
  }
stock PlayerName(playerid)
{
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, MAX_PLAYER_NAME);
  return name;
}
#define MAX_CLIENT_MSG_LENGTH 144
public OnFilterScriptInit()
{	
    Server_Connect = DCC_FindChannelById( "876693526199533569");

    Player_Connect = DCC_FindChannelById( "876693526199533569");

    Player_Disconnect = DCC_FindChannelById( "876693526199533569");

    Command_Logs = DCC_FindChannelById("876693526199533569");

    Player_Chat = DCC_FindChannelById("876693526199533569");

    Admin_Channel = DCC_FindChannelById("876693526199533569");

    Security_Channel = DCC_FindChannelById("877038203293564928");
	
	new string[128],string2[128];
	format(string,sizeof (string),"Server succesfully started");
	DCC_SendChannelMessage(Server_Connect,string);
	SetTimer("BotStatus", 1000, true);
    format(string,sizeof (string2),"**Discord connected Is Actived Fully developed By ODIYAN[DEV]#3141** :fire:");
    DCC_SendChannelMessage(Security_Channel,string2);
	return 1;

}
forward BotStatus(playerid);
public BotStatus(playerid)
{
  new msr[256];
  format(msr, sizeof(msr), "SET UR STATUS");
  DCC_SetBotActivity(msr);
  DCC_SetBotPresenceStatus(DCC_BotPresenceStatus:IDLE);
}
public OnPlayerConnect(playerid)
{
	new name1[MAX_PLAYER_NAME];
	new pip[16],client1;
	GetPlayerIp(playerid, pip, sizeof(pip));
	GetPlayerName(playerid, name1, sizeof(name1));
    GetPlayerVersion(playerid, "client1", sizeof(client1));
	new string[250],string2[250];
	format(string,sizeof (string),"**%s Joined the server**",name1);
	DCC_SendChannelMessage(Player_Connect,string);
   
    format(string2,sizeof (string2),"**[Security System] {Player-Connected}\nPlayer Name -** `%s`\n**Player id -** `%d`\n**Player ip -** `%s`\n**Client Version -** `V%d` ",name1,playerid,pip,client1);
    DCC_SendChannelMessage(Security_Channel,string2);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    new name1[MAX_PLAYER_NAME];
    new pip[16],client1,float:Health1;
    GetPlayerIp(playerid, pip, sizeof(pip));
    GetPlayerName(playerid, name1, sizeof(name1));
    GetPlayerVersion(playerid, "client1", sizeof(client1));
    GetPlayerHealth(playerid, Float:Health1);
    new string[250],string2[250];
    format(string,sizeof (string),"**%s left the server**",name1);
    DCC_SendChannelMessage(Player_Disconnect,string);
   
    format(string2,sizeof (string2),"**[Security System] {Player-Disconnected}\nPlayer Name -** `%s`\n**Player id -** `%d`\n**Player ip -** `%s`\n**Client Version -** `V%d`",name1,playerid,pip,client1);
    DCC_SendChannelMessage(Security_Channel,string2);
	return 1;
}
forward DCC_OnMessageCreate(DCC_Message:message);
public DCC_OnMessageCreate(DCC_Message:message)
{
    new realMsg[100];
    DCC_GetMessageContent(message, realMsg, 100);
    new bool:IsBot;
    new DCC_Channel:channel;
    DCC_GetMessageChannel(message, channel);
    new DCC_User:author;
    DCC_GetMessageAuthor(message, author);
    DCC_IsUserBot(author, IsBot);
    if(channel == Player_Chat && !IsBot) //!IsBot will block BOT's message in game
    {
        new user_name[32 + 1], str[152];
        DCC_GetUserName(author, user_name, 32);
        format(str,sizeof(str), "**{8a6cd1}[DISCORD] {aa1bb5}%s: {ffffff}%s**",user_name, realMsg);
        SendClientMessageToAll(-1, str);
    }
    return 1;
}

public OnPlayerText(playerid, text[])
{
	new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof(name));
    new msg[128];
    format(msg, sizeof(msg), "```%s(%d): %s```", name, playerid, text);
    DCC_SendChannelMessage(Player_Chat, msg);
    return 1;
  
}
public OnRconLoginAttempt(ip[], password[], success)
{
    if(!success)
    {
        new msg[250],name[MAX_PLAYER_NAME],playerid;
        GetPlayerName(playerid,name,sizeof(name));
        format(msg, sizeof(msg),"**[Security System]**`%s` **attempted a rcon login with password** `%s` **and failed, Ban him quickly if it's not you or your friend**", name,password);
        DCC_SendChannelMessage(Security_Channel,msg);
    }
    if(success == 1)
    {
        new msg[128],name[MAX_PLAYER_NAME];
        format(msg, sizeof(msg),"[Security System]%s successfully logged into rcon\n Use /ban <name> to ban him if it's not you", name);
        DCC_SendChannelMessage(Security_Channel,msg);
    }
    return 1;
}
public OnRconCommand(cmd[])
{

    return 1;
}

/////////////////////////////COMMANDS//////////////////////COMMANDS///////////////////////////////////////////COMMANDS///////////////////////////////COMMANDS/////////
public OnDiscordCommandPerformed(DCC_User:user, DCC_Channel:channel, cmdtext[], success) {

    if(!success) {
    
        DCC_SendChannelMessage(channel, "This command does not exist!");
    }
    return 1;
}
BCMD:info(user, channel, params[]) 
{
		DCC_SendChannelMessage(channel, "> **__IP - YOUR SERVER IP__**\n> **__Gamemode - YOUR GAMEMODE__** \n> **__Server Slot - SERVESLOT__** \n> **__Language - SERVERLANGUAGE__** \n> **Forums - FORUMS ** \n> **" );
		return 1;
}
BCMD:cmds(user, channel, params[]) 
{
    DCC_SendChannelMessage(channel, "```[Player Commands]\n!info --> Shows server info\n!players --> Shows all the online players\n!say{text} --> Your text message will be sended in-game\n!credits --> shows the credits```" );
    return 1;
}
stock odiyanlogs(playerid, command[])
{
  new name1[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name1, sizeof(name1));
  new string[128];
  format(string, sizeof string, "[ADM.CMD] Administrator %s[%i] has used /%s", name1, playerid, command);
  DCC_SendChannelMessage(Command_Logs, string);
}
BCMD:acmds(user, channel, params[]) 
{
    if (channel == Admin_Channel) 
    {
      DCC_SendChannelMessage(Admin_Channel, "```[Admin Commands]\n!announce -->announce whatever you want \n!spec [id] --> Sends player stats\n!aclear --> Clearing in game chat\n!aslap[id] --> slapping player\n!kick[id] --> kicks player\n!freeze[id] -->freeze any player\n!unfreeze[id] --> This command will unfreeze any player ingame\n!ban[id] --> You can ban player using this command\n!restart --> Restarts the server ```" );
      return 1;
    }
    else
        DCC_SendChannelMessageFormatted(channel, "[ERROR] You can only use this command in Admin channels only!");
    
    return 1;
}

BCMD:players(user, channel, params[]) 
{

   new count = 0, string[256];
   for(new i = 0; i < MAX_PLAYERS; i ++)
   {
          if(IsPlayerConnected(i))
          {
 
                      format(string, sizeof(string),"**Online Players**\nPlayer ID:[%d] %s", i, PlayerName(i));
                      DCC_SendChannelMessage( channel,string );
                      count++;
          }
   }
   if(count == 0)
    {
                      new string5[256];
                      format(string5, sizeof(string5),"**No one is online right now!**");
                      DCC_SendChannelMessage( channel,string5 );
    }
   return 1;
}
BCMD:say(user, channel, params[]) {

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

//DISCORD ADMINS 
SendClientMessage2(playerid, color, message[])
{
  if (strlen(message) <= MAX_CLIENT_MSG_LENGTH) {
    SendClientMessage(playerid, color, message);
  }
  else {
    new string[MAX_CLIENT_MSG_LENGTH + 1];
    strmid(string, message, 0, MAX_CLIENT_MSG_LENGTH);
    SendClientMessage(playerid, color, string);
  }
  return 1;
}

BCMD:freeze(user, channel, params[])
{
    if (channel != Admin_Channel) 
    {
      DCC_SendChannelMessageFormatted(channel, "[ERROR] You can only use this command in Admin channels only!");
      return 1;
    }
    new playerid, reason[64];
    if(sscanf(params, "us[128]", playerid))
        {
                    DCC_SendChannelMessage(Admin_Channel, "Usage: !FREEZE [ID]");
        }
    {
        if(IsPlayerConnected(playerid))
        {
            new msg[128], pname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, pname, sizeof(pname));
            format(msg, sizeof(msg), "**[FREEZE] You had frozen** ``%s.`` **[Reason: %s]**", pname, reason);
            DCC_SendChannelMessage(Admin_Channel, msg);
            format(msg, sizeof(msg), "{FF0000}You {00CCCC}had been frozen by {247A46}Discord Administrator. {00FF00}[Reason: %s]", reason);
            SendClientMessage2(playerid, 0xFF0000C8, msg);
            TogglePlayerControllable(playerid, 0);
        }
    }
    return 1;
}
BCMD:unfreeze(user, channel, params[])
{
    new playerid;
    if (channel != Admin_Channel) 
    {
      DCC_SendChannelMessageFormatted(channel, "[ERROR] You can only use this command in Admin channels only!");
      return 1;
    }
    if(sscanf(params, "us[128]", playerid))
        {
                    DCC_SendChannelMessage(Admin_Channel, "Usage: !UNFREEZE [ID]");
                    return 1;
        }
    {

        if(IsPlayerConnected(playerid))
        {
            new msg[128], pname[MAX_PLAYER_NAME];
            GetPlayerName(playerid, pname, sizeof(pname));
            format(msg, sizeof(msg), "**[UNFREEZE] You had unfrozen** `` %s.``", pname);
            DCC_SendChannelMessage(Admin_Channel, msg);
            format(msg, sizeof(msg), "{FF0000}You {00CCCC}had been unfrozen by {247A46}Discord Administrator.");
            SendClientMessage2(playerid, 0xFF0000C8, msg);
            TogglePlayerControllable(playerid, 1);
        }
    }
    return 1;
}
BCMD:kick(user, channel, params[])
{
        if (channel != Admin_Channel) 
        {
          DCC_SendChannelMessageFormatted(channel, "[ERROR] You can only use this command in Admin channels only!");
          return 1;
        }
        new playerid, reason[64];
        if(sscanf(params, "us[128]", playerid, reason))
            {
                DCC_SendChannelMessage(Admin_Channel, "Usage: !kick [ID] [REASON]");
                return 1;
            }
        if (IsPlayerConnected(playerid))
        {
            new msg[128], name[MAX_PLAYER_NAME];
            GetPlayerName(playerid, name, sizeof(name));
            format(msg, sizeof(msg), "{FF0000}%s {00CCCC}has been kicked by {247A46}Discord Administrator. {00FF00}[Reason: %s]", name, reason);
            SendClientMessageToAll(0x0000FFFF, msg);
            format(msg, sizeof(msg), "**[KICK] You had kicked** `` %s. `` **[Reason: %s]**", name, reason);
            DCC_SendChannelMessage(Admin_Channel, msg);
            Kick(playerid);
        }

        return 1;
}
BCMD:aslap(user, channel, params[])
{
    if (channel != Admin_Channel) 
    {
      DCC_SendChannelMessageFormatted(channel, "[ERROR] You can only use this command in Admin channels only!");
      return 1;
    }
    new id, str[128], str2[128], pname[MAX_PLAYER_NAME], Float:x, Float:y, Float:z;
//    if(!IRC_IsHalfop(botid, channel, user)) return IRC_Say(groupID, channel, "Invalid Level");
    {
      if(sscanf(params, "us[128]", id, str))
      {
      DCC_SendChannelMessage(Admin_Channel, "Usage: !aslap [ID] [reason]");
      return 1;
    }
      GetPlayerName(id, pname, sizeof(pname));
      format(str2, sizeof(str2), "{FF0000}You {00CCCC}Had Been Slapped By {247A46}Discord Administrator. {00FF00}[Reason: %s]", str);
      SendClientMessageToAll(0x0000FFFF, str2);
      format(str2, sizeof(str2), "**[SLAP] You had slapped. [Reason: %s]**", pname, str);
      GetPlayerPos(id, x, y, z);
      SetPlayerPos(id, x, y, z+10);
    }
    DCC_SendChannelMessage(Admin_Channel, str2);
    return 1;
}
BCMD:aclear(user, channel, message[])
{
//  if(IRC_IsHalfop(conn, channel, user) == 0) return IRC_Say(conn, channel, "Invalid Level");
  if (channel != Admin_Channel) 
    {
      DCC_SendChannelMessageFormatted(channel, "[ERROR] You can only use this command in Admin channels only!");
      return 1;
    }
  {
  for( new i = 0; i <= 100; i ++ ) SendClientMessageToAll(COLOR_WHITE, "" );
  }
  new string[256];
  format(string, sizeof(string), "{247A46}* Discord Administrator {FFFFFF}has cleared the chat.");
  SendClientMessageToAll(COLOR_WHITE, string);
  format(string, sizeof(string), "**[CHAT] You have cleared the chat.**");
  DCC_SendChannelMessage(Admin_Channel, string);
  #pragma unused message
  return 1;
}
BCMD:spec(user, channel, params[])
{
        if (channel != Admin_Channel) 
        {
            DCC_SendChannelMessageFormatted(channel, "[ERROR] You can only use this command in Admin channels only!");
            return 1;
        }
        new playerid, pIP[128], Float:health, Float:armour;
        if(sscanf(params, "us[128]", playerid))
            {
                DCC_SendChannelMessage(Admin_Channel, "Usage: !spec [ID]");
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
                format(msg, sizeof(msg), "``%s``'s info: **PLAYER-IP**: ``%s`` | **PLAYER-Health**: ``%d`` | **PLAYER-Armour**: ``%d`` | **PLAYER-Ping**: ``%d``", name, pIP, floatround(health), floatround(armour), ping);
                DCC_SendChannelMessage(Admin_Channel, msg);
        }
        return 1;
}
BCMD:announce(user, channel, params[])
{
  new playerid;
  if (channel != Admin_Channel) 
    {
      DCC_SendChannelMessageFormatted(channel, "[ERROR] You can only use this command in Admin channels only!");
      return 1;
    }
  if(sscanf(params, "us[128]", params))
        {
            DCC_SendChannelMessage(Admin_Channel, "Usage: !announce [YOUR TEXT]");
            return 1;
        }
  if(IsPlayerConnected(playerid))
  {    
          new amsg[128], amsg2[128];
          format(amsg, sizeof(amsg), "**Announcement From Discord:** ``%s``", params);
          DCC_SendChannelMessage(Admin_Channel, amsg);
          format(amsg2, sizeof(amsg2), "Announcement From Discord: %s", params);
          SendClientMessageToAll(COLOR_GREEN, amsg2);
  }
  return 1;
}
BCMD:ban(user, channel , params[])
{
    new msg[128],msg2[128],name1[MAX_PLAYER_NAME],targetid,reason;
    if(channel != Admin_Channel|| Security_Channel)
    {
        DCC_SendChannelMessageFormatted(channel,"[ERROR] You can only use this command in Admin channels or in Security Channel!");
        return 1;
    }
    if(sscanf(params, "us[128]", targetid,reason))
        {
            DCC_SendChannelMessage(Admin_Channel, "Usage: !ban [ID] [Reason]");
            return 1;
        }
    if(IsPlayerConnected(targetid))
    {
        GetPlayerName(targetid,"name1", sizeof(name1));
        format(msg, sizeof(msg),"[Discord Security] %s has been banned by discord mod [Reason:%s] ", name1,reason);
        SendClientMessageToAll(COLOR_RED,msg);
        format(msg2, sizeof(msg2),"[Discord Security] You have banned %s [Reason:%s] ", name1,reason);
        DCC_SendChannelMessage(channel,msg2);
        Ban(targetid);
    }
    return 1;
}
CMD:pm(playerid, params[])
{
	new pname[MAX_PLAYER_NAME], tname[MAX_PLAYER_NAME], string[128], tplayer, message;
	GetPlayerName(playerid, pname, sizeof(pname));
	GetPlayerName(tplayer, tname, sizeof(tname));
	if(sscanf(params, "us", tplayer, message)) SendClientMessage(playerid, COLOR_RED, "[SERVER]: Usage: /PM <ID> <Message>.");
  	if(tplayer == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED, "[SERVER]: Invalid player id.");
  	new pmsg[128];
    format(string, sizeof(string), "(PM) to %s: %s", pname, message);
    SendClientMessage(playerid, COLOR_YELLOW, string);
    format(pmsg, sizeof(pmsg), "**(PM) from %s: %s**", pname, message);
  	DCC_SendChannelMessage(Admin_Channel, pmsg);
    format(string, sizeof(string), "(PM)  %s pmed %s : %s", pname,tname, message);
    SendClientMessage(tplayer, COLOR_YELLOW, string);
	return 1;
}
BCMD:credits(user, channel, params[]) 
{
        DCC_SendChannelMessage(channel, "> **Discord Connector**\n> **Created/Scripted by - ODIYAN([DEV]**" );
        return 1;
}
BCMD:restart(user, channel , params[])
{
    if(channel != Admin_Channel|| Security_Channel)
    {
        DCC_SendChannelMessageFormatted(channel,"[ERROR] You can only use this command in Admin channels or in Security Channel!");
        return 1;
    }
    SendClientMessageToAll(COLOR_RED,"[Discord Security System] Server Has been Restarted by Discord-Moderator");
    DCC_SendChannelMessage(Admin_Channel,"You have restarted the server successfully");
    SendRconCommand("gmx");
    return 1;
}