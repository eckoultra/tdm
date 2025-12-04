
#include <a_samp>
#include <Pawn.CMD>
#include <a_mysql>
#include <sscanf2>
#include <dini>
#include <mSelection>
#include <DialogCenter>
#include <timestamptodate>
#include <progress>
#include <foreach>
#include <nex-ac_es.lang>
#include <nex-ac>

// === DS HEART SYSTEM (auto-insert) ===
#if !defined DS_HEART_SYSTEM
    #define DS_HEART_SYSTEM

    #define DS_HEART_MODEL          (1240)
    #define DS_HEART_TYPE           (1)        // 1 = manual pickup
    #define DS_HEART_HEAL           (30.0)     // +30 HP
    #define DS_HEART_LIFETIME_MS    (30000)    // 30s
    #define DS_HEART_MAX            (128)

    new bool:DS_HeartActive[DS_HEART_MAX];
    new DS_HeartPickup[DS_HEART_MAX];
    new DS_HeartVW[DS_HEART_MAX];
    new IgnorarAnticheat[MAX_PLAYERS]; // 0 = no ignorar, 1 = ignorar
    //new TimerTopKills;




	//damage informer
    new PlayerText:DamageInfoTD[MAX_PLAYERS];
	new DamageTimer[MAX_PLAYERS];
	//ping,pl,muertes,kills
	new PlayerText:TD_ping[MAX_PLAYERS];
	new PlayerText:TD_packet[MAX_PLAYERS];
	new PlayerText:TD_kills[MAX_PLAYERS];
	new PlayerText:TD_muertes[MAX_PLAYERS];
	new PlayerText:TD_fps[MAX_PLAYERS];
	//top kill
	new PlayerText:TD_TopTitulo[MAX_PLAYERS];
	new PlayerText:TD_TopLinea[MAX_PLAYERS][5];

	new TopNames[5][24];
	new TopScores[5];

 //td ping - pl



    forward DS_Heart_Expire(slot);

    stock DS_Heart_Spawn(Float:x, Float:y, Float:z, vw)
    {
        new slot = -1;
        for (new i = 0; i < DS_HEART_MAX; i++) { if (!DS_HeartActive[i]) { slot = i; break; } }
        if (slot == -1) return -1;

        DS_HeartPickup[slot] = CreatePickup(DS_HEART_MODEL, DS_HEART_TYPE, x, y, z, vw);
        DS_HeartActive[slot] = true;
        DS_HeartVW[slot] = vw;

        SetTimerEx("DS_Heart_Expire", DS_HEART_LIFETIME_MS, false, "i", slot);
        return slot;
    }

    public DS_Heart_Expire(slot)
    {
        if (slot < 0 || slot >= DS_HEART_MAX) return 1;
        if (DS_HeartActive[slot])
        {
            DestroyPickup(DS_HeartPickup[slot]);
            DS_HeartActive[slot] = false;
        }
        return 1;
    }

    stock DS_Heart_PickupHeal(playerid, slot)
    {
        if (slot < 0 || slot >= DS_HEART_MAX) return 0;
        if (!DS_HeartActive[slot]) return 0;
        if (GetPlayerVirtualWorld(playerid) != DS_HeartVW[slot]) return 0;

        new Float:hp;
        GetPlayerHealth(playerid, hp);
        hp += DS_HEART_HEAL;
        if (hp > 100.0) hp = 100.0;
        SetPlayerHealth(playerid, hp);

        DestroyPickup(DS_HeartPickup[slot]);
        DS_HeartActive[slot] = false;

        return 1;
    }
#endif
// === END DS HEART SYSTEM ===


//======(DEFINE)======//
#pragma disablerecursion
#define SendFormattedMessage(%0,%1,%2,%3) \
new text[128]; \
format(text,sizeof(text),%2,%3); \
SendClientMessage(%0,%1,text)
#define SendFormattedMessageToAll(%1,%2,%3) \
new texto[128]; \
format(texto,sizeof(texto),%2,%3); \
SendClientMessageToAll(%1,texto)
//======(DEFINE)======//
#undef MAX_PLAYERS
#undef MAX_VEHICLES
#undef MAX_OBJECTS
#define OFFLINE             "ID incorrecta o jugador no conectado"
#define MAX_OBJECTS (5)
#define MAX_VEHICLES (100)
#define MAX_PLAYERS (50)
#define SCM     SendClientMessage
#define funcion%0(%1) forward%0(%1); public%0(%1)
#define HOSTNAME "*.*.* « D a r k S h o t s - T D M » *.*.*"
#define SERVERMODE "TDM BETA 0.3"
#define WEBURL "www.darkshots.net"
#define MAPNAME "Bayside"
#define LENGUAJE "Español - Spanish"
#define DATABASENAME "IpToCountry.db"
//mysql_connect

#define HOST "31.170.167.204" //dejenlo como está
#define DBUSER "u437278218_extreme" //usuario de la base de datos
#define DBNAME "u437278218_extreme" //nombre de la base de datos
#define DBPASS "Linares.12" //contraseña de la base de datos

/*
#define HOST "localhost" //dejenlo como está
#define DBUSER "root" //usuario de la base de datos
#define DBNAME "tdm" //nombre de la base de datos
#define DBPASS "" //contraseña de la base de datos
*/
//mysql_connect
#define AkaCuentas "Server/config/aka.txt"
#define REGISTRO 1
#define INGRESO 2
#define TIENDA 3
#define ARMAST 4
#define SUGERENCIA 5
#define SUGERENCIA2 6
#define COINS 7
#define SANCIONADOS 8
#define CARS 9
#define D_REPORTES      10
#define loquendoVoz 11
#define loquendoVoz2 12
#define MONEDAS 13
#define MONEDAS2 14
#define MONEDAS3 15
#define MONEDAS4 16
#define MONEDAS5 17
#define MONEDAS6 18
#define DIALOG_VIP 19
#define SVRCONFIG 20
#define CLIMA 21
#define DIALOG_INTERIORS 22
#define CONFIG 23
#define dialogname 24
#define dialogpass 25
#define dialogpass2 26
#define DUELOSMENU 27
#define DUELOSMENU2 28
#define DUELOSMENU3 29
#define DUELOSMENU4 30
#define TEAM 31
#define CHANGETEAM 32
#define EXPULSADO 33
#define TAKEOVER_TIME 30 // how many seconds needed to take over the zone
#define MIN_MEMBERS_TO_START_WAR 3 // how many team members needed in a zone to start a war
#define MIN_DEATHS_TO_START_WAR 3 // how many team members must be killed in a zone to start a war
//Duelos
#define ARENAS 10
//======(PERMISOS)======
#define Permiso "Dkyzer"
#define Permiso2 "eck0"
#define Permiso3 "Josemc"
//======(MAX)======
#define MAX_REPORTES    20
#define MAX_CONNECTIONS_FROM_IP 1
#define MAX_ARMAS 10 // El máximo de armas que pueden haber en el suelo.
#define MAX_SPAM 3
#define MAX_ADV 3
//======(EQUIPOS)=======
#define EQUIPOS "Equipo\tTipo\n{007CFF}Old´s Gang\tPúblico\n{FF7B00}66'The Wins\tPúblico\n{F00707}-The Legends-\tPúblico\n{ff00ff}DarkShots ADM\t{00FFFF}Privado\n{6527F5}> Demen$ia <\t{00FFFF}Privado"
#define OldsGang 50 //olds gang
#define TheWins 51 //66TheWins
#define TheLegends 54
#define EnVenta 52 //DarkShots ADM
#define eTeam 53
//Colores de auto
#define AUTONICK 3
#define AUTOECKO 183
#define AUTOOldsGang 152
#define AUTOTheWins 219
#define AUTODEMENSIA 183
//======(SISTEMAS)=======
#define MUSICA 34
#define MUSICA2 35
#define DIALOG_BANEOS 36
#define GAMES 37
//======(COLORES)=======
#define cverde2         "{99FF00}"
#define DARK 			"{343a40}"
#define FUCSIA 			"{FF00FF}" // O el código exacto de tu fucsia
#define BLANCO 			"{FFFFFF}"
#define COLOR_DARK 		0x343a40FF
#define CHICLE 			"{04ff82}"
#define COLOR_CHICLE 	0x04ff82FF
#define lightred 		0x33CCFFAA
#define camarillo		"{FFFF00}"
#define cverde          "{00FF00}"
#define cverde2         "{99FF00}"
#define warning 		"{FF4500}"
#define GRIS 			0xAFAFAFAA
#define ROJO 			0xFF0000FF
#define VERDE 			0x00FF00FF
#define AZUL 			0x0000FFFF
#define MORADO 			0x8700FFFF
#define CELESTE 		0x00FFFFFF
#define ROSA 			0xFF00FFFF
#define VIOLETA 		0x7A00FFFF
#define AMARILLO 		0xFFFF00FF
#define orange 			0xFF9900AA
#define RELEASED(%0)	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define PRESSED(%0)		(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
new Float:ex,Float:ey,Float:ez,EnEvento[MAX_PLAYERS];
//======(NEW)=======
new resultadob;
new TimerCombate[MAX_PLAYERS],EnCombate[MAX_PLAYERS],TiempoCombate[MAX_PLAYERS],CColocado[MAX_PLAYERS],InShop[MAX_PLAYERS];
new EscopetaON[MAX_PLAYERS],EDCON[MAX_PLAYERS],RIFLEON[MAX_PLAYERS],SNIPERON[MAX_PLAYERS],M4ON[MAX_PLAYERS],MP5ON[MAX_PLAYERS];
new inindex[MAX_PLAYERS], inmodel[MAX_PLAYERS];
new NombreI,Colorduty[MAX_PLAYERS],DuelosOff;
new OnDuty[MAX_PLAYERS];
new fAutoC[MAX_PLAYERS];
new SpecteandoA[MAX_PLAYERS];
new Tiempo_Random[MAX_PLAYERS];
new timerduelo[MAX_PLAYERS],timermapa[MAX_PLAYERS][3];
new Sancion[MAX_PLAYERS],TimerSancion[MAX_PLAYERS],TimerSancion2[MAX_PLAYERS];
static iPlayerChatTime[MAX_PLAYERS];
new ADpm[MAX_PLAYERS];
new Musica[MAX_PLAYERS];
new OCoins[MAX_PLAYERS],ODinero[MAX_PLAYERS],Ofrecedor[MAX_PLAYERS];
new bool:Escuchando[MAX_PLAYERS];
new PrimeraSalida[MAX_PLAYERS];
static PlayerText:NOTIFICATION_MESSAGE[MAX_PLAYERS][4], NotificationSlot[MAX_PLAYERS][3], NotificationTime[MAX_PLAYERS][3];
new bool:pCBugging[MAX_PLAYERS];
new ptmCBugFreezeOver[MAX_PLAYERS],CBUG_DISABLED = 1;
new VarConteo = -1;
new VarConteoT;
new Float:ObjCoords[MAX_ARMAS][3];
new Object[MAX_ARMAS];
new Objetop[MAX_PLAYERS];
new ObjectID[MAX_ARMAS][2];
new aVehicleNames[212][] =
{
	{"Landstalker"},
	{"Bravura"},
	{"Buffalo"},
	{"Linerunner"},
	{"Perrenial"},
	{"Sentinel"},
	{"Dumper"},
	{"Firetruck"},
	{"Trashmaster"},
	{"Stretch"},
	{"Manana"},
	{"Infernus"},
	{"Voodoo"},
	{"Pony"},
	{"Mule"},
	{"Cheetah"},
	{"Ambulance"},
	{"Leviathan"},
	{"Moonbeam"},
	{"Esperanto"},
	{"Taxi"},
	{"Washington"},
	{"Bobcat"},
	{"Mr Whoopee"},
	{"BF Injection"},
	{"Hunter"},
	{"Premier"},
	{"Enforcer"},
	{"Securicar"},
	{"Banshee"},
	{"Predator"},
	{"Bus"},
	{"Rhino"},
	{"Barracks"},
	{"Hotknife"},
	{"Trailer 1"},
	{"Previon"},
	{"Coach"},
	{"Cabbie"},
	{"Stallion"},
	{"Rumpo"},
	{"RC Bandit"},
	{"Romero"},
	{"Packer"},
	{"Monster"},
	{"Admiral"},
	{"Squalo"},
	{"Seasparrow"},
	{"Pizzaboy"},
	{"Tram"},
	{"Trailer 2"},
	{"Turismo"},
	{"Speeder"},
	{"Reefer"},
	{"Tropic"},
	{"Flatbed"},
	{"Yankee"},
	{"Caddy"},
	{"Solair"},
	{"Berkley's RC Van"},
	{"Skimmer"},
	{"PCJ-600"},
	{"Faggio"},
	{"Freeway"},
	{"RC Baron"},
	{"RC Raider"},
	{"Glendale"},
	{"Oceanic"},
	{"Sanchez"},
	{"Sparrow"},
	{"Patriot"},
	{"Quad"},
	{"Coastguard"},
	{"Dinghy"},
	{"Hermes"},
	{"Sabre"},
	{"Rustler"},
	{"ZR-350"},
	{"Walton"},
	{"Regina"},
	{"Comet"},
	{"BMX"},
	{"Burrito"},
	{"Camper"},
	{"Marquis"},
	{"Baggage"},
	{"Dozer"},
	{"Maverick"},
	{"News Chopper"},
	{"Rancher"},
	{"FBI Rancher"},
	{"Virgo"},
	{"Greenwood"},
	{"Jetmax"},
	{"Hotring"},
	{"Sandking"},
	{"Blista Compact"},
	{"Police Maverick"},
	{"Boxville"},
	{"Benson"},
	{"Mesa"},
	{"RC Goblin"},
	{"Hotring Racer A"},
	{"Hotring Racer B"},
	{"Bloodring Banger"},
	{"Rancher"},
	{"Super GT"},
	{"Elegant"},
	{"Journey"},
	{"Bike"},
	{"Mountain Bike"},
	{"Beagle"},
	{"Cropdust"},
	{"Stunt"},
	{"Tanker"},
	{"Roadtrain"},
	{"Nebula"},
	{"Majestic"},
	{"Buccaneer"},
	{"Shamal"},
	{"Hydra"},
	{"FCR-900"},
	{"NRG-500"},
	{"HPV1000"},
	{"Cement Truck"},
	{"Tow Truck"},
	{"Fortune"},
	{"Cadrona"},
	{"FBI Truck"},
	{"Willard"},
	{"Forklift"},
	{"Tractor"},
	{"Combine"},
	{"Feltzer"},
	{"Remington"},
	{"Slamvan"},
	{"Blade"},
	{"Freight"},
	{"Streak"},
	{"Vortex"},
	{"Vincent"},
	{"Bullet"},
	{"Clover"},
	{"Sadler"},
	{"Firetruck LA"},
	{"Hustler"},
	{"Intruder"},
	{"Primo"},
	{"Cargobob"},
	{"Tampa"},
	{"Sunrise"},
	{"Merit"},
	{"Utility"},
	{"Nevada"},
	{"Yosemite"},
	{"Windsor"},
	{"Monster A"},
	{"Monster B"},
	{"Uranus"},
	{"Jester"},
	{"Sultan"},
	{"Stratum"},
	{"Elegy"},
	{"Raindance"},
	{"RC Tiger"},
	{"Flash"},
	{"Tahoma"},
	{"Savanna"},
	{"Bandito"},
	{"Freight Flat"},
	{"Streak Carriage"},
	{"Kart"},
	{"Mower"},
	{"Duneride"},
	{"Sweeper"},
	{"Broadway"},
	{"Tornado"},
	{"AT-400"},
	{"DFT-30"},
	{"Huntley"},
	{"Stafford"},
	{"BF-400"},
	{"Newsvan"},
	{"Tug"},
	{"Trailer 3"},
	{"Emperor"},
	{"Wayfarer"},
	{"Euros"},
	{"Hotdog"},
	{"Club"},
	{"Freight Carriage"},
	{"Trailer 3"},
	{"Andromada"},
	{"Dodo"},
	{"RC Cam"},
	{"Launch"},
	{"Police Car (LSPD)"},
	{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},
	{"Police Ranger"},
	{"Picador"},
	{"S.W.A.T. Van"},
	{"Alpha"},
	{"Phoenix"},
	{"Glendale"},
	{"Sadler"},
	{"Luggage Trailer A"},
	{"Luggage Trailer B"},
	{"Stair Trailer"},
	{"Boxville"},
	{"Farm Plow"},
	{"Utility Trailer"}
};
new const g_aMensajesAutomaticos[][] =
{
    "{CF27F5}[info]{FFFFFF} usa el comando {CF27F5}/random{FFFFFF} para obtener un premio.",
    "{CF27F5}[info]{FFFFFF} con {CF27F5}/ayudavip{FFFFFF} podrás ver los beneficios.",
    "{CF27F5}[info]{FFFFFF} lee nuestras {CF27F5}reglas{FFFFFF} para evitar malos entendidos.",
    "{CF27F5}[info]{FFFFFF} para ver los comandos disponible usa {CF27F5}/cmds.",
    "{CF27F5}[info]{FFFFFF} para configurar algunas cosas de tu cuenta usa {CF27F5}/config."
};
new GunObjects[47][0] = { // Objetos
	{0},// Ninguna.
	{331},// Puño americano.
	{333},// Palo de golf.
	{334},// Porra policial.
	{335},// Navaja.
	{336},// Bate de béisbol.
	{337},// Pala.
	{338},// Palo de pool.
	{339},// Katana.
	{341},// Motosierra.
	{321},// Consolador violeta.
	{322},// Consolador corto blanco.
	{323},// Consolador largo blanco.
	{324},// Consolador vibrador.
	{325},// Ramo de flores.
	{326},// Bastón.
	{342},// Granada.
	{343},// Grabada de gas lacrimógeno.
	{344},// Cóctel Molotov.
	{0},
	{0},
	{0},
	{346},// 9mm.
	{347},// 9mm con silenciador.
	{348},// Desert eagle.
	{349},// Escopeta normal.
	{350},// Escopeta recortada.
	{351},// Escopeta de combate.
	{352},// UZI
	{353},// MP5
	{355},// AK47
	{356},// M4
	{372},// Tec-9
	{357},// Rifle de caza.
	{358},// Rifle de francotirador (sniper)
	{359},// Lanzaconhetes.
	{360},// Lanzacohetes busca-calor.
	{361},// Lanzallamas.
	{362},// Minigun.
	{363},// Detonador.
	{364},// Botón de detonador.
	{365},// Aerosol de gas pimienta.
	{366},// Extinguidor de fuego.
	{367},// Cámara fotográfica.
	{368},// Gafas de visión nocturna.
	{368},// Gafas de visión infrarroja.
	{371}// Paracaídas.
};
// **** TIMESTAMPS
new ptsLastFiredWeapon[MAX_PLAYERS];
new Timer;
new Kills[MAX_PLAYERS],Level[MAX_PLAYERS];
//duelos
new NODUEL[MAX_PLAYERS];
new EnDuelo[MAX_PLAYERS];
new bool:ViendoDuelo[MAX_PLAYERS];
new PlayerText:Textdraw0[MAX_PLAYERS];
new PlayerText:Textdraw1[MAX_PLAYERS];
new PlayerText:Textdraw2[MAX_PLAYERS];
new PlayerText:Textdraw3[MAX_PLAYERS];
//new Text:LogoTD;
new God[MAX_PLAYERS];
//Dueños de equipos
new Owner[MAX_PLAYERS];
// Autorizados de equipos
new Autorizado[MAX_PLAYERS];
//Son de privados
new Invitado[MAX_PLAYERS];
new Invitacion[MAX_PLAYERS];
new SPAMADV[MAX_PLAYERS];
//Objetos y skins de la tienda
new skinlist = mS_INVALID_LISTID;
new objectlist = mS_INVALID_LISTID;
new vehiculos = mS_INVALID_LISTID;
new barcos = mS_INVALID_LISTID;
new aviones = mS_INVALID_LISTID;
//fly
static bool:OnFly[MAX_PLAYERS];
//gteam
new gTeam[MAX_PLAYERS];
new FPS[MAX_PLAYERS];
new FPSS[MAX_PLAYERS];
//Otros New's
new JugadoresEvento;
new GangZone;
new Text:Ann;
new MySQL:con;
new tarmas;

enum enunt
{
	actv,
	c1,
	c2,
	c3
}
new objcoordtimer[MAX_PLAYERS][enunt];

enum team_vehicle_info
{
    v_id,//the vehicle id
    v_team,//the vehicle's team id
    bool:v_exist//boolean to check if vehicle exists
}
new team_vehicle[ MAX_VEHICLES][ team_vehicle_info ];

enum _report
{
    TextReporte[80],
    Reportante[MAX_PLAYER_NAME],
    Reportado[MAX_PLAYER_NAME],
    bool:Activo
};
new Reportes[MAX_REPORTES][_report];

enum DueloData
{
	DesaId,
	DesafiadoId,
	ArmasId,
	Libre,
};
new Duelos[ARENAS][DueloData];

enum oData
{
	bool:used1,
	usando,
	index1,
	modelid1,
	bone1,
	Float:fOffsetX1,
	Float:fOffsetY1,
	Float:fOffsetZ1,
	Float:fRotX1,
	Float:fRotY1,
	Float:fRotZ1,
	Float:fScaleX1,
	Float:fScaleY1,
	Float:fScaleZ1
}
new oInfo[MAX_PLAYERS][MAX_OBJECTS][oData];

enum ServerData
{
	MaxPing,
	ReadPMs,
	ReadCmds,
	MaxAdminLevel,
	AdminOnlySkins,
	NameKick,
	PartNameKick,
	Password[128],
	ConnectMessages,
	AdminCmdMsg,
	DisableChat
};
new ServerInfo[ServerData];

enum Datos
{
	Contra[128],
	Logged,
	SkinUsando,
	FailLogin,
	ScoreNivel,
	Razon[128],
	Skin,
	Dinero,
	AdminNivel,
	Hide,
	Score,
	Baneado,
	Muertes,
	Muteado,
	pCar,
	Dia,
	Ano,
	Mes,
	Hora,
	Minutos,
	ADV,
	SanRazon[18],
	SancionTimeS,
	SancionTime,
	ComproEDC,
	ComproEscopeta,
	ComproMP5,
	ComproM4,
	ComproRifle,
	ComproSniper,
	ComproChaleco,
	Coins,
	VIP,
	VIP_EXPIRE,
	DuelosGanados,
	DuelosPerdidos
};
new Info[MAX_PLAYERS][Datos];

enum eventos
{
	EnCurso,
	VirtualWorld,
	Interior,
	NombreEvento[24],
	Abierto,
}
new Evento[eventos];

main()
{
	print("\n |======================================================================|");
	print(" |                      ||*DarkShots TDM*||                                   |");
	print(" |    |----------/MAPA Y GAMEMODE CARGADAS CORRECTAMENTE/----------|      |");
	print(" |Versión por eck0 - Dkyzer                                                       |");
	print(" |======================================================================|\n");
}


public OnGameModeInit()
{
	print("Iniciando conexión con la base de datos...");
	con = mysql_connect(HOST, DBUSER, DBPASS, DBNAME);
	if(!mysql_errno(con))
	{
		printf("Conectado a la base de datos %s, Host: %s",DBNAME,HOST);
		mysql_set_charset("utf8", con);
	}
	else
	{
		SendRconCommand("exit");
	}
	mysql_log(ERROR | WARNING);
	UsePlayerPedAnims();
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	EnableVehicleFriendlyFire();
	SendRconCommand("hostname "HOSTNAME"");
	SendRconCommand("weburl "WEBURL"");
	SendRconCommand("mapname "MAPNAME"");
	SendRconCommand("language "LENGUAJE"");
	SetGameModeText(SERVERMODE);
	UpdateConfig();
	tarmas = SetTimer("armas", 500, true);
	Config();
	SetTimer("ActualizarHUD", 1000, true);
	SetTimer("ActualizarTopKills", 10000, true);
	SetTimer("AnunciarMensajeAutomatico", 300000, true);
	skinlist = LoadModelSelectionMenu("skins.txt");
	objectlist = LoadModelSelectionMenu("objetos.txt");
	vehiculos = LoadModelSelectionMenu("vehicles.txt");
	barcos = LoadModelSelectionMenu("boats.txt");
	aviones = LoadModelSelectionMenu("planes.txt");
	SetTeamCount(8);
	for(new i=1; i< ARENAS; i++)
	{
		Duelos[i][DesafiadoId] = INVALID_PLAYER_ID;
		Duelos[i][DesaId] = INVALID_PLAYER_ID;
		Duelos[i][ArmasId] = -1;
		Duelos[i][Libre] = 0;
	}
	/*
	Actor[0] = CreateActor(186, -1657.4961,1208.3236,7.2500,351.2710);
	for(new i=0; i < sizeof(ZoneInfo); i++)
	{
    ZoneID[i] = GangZoneCreate(ZoneInfo[i][zMinX], ZoneInfo[i][zMinY], ZoneInfo[i][zMaxX], ZoneInfo[i][zMaxY]);
    barz[i] = CreateProgressBar(290.00, 368.00, 55.50, 3.20, GetTeamZoneColor(ZoneInfo[i][zTeam]), 100.0);
    SetProgressBarMaxValue(barz[i], 30);
	}
	GangZone = GangZoneCreate(-1899.8402404785156, 683.4511795043945, - 1453, 1222);
	SetTimer("ZoneTimer", 1000, true);
	*/
	Ann = TextDrawCreate(319.000000, 308.000000," ");
	TextDrawUseBox(Ann, 1);
	TextDrawBoxColor(Ann, 0x0000ff30);
	TextDrawTextSize(Ann, 32.000000,378.000000);
	TextDrawAlignment(Ann, 2);
	TextDrawBackgroundColor(Ann, 0x000000ff);
	TextDrawFont(Ann, 2);
	TextDrawLetterSize(Ann, 0.399999,1.000000);
	TextDrawColor(Ann, 0xffffffff);
	TextDrawSetShadow(Ann, 1);
	AddStaticVehicle(560,-1526.3385,2605.1375,55.4705,175.7564,146,146); // auto ecko 1
	AddStaticVehicle(468,-1513.9579,2608.7976,55.4978,181.2468,146,146); // auto ecko 2
	AddStaticVehicle(560,-1450.6442,2632.1174,55.5408,182.3100,176,176); //auto the legend
	AddStaticVehicle(560,-1441.3253,2634.0234,55.5413,179.0728,176,176);//augp thelegends
	AddStaticVehicle(560,-1440.8722,2566.6550,55.4307,93.6553,AUTOOldsGang,AUTOOldsGang); // autos oldsgang
	AddStaticVehicle(560,-1454.6462,2565.0261,55.4356,0.8124,AUTOOldsGang,AUTOOldsGang); // autos oldsgang2
	AddStaticVehicle(560,-1514.8790,2691.0266,55.4375,179.8444,AUTOTheWins,AUTOTheWins); // autos TheWins
	AddStaticVehicle(560,-1504.0244,2689.3018,55.4358,94.1605,AUTOTheWins,AUTOTheWins); // autos TheWins 2
    AddStaticVehicle(560,-1506.8792,2525.4036,55.5926,355.3645,AUTODEMENSIA, AUTODEMENSIA); // auto demensia 1
	AddStaticVehicle(468,-1521.6567,2525.6421,55.6121,357.0452,AUTODEMENSIA, AUTODEMENSIA); // auto demensia 2
	/*
	AddStaticVehicle(468,-1878.9651,722.3908,45.1139,268.9184,130,0); //
	AddStaticVehicle(502,-1890.2125,709.0945,45.3338,1.3703,130,0); //
	AddStaticVehicle(541,-1553.9728,1056.1049,6.8125,89.6620,154,154); //
	AddStaticVehicle(468,-1552.7377,1067.2789,6.8566,86.5787,154,154); //
	*/
	CreateActor(179, 296.3961,-40.2165,1001.5156,359.1537);
	Create3DTextLabel("{FF7B00}66'The Wins", 0xFFFFFFFF, -1512.0432,2695.6968,56.0723, 12.0, 0,1);
	Create3DTextLabel("{007CFF}Old's Gang", 0xFFFFFFFF, -1450.1840,2562.3237,56.0233, 12.0, 0,1);
	Create3DTextLabel("{6527F5}Demen$ia", 0xFFFFFFFF, -1514.8712,2521.2454,55.8625, 12.0, 0,1);
	Create3DTextLabel("{ff00ff}DarkShots ADM", 0xFFFFFFFF, -1519.3406,2610.0471,55.8359, 12.0,0, 1);
	Create3DTextLabel("{F20505}The Legends", 0xFFFFFFFF, -1446.2439,2635.9309,56.2543, 15.0,0, 1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {ffffff}para salir",0xFFFFFFFF,460.5563,-88.5414,999.5547,10.0,2,1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {ffffff}para salir",0xFFFFFFFF,501.8928,-67.5638,998.7578,10.0,1,1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {ffffff}para salir",0xFFFFFFFF,460.5563,-88.5414,999.5547,10.0,1,1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {FFFFFF}para salir",0xFFFFFFFF,372.2787,-133.5210,1001.4922,10.0, 0,1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {ffffff}para salir",0xFFFFFFFF,-2158.6143,643.1367,1052.3750,10.0,4,1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {ffffff}para salir",0xFFFFFFFF,255.2837,126.6181,1003.2188,10.0,5,1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {ffffff}para salir",0xFFFFFFFF,246.3907,107.3013,1003.2188,10.0,5,1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {ffffff}para salir",0xFFFFFFFF,2324.4670,-1149.5442,1050.7101,10.0,3,1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {FFFFFF}para salir",0xFFFFFFFF,318.5980,1114.5465,1083.8828,10.0,0,1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {FFFFFF}para salir",0xFFFFFFFF,-229.2949,1401.2042,27.7656,10.0,0,1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {FFFFFF}para salir",0xFFFFFFFF,2324.4797,-1149.5413,1050.7101,10.0,4,1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {FFFFFF}para entrar",0xFFFFFFFF,-1508.8748,2610.7014,55.8359,10.0,0,1);
	Create3DTextLabel("Presiona la tecla {cc33ff}F {FFFFFF}para salir",0xFFFFFFFF,285.3824,-41.7269,1001.5156, 10.0, 0, 1);
	Create3DTextLabel("Tienda\n{cc33ff}Escribe /tienda para ver los articulos", -1, 296.3786,-38.5146,1001.5156,10.0,0,1);
	return 1;
}

public OnGameModeExit()
{
	/*
	for(new i=0;i<sizeof(ZoneInfo); i++)
	DestroyProgressBar(barz[i]);
	*/
	KillTimer(Timer);
	KillTimer(tarmas);
	mysql_close();
	return 1;
}

public OnPlayerConnect(playerid)
{
    IsPlayerBaned(playerid);

    PlayerTextDraws(playerid);
    PlayerTextDrawShow(playerid, Textdraw0[playerid]);
    PlayerTextDrawShow(playerid, Textdraw1[playerid]);
    PlayerTextDrawShow(playerid, Textdraw2[playerid]);

    RemoveBuildingForPlayer(playerid, 1232, -1510.6641, 918.0234, 8.8047, 0.25);

    for(new i=0; i<60; i++) SendClientMessage(playerid, -1, " ");

    LimpiarJugadores(playerid);
    CargarHora(playerid);
    Config();
    ComprobarNivel(playerid);

    foreach(Player, i)
    {
        if(Info[i][AdminNivel] >= 1)
        {
            new msg[128], IP[16];
            GetPlayerIp(playerid, IP, sizeof(IP));
            format(msg, sizeof(msg), "{B6003E}%s {FFFFFF}Se ha unido al servidor || PAIS: {B6003E}%s{FFFFFF} ||",
            Nombre(playerid), IpToCountry_db(IP));
            SendClientMessage(i, GRIS, msg);
        }
    }

    new pAKA[280]; pAKA = dini_Get(AkaCuentas, ReturnIP(playerid));
    new str[128], string[128];
    if (strlen(pAKA) < 3 || !strcmp(pAKA, Nombre(playerid), true))
        format(str, sizeof(str), "(( %s [ID:%d] [Aka: no tiene otro nombre]))", Nombre(playerid), playerid);
    else
        format(str, sizeof(str), "(( %s [ID:%d] [Aka: %s] ))", Nombre(playerid), playerid, pAKA);
    MensajeParaAdmins(0xAFAFAFAA, str);

    if(strlen(dini_Get(AkaCuentas, ReturnIP(playerid))) == 0)
        dini_Set(AkaCuentas, ReturnIP(playerid), Nombre(playerid));
    else
    {
        if(strfind(dini_Get(AkaCuentas, ReturnIP(playerid)), Nombre(playerid), true) == -1)
        {
            format(string, sizeof(string), "%s,%s",
            dini_Get(AkaCuentas, ReturnIP(playerid)), Nombre(playerid));
            dini_Set(AkaCuentas, ReturnIP(playerid), string);
        }
    }

    SetPlayerMapIcon(playerid, 1, -2597.3237,2357.0557,9.8830, 59, 0xbd9f3eFF, MAPICON_GLOBAL);
    SetPlayerMapIcon(playerid, 2, -2479.4761,2317.6650,4.9844, 59, 0xFF0000FF, MAPICON_GLOBAL);
    SetPlayerMapIcon(playerid, 3, -2422.3359,2490.7031,13.2025, 60,0xFF7B00FF, MAPICON_GLOBAL);
    SetPlayerMapIcon(playerid, 4, -2236.9668,2354.1765,4.9799, 58,0xcc33ffFF, MAPICON_GLOBAL);
    SetPlayerMapIcon(playerid, 5, -1519.4404,2609.5242,55.8359, 59, MORADO, MAPICON_GLOBAL);
    SetPlayerMapIcon(playerid, 6, -1511.7067,2694.3125,55.8359, 60, AMARILLO, MAPICON_GLOBAL);
    SetPlayerMapIcon(playerid, 7,-1450.1760,2563.3169,55.8359, 61, CELESTE, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 8, -1509.1079,2610.0342,55.8359, 18, -1, MAPICON_GLOBAL);
    SetPlayerMapIcon(playerid, 9, -2523.4285,2239.7292,5.3512, 62, -1, MAPICON_GLOBAL);

    SendDeathMessage(INVALID_PLAYER_ID, playerid, 200);
    CargarArmas(playerid);

    // =====================================================
    // DAMAGE INFORMER
    // =====================================================
    DamageInfoTD[playerid] = CreatePlayerTextDraw(playerid, 320.0, 330.0, "_");
    PlayerTextDrawLetterSize(playerid, DamageInfoTD[playerid], 0.25, 1.0);
    PlayerTextDrawAlignment(playerid, DamageInfoTD[playerid], 2);
    PlayerTextDrawColor(playerid, DamageInfoTD[playerid], 0x00FF00FF);
    PlayerTextDrawSetOutline(playerid, DamageInfoTD[playerid], 1);
    PlayerTextDrawSetShadow(playerid, DamageInfoTD[playerid], 1);
    PlayerTextDrawFont(playerid, DamageInfoTD[playerid], 1);
    PlayerTextDrawHide(playerid, DamageInfoTD[playerid]);

    // =====================================================
    // HUD LEFT (PING, FPS, PACKET, KILLS, MUERTES) - Ajustado Arriba/Izquierda
    // =====================================================

    TD_ping[playerid] = CreatePlayerTextDraw(playerid, 10.0, 230.0, "ping: 0");
    PlayerTextDrawFont(playerid, TD_ping[playerid], 1);
    PlayerTextDrawLetterSize(playerid, TD_ping[playerid], 0.22, 1.0);
    PlayerTextDrawColor(playerid, TD_ping[playerid], 0xFF00FFFF);
    PlayerTextDrawSetOutline(playerid, TD_ping[playerid], 1);
    PlayerTextDrawAlignment(playerid, TD_ping[playerid], 1);
    PlayerTextDrawShow(playerid, TD_ping[playerid]);

    TD_fps[playerid] = CreatePlayerTextDraw(playerid, 10.0, 250.0, "fps: 0");
    PlayerTextDrawFont(playerid, TD_fps[playerid], 1);
    PlayerTextDrawLetterSize(playerid, TD_fps[playerid], 0.22, 1.0);
    PlayerTextDrawColor(playerid, TD_fps[playerid], 0xFF00FFFF);
    PlayerTextDrawSetOutline(playerid, TD_fps[playerid], 1);
    PlayerTextDrawAlignment(playerid, TD_fps[playerid], 1);
    PlayerTextDrawShow(playerid, TD_fps[playerid]);

    TD_packet[playerid] = CreatePlayerTextDraw(playerid, 10.0, 270.0, "packet: 0.0%");
    PlayerTextDrawFont(playerid, TD_packet[playerid], 1);
    PlayerTextDrawLetterSize(playerid, TD_packet[playerid], 0.22, 1.0);
    PlayerTextDrawColor(playerid, TD_packet[playerid], 0xFF00FFFF);
    PlayerTextDrawSetOutline(playerid, TD_packet[playerid], 1);
    PlayerTextDrawAlignment(playerid, TD_packet[playerid], 1);
    PlayerTextDrawShow(playerid, TD_packet[playerid]);

    TD_kills[playerid] = CreatePlayerTextDraw(playerid, 10.0, 290.0, "kills: 0");
    PlayerTextDrawFont(playerid, TD_kills[playerid], 1);
    PlayerTextDrawLetterSize(playerid, TD_kills[playerid], 0.22, 1.0);
    PlayerTextDrawColor(playerid, TD_kills[playerid], 0xFF00FFFF);
    PlayerTextDrawSetOutline(playerid, TD_kills[playerid], 1);
    PlayerTextDrawAlignment(playerid, TD_kills[playerid], 1);
    PlayerTextDrawShow(playerid, TD_kills[playerid]);

    TD_muertes[playerid] = CreatePlayerTextDraw(playerid, 10.0, 310.0, "muertes: 0");
    PlayerTextDrawFont(playerid, TD_muertes[playerid], 1);
    PlayerTextDrawLetterSize(playerid, TD_muertes[playerid], 0.22, 1.0);
    PlayerTextDrawColor(playerid, TD_muertes[playerid], 0xFF00FFFF);
    PlayerTextDrawSetOutline(playerid, TD_muertes[playerid], 1);
    PlayerTextDrawAlignment(playerid, TD_muertes[playerid], 1);
    PlayerTextDrawShow(playerid, TD_muertes[playerid]);

    // =====================================================
    // TOP KILLS (BOTTOM RIGHT) - Reubicado (Usando solo TD_TopLinea)
    // =====================================================

    // ... Tu código termina en TD_muertes[playerid] ...

    // =====================================================
    // TOP KILLS (FINAL) - MOVIDO DEBAJO DE LA ZONA DE KILLFEED
    // Coordenadas Y ajustadas a 300.0
    // =====================================================

    // Título: TOP KILLS
    TD_TopTitulo[playerid] = CreatePlayerTextDraw(playerid, 630.0, 300.0, "top kills"); // Y: 300.0 (Zona segura)
    PlayerTextDrawFont(playerid, TD_TopTitulo[playerid], 1);
    PlayerTextDrawLetterSize(playerid, TD_TopTitulo[playerid], 0.30, 1.2);
    PlayerTextDrawColor(playerid, TD_TopTitulo[playerid], 0xFF00FFFF); // FUCSIA
    PlayerTextDrawSetOutline(playerid, TD_TopTitulo[playerid], 1);
    PlayerTextDrawAlignment(playerid, TD_TopTitulo[playerid], 3); // Alineación a la DERECHA
    PlayerTextDrawShow(playerid, TD_TopTitulo[playerid]);

    new Float:y = 325.0; // Espaciado debajo del título (300.0 + 25.0)
    for(new i = 0; i < 5; i++)
    {
        // TD_TopLinea[playerid][i]
        TD_TopLinea[playerid][i] = CreatePlayerTextDraw(playerid, 630.0, y, "Cargando...");
        PlayerTextDrawFont(playerid, TD_TopLinea[playerid][i], 1);
        PlayerTextDrawLetterSize(playerid, TD_TopLinea[playerid][i], 0.20, 0.95);
        PlayerTextDrawColor(playerid, TD_TopLinea[playerid][i], 0xFF00FFFF); // FUCSIA
        PlayerTextDrawSetOutline(playerid, TD_TopLinea[playerid][i], 1);
        PlayerTextDrawAlignment(playerid, TD_TopLinea[playerid][i], 3); // Alineación a la DERECHA
        PlayerTextDrawShow(playerid, TD_TopLinea[playerid][i]);

        y += 20.0;
    }

    return 1;
}



funcion OnPlayerLogin(playerid)
{
    new info[256];

    if(cache_num_rows() > 0)
    {
        cache_get_value_name(0, "Contra", Info[playerid][Contra], 65);
        format(info, sizeof(info),
            "\
				\\c{FFFFFF}Bienvenido, {ff9933}%s\n\n\
				\\c{FFFFFF}Por favor, ingresa tu contraseña para continuar\n\
				\\c{AAAAAA}Recuerda que tu información está segura y protegida.", Nombre(playerid));

        ShowPlayerDialog(playerid, INGRESO, DIALOG_STYLE_PASSWORD, "{ff33cc}Acceso al servidor", info, "{FFFFFF}Ingresar", "{FFFFFF}Salir");
    }
    else
    {
        format(info, sizeof(info),
            "\
				\\c{ff9933}¡Bienvenido!\n\n\
				\\c{FFFFFF}Crea tu cuenta ingresando una contraseña\n\
				\\c{AAAAAA}Asegúrate de usar una contraseña segura para proteger tu personaje.");

        ShowPlayerDialog(playerid, REGISTRO, DIALOG_STYLE_PASSWORD, "{ff33cc}->Registrarse<-", info, "{FFFFFF}Crear Cuenta", "{FFFFFF}Salir");
    }

    return 1;
}

funcion Camara(playerid)
{
	SetPlayerCameraPos(playerid, -1559.939941, 924.159423, 82.675903);
	SetPlayerCameraLookAt(playerid, -1559.939941, 924.159423, 82.675903);
	//SetPlayerCameraPos(playerid, -2608.8828,2256.5967,58.6740);
	//SetPlayerCameraLookAt(playerid, -2608.8828,2256.5967,58.6740);
}

public OnPlayerRequestClass(playerid, classid)
{
	TogglePlayerSpectating(playerid, 1);
	new query[128];
	mysql_format(con, query, sizeof(query), "SELECT * FROM `usuarios` WHERE `Nombre` = '%e'",Nombre(playerid));
	mysql_pquery(con, query, "OnPlayerLogin", "d",playerid);
	SetTimerEx("Camara", 300, false, "d", playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	/*PlayerTextDrawDestroy(playerid, zonas[playerid]);*/
	PlayerTextDrawDestroy(playerid, Textdraw0[playerid]);
	PlayerTextDrawDestroy(playerid, Textdraw1[playerid]);
	PlayerTextDrawDestroy(playerid, Textdraw2[playerid]);
	PlayerTextDrawDestroy(playerid, Textdraw3[playerid]);
	PlayerTextDrawDestroy(playerid, NOTIFICATION_MESSAGE[playerid][0]);
    PlayerTextDrawDestroy(playerid, NOTIFICATION_MESSAGE[playerid][1]);
    PlayerTextDrawDestroy(playerid, NOTIFICATION_MESSAGE[playerid][2]);
    PlayerTextDrawDestroy(playerid, NOTIFICATION_MESSAGE[playerid][3]);
    PlayerTextDrawDestroy(playerid, TD_ping[playerid]);
    PlayerTextDrawDestroy(playerid, TD_packet[playerid]);
    PlayerTextDrawDestroy(playerid, TD_kills[playerid]);
    PlayerTextDrawDestroy(playerid, TD_muertes[playerid]);
	ResetPlayerVariables(playerid);

	if(GetPVarInt(playerid, "Reconnecting") == 1)
    {
        new iStr[30], iP[16];
        GetPVarString(playerid, "RecIP", iP, sizeof(iP));
        printf("%s", iP);
        format(iStr, sizeof(iStr), "unbanip %s", iP);
        SendRconCommand(iStr);
        SendRconCommand("reloadbans");
        SetPVarInt(playerid, "Reconnecting", 0);
    }
	if(GetPVarInt(playerid, "Enviado")==1)
	{
		for(new i=1; i<=ARENAS; i++)
		{
			if(Duelos[i][DesaId] == playerid)
			{
				new frm[128];
				format(frm, 128, "%s salió del servidor, el duelo se auto canceló.",Nombre(Duelos[i][DesaId]));
				SendClientMessage(Duelos[i][DesafiadoId], -1, frm);
				SetPVarInt(Duelos[i][DesafiadoId], "Invitado", INVALID_PLAYER_ID);
				SetPVarInt(Duelos[i][DesaId], "Invitado", INVALID_PLAYER_ID);
				Duelos[i][DesafiadoId] = -1;
				Duelos[i][DesaId] = -1;
				Duelos[i][ArmasId] = -1;
				Duelos[i][Libre] = 0;
				SetPVarInt(playerid, "Enviado", 0);
				KillTimer(timerduelo[playerid]);
				break;
			}
		}
	}
	if(Sancion[playerid])
	{
		KillTimer(TimerSancion2[playerid]);
		KillTimer(TimerSancion[playerid]);
	}
	if(Info[playerid][pCar] != -1) CarDeleter(Info[playerid][pCar]);
	SendDeathMessage(INVALID_PLAYER_ID, playerid, 201);
	foreach(Player,i)
	{
		if(Info[i][AdminNivel] > 1)
		{
			new szDisconnectReason[3][] = { "Timeout/Crash","Quit","Kick/Ban" };
			SendFormattedMessage(i,-1,"%s (%d) Ha salido del servidor %s.",Nombre(playerid),playerid,szDisconnectReason[reason]);
		}
	}
	if (EnDuelo[playerid]==1)
	{
		for (new i=1; i<=ARENAS; i++)
		{
			if ((Duelos[i][DesaId] == playerid || Duelos[i][DesafiadoId] == playerid) && (Duelos[i][Libre]==1))
			{
				Duelos[i][Libre] = 0;
				EnDuelo[Duelos[i][DesaId]] = 0;
				EnDuelo[Duelos[i][DesafiadoId]] = 0;
				if (playerid == Duelos[i][DesaId])
				{
					SetPVarInt(Duelos[i][DesafiadoId], "Invitado", INVALID_PLAYER_ID);
					SetPVarInt(Duelos[i][DesaId], "Invitado", INVALID_PLAYER_ID);
					new string2[128];
					format(string2,sizeof(string2),"%s a abandonado el servidor en medio de un duelo, %s es el ganador por default.",Nombre(playerid),Nombre(Duelos[i][DesafiadoId]));
					SendClientMessageToAll(-1,string2);
					SpawnPlayer(Duelos[i][DesafiadoId]);
					Info[Duelos[i][DesafiadoId]][DuelosGanados]++;
					Info[playerid][DuelosPerdidos]++;
					new str[128];
					foreach(Player,x)
					{
						if(ViendoDuelo[x] == true)
						{
							ViendoDuelo[x] = false;
							TogglePlayerSpectating(x, 0);
							format(str, sizeof(str), "%s Winner", Nombre(Duelos[i][DesafiadoId]));
							GameTextForPlayer(x, str, 3000, 1);
							SpawnPlayer(x);
						}
					}
				}
				if (playerid == Duelos[i][DesafiadoId])
				{

					SetPVarInt(Duelos[i][DesaId], "Invitado", INVALID_PLAYER_ID);
					SetPVarInt(Duelos[i][DesafiadoId], "Invitado", INVALID_PLAYER_ID);
					new string2[128];
					format(string2,sizeof(string2),"%s a abandonado el servidor en medio de un duelo, %s es el ganador por default.",Nombre(playerid),Nombre(Duelos[i][DesaId]));
					SendClientMessageToAll(-1,string2);
					SpawnPlayer(Duelos[i][DesaId]);
					Info[Duelos[i][DesaId]][DuelosGanados]++;
					Info[playerid][DuelosPerdidos]++;
					new str[128];
					foreach(Player,x)
					{
						if(ViendoDuelo[x] == true)
						{
							ViendoDuelo[x] = false;
							TogglePlayerSpectating(x, 0);
							format(str, sizeof(str), "%s Winner", Nombre(Duelos[i][DesaId]));
							GameTextForPlayer(x, str, 3000, 1);
							SpawnPlayer(x);
						}
					}
				}
				Duelos[i][DesaId] = -1;
				Duelos[i][DesafiadoId] = -1;
				Duelos[i][ArmasId] = -1;
				return 1;
			}
		}
	}
	OnPlayerSave(playerid);
	return 1;
}

funcion CargarArmas(playerid)
{
	if(EDCON[playerid]) GivePlayerWeapon(playerid, 27, 99999);
	if(EscopetaON[playerid]) GivePlayerWeapon(playerid, 25, 99999);
	if(M4ON[playerid]) GivePlayerWeapon(playerid, 31, 99999);
	if(MP5ON[playerid]) GivePlayerWeapon(playerid, 29, 99999);
	if(SNIPERON[playerid]) GivePlayerWeapon(playerid, 34, 99999);
	if(RIFLEON[playerid]) GivePlayerWeapon(playerid, 33, 99999);
	if(Info[playerid][ComproChaleco]) SetPlayerArmour(playerid, 100);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	CargarSpawn(playerid);
	SetPlayerHealth(playerid,100);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 24, 99999);
	CargarArmas(playerid);
	SetPlayerTeam(playerid, gTeam[playerid]);
	for(new i,j=MAX_OBJECTS; i<j; i++)
	{
		if(oInfo[playerid][i][used1] == true && oInfo[playerid][i][usando] == 1) SetPlayerAttachedObject(playerid, oInfo[playerid][i][index1], oInfo[playerid][i][modelid1], oInfo[playerid][i][bone1], oInfo[playerid][i][fOffsetX1], oInfo[playerid][i][fOffsetY1], oInfo[playerid][i][fOffsetZ1], oInfo[playerid][i][fRotX1], oInfo[playerid][i][fRotY1], oInfo[playerid][i][fRotZ1], oInfo[playerid][i][fScaleX1], oInfo[playerid][i][fScaleY1], oInfo[playerid][i][fScaleZ1]);
	}
	if(Sancion[playerid] == 1)
	{
		new string[128];
		SetPlayerPos(playerid, 222.7200,110.5350,999.0156);
		SetPlayerInterior(playerid, 10);
		SetPlayerVirtualWorld(playerid, 5);
		if(Info[playerid][SancionTimeS] >= 60) format(string, sizeof(string), "Cumple tu sanción te quedan %d minutos y %d segundos.",Info[playerid][SancionTimeS]/60,(Info[playerid][SancionTimeS] % 60));
		else format(string, sizeof(string), "Cumple tu sanción te quedan %d segundos.",Info[playerid][SancionTimeS]);
		SendClientMessage(playerid, -1, string);
		TimerSancion2[playerid] = SetTimerEx("BajarTiempos", 1000, 1, "d", playerid);
		TimerSancion[playerid] = SetTimerEx("LibreSan", Info[playerid][SancionTimeS]*1000, false, "d", playerid);
		SetPlayerColor(playerid, 0xFFFFFFFF);
	}
	if(GetPVarInt(playerid, "horatmp")!=-1) SetPlayerTime(playerid, GetPVarInt(playerid, "horatmp"), 0);
	else CargarHora(playerid);
	if(God[playerid] == 1) SetPlayerHealth(playerid, 100000);
	if(Info[playerid][Skin] > 0 && Info[playerid][SkinUsando] == 1) SetPlayerSkin(playerid, Info[playerid][Skin]);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{

// DS Heart: spawn heart at victim position when killed by another player
	if (killerid != INVALID_PLAYER_ID && killerid != playerid)
	{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	new vw = GetPlayerVirtualWorld(playerid);
	DS_Heart_Spawn(x, y, z, vw);
	}

	new dinero, formatomuerte22[128];
	if(reason == WEAPON_VEHICLE)
	{
		Sancionar(killerid,"Car Kill",4);
		return 1;
	}
	if(killerid != INVALID_PLAYER_ID)
	{
		Kills[killerid]++;
		Level[killerid]++;
		Kills[playerid] = 0;
		Level[playerid] = 0;
		QuitarCombate(playerid);
		SetPlayerWantedLevel(playerid, Level[playerid]);
		if(!EnDuelo[killerid])
		{
			SendDeathMessage(killerid, playerid, reason);
			SetPlayerWantedLevel(playerid, Level[playerid]);
		}
		SetPlayerScore(killerid, GetPlayerScore(killerid)+1);
		if(Info[killerid][VIP] == 1) Info[killerid][Score]+=1,SetPlayerScore(killerid, GetPlayerScore(killerid)+1);
		Info[killerid][Score]++;
		Info[playerid][Muertes]++;
		switch(reason)
		{
			case WEAPON_DEAGLE:
			{
				if(!Info[killerid][VIP]) dinero = 1000;
				else dinero = 2000;
			}
			case WEAPON_SHOTGUN:
			{
				if(!Info[killerid][VIP]) dinero = 500;
				else dinero = 1500;
			}
			case WEAPON_M4:
			{
				if(!Info[killerid][VIP]) dinero = 500;
				else dinero = 1500;
			}
			case WEAPON_SNIPER:
			{
				if(!Info[killerid][VIP]) dinero = 2500;
				else dinero = 3500;
			}
			case WEAPON_SHOTGSPA:
			{
				if(!Info[killerid][VIP]) dinero = 5000;
				else dinero = 1500;
			}
			case WEAPON_RIFLE:
			{
				if(!Info[killerid][VIP]) dinero = 3000;
				else dinero = 4000;
			}
		}
	 	if(dinero > 0)
		{
			GivePlayerMoney(killerid, dinero);
			format(formatomuerte22,sizeof(formatomuerte22),"~g~+%d$",dinero);
			GameTextForPlayer(killerid, formatomuerte22, 3000, 1);
			Info[killerid][Dinero] += dinero;
		}
		if(EnDuelo[killerid] == 0)
		{
			switch(Kills[killerid])
			{
				case 1..5: SetPlayerWantedLevel(killerid, Level[killerid]);
				case 6:
				{
					SetPlayerWantedLevel(killerid, Level[killerid]);
					SendClientMessage(killerid, -1, "Felicidades, se te ha dado una moneda por llegar a 6 kills.");
					Info[killerid][Coins]++;
				}
			}
		}
	}
	else
	{
		SendDeathMessage(INVALID_PLAYER_ID, playerid, reason);
		Kills[playerid] = 0;
		Level[playerid] = 0;
		SetPlayerWantedLevel(playerid, Level[playerid]);
	}
	if(!EnDuelo[playerid] && !EnEvento[playerid]) tirar_armas(playerid);
	if(EnEvento[playerid] == 1)
	{
		EnEvento[playerid] = 0;
		JugadoresEvento--;
	}
	if (EnDuelo[playerid] == 1 && EnDuelo[killerid] == 1)
	{
		for (new i=1; i<= ARENAS; i++)
		{
			if ((Duelos[i][DesaId] == playerid || Duelos[i][DesaId] == killerid) && (Duelos[i][DesafiadoId] == playerid) || (Duelos[i][DesafiadoId] == killerid))
			{
				new Float:vida,Float:chaleco;
				GetPlayerHealth(killerid, vida);
				GetPlayerArmour(killerid, chaleco);
				new str[128];
				format(str,sizeof(str),"Haz perdido el duelo contra %s",Nombre(killerid));
				SendClientMessage(playerid,-1,str);
				format(str,sizeof(str),"Haz ganado el duelo contra %s",Nombre(playerid));
				SendClientMessage(killerid,-1,str);
				format(str, sizeof(str), "%s Ha ganado el duelo contra %s con %2.0f de salud y %2.0f de chaleco",Nombre(killerid),Nombre(playerid),vida,chaleco);
				SendClientMessageToAll(-1, str);
				GivePlayerMoney(playerid, -GetPVarInt(playerid, "Apuesta"));
				GivePlayerMoney(killerid, GetPVarInt(playerid, "Apuesta"));
				Info[playerid][Dinero]-=GetPVarInt(playerid, "Apuesta");
				Info[killerid][Dinero]+=GetPVarInt(playerid, "Apuesta");
				SetPVarInt(playerid, "Apuesta", 0);
				SetPVarInt(killerid, "Apuesta", 0);
				EnDuelo[playerid] = 0;
				EnDuelo[killerid] = 0;
				Info[killerid][DuelosGanados]++;
				Info[playerid][DuelosPerdidos]++;
				Duelos[i][DesafiadoId] = -1;
				Duelos[i][DesaId] = -1;
				Duelos[i][ArmasId] = -1;
				Duelos[i][Libre] = 0;
				SetTimerEx("TimerDuelo", 4000, false, "d", killerid);
				for(new x=0; x<GetMaxPlayers(); x++)
				{
					if(IsPlayerConnected(x) == 1 && ViendoDuelo[x] == true)
					{
						ViendoDuelo[x] = false;
						TogglePlayerSpectating(x, false);
						format(str, sizeof(str), "%s Winner", Nombre(killerid));
						GameTextForPlayer(x, str, 3000, 1);
						SpawnPlayer(x);
					}
				}
				return 1;
			}
		}
	}
	return 1;
}
forward AnunciarMensajeAutomatico();
public AnunciarMensajeAutomatico()
{
    // 1. Obtiene el número total de mensajes definidos en el array.
    new num_mensajes = sizeof(g_aMensajesAutomaticos);

    // 2. Genera un índice aleatorio entre 0 y (num_mensajes - 1).
    new indice_aleatorio = random(num_mensajes);

    // 3. Envía el mensaje seleccionado a todo el servidor.
    SendClientMessageToAll(0xFFFFFFFF, g_aMensajesAutomaticos[indice_aleatorio]); // El 0xFFFFFFFF es el color por defecto (Blanco) del mensaje del servidor, pero el color real será el que definas con el tag {COLOR} en el array.

    return 1;
}
stock ActualizarArmas(playerid)
{
    // Quitar todas las armas
    ResetPlayerWeapons(playerid);

    // Quitar arma default id 24 por si la GM la da
    GivePlayerWeapon(playerid, 24, 0);
    GivePlayerWeapon(playerid, 24, -1);

    // Dar solo las armas activadas
    if(EscopetaON[playerid]) GivePlayerWeapon(playerid, 25, 99999);
    if(EDCON[playerid])      GivePlayerWeapon(playerid, 27, 99999);
    if(MP5ON[playerid])      GivePlayerWeapon(playerid, 29, 99999);
    if(M4ON[playerid])       GivePlayerWeapon(playerid, 31, 99999);
    if(RIFLEON[playerid])    GivePlayerWeapon(playerid, 33, 99999);
    if(SNIPERON[playerid])   GivePlayerWeapon(playerid, 34, 99999);
}
stock NombreArma(weaponid, name[], len)
{
    switch (weaponid)
    {
        case 24: format(name, len, "DK");
        case 25: format(name, len, "Escopeta");
        case 27: format(name, len, "EDC");
        case 29: format(name, len, "MP5");
        case 31: format(name, len, "M4");
        case 33: format(name, len, "Rifle");
        case 34: format(name, len, "Sniper");
        default: format(name, len, "id: %d", weaponid);
    }
    return 1;
}

stock Float:GetPlayerPacketLoss(playerid)
{
	new stats[401], stringstats[70];
	GetPlayerNetworkStats(playerid, stats, sizeof(stats));
	new len = strfind(stats, "Packetloss: ");
	new Float:packetloss = 0.0;
	if(len != -1)
	{
		strmid(stringstats, stats, len, strlen(stats));
		new len2 = strfind(stringstats, "%");
		if(len != -1)
		{
			strdel(stats, 0, strlen(stats));
			strmid(stats, stringstats, len2-3, len2);
			packetloss = floatstr(stats);
		}
	}
	return packetloss;
}
stock ActualizarTopTD(playerid)
{
    new linea[64];

    // La fuente base de TD_TopLinea es FUCSIA.

    for(new i = 0; i < 5; i++)
    {
        // Formato deseado: (FUCSIA)RANGO.(BLANCO) NOMBRE - (FUCSIA) SCORE

        if (TopScores[i] > 0 || !strcmp(TopNames[i], "-"))
        {
            // i+1 (Rango) es FUCSIA (por defecto)
            // Usamos ~w~ (White) para el nombre.
            // El score volverá a ser FUCSIA (color de la fuente), o seguirá siendo ~w~ si no se resetea.

            format(linea, sizeof(linea), "%d. ~w~%s - %d",
                i + 1,        // Rango (FUCSIA)
                TopNames[i],  // Nombre (BLANCO por ~w~)
                TopScores[i]); // Score (Debe ser FUCSIA, pero depende del cliente)
        }
        else
        {
            format(linea, sizeof(linea), "");
        }

        PlayerTextDrawSetString(playerid, TD_TopLinea[playerid][i], linea);
    }
    return 1;
}

forward OnCargarTopKills();
public OnCargarTopKills()
{
    // === Control de Error de Conexión Perdida (ERROR 2013) ===
    if (cache_num_rows() == 0 && mysql_errno() == 2013) // Verifica si la consulta falló por conexión perdida
    {
        // Si hay error 2013, simplemente salimos del callback sin intentar actualizar los TD vacíos,
        // y esperamos que el Timer en 60s intente la consulta de nuevo.
        return 1;
    }
    // =========================================================

    new rows = cache_num_rows();
    if(rows == 0) return 1;

    new name[24];

    for(new i = 0; i < 5; i++)
    {
        if(i < rows)
        {
            cache_get_value_name(i, "Nombre", name, 24);
            format(TopNames[i], 24, "%s", name);

            cache_get_value_name_int(i, "Score", TopScores[i]);
        }
        else
        {
            format(TopNames[i], 24, "-");
            TopScores[i] = 0;
        }
    }

    // Actualizar los textdraws a todos los jugadores
    foreach(Player, p)
    {
        ActualizarTopTD(p);
    }

    return 1;
}

// Y tu función de consulta vuelve a ser simple:
forward ActualizarTopKills();
public ActualizarTopKills()
{
    // NOTA: EL TIMER YA LLAMA ESTO CADA 60S
    mysql_pquery(con,
        "SELECT Nombre, Score FROM usuarios ORDER BY Score DESC LIMIT 5",
        "OnCargarTopKills");
    return 1;
}

forward Conteo();
public Conteo()
{
	VarConteo--;
 	new celdas[7];
	format(celdas, 7, "%i", VarConteo);
	GameTextForAll(celdas, 1000, 3);
	if(VarConteo == 0)
	{
		KillTimer(VarConteoT);
		GameTextForAll("Go!!", 3000, 3);
		VarConteo = -1;
	}
	return 1;
}
CMD:id(playerid, params[])
{
    new jugador;
    // Leemos un número directamente desde params (ID desde 0 en adelante)
    if(sscanf(params, "r", jugador))
        return SendClientMessage(playerid, -1, "Usa: /id [id]");

    if(!IsPlayerConnected(jugador))
        return SendClientMessage(playerid, GRIS, "No se encontró ningún jugador.");

    // Datos en tiempo real
    new fps = FPS[jugador];
    new ping = GetPlayerPing(jugador);
    new Float:packet = GetPlayerPacketLoss(jugador);

    new string[170];
    format(string, sizeof(string),
        "{cc33ff}nombre:{ffffff} %s {cc33ff}id:{ffffff} %d {cc33ff}fps:{ffffff} %d {cc33ff}ping:{ffffff} %d {cc33ff}packetloss:{ffffff}%.1f%%",
        Nombre(jugador), jugador, fps, ping, packet);

    SendClientMessage(playerid, 0xFFFFFFFF, string);
    return 1;
}
CMD:banlist(playerid)
{
	new rows,Nick[MAX_PLAYER_NAME],ipe[18],utm[10],str[2000];
	mysql_query(con, "SELECT `Nombre`,`Baneado`,`IP` FROM `usuarios` WHERE `Baneado` = '1'");
	rows = cache_num_rows();
	if(rows)
	{
		str = "Nombre\tIP\tLast on\n";
		for(new i=0; i<rows; i++)
		{
			cache_get_value_name(i, "IP", ipe);
			cache_get_value_name(i, "lastOn", utm);
			cache_get_value_name(i, "Nombre", Nick);
			format(str, sizeof(str), "%s%s\t%s\t%s\n",str,Nick,ipe,utm);
		}
		ShowPlayerDialog(playerid, DIALOG_BANEOS, DIALOG_STYLE_TABLIST_HEADERS, "Lista de prohibidos", str,"Cerrar", "");
	}
	return 1;
}

CMD:carid(playerid,params[])
{
	new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "Usa: /carid [vehiculo id]");
	CarSpawner(playerid,id);
	return 1;
}

CMD:carname(playerid,params[])
{
	if(Info[playerid][AdminNivel]<3) return -1;
	new name[30],id;
	if(sscanf(params, "s[30]", name)) return SendClientMessage(playerid, -1, "Usa: /carname [nombre auto]");
	id = GetVehicleModelIDFromName(name);
	CarSpawner(playerid,id);
	return 1;
}

CMD:gang(playerid,params[])
{
	if(Info[playerid][AdminNivel]<5) return -1;
	new d;
	if(sscanf(params, "d", d)) return SendClientMessage(playerid, -1, "Usa: /gang [GangID]");
	Invitado[playerid] = d;
	Owner[playerid] = d;
	return 1;
}

CMD:irpos(playerid, params[])
{
	if(Info[playerid][AdminNivel]<3)return-1;
    new string[75],  Float:X, Float:Y, Float:Z,interior;
    if(sscanf(params, "fffd", Float:X, Float:Y, Float:Z,interior)) return SendClientMessage(playerid, -1, "Usa: /irpos [X-Y-Z-interior]");
    SetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
    SetPlayerInterior(playerid, interior);
    format(string, sizeof string, "Te haz teletransportado a las coordenadas 'X'%f 'Y'%f 'Z'%f", Float:X, Float:Y, Float:Z);
    SendClientMessage(playerid, -1, string);
    return 1;
}

CMD:cevento(playerid)
{
	if(Info[playerid][AdminNivel]<3) return -1;
	foreach(Player,i)
	{
		if(EnEvento[i] && i!=playerid)
		{
			TogglePlayerControllable(i, true);
			SetPVarInt(i, "Congelado", 0);
		}
	}
	return 1;
}
CMD:nocheat(playerid, params[])
{
    if(Info[playerid][AdminNivel] < 7) return -1;
    if(isnull(params) || strval(params) < 0 || strval(params) > 52)
        return SendClientMessage(playerid, -1, "/nocheat [código]");

    new code = strval(params);
    new string[128];

    // Si IsAntiCheatEnabled retorna 0/1 en lugar de bool
    new currentStatus = IsAntiCheatEnabled(code);
    new bool:isEnabled = (currentStatus == 1) ? true : false;

    // Cambiar estado
    EnableAntiCheat(code, !isEnabled); // Prueba con 2 parámetros

    format(string, sizeof(string), "[ANTICHEAT] %s ha %s la protección código (#%03d).",
        Nombre(playerid),
        (!isEnabled) ? ("habilitado") : ("deshabilitado"),
        code);

    MensajeParaAdmins(MORADO, string);

    return 1;
}
CMD:dcevento(playerid)
{
	if(Info[playerid][AdminNivel]<3) return -1;
	for(new i=0;i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && EnEvento[i] && i!=playerid)
		{
			TogglePlayerControllable(i, false);
			SetPVarInt(i, "Congelado", 1);
		}
	}
	return 1;
}

CMD:earmas(playerid)
{
	if(Info[playerid][AdminNivel]<3) return -1;
	for(new i=0;i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && EnEvento[i])
		{
			ResetPlayerWeapons(i);
		}
	}
	return 1;
}

CMD:reconectar(playerid, const params[])
{
	if(Info[playerid][AdminNivel]<3) return -1;
    new pIP[16],iStr[25],id;
    if(sscanf(params, "r", id)) return SendClientMessage(playerid, 0xFF0000FF, "Usa: /Reconectar [Id/Nombre]");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "Jugador no conectado");
    GetPlayerIp(id, pIP, sizeof(pIP));
    SetPVarInt(id, "Reconnecting", 1);
    SetPVarString(id, "RecIP", pIP);
    format(iStr, sizeof(iStr), "banip %s", pIP);
    SendRconCommand(iStr);
    SendClientMessage(id, 0x008080FF, "Reconectando, espera...");
    return 1;
}

CMD:oevento(playerid)
{
	if(Info[playerid][AdminNivel]<3) return -1;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && EnEvento[i])
		{
			SetPlayerColor(i, 0xFFFFFFFF);
		}
	}
	return 1;
}

CMD:interiors(playerid)
{
	if(Info[playerid][AdminNivel]<3) return -1;
	ShowPlayerDialog(playerid, DIALOG_INTERIORS, DIALOG_STYLE_LIST, "Interiores", "Planning Department\nLVPD\nPizza Stack\nRC Battlefield\nCaligula's Casino\nBig Smoke's Crack Palace\nMadd Dogg's Mansion\nDirtbike Stadium\nVice Stadium\nAmmunation\nAtrium", "Select", "Cerrar");
	return 1;
}

CMD:i(playerid)
{
	if(!strcmp(Nombre(playerid), "Dkyzer", true)) SetPlayerInterior(playerid, 1);
	return 1;
}

CMD:asay(playerid, params[])
{
 	if(Info[playerid][AdminNivel] < 6) return -1;
	if(isnull(params)) return SendClientMessage(playerid, GRIS, "Usa: /asay [text]");
	new string[128];
	format(string, sizeof(string), "** Admin %s: %s", Nombre(playerid), params);
	SendClientMessageToAll(orange, string);
	return 1;
}

CMD:renovarvip(playerid)
{
	if(Info[playerid][VIP] == 0) return SendClientMessage(playerid, -1, "Debes tener cuenta vip para usar este comando");
	if(Info[playerid][Coins]<40) return SendClientMessage(playerid, -1, "Necesitas tener 40 monedas para renovar");
	Info[playerid][VIP_EXPIRE]+=2592000;
	new dia,mes,ano,hora,minuto,segundo,ns[340],year,month,day,hour,minute;
	getdate(year, month, day);
	gettime(hour, minute);
	TimestampToDate(Info[playerid][VIP_EXPIRE],ano,mes,dia,hora,minuto,segundo,0,0);
	format(ns, sizeof ns, "{ffffff}Haz renovado tu cuenta vip ahora la fecha de expiración es la siguiente:\n\n Dia: %d Mes: %d (%s) Año: %d\nHora: %d Minuto: %d Segundo: %d\n\nFecha actual: %d/%d (%s) /%d %d:%d",
	dia,mes,GetMonth(mes),ano,hora,minuto,segundo,day,month,GetMonth(month),year,hour,minute);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Renovación VIP", ns, "Cerrar", "");
	Info[playerid][Coins]-=40;
	return 1;
}

CMD:random(playerid)
{
	if(Tiempo_Random[playerid] > gettime()) return SendClientMessage(playerid, -1, "Solo puedes volver a usar este comando en 7 horas.");
	Tiempo_Random[playerid] = gettime()+25200;
	new Query[128];
	mysql_format(con, Query, 128, "UPDATE `usuarios` SET `RANDOM_TIME` = '%d' WHERE `Nombre` = '%s'",Tiempo_Random[playerid],Nombre(playerid));
	mysql_query(con, Query);
	new variable;
	switch(random(9))
	{
		case 0:
		{
			Info[playerid][Dinero]+=10000;
			GivePlayerMoney(playerid, 10000);
		}
		case 1:
		{
			variable = 1;
			Info[playerid][Dinero]+=25000;
			GivePlayerMoney(playerid, 25000);
		}
		case 2:
		{
			variable = 2;
			Info[playerid][Dinero]+=50000;
			GivePlayerMoney(playerid, 50000);
		}
		case 3:
		{
			variable = 3;
			Info[playerid][Dinero]+=65000;
			GivePlayerMoney(playerid, 65000);
		}
		case 4:
		{
			variable = 4;
			Info[playerid][Score]+=5;
			SetPlayerScore(playerid, GetPlayerScore(playerid)+5);
		}
		case 5:
		{
			variable = 5;
			Info[playerid][Score]+=10;
			SetPlayerScore(playerid, GetPlayerScore(playerid)+10);
		}
		case 6:
		{
			variable = 6;
			Info[playerid][Score]+=25;
			SetPlayerScore(playerid, GetPlayerScore(playerid)+25);
		}
		case 7:
		{
			variable = 7;
			Info[playerid][Score]+=50;
			SetPlayerScore(playerid, GetPlayerScore(playerid)+50);
		}
		case 8:
		{
			variable = 8;
			Info[playerid][Coins]+=2;
		}
	}
	switch(variable)
	{
		case 0: SendClientMessage(playerid, AMARILLO, "Felicidades... {3e9c35}10.000$!");
		case 1: SendClientMessage(playerid, AMARILLO, "Felicidades... {3e9c35}25.000${ffffff}!");
		case 2: SendClientMessage(playerid, AMARILLO, "Felicidades... {3e9c35}50.000${ffffff}!");
		case 3: SendClientMessage(playerid, AMARILLO, "Felicidades... {3e9c35}65.000${ffffff}!");
		case 4: SendClientMessage(playerid, AMARILLO, "Felicidades... "warning"5 Score{ffffff}!");
		case 5: SendClientMessage(playerid, AMARILLO, "Felicidades... "warning"10 Score{ffffff}!");
		case 6: SendClientMessage(playerid, AMARILLO, "Felicidades... "warning"25 Score{ffffff}!");
		case 7: SendClientMessage(playerid, AMARILLO, "Parece que estás de suerte! "warning"50 Score{ffffff}!");
		case 8: SendClientMessage(playerid, AMARILLO, "Muy bien! "warning"2 Monedas{ffffff}!");
	}
	return 1;
}

CMD:quitarvip(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 6) return -1;
	new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "Usa: /quitarvip [id]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "Jugador no conectado");
	Info[id][VIP] = 0;
	return 1;
}

CMD:expirav(playerid)
{
	if(Info[playerid][VIP] == 0) return SendClientMessage(playerid, -1, "Debes tener cuenta vip para usar este comando");
	new dia,mes,ano,hora,minuto,segundo,string[320],hour,minute,year,month,day;
	TimestampToDate(Info[playerid][VIP_EXPIRE],ano,mes,dia,hora,minuto,segundo,0,0);
	gettime(hour, minute);
	getdate(year, month, day);
	format(string, sizeof(string), "{ffffff}Fecha de expiración de tu cuenta VIP:\n\nExpira en %d/%d (%s) /%d %d:%d:%d\n\n Fecha actual: %d/%d (%s) /%d %d:%d",dia,mes,GetMonth(mes),ano,hora,minuto,segundo,day,month,GetMonth(month),year,hour,minute);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Fecha de expiración", string, "Cerrar", "");
	return 1;
}

CMD:tiempo(playerid,params[])
{
	if(Sancion[playerid] == 0) return 1;
	VerTiempos(playerid,playerid);
	return 1;
}

CMD:banm(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new id,dias,rason[20],dai,mes,anio,hour,minute;
	if(sscanf(params, "rds[20]", id,dias,rason)) return SendClientMessage(playerid, -1, "Usa: /banm [id/nombre] [minutos] [razón]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "Jugador no conectado");
	getdate(anio, mes, dai);
	gettime(hour, minute);
	new query[320];
	mysql_format(con, query, sizeof query, "INSERT INTO `ipsban` (`IP`,`Minutos`,`UNIX`,`Razon`,`banby`,`bandate`,`banhour`) VALUES ('%s','%d','%d','%s','%s','%d/%d/%d','%d:%d')",ReturnIP(id),dias,(dias*60)+gettime(),rason,Nombre(playerid),dai,mes,anio,hour,minute);
	mysql_query(con, query);
	format(query, 128, "El %s %s ha baneado a {ff0000}%s{ffffff} por {ff0000}%d {ffffff}minutos, razón: {ff0000}%s{ffffff}.",Rango(playerid),Nombre(playerid),Nombre(id),dias,rason);
	SendClientMessageToAll(-1, query);
	SetTimerEx("Kickear", 300, false, "d", id);
	return 1;
}

CMD:band(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 5) return -1;
	new id,dias,rason[20],dai,mes,anio,hour,minute;
	if(sscanf(params, "rds[20]", id,dias,rason)) return SendClientMessage(playerid, -1, "Usa: /band [id/nombre] [dias] [razón]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "Jugador no conectado");
	getdate(anio, mes, dai);
	GetPlayerTime(playerid, hour, minute);
	new query[270];
	mysql_format(con, query, sizeof query, "INSERT INTO `ipsban` (`IP`,`Dias`,`UNIX`,`Razon`,`banby`,`bandate`,`banhour`) VALUES ('%s','%d','%d','%s','%s','%d/%d/%d','%d:%d')",ReturnIP(id),dias,(dias*86400)+gettime(),rason,Nombre(playerid),dai,mes,anio,hour,minute);
	mysql_query(con, query);
	format(query, 128, "El %s %s ha baneado a {ff0000}%s{ffffff} por {ff0000}%d {ffffff}días, razón: {ff0000}%s{ffffff}.",Rango(playerid),Nombre(playerid),Nombre(id),dias,rason);
	SendClientMessageToAll(-1, query);
	SetTimerEx("Kickear", 300, false, "d", id);
	return 1;
}

CMD:earma(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new weaponid;
	if(sscanf(params, "d", weaponid)) return SendClientMessage(playerid, -1, "Usa: /earma [arma id]");
	for(new i=0,j=GetMaxPlayers(); i<j; i++)
	{
		if(IsPlayerConnected(i) && EnEvento[i] == 1)
		{
			ResetPlayerWeapons(i);
			GivePlayerWeapon(i, weaponid, 99999);
		}
	}
	return 1;
}

CMD:eauto(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new vehicleid;
	if(sscanf(params, "d", vehicleid)) return SendClientMessage(playerid, -1, "Usa: /eauto [autoid]");
	for(new i=0,j=GetMaxPlayers(); i<j; i++)
	{
		if(IsPlayerConnected(i) && EnEvento[i] == 1)
		{
			CarSpawner(i,vehicleid);
		}
	}
	return 1;
}

CMD:echaleco(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new Float:vida;
	if(sscanf(params, "f", vida)) return SendClientMessage(playerid, -1, "Usa: /echaleco [cantidad]");
	for(new i=0,j=GetMaxPlayers(); i<j; i++)
	{
		if(IsPlayerConnected(i) && EnEvento[i] == 1)
		{
			SetPlayerArmour(i, vida);
		}
	}
	return 1;
}

CMD:evida(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new Float:vida;
	if(sscanf(params, "f", vida)) return SendClientMessage(playerid, -1, "Usa: /evida [cantidad]");
	for(new i=0,j=GetMaxPlayers(); i<j; i++)
	{
		if(IsPlayerConnected(i) && EnEvento[i] == 1)
		{
			SetPlayerHealth(i, vida);
		}
	}
	return 1;
}

CMD:traerevento(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new aidi;
	if(sscanf(params, "r", aidi)) return SendClientMessage(playerid, -1, "Usa: /traerevento [id/nombre]");
	if(!IsPlayerConnected(aidi)) return SendClientMessage(playerid, GRIS, "El jugador no está conectado");
	EnEvento[aidi] = 1;
	SetPlayerPos(aidi, ex+1, ey, ez+0.5);
	SetPlayerInterior(aidi, Evento[Interior]);
	SetPlayerVirtualWorld(aidi, Evento[VirtualWorld]);
	return 1;
}

CMD:finevento(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new aidi,anuncio[25];
	if(sscanf(params, "r", aidi)) return SendClientMessage(playerid, -1, "Usa: /finevento [id/nombre del ganador]");
	if(!IsPlayerConnected(aidi)) return SendClientMessage(playerid, GRIS, "El jugador no está conectado");
	if(EnEvento[aidi] == 0) return SendClientMessage(playerid, GRIS, "El jugador no está en evento");
	SendFormattedMessageToAll(-1,"El evento %s ha finalizado el ganador es %s",Evento[NombreEvento],Nombre(aidi));
	format(anuncio, 25, "Winner %s",Nombre(aidi));
	GameTextForAll(anuncio, 3500, 0);
	if(Evento[EnCurso] == 1)
	{
		Evento[EnCurso] = 0;
		Evento[Abierto] = 0;
		JugadoresEvento=0;
	}
	foreach(Player,i)
	{
		PlayerTextDrawHide(i, NOTIFICATION_MESSAGE[i][3]);
	}
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && EnEvento[i] == 1)
		{
			EnEvento[i] = 0;
			SpawnPlayer(i);
		}
	}
	return 1;
}

CMD:crearevento(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	if(Evento[EnCurso] == 1) return SendClientMessage(playerid, -1, "Ya hay un evento en curso");
	new nameevento[20],string[128];
	if(sscanf(params, "s[20]", nameevento)) return SendClientMessage(playerid, -1, "Usa: /crearevento [nombre evento]");
	new AdmRank[25];
	switch(Info[playerid][AdminNivel])
	{
		case 1: AdmRank = "Youtuber";
		case 2: AdmRank = "Ayudante";
		case 3: AdmRank = "Moderador";
		case 4: AdmRank = "Moderador Global";
		case 5: AdmRank = "Moderador Técnico";
		case 6: AdmRank = "Administrador";
		case 7: AdmRank = "Fundador";
	}
	format(Evento[NombreEvento], 24, "%s", nameevento);
	format(string, 128, "El %s %s inició el Evento %s espera que se abra para participar",AdmRank,Nombre(playerid),nameevento);
	GetPlayerPos(playerid, ex, ey, ez);
	Evento[Interior] = GetPlayerInterior(playerid);
	Evento[VirtualWorld] = GetPlayerVirtualWorld(playerid);
	Evento[EnCurso] = 1;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SendClientMessage(i, -1, ""CHICLE" 	 ==============================-======================================== 	 "),
			SendClientMessage(i, -1, string),SendClientMessage(i, -1, ""CHICLE" 	 ==============================-======================================== 	 ");
		}
    }
	return 1;
}

CMD:uevento(playerid,params[])
{
	new str[128],count;
	str = "Nombre\tID\n";
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(EnEvento[i])
			{
				count++;
				format(str, sizeof(str), "%s%s\t(%d)\n",str,Nombre(i),i);
			}
		}
	}
	if(count==0) return SendClientMessage(playerid, -1, "No se encontraron jugadores en evento");
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "Lista de usuaros en evento", str, "Cerrar", "");
	return 1;
}

CMD:salir(playerid)
{
	if(EnEvento[playerid] == 1)
	{
		SpawnPlayer(playerid);
		JugadoresEvento--;
		EnEvento[playerid] = 0;
		SendClientMessage(playerid, -1, "Haz salido del evento");
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && Info[playerid][AdminNivel] >= 3)
			{
				SendFormattedMessage(i,-1,"%s (%d) Salió del evento quedan %d",Nombre(playerid),playerid,JugadoresEvento);
			}
		}
		return 1;
	}
	return SendClientMessage(playerid, -1, "No estás en evento");
}

CMD:cerrarevento(playerid)
{
	if(Info[playerid][AdminNivel] <3)return -1;
	if(Evento[EnCurso] == 0) return SendClientMessage(playerid, -1, "No has creado un evento");
	new AdmRank[25];
	switch(Info[playerid][AdminNivel])
	{
		case 1: AdmRank = "Youtuber";
		case 2: AdmRank = "Ayudante";
		case 3: AdmRank = "Moderador";
		case 4: AdmRank = "Moderador Global";
		case 5: AdmRank = "Moderador Técnico";
		case 6: AdmRank = "Administrador";
		case 7: AdmRank = "Fundador";
	}
	Evento[Abierto] = 0;
	new str[128];
	format(str, 128, "El %s %s cerró el evento %s ya no podrán unirse más",AdmRank,Nombre(playerid),Evento[NombreEvento]);
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SendClientMessage(i, -1, ""CHICLE" 	 ==============================-======================================== 	 ");
    		SendClientMessage(i, -1, str);
    		SendClientMessage(i, -1, ""CHICLE" 	 ==============================-======================================== 	 ");
    		PlayerTextDrawHide(i, NOTIFICATION_MESSAGE[i][3]);
		}
	}
	Evento[Abierto] = 2;
	return 1;
}

CMD:eequipo(playerid)
{
	if(Info[playerid][AdminNivel] <3)return -1;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && EnEvento[i])
		{
			SetPlayerTeam(i, NO_TEAM);
		}
	}
	return 1;
}

CMD:abrirevento(playerid)
{
	if(Info[playerid][AdminNivel] <3)return -1;
	if(Evento[EnCurso] == 0) return SendClientMessage(playerid, -1, "No has creado un evento");
	new str[128];
	format(str, 128, "Evento ~g~~h~%s ~w~abierto! usa ~g~~h~/irevento~w~ para participar", Evento[NombreEvento]);
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			PlayerTextDrawSetString(i,NOTIFICATION_MESSAGE[i][3], str);
		    PlayerTextDrawShow(i,NOTIFICATION_MESSAGE[i][3]);
		}
	}
	Evento[Abierto] = 1;
    return 1;
}

CMD:irevento(playerid)
{
	if(EnEvento[playerid] == 1) return SendClientMessage(playerid, -1, "Ya estás en el evento");
	if(Evento[EnCurso] == 0) return SendClientMessage(playerid, -1, "No hay evento iniciado actualmente");
	if(Evento[Abierto] == 2)
	{
		SendFormattedMessage(playerid,-1,"El evento %s ya está cerrado.",Evento[NombreEvento]);
		return 1;
	}
	else if(Evento[Abierto] == 0)
	{
		SendFormattedMessage(playerid,-1,"El evento %s todavía no ha abierto.",Evento[NombreEvento]);
		return 1;
	}
	SetCameraBehindPlayer(playerid);
	SetPlayerPos(playerid, ex+1, ey, ez+0.5);
	SetPlayerInterior(playerid, Evento[Interior]);
	SetPlayerVirtualWorld(playerid, Evento[VirtualWorld]);
	JugadoresEvento++;
	EnEvento[playerid] = 1;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i) && Info[i][AdminNivel] >= 3)
		{
			SendFormattedMessage(i,-1,"El participante %s (%d) se unió al evento, en total %d personas",Nombre(playerid),playerid,JugadoresEvento);
		}
	}
	return 1;
}

CMD:svrconfig(playerid)
{
	if(Info[playerid][AdminNivel]<5)return-1;
	new string[350];
	format(string, sizeof(string), "Opción\tEstado\nAnti-Cbug (Global)\t%s\nCambio de nombre (Global)\t%s\nDuelos (Global)\t%s\nChat (Global)\t%s",CBUG_DISABLED == 1 ? ("{FF0000}OFF"):("{00FF00}ON"),NombreI == 1 ? ("{FF0000}OFF"):("{00FF00}ON"),DuelosOff == 1 ?("{FF0000}OFF"):("{00ff00}ON"),ServerInfo[DisableChat] == 1 ?("{FF0000}OFF"):("{00FF00}ON"));
	ShowPlayerDialog(playerid, SVRCONFIG, DIALOG_STYLE_TABLIST_HEADERS, "Configuarción del servidor", string, "oc", "Cerrar");
	return 1;
}

CMD:voz(playerid,params[])
{
	#pragma unused params
	if(Info[playerid][AdminNivel] >= 4)
	{
		ShowPlayerDialog(playerid,loquendoVoz,DIALOG_STYLE_INPUT,"{ffffff}Voz masculina","{FF8000}Escribe el texto que quieres que todos escuchen en el espacio de abajo","Reproducir","Cancelar");
		PlayerPlaySound(playerid, 1058 , 0.0, 0.0, 0.0);
	}
	else return -1;
	return 1;
}

CMD:vozfem(playerid,params[])
{
	if(Info[playerid][AdminNivel] >= 4)
	{
		ShowPlayerDialog(playerid,loquendoVoz2,DIALOG_STYLE_INPUT,"{ffffff}Voz femenina","{FF8000}Escribe el texto que quieres que todos escuchen en el espacio de abajo","Reproducir","Cancelar");
		PlayerPlaySound(playerid, 1058 , 0.0, 0.0, 0.0);
	}
	else return -1;
	return 1;
}

CMD:flip(playerid)
{
	if(Info[playerid][VIP] ==0) return SendClientMessage(playerid, -1, "Comando solo para miembros VIP");
	if(IsPlayerInAnyVehicle(playerid) || (GetPlayerState(playerid) == PLAYER_STATE_DRIVER))
	{
		new veh;
		new Float:angle;
		veh = GetPlayerVehicleID(playerid);
		GetVehicleZAngle(veh, angle);
		SetVehicleZAngle(veh, angle);
		new vid = GetPlayerVehicleID(playerid);
		RepairVehicle(vid);
		SendClientMessage(playerid,-1,"Tu auto ha sido flipeado y reparado");
	}
	else return SendClientMessage(playerid, -1, "Debes estar en un vehiculo para usar /flip");
	return 1;
}

CMD:ayudavip(playerid)
{
    new str[1800];
    str[0] = '\0'; // limpiar el string antes de concatenar

    strcat(str, "{FFD103}========== AYUDA VIP ==========\n\n");
    strcat(str, "{FFFFFF}Como miembro {FFD103}VIP{FFFFFF} obtienes ventajas exclusivas:\n\n");
    strcat(str, "{FFD103}* {FFFFFF}Ganas 2 score por cada kill.\n");
    strcat(str, "{FFD103}* {FFFFFF}Reparas tu auto pulsando la tecla {FFD103}Y{FFFFFF}.\n");
    strcat(str, "{FFD103}* {FFFFFF}Tener nitro en los autos usando {FFD103}click{FFFFFF}.\n");
    strcat(str, "{FFD103}* {FFFFFF}Restablecer tu auto con {FFD103}/flip{FFFFFF}.\n");
    strcat(str, "{FFD103}* {FFFFFF}Chat Privado VIP: ![Texto]\n");
    strcat(str, "{FFD103}* {FFFFFF}Cambiar tu skin con {FFD103}/skin{FFFFFF}.\n");
    strcat(str, "{FFD103}* {FFFFFF}Tener autos tuneados: {FFD103}/tauto{FFFFFF}.\n");
    strcat(str, "{FFD103}* {FFFFFF}Ganas $1000 por kill con Deagle.\n");
    strcat(str, "{FFD103}* {FFFFFF}Usar el comando {FFD103}/tienda{FFFFFF} en cualquier lugar.\n\n");
    strcat(str, "{AAAAAA}Estas ventajas se actualizarán constantemente.\n");
    strcat(str, "{FFD103}================================");

    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{FFD103}AYUDA VIP", str, "Cerrar", "");
    return 1;
}


CMD:darauto(playerid,params[])
{
	if(Info[playerid][AdminNivel]<3)return -1;
	new vehicleid,id;
	if(sscanf(params, "dd", id,vehicleid)) return SendClientMessage(playerid, -1, "Usa: /darauto [id] [vehicleid]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, GRIS, "El jugador no está conectado");
	SendFormattedMessage(playerid,-1,"Le diste un auto id %d a %s",vehicleid,Nombre(id));
	CarSpawner(id,vehicleid);
	return 1;
}

CMD:timeall(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 4) return -1;
	new hour;
	if(sscanf(params, "d", hour)) return SendClientMessage(playerid, GRIS, "Usa: /timeall [hora]");
	SetPlayerTime(playerid, hour, 0);
	SetPVarInt(playerid, "horatmp", hour);
	return 1;
}

CMD:conteo(playerid, params[])
{
	if(Info[playerid][AdminNivel] < 1) return-1;
    if(VarConteo == -1)
    {
        VarConteo = 6; // este empezará desde el cuatro..
        VarConteoT = SetTimer("Conteo", 1000, true); // lo ponemos "true" para que repita cada segundo.
        SendClientMessage(playerid, -1, "Empezaste un conteo");
    }
    else return SendClientMessage(playerid,-1,"Conteo en proceso...");
    return 1;
}


CMD:gc(playerid)
{
	if(Info[playerid][AdminNivel] < 6) return -1;
	new players;
 	for(new i=0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			OnPlayerSave(i);
			players++;
		}
	}
 	SendFormattedMessage(playerid,-1,"Se han guardado %d cuentas",players);
	return 1;
}

CMD:tauto(playerid,params[])
{
if(EnCombate[playerid]) return SendClientMessage(playerid, -1, "No puedes usar Vehículos estando en combate.");
if(Info[playerid][AdminNivel] > 4 || Info[playerid][VIP] == 1)
{
new msg[144];
format(msg, sizeof msg, "{FFD700}%s {FFFFFF}usuario {FFD700}VIP{FFFFFF} creó un coche tunning.", Nombre(playerid));
SendClientMessageToAll(-1, msg);
new tautoid;
if(sscanf(params, "d", tautoid)) return SendClientMessage(playerid, -1, "Usa: /tauto [1-10]");
if(tautoid == 1) {
if(Info[playerid][pCar] != 0) DestroyVehicle(Info[playerid][pCar]);
new Float:X,Float:Y,Float:Z,Float:ROT,cochet;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle (playerid,ROT);
cochet = Info[playerid][pCar] = CreateVehicle( 560,X,Y,Z,ROT,3,0,20);
PutPlayerInVehicle(playerid,cochet,0);
AddVehicleComponent(cochet, 1028);	AddVehicleComponent(cochet, 1030);	AddVehicleComponent(cochet, 1031);	AddVehicleComponent(cochet, 1138);	AddVehicleComponent(cochet, 1140);  AddVehicleComponent(cochet, 1170);
AddVehicleComponent(cochet, 1028);	AddVehicleComponent(cochet, 1030);	AddVehicleComponent(cochet, 1031);	AddVehicleComponent(cochet, 1138);	AddVehicleComponent(cochet, 1140);  AddVehicleComponent(cochet, 1170);
AddVehicleComponent(cochet, 1080);	AddVehicleComponent(cochet, 1086); AddVehicleComponent(cochet, 1087); AddVehicleComponent(cochet, 1010);
PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
ChangeVehiclePaintjob(cochet,1);
SetVehicleVirtualWorld(cochet, GetPlayerVirtualWorld(playerid));
LinkVehicleToInterior(cochet, GetPlayerInterior(playerid));
} else if(tautoid == 2) {
if(Info[playerid][pCar] != 0) DestroyVehicle(Info[playerid][pCar]);
new Float:X,Float:Y,Float:Z,Float:ROT,cochet;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle (playerid,ROT);
cochet = Info[playerid][pCar] = CreateVehicle( 560,X,Y,Z,ROT,3,0,20);
PutPlayerInVehicle(playerid,cochet,0);
AddVehicleComponent(cochet, 1028);	AddVehicleComponent(cochet, 1030);	AddVehicleComponent(cochet, 1031);	AddVehicleComponent(cochet, 1138);	AddVehicleComponent(cochet, 1140);  AddVehicleComponent(cochet, 1170);
AddVehicleComponent(cochet, 1080);	AddVehicleComponent(cochet, 1086); AddVehicleComponent(cochet, 1087); AddVehicleComponent(cochet, 1010);
PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
ChangeVehiclePaintjob(cochet,2);
SetVehicleVirtualWorld(cochet, GetPlayerVirtualWorld(playerid));
LinkVehicleToInterior(cochet, GetPlayerInterior(playerid));
} else if(tautoid == 3) {
if(Info[playerid][pCar] != 0) DestroyVehicle(Info[playerid][pCar]);
new Float:X,Float:Y,Float:Z,Float:ROT,cochet;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle (playerid,ROT);
cochet = Info[playerid][pCar] = CreateVehicle( 559,X,Y,Z,ROT,3,0,20);
PutPlayerInVehicle(playerid,cochet,0);
AddVehicleComponent(cochet,1065); AddVehicleComponent(cochet,1067); AddVehicleComponent(cochet,1162);
AddVehicleComponent(cochet,1010); AddVehicleComponent(cochet,1073);
PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
ChangeVehiclePaintjob(cochet,1);
SetVehicleVirtualWorld(cochet, GetPlayerVirtualWorld(playerid));
LinkVehicleToInterior(cochet, GetPlayerInterior(playerid));
} else if(tautoid == 4) {
if(Info[playerid][pCar] != 0) DestroyVehicle(Info[playerid][pCar]);
new Float:X,Float:Y,Float:Z,Float:ROT,cochet;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle (playerid,ROT);
cochet = Info[playerid][pCar] = CreateVehicle( 565,X,Y,Z,ROT,3,0,20);
PutPlayerInVehicle(playerid,cochet,0);
AddVehicleComponent(cochet,1046);
AddVehicleComponent(cochet,1049); AddVehicleComponent(cochet,1053);
AddVehicleComponent(cochet,1010); AddVehicleComponent(cochet,1073);
PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
ChangeVehiclePaintjob(cochet,1);
SetVehicleVirtualWorld(cochet, GetPlayerVirtualWorld(playerid));
LinkVehicleToInterior(cochet, GetPlayerInterior(playerid));
} else if(tautoid == 5) {
if(Info[playerid][pCar] != 0) DestroyVehicle(Info[playerid][pCar]);
new Float:X,Float:Y,Float:Z,Float:ROT,cochet;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle (playerid,ROT);
cochet = Info[playerid][pCar] = CreateVehicle( 558,X,Y,Z,ROT,3,0,20);
PutPlayerInVehicle(playerid,cochet,0);
AddVehicleComponent(cochet,1088); AddVehicleComponent(cochet,1092);
AddVehicleComponent(cochet,1139); AddVehicleComponent(cochet,1010);
AddVehicleComponent(cochet,1073);
PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
ChangeVehiclePaintjob(cochet,1);
SetVehicleVirtualWorld(cochet, GetPlayerVirtualWorld(playerid));
LinkVehicleToInterior(cochet,
GetPlayerInterior(playerid));
} else if(tautoid == 6) {
if(Info[playerid][pCar] != 0) DestroyVehicle(Info[playerid][pCar]);
new Float:X,Float:Y,Float:Z,Float:ROT,cochet;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle (playerid,ROT);
cochet = Info[playerid][pCar] = CreateVehicle( 560,X,Y,Z,ROT,3,0,20);
PutPlayerInVehicle(playerid,cochet,0);
AddVehicleComponent(cochet, 1087); AddVehicleComponent(cochet, 1010);
AddVehicleComponent(cochet, 1138); AddVehicleComponent(cochet, 1170);
AddVehicleComponent(cochet, 1030); AddVehicleComponent(cochet, 1028);
AddVehicleComponent(cochet, 1170); AddVehicleComponent(cochet, 1031);
AddVehicleComponent(cochet, 1080); AddVehicleComponent(cochet, 1140);
AddVehicleComponent(cochet, 1086); AddVehicleComponent(cochet, 1028);
AddVehicleComponent(cochet, 1030);	AddVehicleComponent(cochet, 1031);
AddVehicleComponent(cochet, 1140); AddVehicleComponent(cochet, 1138);
PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
ChangeVehiclePaintjob(cochet,0);
SetVehicleVirtualWorld(cochet,GetPlayerVirtualWorld(playerid));
LinkVehicleToInterior(cochet,GetPlayerInterior(playerid));
} else if(tautoid == 7) {
if(Info[playerid][pCar] != 0) DestroyVehicle(Info[playerid][pCar]);
new Float:X,Float:Y,Float:Z,Float:ROT,cochet;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle (playerid,ROT);
cochet = Info[playerid][pCar] = CreateVehicle( 562,X,Y,Z,ROT,3,0,20);
PutPlayerInVehicle(playerid,cochet,0);
AddVehicleComponent(cochet,1034); AddVehicleComponent(cochet,1038);
AddVehicleComponent(cochet,1147); AddVehicleComponent(cochet,1010);
AddVehicleComponent(cochet,1073);
PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
ChangeVehiclePaintjob(cochet,1);
SetVehicleVirtualWorld(cochet, GetPlayerVirtualWorld(playerid));
LinkVehicleToInterior(cochet, GetPlayerInterior(playerid));
} else if(tautoid == 8) {
if(Info[playerid][pCar] != 0) DestroyVehicle(Info[playerid][pCar]);
new Float:X,Float:Y,Float:Z,Float:ROT,cochet;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle (playerid,ROT);
cochet = Info[playerid][pCar] = CreateVehicle( 535,X,Y,Z,ROT,3,0,20);
PutPlayerInVehicle(playerid,cochet,0);
ChangeVehiclePaintjob(cochet,1); AddVehicleComponent(cochet,1109);
AddVehicleComponent(cochet,1115); AddVehicleComponent(cochet,1117);
AddVehicleComponent(cochet,1073); AddVehicleComponent(cochet,1010);
AddVehicleComponent(cochet,1087); AddVehicleComponent(cochet,1114);
AddVehicleComponent(cochet,1081); AddVehicleComponent(cochet,1119);
AddVehicleComponent(cochet,1121);
PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
SetVehicleVirtualWorld(cochet, GetPlayerVirtualWorld(playerid));
LinkVehicleToInterior(cochet, GetPlayerInterior(playerid));
} else if(tautoid == 9) {
if(Info[playerid][pCar] != 0) DestroyVehicle(Info[playerid][pCar]);
new Float:X,Float:Y,Float:Z,Float:ROT,cochet;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle (playerid,ROT);
cochet = Info[playerid][pCar] = CreateVehicle( 558,X,Y,Z,ROT,3,0,20);
PutPlayerInVehicle(playerid,cochet,0);
AddVehicleComponent(cochet,1092); AddVehicleComponent(cochet,1166);
AddVehicleComponent(cochet,1165); AddVehicleComponent(cochet,1090);
AddVehicleComponent(cochet,1094); AddVehicleComponent(cochet,1010);
AddVehicleComponent(cochet,1087); AddVehicleComponent(cochet,1163);
AddVehicleComponent(cochet,1091);
PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
ChangeVehiclePaintjob(cochet,2);
SetVehicleVirtualWorld(cochet, GetPlayerVirtualWorld(playerid));
LinkVehicleToInterior(cochet, GetPlayerInterior(playerid));
} else if(tautoid == 10) {
if(tautoid == 10) DestroyVehicle(Info[playerid][pCar]);
new Float:X,Float:Y,Float:Z,Float:ROT,cochet;
GetPlayerPos(playerid,X,Y,Z);
GetPlayerFacingAngle (playerid,ROT);
cochet = Info[playerid][pCar] = CreateVehicle( 562,X,Y,Z,ROT,3,0,20);
PutPlayerInVehicle(playerid,cochet,0);
AddVehicleComponent(cochet,1034); AddVehicleComponent(cochet,1038);
AddVehicleComponent(cochet,1147); AddVehicleComponent(cochet,1010);
AddVehicleComponent(cochet,1073);
PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
ChangeVehiclePaintjob(cochet,0);
SetVehicleVirtualWorld(cochet, GetPlayerVirtualWorld(playerid));
LinkVehicleToInterior(cochet, GetPlayerInterior(playerid));
} else { SendClientMessage(playerid, ROJO, "Error: Auto tuneado invalido [1-10]"); }
}
return 1; }

CMD:jetpack(playerid)
{
	if(Info[playerid][AdminNivel] < 1)return -1;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	return 1;
}

CMD:qreportes(playerid)
{
	if(Info[playerid][AdminNivel] < 2)return -1;
	SendClientMessage(playerid, -1, "Se han limpiado todos los reportes.");
	ClearReportes();
	return 1;
}

CMD:borrarautos(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 4) return -1;
	for(new i=0; i<GetMaxPlayers(); i++)
	{
		if(IsVehicleOccupied(i) == 0 && Info[i][pCar] != -1)
		{
			CarDeleter(Info[i][pCar]);
		}
	}
	return 1;
}

CMD:respawncars(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 4) return -1;
	for(new i=1; i<MAX_VEHICLES; i++)
	{
		if(IsVehicleOccupied(i) == 0) SetVehicleToRespawn(i);
	}
	return 1;
}

funcion CarSpawner(playerid,model)
{
	if(IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid, ROJO, "Usted ya tiene un coche!");
	else
	{
		new Float:x, Float:y, Float:z, Float:angle;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);
		if(Info[playerid][pCar] != -1) CarDeleter(Info[playerid][pCar]);
		new vehicleid=CreateVehicle(model, x, y, z, angle, GetPlayerColor(playerid), -1, -1);
		PutPlayerInVehicle(playerid, vehicleid, 0);
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
		LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
		ChangeVehicleColor(vehicleid,0,7);
		Info[playerid][pCar] = vehicleid;
	}
	return 1;
}

funcion CarDeleter(vehicleid)
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		new Float:X,Float:Y,Float:Z;
		if(IsPlayerInVehicle(i, vehicleid))
		{
			RemovePlayerFromVehicle(i);
			GetPlayerPos(i,X,Y,Z);
			SetPlayerPos(i,X,Y+3,Z);
		}
		SetVehicleParamsForPlayer(vehicleid,i,0,1);
	}
	SetTimerEx("VehRes",1500,0,"i",vehicleid);
}

funcion VehRes(vehicleid)
{
	DestroyVehicle(vehicleid);
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	new msj[128];
	foreach(Player,i)
	{
		if((Info[i][AdminNivel] > Info[playerid][AdminNivel]) && (Info[i][AdminNivel] > 2) && i!=playerid)
		{
			format(msj, sizeof(msj), "%s (%d) Tipeó: /%s",Nombre(playerid),playerid,cmd);
			SendClientMessage(i, 0xB9C9BFFF, msj);
		}
	}
	return 1;
}

// Timer que oculta el TextDraw
forward HideCommandError(playerid);
public HideCommandError(playerid)
{
    PlayerTextDrawHide(playerid, NOTIFICATION_MESSAGE[playerid][3]);
    return 0; // Timer de una sola vez
}


forward ActualizarHUD();
public ActualizarHUD()
{
    foreach(new playerid : Player)
    {
        if(!IsPlayerConnected(playerid)) continue;

        new ping = GetPlayerPing(playerid);
        new Float:packet = GetPlayerPacketLoss(playerid);
        new kills = Info[playerid][Score];
        new muertes = Info[playerid][Muertes];

        // ?? AQUÍ se integra la lectura de los FPS
        new fps = FPS[playerid]; // Obtiene el valor calculado en OnPlayerUpdate

        new str[64];

        // ping valor blanco
        format(str, sizeof(str), "ping: ~w~%d", ping);
        PlayerTextDrawSetString(playerid, TD_ping[playerid], str);

        // packet blanco
        format(str, sizeof(str), "packet: ~w~%.1f%%", packet);
        PlayerTextDrawSetString(playerid, TD_packet[playerid], str);

        // kills
        format(str, sizeof(str), "kills: ~w~%d", kills);
        PlayerTextDrawSetString(playerid, TD_kills[playerid], str);

        // muertes
        format(str, sizeof(str), "muertes: ~w~%d", muertes);
        PlayerTextDrawSetString(playerid, TD_muertes[playerid], str);

        // ? FPS (NUEVO BLOQUE)
        // Lee la variable FPS y actualiza el TextDraw correspondiente.
        format(str, sizeof(str), "fps: ~w~%d", fps);
        PlayerTextDrawSetString(playerid, TD_fps[playerid], str);
    }
    return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if(result == -1)
    {
        new str[128];
        format(str, sizeof(str), "~r~~h~ERROR~w~: El comando ~r~~h~/%s~w~ no existe.", cmd);

        PlayerTextDrawSetString(playerid, NOTIFICATION_MESSAGE[playerid][3], str);
        PlayerTextDrawShow(playerid, NOTIFICATION_MESSAGE[playerid][3]);

        // Timer de 3 segundos para ocultar el TextDraw
        SetTimerEx("HideCommandError", 3000, false, "i", playerid);

        return 1;
    }
    return 1;
}

forward OnCheatDetected(playerid, ip_address[], type, code);
public OnCheatDetected(playerid, ip_address[], type, code)
{
    new msg[256];

    if(IgnorarAnticheat[playerid] == 1)
    {
        return 1; // no expulsar ni bloquear
    }

    if (type)
    {
        BlockIpAddress(ip_address, 0);
        return 1;
    }

    switch (code)
    {
        case 0:
        {
            format(msg, sizeof msg, "{FFFFFF}El jugador {F20CC0}%s(ID:%d){FFFFFF} fue expulsado por el anticheat. Razon:{F20CC0} AB a pie (0).", Nombre(playerid), playerid);
        }
        case 1:
        {
            format(msg, sizeof msg, "{FFFFFF}El jugador {F20CC0}%s(ID:%d){FFFFFF} fue expulsado por el anticheat. Razon:{F20CC0} AB en vehiculo (1).", Nombre(playerid), playerid);
        }
        case 2:
        {
            format(msg, sizeof msg, "{F20CC0}[SPECTEAR]{FFFFFF} Al jugador %s (ID:%d) Razon:{F20CC0} Teleport (2).", Nombre(playerid), playerid);
        }
        case 3:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d){FFFFFF} fue expulsado. Razon:{F55018} Cheat de teleport en vehiculo (3).", Nombre(playerid), playerid);
        }
        case 4:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d){FFFFFF} fue expulsado. Razon:{F55018} Cheat de teleport entre vehiculos (4).", Nombre(playerid), playerid);
        }
        case 6:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d){FFFFFF} fue expulsado. Razon:{F55018} FIX TP HACK PICKUPS (6).", Nombre(playerid), playerid);
        }
        case 7:
        {
            format(msg, sizeof msg, "{FFFFFF}El jugador {F20CC0}%s(ID:%d){FFFFFF} fue expulsado. Razon:{F20CC0} Cheat de volar (7).", Nombre(playerid), playerid);
        }
        case 8:
        {
            format(msg, sizeof msg, "{FFFFFF}El jugador {F20CC0}%s(ID:%d){FFFFFF} fue expulsado. Razon:{F20CC0} Fly hack vehiculo (8).", Nombre(playerid), playerid);
        }
        case 9:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Speedhack a pie (9).", Nombre(playerid), playerid);
        }
        case 10:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Speedhack vehiculo (10).", Nombre(playerid), playerid);
        }
        case 11:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} RC (11).", Nombre(playerid), playerid);
        }
        case 12:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Cheat de vida (12).", Nombre(playerid), playerid);
        }
        case 13:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Cheat de blindaje (13).", Nombre(playerid), playerid);
        }
        case 15:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Cheat de armas (%d).", Nombre(playerid), playerid, GetPlayerWeapon(playerid));
        }
        case 16:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Cheat de municion (16).", Nombre(playerid), playerid);
        }
        case 18:
        {
            new string[144];
            format(string, sizeof(string), "{F55018}[Anticheat]{FFFFFF} Sospecha de {086A87}%s(ID:%d) Razón:{086A87} Cheat de animaciones (18).", Nombre(playerid), playerid);
            MensajeParaAdmins(-1, string);
            return 1;
        }
        case 19:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Godmode a pie (19).", Nombre(playerid), playerid);
        }
        case 20:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Godmode vehiculo (20).", Nombre(playerid), playerid);
        }
        case 21:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Cheat de invisibilidad (21).", Nombre(playerid), playerid);
        }
        case 22:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}: Codigo 22 detectado para %s(ID:%d).", Nombre(playerid), playerid);
        }
        case 23:
        {
            format(msg, sizeof msg, "{FFFFFF}El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{086A87} Cheat de tuneo (23).", Nombre(playerid), playerid);
        }
        case 24:
        {
            format(msg, sizeof msg, "{FFFFFF}[Anticheat] Sospecha de {086A87}%s(ID:%d) Razón:{F55018} Cheat de parkour (24).", Nombre(playerid), playerid);
            MensajeParaAdmins(-1, msg);
            return 1;
        }
        case 25:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Quick turn (25).", Nombre(playerid), playerid);
        }
        case 26:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Rapid fire (26).", Nombre(playerid), playerid);
        }
        case 29:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Aimbot (29).", Nombre(playerid), playerid);
        }
        case 31:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}:El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Car spam / Delete car (31).", Nombre(playerid), playerid);
        }
        case 33:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}: Sospecha de {086A87}%s(ID:%d) Razón:{F55018} Cheat de descongelarse (33).", Nombre(playerid), playerid);
            MensajeParaAdmins(-1, msg);
            return 1;
        }
        case 34:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Cheat de invisibilidad (34).", Nombre(playerid), playerid);
        }
        case 39:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF} Codigo 39 detectado para %s(ID:%d).", Nombre(playerid), playerid);
        }
        case 40:
        {
            SendClientMessage(playerid, -1, MAX_CONNECTS_MSG);
            return 1;
        }
        case 41:
        {
            SendClientMessage(playerid, -1, UNKNOWN_CLIENT_MSG);
            return 1;
        }
        case 42:
        {
            return Kick(playerid);
        }
        case 44:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}El jugador {086A87}%s(ID:%d) fue expulsado por el anticheat. Razon:{F55018} Crasher (asiento invalido) (44).", Nombre(playerid), playerid);
        }
        case 47:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}El jugador {086A87}%s(ID:%d) fue expulsado por el anticheat. Razon:{F55018} Crasher weapons (47).", Nombre(playerid), playerid);
        }
        case 48:
        {
            return Kick(playerid);
        }
        case 49:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Spamear puertas (49).", Nombre(playerid), playerid);
        }
        case 50:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Seat flood (50).", Nombre(playerid), playerid);
        }
        case 51:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} Intento de DDoS (51).", Nombre(playerid), playerid);
        }
        case 52:
        {
            format(msg, sizeof msg, "{F55018}[Anticheat]{FFFFFF}El jugador {086A87}%s(ID:%d) fue expulsado. Razon:{F55018} NOP (52).", Nombre(playerid), playerid);
        }
        default: return 1;
    }

    // Si hay mensaje, enviarlo a todos y expulsar
    if(code >= 0)
    {
        SendClientMessageToAll(-1, msg);
        Kick(playerid);
    }

    return 1;
}



CMD:darvida(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 5) return -1;
	new id,Float:health;
	if(sscanf(params, "df", id,health)) return SendClientMessage(playerid, -1, "Usa: /darvida [id] [cantidad]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, GRIS, "El jugador no está conectado");
	SendFormattedMessage(playerid,-1,"Le has puesto %2.0f de vida a %s.",health,Nombre(id));
	SetPlayerHealth(id, Float:health);
	return 1;
}

CMD:ip(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 5) return -1;
	new query[128],name[24];
	if(sscanf(params, "s[24]", name)) return SendClientMessage(playerid, -1, "Usa /ip [nombre dp]");
	mysql_format(con, query, sizeof(query), "SELECT * FROM `usuarios` WHERE `Nombre` = '%s'",name);
	mysql_pquery(con, query, "OnIpCmd", "ds",playerid,name);
	return 1;
}

funcion OnIpCmd(playerid,name[])
{
	new rows = cache_num_rows(),ipe[18],ip[128];
	if(rows > 0)
	{
		cache_get_value_name(0, "IP", ipe, 18);
		format(ip, sizeof(ip), "La ip de %s es: %s", name,ipe);
		SendClientMessage(playerid, -1, ip);
	}
	else
	{
		format(ip, sizeof(ip), "No existe la cuenta %s en la base de datos", name);
		SendClientMessage(playerid, -1, ip);
	}
	return 1;
}

CMD:banip(playerid,params[])
{
	if(Info[playerid][AdminNivel] <5 ) return -1;
	new ip[24],playerip[16],ban[60];
	if(sscanf(params, "s[24]", ip)) return SendClientMessage(playerid,GRIS, "Usa: /banip [IP]");
	format(ban, sizeof(ban), "banip %s", ip);
	SendRconCommand(ban);
	new str[128];
	format(str, 128, "La IP %s ha sido baneada con éxito.", ip);
	SendClientMessage(playerid, -1, str);
	for(new i=0; i<GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i))
		{
			GetPlayerIp(i, playerip, sizeof(playerip));
			if(strcmp(playerip, ip, true)==0)
			{
				format(str, 128, "Se pateó a %s por tener la IP baneada.", Nombre(i));
				SendClientMessage(playerid, -1, str);
				Kick(i);
				break;
			}
		}
	}
	return 1;
}

CMD:liberar(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new id,str[128];
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "Usa /liberar [sancionado id]"),SendClientMessage(playerid, -1, "Para saber la lista de sancionados escribe /sancionados.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "El jugador no está conectado");
	if(Sancion[id] == 0) return SendClientMessage(playerid, -1, "El jugador no está sancionado vease /sancionados");
	Sancion[id] = 0;
	Info[id][SancionTimeS] = 0;
	Info[id][SancionTime] = 0;
	KillTimer(TimerSancion[id]);
	new mensaje[300];
	mysql_format(con, mensaje, 300, "UPDATE `usuarios` SET `Sancionado` = '0', `SancionTime` = '0', `SanRazon` = '' WHERE `Nombre` = '%s'",Nombre(id));
	mysql_query(con, mensaje);
	SpawnPlayer(id);
	SendFormattedMessage(id,-1,"%s Te ha liberado, eres libre.",Nombre(playerid));
	format(str, 128, "Haz liberado a %s ahora es libre.", Nombre(id));
	SendClientMessage(playerid, -1, str);
	return 1;
}

CMD:sancionados(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new str[128],count = 0;
	str = "Nombre\tID\tRazón\n";
	foreach(Player,i)
	{
		if(Sancion[i] == 1)
		{
			format(str, sizeof(str), "%s %s\t%d\t%s\n",str,Nombre(i),i,Info[i][SanRazon]);
			count++;
		}
	}
	if(count == 0) return SendClientMessage(playerid, -1, "No hay sancionados en este momento");
	ShowPlayerDialog(playerid, SANCIONADOS, DIALOG_STYLE_TABLIST_HEADERS, "Sancionados", str, "Cerrar", "");
	return 1;
}

CMD:darcoins(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 7) return -1;
	new id,coins;
	if(sscanf(params, "dd", id,coins)) return SendClientMessage(playerid, -1, "Usa /darcoins [id] [coins]");
	if(!IsPlayerConnected(id))return SendClientMessage(playerid, -1, "Jugador no conectado");
	Info[id][Coins] +=coins;
	SendFormattedMessage(playerid,-1,"Le has dado %d coins a %s.",coins,Nombre(id));
	return 1;
}

CMD:m(playerid,params[]) {
if(Info[playerid][AdminNivel] >= 2) {
		new string2[128];
		if(!strlen(params)) return SendClientMessage(playerid, ROJO, "USE: /m [texto]");
		format(string2, sizeof(string2), "{00FF00}Moderador %s:{FFFFFF} %s", Nombre(playerid), params[0] );
		return SendClientMessageToAll(-1,string2);
	} else return -1;
}

CMD:fakechat(playerid,params[]) {
	if(Info[playerid][AdminNivel] >= 6) {

		new player1,tmp[128];
		if(sscanf(params, "ds[128]", player1,tmp)) return SendClientMessage(playerid, ROJO, "Usa /fakechat id mensaje");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			SendPlayerMessageToAll(player1, tmp);
			return 1;
		} else return SendClientMessage(playerid,ROJO,"Jugador no conectado");
	} else return -1;
}

CMD:daredcall(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	foreach(Player,i)
	{
		GivePlayerWeapon(i,27,1000000);
		SCM(i,-1,"Edc para todos!");
	}
	return 1;
}

CMD:daredc(playerid,params[])
{
	new jugadorid, string[128];
	if(Info[playerid][AdminNivel] >= 3)
	{
		if(sscanf(params,"d",jugadorid)) return SendClientMessage(playerid,0xff000000,"Usa /daredc [id]");
		{
			if(!IsPlayerConnected(jugadorid)) return SendClientMessage(playerid,0xff000000,"Jugador no conectado");
			format(string,sizeof(string),"Le has dado una {00ff00}Escopeta de combate{ffffff} a %s ",Nombre(jugadorid));
			SendClientMessage(playerid,0xffffffff,string);
			format(string,sizeof(string),"El administrador %s te ha dado una {00ff00}Escopeta de Combate",Nombre(playerid));
			SendClientMessage(jugadorid,0xffffffff,string);
			GivePlayerWeapon(jugadorid,27,1000000);
		}
	}
	else return -1;
	return 1;
}

CMD:nomusicaall(playerid,params[])
{
	foreach(Player,i)
	{
		StopAudioStreamForPlayer(i);
	}
	return 1;
}

CMD:nomusica(playerid,params[])
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}

CMD:prendas(playerid, const params[])
{
	new string[350], s[50],object[40];
	format(object, sizeof(object), "{cc33ff}%s",GetWeaponNameEx(oInfo[playerid][0][modelid1]));
	format(string, sizeof(string), "{84B4C4}Slot 1\t%s\n", oInfo[playerid][0][used1] == true ? (object) : ("{0DFF00}Vacio"));
	for(new i=1,j=MAX_OBJECTS; i<j; i++) {
		format(object, sizeof(object), "{cc33ff}%s",GetWeaponNameEx(oInfo[playerid][i][modelid1]));
		format(s, sizeof(s), "{84B4C4}Slot %d\t%s\n", i+1, oInfo[playerid][i][used1] == true ? (object) : ("{0DFF00}Vacio"));
		strcat(string, s); }
	ShowPlayerDialog(playerid, 70, DIALOG_STYLE_TABLIST, "{33FF00}Prendas", string, "Aceptar", "Cancelar");
	return 1;
}

CMD:move(playerid,params[]) {
	if(Info[playerid][AdminNivel] >= 6) {
		if(!strlen(params)) return SendClientMessage(playerid, ROJO, "USAGE: /move [up / down / +x / -x / +y / -y / off]");
		new Float:X7, Float:Y7, Float:Z7;
		if(strcmp(params,"up",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X7,Y7,Z7);	SetPlayerPos(playerid,X7,Y7,Z7+5); SetCameraBehindPlayer(playerid); }
		else if(strcmp(params,"down",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X7,Y7,Z7);	SetPlayerPos(playerid,X7,Y7,Z7-5); SetCameraBehindPlayer(playerid); }
		else if(strcmp(params,"+x",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X7,Y7,Z7);	SetPlayerPos(playerid,X7+5,Y7,Z7);	}
		else if(strcmp(params,"-x",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X7,Y7,Z7);	SetPlayerPos(playerid,X7-5,Y7,Z7); }
		else if(strcmp(params,"+y",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X7,Y7,Z7);	SetPlayerPos(playerid,X7,Y7+5,Z7);	}
		else if(strcmp(params,"-y",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X7,Y7,Z7);	SetPlayerPos(playerid,X7,Y7-5,Z7);	}
		else if(strcmp(params,"off",true) == 0)	{
			TogglePlayerControllable(playerid,true);	}
		else return SendClientMessage(playerid,ROJO,"USAGE: /move [up / down / +x / -x / +y / -y / off]");
		return 1;
	} else return -1;
}

CMD:san(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 2) return -1;
	new id,tiempo,razon[50],mensaje[300];
	if(sscanf(params, "rds[50]", id,tiempo,razon)) return SendClientMessage(playerid, ROJO, "Usa: /San [id/nombre] [Minutos] [Razón]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "ID incorrecta o jugador no conectado");
	if(Sancion[id] == 1) return SendClientMessage(playerid, ROJO, "Ese jugador ya está encarcelado!");
	if(tiempo == 0) return SendClientMessage(playerid, -1, "1min minimo");
	format(mensaje, sizeof(mensaje), "Haz sancionado a %s por %d minutos",Nombre(id),tiempo);
	format(mensaje, sizeof(mensaje), "{FF0000}%s {FFFFFF}Fue sancionado, Razón: {FF0000}%s",Nombre(id),razon);
	SendClientMessageToAll(-1, mensaje);
	format(mensaje, sizeof(mensaje), "Fuiste sancionado por {FF0000}%d{FFFFFF} minutos",tiempo);
	SendClientMessage(id, -1, mensaje);
	SetPlayerPos(id, 222.7200,110.5350,999.0156);
	SetPlayerInterior(id, 10);
	ResetPlayerWeapons(id);
	SetPlayerVirtualWorld(id, 1+id);
	format(Info[id][SanRazon], 18, "%s", razon);
	Info[id][SancionTime] = tiempo*60*1000;
	Info[id][SancionTimeS] = tiempo*60;
	mysql_format(con, mensaje, 300, "UPDATE `usuarios` SET `Sancionado` = '1', `SancionTime` = '%d', `SanRazon` = '%s' WHERE `Nombre` = '%s'",Info[id][SancionTime],razon,Nombre(id));
	mysql_query(con, mensaje);
	TimerSancion2[id] = SetTimerEx("BajarTiempos", 1000, 1, "d", id);
	TimerSancion[id] = SetTimerEx("LibreSan", Info[id][SancionTime], false, "d", id);
	Sancion[id] = 1;
	return 1;
}

funcion LibreSan(playerid)
{
	Sancion[playerid] = 0;
	Info[playerid][SancionTime] = 0;
	Info[playerid][SancionTimeS] = 0;
	format(Info[playerid][SanRazon], 18, " ");
	SendClientMessage(playerid, VERDE, "Ahora eres libre!");
	KillTimer(TimerSancion2[playerid]);
	KillTimer(TimerSancion[playerid]);
	new mensaje[300];
	mysql_format(con, mensaje, 300, "UPDATE `usuarios` SET `Sancionado` = '0', `SancionTime` = '0', `SanRazon` = '' WHERE `Nombre` = '%s'",Nombre(playerid));
	mysql_query(con, mensaje);
	SpawnPlayer(playerid);
	return 1;
}

CMD:sound(playerid,params[])
{
	new sound;
	if(sscanf(params, "d", sound)) return SendClientMessage(playerid, -1, "Usa: /sound [id]");
	PlayerPlaySound (playerid, 1186, 0.0, 0.0, 0.0);
	PlayerPlaySound(playerid, sound,0,0,0);
	return 1;
}

CMD:a(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 4) return -1;
	new mensaje[128],string[128];
	if(sscanf(params, "s[128]", mensaje)) return SendClientMessage(playerid, ROJO, "Usa: /a [Mensaje]");
	format(string, sizeof(string), "[EQUIPO ADMINISTRATIVO]: {cc33ff}%s",mensaje);
	SendClientMessageToAll(-1, string);
	return 1;
}

CMD:cid(playerid,params[])
{
	new weatherid;
	if(sscanf(params, "d", weatherid)) return SendClientMessage(playerid, -1, "Usa: /cid [clima id]");
	SetPlayerWeather(playerid, weatherid);
	return 1;
}

CMD:clima(playerid)
{
	ShowPlayerDialog(playerid, CLIMA, DIALOG_STYLE_LIST, "Climas", "Normal\nNublado\nLimpio\nTormentoso\nNiebla\nOpaco\nNublado lluvioso\nAtardecer", "Set", "Cerrar");
	return 1;
}

CMD:config(playerid)
{
	new nombre[MAX_PLAYER_NAME];
	GetPlayerName(playerid,nombre,sizeof(nombre));
	new string[250];
	new MP[20], DUEL[20],esquin[20];
	if(ADpm[playerid] == 1) MP = "{FF0000}DESACTIVADO";
	if(ADpm[playerid] == 0) MP = "{00FF00}ACTIVADO";
	if(NODUEL[playerid] == 1) DUEL = "{FF0000}DESACTIVADO";
	if(NODUEL[playerid] == 0) DUEL = "{00FF00}ACTIVADO";
	if(Info[playerid][SkinUsando]==1) esquin = "{00FF00}ACTIVADO";
	else esquin = "{FF0000}DESACTIVADO";
	format(string,sizeof(string),"Cambiar Nombre\t\t{00FF00}%s\nCambiar Contraseña\nMensajes Privados\t\t%s\nInvitaciones de Duelos\t\t%s\nConfiguración de Armas\nSkin personalizado\t\t%s",nombre,MP,DUEL,esquin);
	ShowPlayerDialog(playerid,CONFIG,DIALOG_STYLE_LIST,"SU CONFIGURACION",string,"Aceptar","Cancelar");
	return 1;
}

CMD:mp(playerid, const params[])
{
	if(IsPlayerFlooding(playerid)) return SendClientMessage(playerid,ROJO,"[ADVERTENCIA]: Solo puedes enviar MP's cada 3 Segundos");
	iPlayerChatTime[playerid] = GetTickCount();
	new id;
	new mensage[256];
	new namax[MAX_PLAYERS];
	new namax2[MAX_PLAYERS];
	new string2[128];
	if(sscanf(params, "ds[128]",id, mensage)) return SendClientMessage(playerid, GRIS, "Usa: /mp [ID] [Mensaje]");
	if(id == playerid) return SendClientMessage(playerid, ROJO, "No puedes enviarte un mp a ti mismo.");
	if(ADpm[id] == 0)
	{
		if(IsPlayerConnected(id))
		{
			if(DetectarSpam(mensage))
			{
				if(Info[playerid][AdminNivel] == 0 && !IsPlayerAdmin(playerid))
				{
					GetPlayerName(playerid,string2,sizeof(string2));
					ShowPlayerDialog(playerid, 12, DIALOG_STYLE_MSGBOX, "{00FFFF}Anti Spam", "{FFFFFF}Evita el spam, puedes ser{FF0000} Baneado", "Aceptar", "");
					format(string2,sizeof(string2),"[INFO-ADMINS]: {FFFFFF}%s {FF0000}ID: {FFFFFF}[%i] {FF0000}Posible Spam Dijo: %s",string2,playerid,mensage);
					MensajeParaAdmins(ROJO,string2);
					return 1;
				}
			}
			GetPlayerName(playerid, namax, sizeof(namax));
			GetPlayerName(id, namax2, sizeof(namax2));
			format(string2, sizeof(string2), ">> %s(%d): %s", namax2, id, mensage);
			SendClientMessage(playerid,AMARILLO, string2);
			format(string2, sizeof(string2), "** %s(%d): %s", namax, playerid, mensage);
			SendClientMessage(id,AMARILLO,string2);
			PlayerPlaySound(id,1085,0.0,0.0,0.0);
			if(Info[playerid][AdminNivel] != 6)
			{
				format(string2, sizeof(string2), "|- MP: %s(%d) A %s(%d): %s", namax, playerid, namax2, id, mensage);
				foreach(Player,a)
				if(IsPlayerConnected(a) && (Info[a][AdminNivel] >= 2) && a != playerid)
				SendClientMessage(a, lightred, string2);
			}
		}
		else SendClientMessage(playerid, ROJO, "ID incorrecta o jugador no conectado");
	}
	else SendClientMessage(playerid, ROJO, "El jugador tiene los mensajes desactivados desactivados");
	return 1;
}

CMD:reglas(playerid)
{
	new regla[700];
	strcat(regla, "{FFFFFF}» Reglas a seguir:\n\n");
	strcat(regla, "1- No abusar de los bugs y reportar estos inmediatamente con el administrador.\n");
	strcat(regla, "• Si abusas de bugs serás pateado del servidor.\n");
	strcat(regla, "2- Prohibido matar a un admin en evento.\n");
	strcat(regla, "• Serás expulsado del evento y no volverás a unirte más.\n");
	strcat(regla, "3- Prohibido Hacer Flood En Chat General/Por PM/de cmds y hacer spam\n");
	strcat(regla, "• Serás baneado por el Anti Cheat o un Administrador\n");
	strcat(regla, "4- No usar cheats/hacks/mods para tu ventaja.\n");
	strcat(regla, "• Baneo completamente por el anti cheat o un administrador\n");
	strcat(regla, "5- Prohibido hacer Drive By(DB) y CarKill(CK)\n");
	strcat(regla, "• Serás encarcelado automaticamente por 4 minutos.\n");
	strcat(regla, "» Estás son todas las reglas si incumples alguna de estas serás sancionado\n");
	strcat(regla, "» Diviertase y trate de cumplir las reglas.\n");
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "» Reglas » DarkShots TEAM DEATHMATCH", regla, "OK", "");
	return 1;
}

CMD:vips(playerid)
{
	new str[500],count;
	foreach(Player,i)
	{
		if(Info[i][VIP])
		{
			count++;
			if(i == 0)
			format(str, sizeof(str), "#\tNombre\tID\n{ffffff}#%d\t{ffff00}%s\t{ffff00}({ffffff}%d{ffff00})\t\n",i+1,Nombre(i),i);
			else format(str, sizeof(str), "%s{ffffff}#%d\t{ffff00}%s\t{ffff00}({ffffff}%d{ffff00})\n",str,i+1,Nombre(i),i);
		}
	}
	if(count==0) return SendClientMessage(playerid, -1, "No hay vips online");
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "VIPs Online", str, "Cerrar", "");
	return 1;
}

CMD:cmds(playerid, const params[])
{
	new str[1220];
	strcat(str, "{FFFFFF}» Estadisticas:{cc33ff}\n");
	strcat(str, "• /Est {ffffff}» {cc33ff}/Estadisticas {ffffff}» {cc33ff}/Stats\n\n");
	strcat(str, "{FFFFFF}» Estadisticas de conexión:{cc33ff}\n");
	strcat(str, "• /ID\n\n");
	strcat(str, "{FFFFFF}» Duelos:{cc33ff}\n");
	strcat(str, "• /Duelo [ID] {ffffff}» {cc33ff}/Duelo ver [ID] {ffffff}» {cc33ff}/Duelo ver no {ffffff}» {cc33ff}/Aceptar duelo {ffffff}» {cc33ff}/Rechazar duelo\n\n");
	strcat(str, "{FFFFFF}» Reportes:{cc33ff}\n");
	strcat(str, "• /Reportar {ffffff}» {cc33ff}/Report\n\n");
	strcat(str, "{FFFFFF}» Administración:{cc33ff}\n");
	strcat(str, "• /Admins {ffffff}» {cc33ff}/Staff {ffffff}» {cc33ff}/Administradores\n\n");
	strcat(str, "{FFFFFF}» Equipos:{cc33ff}\n");
	strcat(str, "• /Team {ffffff}» {cc33ff}/Equipo {ffffff}» {cc33ff}/R {ffffff}» {cc33ff}/Aceptar miembro {ffffff}» {cc33ff}/Rechazar miembro\n\n");
	strcat(str, "{FFFFFF}» Recomendaciones:{cc33ff}\n");
	strcat(str, "• /Sugerencia {ffffff}» {cc33ff}/Reglas\n\n");
	strcat(str, "{FFFFFF}» Configuraciones:{cc33ff}\n");
	strcat(str, "• /Configuracion {ffffff}» {cc33ff}/Config\n\n");
	strcat(str, "{FFFFFF}» Transferencias/Pagos:{cc33ff}\n");
	strcat(str, "• /Pagar {ffffff}» {cc33ff}/Payto {ffffff}» {cc33ff}/Pay\n\n");
	strcat(str, "{FFFFFF}» Clima y hora:{cc33ff}\n");
	strcat(str, "• /clima {ffffff}» {cc33ff}/cid {ffffff}» {cc33ff}/hora\n\n");
	strcat(str, "{FFFFFF}» Eventos:{cc33ff}\n");
	strcat(str, "• /irevento {ffffff}» {cc33ff}/salir");
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ffffff}» Comandos {cc33ff}Disponibles", str, "Cerrar", "");
	PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
	return 1;
}

CMD:ann(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new AnnString[64];
	if(sscanf(params, "s[64]", AnnString)) return SendClientMessage(playerid, ROJO, "Usa: /ann [Texto]");
	TextDrawSetString(Ann, AnnString);
	TextDrawShowForAll(Ann);
	SetTimer("HideAnn", 5000, false);
	return 1;
}

funcion HideAnn()
{
	TextDrawHideForAll(Ann); //Announce En Texdraw
	return 1;
}

CMD:reiniciarsv(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 7) return -1;
	SendRconCommand("gmx");
	return 1;
}

CMD:sugerencia(playerid,params[])
{
	if(EnDuelo[playerid] == 1) return SendClientMessage(playerid, -1, "No puedes usar este comando estando en un duelo.");
	ShowPlayerDialog(playerid, SUGERENCIA, DIALOG_STYLE_MSGBOX, "{cc33ff}Sugerencias", "{FFFFFF}Por favor no abusar de este comando\nSolo usarlo para lo que está hecho, reportar bugs y dar sugerencias.", "Aceptar", "");
	return 1;
}

CMD:cpanel(playerid)
{
	if(Info[playerid][AdminNivel] < 7) return -1;
	new var[221];
	format(var, sizeof(var),"Cambiar hostname\nCambiar password\nCambiar rcon-pass\nBanear usuario\nBanear IP\nDesban usuario\nDesban IP\nPatear usuario\nCrashear usuario\nCambiar GameModeText\nCambiar MapName\nCambiar Web URL\nCambiar WorldTime\nCambiar Weather");
	ShowPlayerDialog(playerid, 1000, DIALOG_STYLE_TABLIST, "cPanel v1.0", var, "Sig", "Cerrar");
	return 1;
}

CMD:duelo(playerid,params[])
{
	if(EnEvento[playerid] == 1) return SendClientMessage(playerid, -1, "No puedes enviar duelos estando en evento");
	if(Sancion[playerid] == 1) return SendClientMessage(playerid, -1, "No puedes usar este comando estando sancionado");
	if(DuelosOff == 1) return SendClientMessage(playerid, -1, "Los duelos fueron desactivados por un administrador");
	new tmp[30],ID,no[10];
	if(!sscanf(params, "s[30]d", tmp,ID) && !strcmp(tmp, "ver", true))
	{
		if(!IsPlayerConnected(ID)) return SendClientMessage(playerid, -1, "El jugador no está conectado.");
		if(EnDuelo[ID]==0) return SendClientMessage(playerid, -1, "El jugador no está en duelo.");
		if(ViendoDuelo[playerid] == true) return SendClientMessage(playerid, -1, "Ya estás viendo un duelo.");
		if(EnDuelo[ID]==1)
		{
			SetPlayerInterior(playerid, GetPlayerInterior(ID));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(ID));
			ViendoDuelo[playerid] = true;
			TogglePlayerSpectating(playerid, 1);
			PlayerSpectatePlayer(playerid, ID);
		}
		return 1;
	}
	if(!sscanf(params, "s[30]s[10]", tmp,no))
	{
		if(!strcmp(no, "no", true) && !strcmp(tmp, "ver", true))
		{
			if(ViendoDuelo[playerid] == false) return SendClientMessage(playerid, -1, "No estás viendo ningun duelo.");
			if(ViendoDuelo[playerid] == true)
			{
				ViendoDuelo[playerid] = false;
				TogglePlayerSpectating(playerid, 0);
				SpawnPlayer(playerid);
			}
		}
		return 1;
	}
	if(EnDuelo[playerid] == 1) return SendClientMessage(playerid, GRIS, "No puedes usar este comando estando en un duelo.");
	if(sscanf(params, "d", ID)) return SendClientMessage(playerid, -1, "Usa /duelo [ID]");
	if(EnCombate[ID]) return SendClientMessage(playerid, GRIS, "El jugador está en combate");
	if(!Info[ID][Logged]) return SendClientMessage(playerid, -1, "El jugador no se ha identificado");
	if(GetPVarInt(ID, "Invitado")==ID) return SendClientMessage(playerid, GRIS, "El jugador está siendo invitado a un duelo.");
	if (!IsPlayerConnected(ID)) return SendClientMessage(playerid,GRIS,"El jugador no está conectado.");
	if(ID == playerid) return SendClientMessage(playerid, GRIS, "No puedes enviarte un duelo a ti mismo.");
	if (EnDuelo[ID] == 1) return SendClientMessage(playerid,GRIS,"El jugador al que quieres invitar esta actuamente en un duelo.");
	if(	NODUEL[ID] == 1) return SendClientMessage(playerid,GRIS,"El jugador está en /noduelo");
	if(GetPVarInt(playerid, "Invitado")==playerid) return SendClientMessage(playerid, -1, "Estás siendo invitado a un duelo espera unos segundos.");
	if(Sancion[ID] == 1) return SendClientMessage(playerid, GRIS, "El jugador está sancionado");
	SetPVarInt(playerid, "Invitado", ID);
	SetPVarInt(ID, "Invitado", ID);
	ShowPlayerDialog(playerid, DUELOSMENU2, DIALOG_STYLE_LIST,"Elige una arena","San Fierro\nAmmunation\nWarehouse\nFábrica\nEstadio Beisbol\nEscuela de autos\nLil' probe inn\nLas Venturas\nLas Venturas 2","Escojer", "Cancelar");
	return 1;
}

CMD:noduelo(playerid,params[])
{
	if(	NODUEL[playerid] == 0)
	{
		NODUEL[playerid] = 1;
		return SendClientMessage(playerid,ROJO,"Ahora No Recibirás Duelos");
	}
	else return SendClientMessage(playerid,ROJO,"Ya estás en no duelo usa /siduelo para recibir duelos");
}

CMD:siduelo(playerid,params[])
{
	#pragma unused params
	if(	NODUEL[playerid] == 1)
	{
		NODUEL[playerid] = 0;
		return SendClientMessage(playerid,ROJO,"Ahora Recibirás Duelos");
	}
	else return SendClientMessage(playerid,ROJO,"Ya estás en si duelo usa /noduelo para no recibir duelos");
}

CMD:nogod(playerid)
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	SetPlayerHealth(playerid, 100);
	SendClientMessage(playerid, -1, "Ahora estás en modo normal los disparos te harán daño.");
	God[playerid] = 0;
	return 1;
}

CMD:god(playerid)
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	SetPlayerHealth(playerid, 1000000);
	SendClientMessage(playerid, -1, "Ahora estás en modo dios nada te hace daño.");
	God[playerid] = 1;
	return 1;
}

CMD:anuncio(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 1) return -1;
	new anuncio[128];
	if(sscanf(params, "s[128]", anuncio)) return SendClientMessage(playerid, GRIS, "Usa: /Anuncio [Mensaje]");
	GameTextForAll(anuncio, 3500, 0);
	return 1;
}

CMD:r(playerid,params[])
{
	if(gTeam[playerid])
	{
		new string[128], name[24];
		if(sscanf(params,"s[128]",string)) return SCM(playerid,0xff0000ff,"Usa: /r [Mensaje]");
		GetPlayerName(playerid, name, sizeof(name));
		format(string, sizeof(string), "(%s) (Radio): %s", name, string);
		foreach(Player,i)
		{
			if(gTeam[i] == gTeam[playerid])
			{
				SendClientMessage(i, 0xFF0080FF, string);
			}
		}
	}
	return 1;
}

CMD:slap(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new slapid,string2[128];
	if(sscanf(params, "d", slapid)) return SCM(playerid,ROJO,"Usa: /Slap [id]");
	new Float:Health, Float:x, Float:y, Float:z;
	GetPlayerHealth(slapid,Health);
	SetPlayerHealth(slapid,Health-25);
	GetPlayerPos(slapid,x,y,z);
	SetPlayerPos(slapid,x,y,z+5);
	PlayerPlaySound(playerid,1190,0.0,0.0,0.0);
	PlayerPlaySound(slapid,1190,0.0,0.0,0.0);
	format(string2,sizeof(string2),"Usted A slapeado a %s",Nombre(slapid));
	return SendClientMessage(playerid,ROJO,string2);
}

CMD:rechazar(playerid,params[])
{
	new item[12];
	if(!sscanf(params, "s[12]", item))
	{
		if(!strcmp(item, "coins", true))
		{
			if(Ofrecedor[playerid] == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "No te están ofreciendo monedas.");
			SendFormattedMessage(playerid,-1,"Haz rechazado las monedas de %s",Nombre(Ofrecedor[playerid]));
			OCoins[playerid] = 0;
			ODinero[playerid] = 0;
			Ofrecedor[playerid] = INVALID_PLAYER_ID;
			return 1;
		}
		if(!strcmp(item, "duelo", true))
		{
			if(EnDuelo[playerid] == 1)
			{
				for (new i=1; i<=ARENAS; i++)
				{
					if ((Duelos[i][DesaId] == playerid || Duelos[i][DesafiadoId] == playerid) && (Duelos[i][Libre]==1))
					{
						Duelos[i][Libre] = 0;
						EnDuelo[Duelos[i][DesaId]] = 0;
						EnDuelo[Duelos[i][DesafiadoId]] = 0;
						SetPVarInt(Duelos[i][DesaId], "Invitado", INVALID_PLAYER_ID);
						SetPVarInt(Duelos[i][DesafiadoId], "Invitado", INVALID_PLAYER_ID);
						if (playerid == Duelos[i][DesaId])
						{
							new string2[128];
							format(string2,sizeof(string2),"%s a abandonado el duelo, %s es el ganador por default.",Nombre(playerid),Nombre(Duelos[i][DesafiadoId]));
							SendClientMessageToAll(-1,string2);
							SpawnPlayer(Duelos[i][DesafiadoId]);
						}
						if (playerid == Duelos[i][DesafiadoId])
						{
							new string2[128];
							format(string2,sizeof(string2),"%s a abandonado el duelo, %s es el ganador por default.",Nombre(playerid),Nombre(Duelos[i][DesaId]));
							SendClientMessageToAll(-1,string2);
							SpawnPlayer(Duelos[i][DesaId]);
						}
						SpawnPlayer(playerid);
						Duelos[i][DesaId] = -1;
						Duelos[i][DesafiadoId] = -1;
						Duelos[i][ArmasId] = -1;
						break;
					}
				}
				return 1;
			}
			if(GetPVarInt(playerid, "Invitado")!=playerid) return SendClientMessage(playerid, -1, "No haz sido invitado por nadie.");
			for (new i=1; i <=ARENAS; i++)
			{
				if (Duelos[i][DesafiadoId] == playerid)
				{
					new str[128];
					format(str,sizeof(str),"%s rechazó el duelo.",Nombre(playerid));
					SendClientMessage(Duelos[i][DesaId],-1,str);
					SendClientMessage(playerid, -1, "Rechazaste el duelo.");
					Duelos[i][DesafiadoId] = -1;
					Duelos[i][DesaId] = -1;
					Duelos[i][ArmasId] = -1;
					Duelos[i][Libre] = 0;
					SetPVarInt(Duelos[i][DesaId], "invitado", INVALID_PLAYER_ID);
					SetPVarInt(playerid, "Invitado", INVALID_PLAYER_ID);
					break;
				}
			}
		}
		if(strcmp(item,"miembro", true)==0)
		{
			if(Invitacion[playerid] == 0) return SendClientMessage(playerid, -1, "No tienes invitacion pendiente.");
			if(Invitacion[playerid] > 0)
			{
				Invitacion[playerid] = 0;
				SendClientMessage(playerid, -1, "Haz rechazado la invitación al equipo.");
			}
			return 1;
		}
	}
	return 1;
}

CMD:vendercoins(playerid,params[])
{
	new dinero,cantidad,id,str[128];
	if(sscanf(params, "ddd",id,cantidad,dinero)) return SendClientMessage(playerid, -1, "Usa: /vendercoins [ID] [Cantidad] [Dinero]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "Ese jugador se encuentra desconectado");
	if(GetPlayerMoney(id)<dinero) return format(str, sizeof(str), "%s No tiene esa cantidad de dinero", Nombre(id)),SendClientMessage(playerid, -1, str),1;
	if(id == playerid) return SendClientMessage(playerid, -1, "No puedes ofrecerte monedas a ti mismo.");
	if(Info[playerid][Coins] < cantidad) return SendClientMessage(playerid, -1, "No tienes esa cantidad de monedas");
	if(Ofrecedor[id] == playerid) return format(str, sizeof(str), "Ya le ofreciste %d monedas a %s.",OCoins[id],Nombre(id)), SendClientMessage(playerid, -1, str),1;
	SendFormattedMessage(playerid,-1,"Le ofreciste %d monedas a %s por $%d.",cantidad,Nombre(id),dinero);
	format(text, sizeof(text), "%s te está ofreciendo %d monedas por $%d",Nombre(playerid),cantidad,dinero);
	SendClientMessage(id, -1, text);
	SendClientMessage(id, -1, "Usa /aceptar coins o /rechazar coins");
	OCoins[id] = cantidad;
	ODinero[id] = dinero;
	Ofrecedor[id] = playerid;
	return 1;
}

// ================= CMD:ACEPTAR =================
CMD:aceptar(playerid, params[])
{
    if(Sancion[playerid] == 1)
        return SendClientMessage(playerid, GRIS, "No puedes usar este comando estando en sanción.");

    if(EnCombate[playerid] == 1)
        return SendClientMessage(playerid, GRIS, "No puedes usar este comando estando en combate.");

    new item[12];
    if(!sscanf(params, "s[12]", item))
    {
        // -------- Aceptar monedas --------
        if(strcmp(item, "coins", true) == 0)
        {
            if(Ofrecedor[playerid] == INVALID_PLAYER_ID)
                return SendClientMessage(playerid, -1, "No te están ofreciendo monedas.");

            Info[playerid][Coins] += OCoins[playerid];
            GivePlayerMoney(playerid, -ODinero[playerid]);
            GivePlayerMoney(Ofrecedor[playerid], ODinero[playerid]);
            Info[Ofrecedor[playerid]][Coins] -= OCoins[playerid];
            Info[playerid][Dinero] -= ODinero[playerid];
            Info[Ofrecedor[playerid]][Dinero] += ODinero[playerid];

            SendFormattedMessage(playerid, -1, "Haz aceptado %d monedas de %s por $%d.", OCoins[playerid], Nombre(Ofrecedor[playerid]), ODinero[playerid]);

            if(OCoins[playerid] == 1)
                format(text, sizeof(text), "%s Aceptó tu moneda por $%d", Nombre(playerid), ODinero[playerid]);
            else
                format(text, sizeof(text), "%s Aceptó tus monedas por $%d", Nombre(playerid), ODinero[playerid]);

            SendClientMessage(Ofrecedor[playerid], -1, text);

            OCoins[playerid] = 0;
            ODinero[playerid] = 0;
            Ofrecedor[playerid] = INVALID_PLAYER_ID;
            return 1;
        }

        // -------- Aceptar duelo --------
        if(strcmp(item, "duelo", true) == 0)
        {
            if(EnDuelo[playerid] == 1)
                return SendClientMessage(playerid, GRIS, "No puedes usar este comando estando en un duelo.");

            if(GetPVarInt(playerid, "Invitado") != playerid)
                return SendClientMessage(playerid, GRIS, "No haz sido invitado por nadie.");

            for(new i = 1; i <= ARENAS; i++)
            {
                if(Duelos[i][DesafiadoId] == playerid)
                {
                    Duelos[i][Libre] = 1;
                    EnDuelo[playerid] = 1;
                    EnDuelo[Duelos[i][DesaId]] = 1;
                    SetPVarInt(Duelos[i][DesaId], "Enviado", 0);
                    KillTimer(timerduelo[playerid]);
                    SetPVarInt(playerid, "Invitado", INVALID_PLAYER_ID);
                    SetPlayerTeam(playerid, NO_TEAM);
                    SetPlayerTeam(Duelos[i][DesaId], NO_TEAM);
                    SetDuel(Duelos[i][DesaId], Duelos[i][DesafiadoId], Duelos[i][ArmasId], i);

                    new wep[128];
                    switch(Duelos[i][ArmasId])
                    {
                        case 1: wep = "Desert Eagle";
                        case 2: wep = "Escopeta De Combate";
                        case 3: wep = "Escopeta";
                        case 4: wep = "MP5";
                        case 5: wep = "M4";
                        case 6: wep = "Rifle";
                        case 7: wep = "Sniper";
                    }

                    new string[128];
                    if(GetPVarInt(playerid, "Apuesta") == 0)
                        format(string, sizeof(string), "{00ff00}%s {E0E83E}Jugará un duelo contra {00ff00}%s {E0E83E}con %s.", Nombre(Duelos[i][DesaId]), Nombre(Duelos[i][DesafiadoId]), wep);
                    else
                        format(string, sizeof(string), "{00ff00}%s {E0E83E}Jugará un duelo contra {00ff00}%s {E0E83E}con %s por %d$.", Nombre(Duelos[i][DesaId]), Nombre(Duelos[i][DesafiadoId]), wep, GetPVarInt(playerid, "Apuesta"));

                    SendClientMessageToAll(0xE0E83EFF, string);
                    break;
                }
            }
            return 1;
        }

        // -------- Aceptar miembro --------
        if(strcmp(item, "miembro", true) == 0)
        {
            new teamID;

            switch(Invitacion[playerid])
            {
                case EnVenta: teamID = 52;
                case eTeam:   teamID = 53;
                default:
                {
                    SendClientMessage(playerid, -1, "No tienes invitación pendiente.");
                    return 1;
                }
            }

            Invitado[playerid] = Invitacion[playerid];
            SetPlayerTeam(playerid, teamID);
            Invitacion[playerid] = 0;

            new msg[128]; // ? único cambio
            format(msg, sizeof(msg), "Has sido agregado al equipo %d.", teamID);
            SendClientMessage(playerid, 0x00FF00FF, msg);

            return 1;
        }
    }

    return 1;
}


// ================= CMD:INVITAR =================
CMD:invitar(playerid, params[])
{
    if(Autorizado[playerid] == 0) return SendClientMessage(playerid, -1, "No eres lider de ningun equipo");

    new targetID;
    if(sscanf(params, "d", targetID))
        return SendClientMessage(playerid, GRIS, "Usa: /Invitar [ID]");

    if(targetID == playerid)
        return SendClientMessage(playerid, ROJO, "Ya perteneces al equipo.");

    if(Invitado[targetID] == Invitado[playerid])
        return SendClientMessage(playerid, ROJO, "Ese jugador ya está en el equipo");

    if(!IsPlayerConnected(targetID))
        return SendClientMessage(playerid, ROJO, "ID incorrecta o jugador no conectado");

    // Guardamos **el team real del líder** para que el invitado reciba correctamente
    Invitacion[targetID] = gTeam[playerid];

    new string[128];
    format(string, sizeof(string), "%s Te está invitando a su equipo", Nombre(playerid));
    SendClientMessage(targetID, -1, string);
    SendClientMessage(targetID, -1, "Usa /aceptar miembro o /rechazar miembro.");

    SendFormattedMessage(playerid, -1, "Haz enviado invitación de tu equipo a %s", Nombre(targetID));

    return 1;
}




// Asume que 1 = Tiene permiso para invitar, 0 = No tiene permiso.

CMD:permisosinvitar(playerid, params[])
{
    // --- 1. Verificación de Permisos de Administrador (Nivel 7) ---
    // Usamos 'Info[playerid][AdminNivel]' según tu especificación.
    if (Info[playerid][AdminNivel] < 7)
    {
        // Color Rojo (0xFFFF0000)
        SendClientMessage(playerid, 0xFFFF0000, "ERROR: No tienes los permisos de administrador necesarios (Nivel 7).");
        return 1;
    }

    new targetid, status, query[128];

    // --- 2. Verificación de Sintaxis y Parseo ---
    // El 'status' es el valor que se asignará a la columna 'Autorizado' (0 para quitar, 1 para dar)
    if (sscanf(params, "dd", targetid, status))
    {
        // Color Blanco (0xFFFFFFFF)
        SendClientMessage(playerid, 0xFFFFFFFF, "USO: /permisosinvitar [ID Jugador] [0/1]");
        SendClientMessage(playerid, 0xFFFFFFFF, "INFO: 1 = Dar permiso de invitar; 0 = Quitar permiso de invitar.");
        return 1;
    }

    // --- 3. Validación del ID del Jugador Objetivo ---
    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xFFFF0000, "ERROR: ID de jugador no válido o desconectado.");
        return 1;
    }

    // --- 4. Validación del Estado (Status) ---
    if (status != 0 && status != 1)
    {
        SendClientMessage(playerid, 0xFFFF0000, "ERROR: El estado debe ser 0 (Quitar) o 1 (Dar).");
        return 1;
    }

    // --- 5. Construir la Consulta SQL (Actualizar 'Autorizado') ---
    format(query, sizeof(query), "UPDATE `usuarios` SET `Autorizado` = %d WHERE `ID` = %d", status, targetid);

    // --- 6. Ejecutar la Consulta Asíncrona ---
    mysql_query(con, query);

    // --- 7. Notificar al Administrador y al Jugador ---

    // Actualiza la variable del servidor del jugador inmediatamente.
    // Asumimos que tu variable de autorización se llama 'Autorizado[playerid]' o similar.
    // Si usas el sistema 'Info', puede ser: Info[targetid][pAutorizado] = status;
    Autorizado[targetid] = status;

    new targetName[MAX_PLAYER_NAME];
    GetPlayerName(targetid, targetName, sizeof(targetName));

    new statusMessage[64];
    new adminColor, targetColor;

    if (status == 1)
    {
        statusMessage = "ha recibido el permiso de invitar.";
        adminColor = 0x00FF00FF; // Verde para Dar
        targetColor = 0x00FF00FF;
    }
    else // status == 0
    {
        statusMessage = "ha sido REVOCADO el permiso de invitar.";
        adminColor = 0xFFFF0000; // Rojo para Quitar
        targetColor = 0xFFFF0000;
    }

    // Mensaje para el Admin
    format(query, sizeof(query), "ADMIN: %s (ID: %d) %s", targetName, targetid, statusMessage);
    SendClientMessage(playerid, adminColor, query);

    // Mensaje para el jugador objetivo
    format(query, sizeof(query), "NOTIFICACIÓN: Su estado de 'permiso para invitar' %s", (status == 1 ? "ha sido otorgado." : "ha sido revocado."));
    SendClientMessage(targetid, targetColor, query);

    return 1;
}
CMD:darteam(playerid, params[])
{
    if (Info[playerid][AdminNivel] < 7)
    {
        // Usamos el color ROJO (0xFFFF0000) para el error.
        SendClientMessage(playerid, 0xFFFF0000, "ERROR: No tienes los permisos de administrador necesarios (Nivel 7).");
        return 1;
    }

    new targetid, teamid, query[128];

    // --- 2. Verificación de Sintaxis y Parseo ---
    if (sscanf(params, "dd", targetid, teamid))
    {
        // Usamos el color BLANCO (0xFFFFFFFF)
        SendClientMessage(playerid, 0xFFFFFFFF, "USO: /darteam [ID Jugador] [ID Owner]");
        SendClientMessage(playerid, 0xFFFFFFFF, "INFO: El ID Owner es el valor numérico para la columna 'Owner' (p. ej. 1, 2, 52, etc.).");
        return 1;
    }

    // --- 3. Validación del ID del Jugador Objetivo ---
    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xFFFF0000, "ERROR: ID de jugador no válido o desconectado.");
        return 1;
    }

    // --- 4. Validación del ID del Equipo (Owner) ---
    // Asumiendo que el ID de Owner debe ser un número positivo (mayor o igual a 1).
    if (teamid <= 0)
    {
        SendClientMessage(playerid, 0xFFFF0000, "ERROR: El ID de Owner debe ser un número positivo (>= 1).");
        return 1;
    }

    // --- 5. Construir la Consulta SQL (Actualizar 'Owner') ---
    // Se usa la columna 'Owner' en lugar de 'Invitado'.
    format(query, sizeof(query), "UPDATE `usuarios` SET `Owner` = %d WHERE `ID` = %d", teamid, targetid);

    mysql_query(con, query);
    Owner[targetid] = teamid;

    new targetName[MAX_PLAYER_NAME];
    GetPlayerName(targetid, targetName, sizeof(targetName));

    // Mensaje para el Admin (Verde: 0x00FF00FF)
    format(query, sizeof(query), "ADMIN: Has asignado a %s (ID: %d) como Owner con ID de equipo: %d.", targetName, targetid, teamid);
    SendClientMessage(playerid, 0x00FF00FF, query);

    // Mensaje para el jugador objetivo (Verde: 0x00FF00FF)
    format(query, sizeof(query), "FELICIDADES: Un administrador te ha asignado como Owner (Equipo ID: %d).", teamid);
    SendClientMessage(targetid, 0x00FF00FF, query);

    return 1;
}
CMD:darlider(playerid,params[])
{
	if(Owner[playerid] == 0) return SendClientMessage(playerid, GRIS, "No eres lider de ningun equipo");
	new id,string[128];
	if(sscanf(params, "r", id)) return SendClientMessage(playerid, -1, "Usa: /darlider [id/nombre]");
	if(id == playerid) return SendClientMessage(playerid, ROJO, "Eres el lider del equipo.");
	if(Owner[id] == Owner[playerid]) return SendClientMessage(playerid, GRIS, "El jugador ya es lider en tu equipo");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "Jugador no conectado");
	if(Invitado[id] != Owner[playerid]) return SendClientMessage(playerid, -1, "El jugador no pertenece a tu equipo");
	Owner[id] = Owner[playerid];
	format(string, sizeof(string), "%s Te ha otorgado rango lider en su equipo.", Nombre(playerid));
	SendClientMessage(id, -1, string);
	format(string, 128, "Le haz dado lider a %s", Nombre(id));
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:permiso(playerid,params[])
{
	if(Owner[playerid] == 0) return SendClientMessage(playerid, GRIS, "No eres lider de ningun equipo");
	new id,string[128];
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, GRIS, "Usa: /permiso [id]");
	if(Autorizado[id] == Owner[playerid]) return SendClientMessage(playerid, GRIS, "El jugador ya tiene sub lider en tu equipo");
	if(id == playerid) return SendClientMessage(playerid, ROJO, "Eres el lider del equipo.");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "ID incorrecta o jugador no conectado");
	if(Invitado[id] != Owner[playerid]) return SendClientMessage(playerid, -1, "El jugador no pertenece a tu equipo");
	Autorizado[id] = Owner[playerid];
	format(string, sizeof(string), "%s Te ha dado autorización en su equipo.", Nombre(playerid));
	SendClientMessage(id, -1, string);
	format(string, 128, "Le haz dado permiso de invitar %s", Nombre(id));
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:tienda(playerid, const params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 296.3786,-38.5146,1001.5156) && Info[playerid][VIP] == 0) return SendClientMessage(playerid,GRIS,"Debes estar en la tienda para poder usar este comando");
	else if(IsPlayerInRangeOfPoint(playerid, 3.0, 296.3786,-38.5146,1001.5156) || Info[playerid][VIP] == 1)
	ShowPlayerDialog(playerid,TIENDA,DIALOG_STYLE_TABLIST_HEADERS,"TIENDA","Item\t\tPrecio\n• Skins\t\t{00ff00}100.000$\n• Chaleco\t\t{00FF00}150.000$\n• Armas\n• Prendas\t{00ff00}250.000$\n• Membresía VIP\t{00ff00}50 Monedas\n• Monedas","Comprar","Cerrar");
	return 1;
}

CMD:car(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	ShowPlayerDialog(playerid, CARS, DIALOG_STYLE_LIST, "Menu de autos", "Vehículos\nBarcos\nAviones", "Aceptar", "Cerrar");
	return 1;
}

CMD:adv(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 2) return -1;
	new id,reazon[50],mensaje[128];
	if(sscanf(params, "rs[50]", id,reazon)) return SendClientMessage(playerid, ROJO, "Usa: /adv [ID/Nombre] [Razón]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "ID Incorrecta o jugador no conectado");
	if(id == playerid) return 1;
	format(mensaje, sizeof(mensaje), "Haz advertido a %s por %s.",Nombre(id), reazon);
	SendClientMessage(playerid, -1, mensaje);
	format(mensaje, sizeof(mensaje), "Haz sido advertido por {ff0000}%s{ffffff}, Razón: {ff0000}%s",Nombre(playerid),reazon);
	SendClientMessage(id, -1, mensaje);
	Info[id][ADV]++;
	if(Info[id][ADV] == MAX_ADV)
	{
		Sancionar(id,"3 Advertencias",4);
		return 1;
	}
	format(mensaje, sizeof(mensaje), "{ff0000}%d {ffffff}Advertencias, 3 y serás sancionado por 4m.",Info[id][ADV]);
	SendClientMessage(id, -1, mensaje);
	return 1;
}

CMD:acciones(playerid, const params[])
{
	new Acciones[775];
	strcat(Acciones, "{FFFFFF}» Acciónes:\n");
	strcat(Acciones, "* /si /no /rendirse /borracho /mmm /servir /servirse /tullio\n");
	strcat(Acciones, "* /bomba /arrestar /jaja /sapiar /asiento /asiento2 /asustado\n");
	strcat(Acciones, "* /amenazar /agredido /herido /rodar /llorar /sentarse /wooo\n");
	strcat(Acciones, "* /encender /vigilar /recostarse /saludo[1-4] /fokear /comodo\n");
	strcat(Acciones, "* /cubrirse /vomitar /comer /despedirse /dormir /piquero /asco\n");
	strcat(Acciones, "* /taichi /boxear /bailar[1-3] /drink /strip[1-20] /echarse\n");
	strcat(Acciones, "* /hablar /sucidio /llamar /Contestacion /Colgar /recoger /sanar\n");
	strcat(Acciones, "* /palmada /agonizar /traficar /beso /crack /cansado /rapear\n");
	strcat(Acciones, "* /asientosexi /skate [1-3] /patada /danzar[0-12] /fumar [2-3]\n");
	strcat(Acciones, "* /adolorido /seacabo /fuerza /quepasa /superpatada /choriso\n");
	strcat(Acciones, "* /tullio /cansado /asco /comodo /alsar /quepa /taxi /mujer\n\n");
	strcat(Acciones, "* Para detener una accion Escribe /Detener o pulsa ENTER o ESPACIO o BIR\n");
	ShowPlayerDialog(playerid,0, DIALOG_STYLE_MSGBOX, "  ", Acciones, "Aceptar", "");
	PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
	return 1;
}

CMD:rendirse(playerid, params[])
{
	ApplyAnimation(playerid, "ROB_BANK","SHP_HandsUp_Scr", 4.0, 0, 1, 1, 1, 1);
	return 1;
}

CMD:borracho(playerid, params[])
{
	ApplyAnimation(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
	return 1;
}

CMD:hablar(playerid,params[]){
ApplyAnimation(playerid,"PED","IDLE_chat",4.1,7,5,1,1,1);return 1;}
CMD:bomb(playerid,params[]){
ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 1, 1, 0,0);return 1;}
CMD:arrestar(playerid,params[]){
ApplyAnimation( playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1,500);
SendClientMessage(playerid, 0x339900AA, "Quieto");return 1;}
CMD:jaja(playerid,params[]){
ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0,0);
SendClientMessage(playerid, 0x339900AA, "Jajajaja");return 1;}
CMD:sapiar(playerid,params[]){
ApplyAnimation(playerid,"PED","roadcross_female",4.1,0,0,0,0,0);
SendClientMessage(playerid, 0x339900AA, "Sapiando");return 1;}
CMD:amenazar(playerid,params[]){
ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 0, 0, 0, 1,500);
SendClientMessage(playerid, 0x339900AA, "Pasa las moneas");return 1;}
CMD:paja(playerid,params[]){
ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 4.0, 1, 0, 0, 1, 0);
SendClientMessage(playerid, 0x339900AA, "te recomiendo /irsecortao");return 1;}
CMD:acabar(playerid,params[]){
ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.0, 0, 0, 0, 0, 0);
SendClientMessage(playerid, 0x339900AA, "Te fuiste cortao");return 1;}
CMD:agredido(playerid,params[]){
ApplyAnimation(playerid, "POLICE", "crm_drgbst_01", 4.0, 0, 0, 0, 1, 0);
SendClientMessage(playerid, 0x339900AA, "para continuar /levantarse");return 1;}
CMD:herido(playerid,params[]){
ApplyAnimation(playerid, "SWEET", "LaFin_Sweet", 4.0, 0, 1, 1, 1, 0);
SendClientMessage(playerid, 0x339900AA, "para continuar /agonizar");return 1;}
CMD:encender(playerid,params[]){
ApplyAnimation(playerid, "SMOKING", "M_smk_in", 4.000000, 0, 0, 1, 1, 0);
SendClientMessage(playerid, 0x339900AA, "para continuar /inhalar o /apagar");return 1;}
CMD:inhalar(playerid,params[]){
ApplyAnimation(playerid, "SMOKING", "M_smk_drag", 4.000000, 1, 0, 0, 0, -1);
SendClientMessage(playerid, 0x339900AA, "para continuar /apagar");return 1;}
CMD:apagar(playerid,params[]){
ApplyAnimation(playerid, "SMOKING", "M_smk_out", 4.000000, 0, 1, 1, 0, 0);return 1;}
CMD:vigilar(playerid,params[]){ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 1, 1, 1, 0, 4000);return 1;}
CMD:recostarse(playerid,params[]){
ApplyAnimation(playerid,"SUNBATHE", "Lay_Bac_in", 4.0, 0, 0, 0, 1, 0);
SendClientMessage(playerid, 0x339900AA, "para continuar /pararse");return 1;}
CMD:pararse(playerid,params[]){
ApplyAnimation(playerid,"SUNBATHE", "Lay_Bac_out", 4.0, 0, 0, 0, 0, 0);return 1;}
CMD:cubrirse(playerid,params[]){
ApplyAnimation(playerid, "ped", "cower", 4.0, 1, 0, 0, 0, 0);
SendClientMessage(playerid, 0x339900AA, "para continuar /pararse");return 1;}
CMD:vomitar(playerid,params[]){
ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0);
SendClientMessage(playerid, 0x339900AA, "buaaaaajjj");return 1;}
CMD:comer(playerid,params[]){
ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.00, 0, 0, 0, 0, 0);return 1;}
CMD:chao(playerid,params[]){
ApplyAnimation(playerid, "KISSING", "BD_GF_Wave", 3.0, 0, 0, 0, 0, 0);
SendClientMessage(playerid, 0x339900AA, "chao");return 1;}
CMD:palmada(playerid,params[]){
ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);
SendClientMessage(playerid, 0x339900AA, "su palmadita");return 1;}
CMD:agonizar(playerid,params[]){
ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.0, 0, 0, 0, 1, 0);
SendClientMessage(playerid, 0x339900AA, "para continuar /levantarse");return 1;}
CMD:levantarse(playerid,params[]){
ApplyAnimation(playerid, "ped", "getup_front", 4.000000, 0, 0, 0, 0, 0);return 1;}
CMD:traficar(playerid,params[]){
ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
SendClientMessage(playerid, 0x339900AA, "pasando y pasando");return 1;}
CMD:beso(playerid,params[]){
ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 4.0, 0, 0, 0, 0, 0);return 1;}
CMD:crack(playerid,params[]){
ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 0, 0, 0, 1, 0);
SendClientMessage(playerid, 0x339900AA, "para continuar /levantarse");return 1;}
CMD:fumar(playerid,params[]){
SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);return 1;}
CMD:sentarse(playerid,params[]){
ApplyAnimation(playerid, "SUNBATHE", "ParkSit_M_in", 4.000000, 0, 1, 1, 1, 0);
SendClientMessage(playerid, 0x339900AA, "para continuar /pararse");return 1;}
CMD:fokear(playerid,params[]){
ApplyAnimation( playerid,"ped", "fucku", 4.0, 0, 1, 1, 1, 1 );
SendClientMessage(playerid, 0x339900AA, "que te pasa ql?");return 1;}
CMD:si(playerid,params[]){
ApplyAnimation(playerid, "GANGS", "Invite_Yes", 4.0, 0, 0, 0, 0, 0);
SendClientMessage(playerid, 0x339900AA, "si");return 1;}
CMD:llamar(playerid,params[]){
ApplyAnimation(playerid, "ped", "phone_in", 4.000000, 0, 0, 0, 1, 4000);
SendClientMessage(playerid, 0x339900AA, "para continuar /colgar");SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);return 1;}
CMD:contestar(playerid,params[]){
ApplyAnimation(playerid, "ped", "phone_in", 4.000000, 0, 0, 0, 1, 4000);
SendClientMessage(playerid, 0x339900AA, "para continuar /colgar");SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);return 1;}
CMD:colgar(playerid,params[]){
ApplyAnimation(playerid, "ped", "phone_out", 4.000000, 0, 1, 1, 0, 0);return 1;}
CMD:piquero(playerid,params[]){
ApplyAnimation(playerid, "DAM_JUMP", "DAM_Launch", 4.0, 0, 1, 1, 1, 1); return 1;}
CMD:taichi(playerid,params[]){
ApplyAnimation(playerid, "PARK", "Tai_Chi_Loop",  4.1,7,5,1,1,1);
SendClientMessage(playerid, 0x339900AA, "siente el flujo");return 1;}
CMD:beber(playerid,params[]){
ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 1, 1, 0, 4000);return 1;}
CMD:boxear(playerid,params[]){
ApplyAnimation(playerid, "GYMNASIUM", "gym_shadowbox",  4.1,7,5,1,1,1);return 1;}
CMD:pelea(playerid,params[]){
ApplyAnimation(playerid, "ped", "FIGHTIDLE", 4.000000, 0, 1, 1, 1, 1);
SendClientMessage(playerid, 0x339900AA, "para continuar /boxear");return 1;}
CMD:recoger(playerid,params[]){
ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.000000, 0, 1, 1, 1, 1);
SendClientMessage(playerid, 0x339900AA, "para continuar /botear");return 1;}
CMD:botear(playerid,params[]){
ApplyAnimation(playerid, "BSKTBALL", "BBALL_walk", 4.000000, 1, 1, 1, 1, 500);
SendClientMessage(playerid, 0x339900AA, "para continuar /clavarse 0 /lanzar");return 1;}
CMD:clavarse(playerid,params[]){
ApplyAnimation(playerid, "BSKTBALL", "BBALL_def_jump_shot", 4.0, 0, 1, 1, 1, 500);return 1;}
CMD:lanzar(playerid,params[]){
ApplyAnimation(playerid, "BSKTBALL", "BBALL_Jump_Shot", 4.0, 0, 1, 1, 1, 500);return 1;}
CMD:asiento(playerid,params[]){
ApplyAnimation(playerid, "ped", "SEAT_down", 4.000000, 0, 0, 0, 1, 0);
SendClientMessage(playerid, 0x339900AA, "para continuar /depie");return 1;}
CMD:depie(playerid,params[]){
ApplyAnimation(playerid, "ped", "SEAT_up", 4.000000, 0, 0, 1, 0, 0);return 1;}
CMD:servirse(playerid,params[]){
ApplyAnimation(playerid,"BAR","Barcustom_get",4.1,0,0,0,0,0);return 1;}
CMD:servir(playerid,params[]){
ApplyAnimation(playerid,"BAR","Barserve_give",4.1,0,0,0,0,0);return 1;}
CMD:asiento2(playerid,params[]){
ApplyAnimation(playerid,"Attractors","Stepsit_in",4.1,0,0,0,1,0);
SendClientMessage(playerid, 0x339900AA, "para continuar /depie2");return 1;}
CMD:depie2(playerid,params[]){
ApplyAnimation(playerid,"Attractors","Stepsit_out",4.1,0,0,0,0,0);return 1;}
CMD:mmm(playerid,params[]){
ApplyAnimation(playerid,"COP_AMBIENT","Coplook_think",4.1,0,0,0,0,0);return 1;}
CMD:rodar(playerid,params[]){
ApplyAnimation(playerid,"MD_CHASE","MD_HANG_Lnd_Roll",4.1,0,1,1,1,0);
SendClientMessage(playerid, 0x339900AA, "para continuar /levantarse");return 1;}
CMD:saludo1(playerid,params[]){
ApplyAnimation(playerid,"GANGS","hndshkaa",4.1,0,0,0,0,0);return 1;}
CMD:saludo2(playerid,params[]){
ApplyAnimation(playerid,"GANGS","hndshkba",4.1,0,0,0,0,0);return 1;}
CMD:saludo3(playerid,params[]){
ApplyAnimation(playerid,"GANGS","hndshkca",4.1,0,0,0,0,0);return 1;}
CMD:saludo4(playerid,params[]){ApplyAnimation(playerid,"GANGS","hndshkfa_swt",4.1,0,0,0,0,0);return 1;}
CMD:sanar(playerid,params[]){ApplyAnimation(playerid,"MEDIC","CPR",4.1,0,0,0,0,0);return 1;}
CMD:llorar(playerid,params[]){
ApplyAnimation(playerid,"GRAVEYARD","mrnF_loop",4.1,0,0,0,0,0);return 1;}
CMD:dormir(playerid,params[]){
ApplyAnimation(playerid,"INT_HOUSE","BED_In_R",4.1,0,0,0,1,0);return 1;}
CMD:detener1(playerid,params[]){
ApplyAnimation(playerid,"POLICE","CopTraf_Stop",4.1,0,0,0,0,0);return 1;}
CMD:rapear(playerid,params[]){
ApplyAnimation(playerid,"RAPPING","RAP_B_Loop",4.0,1,0,0,0,8000);return 1;}
//=================================== strip ================================
CMD:strip(playerid,params[]){
SendClientMessage(playerid, 0xAA3333AA, "/strip[1-20]");return 1;}
CMD:strip1(playerid,params[]){
ApplyAnimation(playerid,"CAR","flag_drop",4.1,0,1,1,1,1);return 1;}
CMD:strip2(playerid,params[]){
ApplyAnimation(playerid,"STRIP","PUN_CASH",4.1,7,5,1,1,1);return 1;}
CMD:strip3(playerid,params[]){
ApplyAnimation(playerid,"STRIP","PUN_HOLLER",4.1,7,5,1,1,1);return 1;}
CMD:strip4(playerid,params[]){
ApplyAnimation(playerid,"STRIP","PUN_LOOP",4.1,7,5,1,1,1);return 1;}
CMD:strip5(playerid,params[]){
ApplyAnimation(playerid,"STRIP","strip_A",4.1,7,5,1,1,1);return 1;}
CMD:strip6(playerid,params[]){
ApplyAnimation(playerid,"STRIP","strip_B",4.1,7,5,1,1,1);return 1;}
CMD:strip7(playerid,params[]){
ApplyAnimation(playerid,"STRIP","strip_C",4.1,7,5,1,1,1);return 1;}
CMD:strip8(playerid,params[]){
ApplyAnimation(playerid,"STRIP","strip_D",4.1,7,5,1,1,1);return 1;}
CMD:strip9(playerid,params[]){
ApplyAnimation(playerid,"STRIP","strip_E",4.1,7,5,1,1,1);return 1;}
CMD:strip10(playerid,params[]){
ApplyAnimation(playerid,"STRIP","strip_F",4.1,7,5,1,1,1);return 1;}
CMD:strip11(playerid,params[]){
ApplyAnimation(playerid,"STRIP","strip_G",4.1,7,5,1,1,1);return 1;}
CMD:strip12(playerid,params[]){
ApplyAnimation(playerid,"STRIP","STR_B2A",4.1,0,1,1,1,1);return 1;}
CMD:strip13(playerid,params[]){
ApplyAnimation(playerid,"STRIP","strip_E",4.1,7,5,1,1,1);return 1;}
CMD:strip14(playerid,params[]){
ApplyAnimation(playerid,"STRIP","STR_B2C",4.000000, 0, 1, 1, 1, 0);return 1;}
CMD:strip15(playerid,params[]){
ApplyAnimation(playerid,"STRIP","STR_C1",4.000000, 0, 1, 1, 1, 0);return 1;}
CMD:strip16(playerid,params[]){
ApplyAnimation(playerid,"STRIP","STR_C2",4.000000, 0, 1, 1, 1, 0);return 1;}
CMD:strip17(playerid,params[]){
ApplyAnimation(playerid,"STRIP","STR_C2B",4.1,7,5,1,1,1);return 1;}
CMD:strip18(playerid,params[]){
ApplyAnimation(playerid,"STRIP","STR_Loop_A",4.1,7,5,1,1,1);return 1;}
CMD:strip19(playerid,params[]){
ApplyAnimation(playerid,"STRIP","STR_Loop_C",4.1,7,5,1,1,1);return 1;}
CMD:strip20(playerid,params[]){
ApplyAnimation(playerid,"STRIP","STR_Loop_B",4.1,7,5,1,1,1);return 1;}
//============================== sentado ===================================
CMD:echarse(playerid,params[]){
ApplyAnimation(playerid,"SUNBATHE","SitnWait_in_W",4.000000, 0, 0, 0, 1, 0);return 1;}
//------------------------------- puta -----------------------------------------
CMD:asientosexi(playerid,params[]){
ApplyAnimation(playerid,"SUNBATHE","ParkSit_W_idleA",4.000000, 0, 1, 1, 1, 0);
SendClientMessage(playerid, 0x339900AA, "para continuar /pararse");return 1;}
//================================ Skate ===================================
CMD:skate(playerid,params[]){
SendClientMessage(playerid, 0xAA3333AA, "/skate 1 2 y 3");return 1;}
CMD:skate1(playerid,params[]){
ApplyAnimation(playerid,"SKATE","skate_run",4.0,1,1,1,1,500);return 1;}
CMD:skate2(playerid,params[]){
ApplyAnimation(playerid,"SKATE","skate_sprint",4.0,1,1,1,1,500);return 1;}
CMD:skate3(playerid,params[]){
ApplyAnimation(playerid,"SKATE","skate_idle",4.0,1,1,1,1,500);return 1;}
//=============================== patada ===================================
CMD:patada(playerid,params[]){ApplyAnimation(playerid,"FIGHT_C","FightC_2",4.1,7,5,1,1,1);return 1;}
//=============================== dansa ====================================
CMD:danzar(playerid,params[]){
SendClientMessage(playerid, 0xAA3333AA, "/danzar[0-12]");return 1;}
CMD:danzar0(playerid,params[]){
ApplyAnimation(playerid,"DANCING","bd_clap",4.1,7,5,1,1,1);return 1;}
CMD:danzar1(playerid,params[]){
ApplyAnimation(playerid,"DANCING","bd_clap1",4.1,7,5,1,1,1);return 1;}
CMD:darnzar2(playerid,params[]){
ApplyAnimation(playerid,"DANCING","dance_loop",4.1,7,5,1,1,1);return 1;}
CMD:darnzar3(playerid,params[]){
ApplyAnimation(playerid,"DANCING","DAN_Down_A",4.1,7,5,1,1,1);return 1;}
CMD:darnzar4(playerid,params[]){
ApplyAnimation(playerid,"DANCING","DAN_Left_A",4.1,7,5,1,1,1);return 1;}
CMD:darnzar5(playerid,params[]){
ApplyAnimation(playerid,"DANCING","DAN_Loop_A",4.1,7,5,1,1,1);return 1;}
CMD:darnzar6(playerid,params[]){
ApplyAnimation(playerid,"DANCING","DAN_Right_A",4.1,7,5,1,1,1);return 1;}
CMD:darnzar7(playerid,params[]){
ApplyAnimation(playerid,"DANCING","DAN_Up_A",4.1,7,5,1,1,1);return 1;}
CMD:darnzar8(playerid,params[]){
ApplyAnimation(playerid,"DANCING","dnce_M_a",4.1,7,5,1,1,1);return 1;}
CMD:darnzar9(playerid,params[]){
ApplyAnimation(playerid,"DANCING","dnce_M_b",4.1,7,5,1,1,1);return 1;}
CMD:darnzar10(playerid,params[]){
ApplyAnimation(playerid,"DANCING","dnce_M_c",4.1,7,5,1,1,1);return 1;}
CMD:darnzar11(playerid,params[]){
ApplyAnimation(playerid,"DANCING","dnce_M_d",4.1,7,5,1,1,1);return 1;}
CMD:darnzar12(playerid,params[]){
ApplyAnimation(playerid,"DANCING","dnce_M_e",4.1,7,5,1,1,1);return 1;}
//===========================================================================
CMD:fumar2(playerid,params[]){
ApplyAnimation(playerid,"SMOKING","F_smklean_loop", 4.0, 1, 0, 0, 0, 0);return 1;}
CMD:fumar3(playerid,params[]){
ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop", 4.0, 1, 0, 0, 0, 0);return 1;}
CMD:asustado(playerid,params[]){
ApplyAnimation(playerid,"PED","handscower",4.1,0,1,1,1,1);return 1;}
CMD:taxi(playerid,params[]){
ApplyAnimation(playerid,"PED","IDLE_taxi",4.1,0,1,1,1,1);return 1;}
CMD:adolorido(playerid,params[]){
ApplyAnimation(playerid,"PED","KO_shot_stom",4.1,0,1,1,1,1);return 1;}
CMD:seacabo(playerid,params[]){
ApplyAnimation(playerid,"PED","Shove_Partial",4.1,0,1,1,1,1);return 1;}
CMD:correr(playerid,params[]){
ApplyAnimation(playerid,"PED","sprint_civi",4.0,1,1,1,1,500);return 1;}
CMD:fuerza(playerid,params[]){
ApplyAnimation(playerid,"benchpress","gym_bp_celebrate",4.1,0,1,1,1,1);return 1;}
CMD:chorizo(playerid,params[]){
ApplyAnimation(playerid,"PED","WALK_gang1",4.0,1,1,1,1,500);return 1;}
CMD:tullio(playerid,params[]){
ApplyAnimation(playerid,"PED","WALK_old",4.0,1,1,1,1,500);return 1;}
CMD:mujer(playerid,params[]){
ApplyAnimation(playerid,"PED","WOMAN_walkpro",4.0,1,1,1,1,500);return 1;}
CMD:asco(playerid,params[]){
ApplyAnimation(playerid,"FOOD","EAT_Vomit_SK",4.1,0,1,1,1,1);
SendClientMessage(playerid, 0x339900AA, "guacala");return 1;}
CMD:quepa(playerid,params[]){
ApplyAnimation(playerid,"GANGS","hndshkea",4.1,0,1,1,1,1);
SendClientMessage(playerid, 0x339900AA, "Que te pasa loco");return 1;}
CMD:wooo(playerid,params[]){
ApplyAnimation(playerid,"ON_LOOKERS","shout_02",4.1,7,5,1,1,1);
SendClientMessage(playerid, 0x339900AA, "wooooo");return 1;}
CMD:quepasa(playerid,params[]){
ApplyAnimation(playerid,"GHANDS","gsign1LH",4.1,0,1,1,1,1);
SendClientMessage(playerid, 0x339900AA, "que pasa!!");return 1;}
CMD:alsar(playerid,params[]){
ApplyAnimation(playerid,"GHANDS","gsign2LH",4.1,0,1,1,1,1);
SendClientMessage(playerid, 0x339900AA, "que pasa!!");return 1;}
CMD:cansado(playerid,params[]){
ApplyAnimation(playerid,"PED","WOMAN_runfatold",4.1,7,5,1,1,1);
SendClientMessage(playerid, 0x339900AA, "haaa");return 1;}
CMD:superpatada(playerid,params[]){
ApplyAnimation(playerid,"FIGHT_C","FightC_3",4.1,0,1,1,1,1);
SendClientMessage(playerid, 0x339900AA, "haaa");return 1;}
CMD:comodo(playerid,params[]){
ApplyAnimation(playerid,"INT_HOUSE","LOU_In",4.1,0,1,1,1,1);
SendClientMessage(playerid, 0x339900AA, "estas comodo");return 1;}
CMD:mear(playerid, params[]) { SetPlayerSpecialAction(playerid, 68); return 1;}
//==============================================================================
CMD:ir(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new Float:poz[3],id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, ROJO, "Usa: /Ir [id]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "ID incorrecta o jugador no conectado.");
	if(id == playerid) return SendClientMessage(playerid, ROJO, "No puedes ir a ti mismo.");
	GetPlayerPos(id, poz[0], poz[1], poz[2]);
	SetPlayerInterior(playerid,GetPlayerInterior(id));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
	SetPlayerPos(playerid, poz[0], poz[1], poz[2]);
	return 1;
}

CMD:no(playerid,params[])
{
	ClearAnimations(playerid);
	return 1;
}

COMMAND:burn(playerid, params[])
{
	new ID,str[128];
    if(sscanf(params, "r", ID)) return SendClientMessage(playerid, GRIS,"Usa: /burn [playerid / Nombre]");
    if(!IsPlayerConnected(ID)) return SendClientMessage(playerid, 0xFF0000FF, "Usuario no conectado.");
    format(str, sizeof(str),"Haz quemado a %s!",Nombre(ID));
    SendClientMessage(playerid, 0xFF9900AA,str);
    new Float:burnx, Float:burny, Float:burnz;
    GetPlayerPos(ID,burnx,burny,burnz);
    CreateExplosion(burnx,burny,burnz,0,10.0);
	return 1;
}




CMD:est(playerid, const params[])
{
	new cadena[350],str[35],vip[10],id;
	if(sscanf(params, "d", id))
	{
		if(Info[playerid][VIP] > 0) vip = "Si";
		else vip = "No";
		new wanted = GetPlayerWantedLevel(playerid),dinero = Info[playerid][Dinero];
		format(cadena, sizeof(cadena), "{FFFFFF}» {cc33ff}Score: {ffffff}%d\n» {cc33ff}Dinero: {00A000}$%d\n{ffffff}» {cc33ff}Muertes: {ffffff}%d\n» {cc33ff}Coins: {ffffff}%d\n» {cc33ff}Vip: {ffffff}%s\n» {cc33ff}Búsqueda: {ffffff}%d\n» {cc33ff}Duelos Ganados: {ffffff}%d\n» {cc33ff}Duelos perdidos: {ffffff}%d\n",Info[playerid][Score],dinero,Info[playerid][Muertes],Info[playerid][Coins],vip,wanted,Info[playerid][DuelosGanados],Info[playerid][DuelosPerdidos]);
		ShowPlayerDialog(playerid, 2019, DIALOG_STYLE_MSGBOX, "Estadisticas", cadena, "Cerrar", "");
	}
	else
	{
		if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "Jugador no conectado");
		if(Info[id][VIP] > 0) vip = "Si";
		else vip = "No";
		format(str, sizeof(str), "Estadisticas de %s", Nombre(id));
		new wanted = GetPlayerWantedLevel(id),dinero = Info[id][Dinero];
		format(cadena, sizeof(cadena), "{FFFFFF}» {cc33ff}Score: {ffffff}%d\n» {cc33ff}Dinero: {00A000}$%d\n{ffffff}» {cc33ff}Muertes: {ffffff}%d\n» {cc33ff}Coins: {ffffff}%d\n» {cc33ff}Vip: {ffffff}%s\n» {cc33ff}Búsqueda: {ffffff}%d\n» {cc33ff}Duelos Ganados: {ffffff}%d\n» {cc33ff}Duelos perdidos: {ffffff}%d\n",Info[id][Score],dinero,Info[id][Muertes],Info[id][Coins],vip,wanted,Info[id][DuelosGanados],Info[id][DuelosPerdidos]);
		ShowPlayerDialog(playerid, 2019, DIALOG_STYLE_MSGBOX, str, cadena, "Cerrar", "");
	}
	return 1;
}

CMD:cmundo(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new mundoid;
	if(sscanf(params, "d", mundoid)) SendClientMessage(playerid, ROJO, "Usa: /Cmundo [mundo id]");
	SetPlayerVirtualWorld(playerid, mundoid);
	return 1;
}

CMD:cc(playerid)
{
	if(Info[playerid][AdminNivel] >= 3)
	{
		new AdmRank[25];
		for(new x=0; x<70; x++) SendClientMessageToAll(-1," ");
		switch(Info[playerid][AdminNivel])
		{
			case 1: AdmRank = "Youtuber";
			case 2: AdmRank = "Ayudante";
			case 3: AdmRank = "Moderador";
			case 4: AdmRank = "Moderador Global";
			case 5: AdmRank = "Moderador Técnico";
			case 6: AdmRank = "Administrador";
			case 7: AdmRank = "Fundador";
		}
		SendFormattedMessageToAll(-1,"El %s %s ha borrado el log.",AdmRank,Nombre(playerid));
	}
	return 1;
}

CMD:espawn(playerid)
{
	if(Info[playerid][AdminNivel] >= 3)
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && EnEvento[i]) SpawnPlayer(i);
		}
	}
	else return -1;
	return 1;
}

CMD:spawnall(playerid)
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	foreach(Player,i)
	{
		SpawnPlayer(i);
	}
	return 1;
}

CMD:spawn(playerid, const params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new id;
	if(!sscanf(params, "d", id))
	{
		if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "Jugador no conectado");
		SendFormattedMessage(playerid,-1,"Haz spawneado a %s.",Nombre(id));
		SpawnPlayer(id);
	}
	else
	{
		SpawnPlayer(playerid);
	}
	return 1;
}

CMD:kill(playerid, const params[])
{
	if(Sancion[playerid] == 1) return SendClientMessage(playerid, -1, "No puedes usar este comando estando sancionado");
	if(EnEvento[playerid] == 1) return SendClientMessage(playerid, -1, "No puedes usar este comando en evento, si quieres salir usa /salir");
	if(EnDuelo[playerid] == 1) return SendClientMessage(playerid, -1, "No puedes usar este comando estando en un duelo.");
	if(GetPVarInt(playerid, "Congelado")==1) return SendClientMessage(playerid, ROJO, "Estás congelado se te ha desactvado /Kill");
	SetPlayerHealth(playerid, 0);
	return 1;
}

CMD:reportes(playerid){
    if(Info[playerid][AdminNivel] < 2) return -1;
    new str[128], dialog[800], detalles[5], cont = 0;
    for(new i = 0; i < MAX_REPORTES; i++){//Realizamos un buscador con el for
        if(Reportes[i][Activo] == true){//Detectamos al administrador en servicio
            strmid(detalles, Reportes[i][TextReporte], 0, 5);//Extraemos solo 5 letras de los detalles para previsualizar el reporte
            format(str, sizeof(str), "%s a %s Detalles: %s...\n", Reportes[i][Reportante], Reportes[i][Reportado], detalles);//Ponemos el formato del dialog
            strcat(dialog, str);//Hacemos un strcat para unir las cadenas de todo el bucle
            cont++;//Realizamos un conteo general para ver cuantos reportes tenemos activos
        }
    }
    if(!cont){
        SendClientMessage(playerid, -1, "[REPORTES]: No cuentas con reportes activos en estos momentos.");
    }
    else{
        SetPVarInt(playerid, "PDialog", 0);//Señalamos el paso del dialog para no andar llenando de ID los dialogos
        ShowPlayerDialog(playerid, D_REPORTES, DIALOG_STYLE_LIST, "Reportes", dialog, "Detalles", "Salir");
        format(str, sizeof(str), "[REPORTES]: Cuentas con %d reportes activos, Si quiere limpiar los reportes usar /qreportes.", cont);
        SendClientMessage(playerid, -1, str);
    }
    return 1;
}

CMD:reportar(playerid, params[]){
    new id, reporte[100];
    if(!sscanf(params, "p< >us[100]", id, reporte) && IsPlayerConnected(id)){//Detectamos los campos y extramemos las variables de la cadena y comprobamos si ID esta conectado
        new str[128], cont = 0;//Creamos la cadena de almacenamiento y el conteo para verificar si en realidad se envia el reporte
        format(str, sizeof(str),"[REPORTE]: {ff0000}%s{ffffff} a {ff0000}%s{ffffff}: %s.", NombrePJ(playerid), NombrePJ(id), reporte);
        foreach(Player,i)
        {
            if(Info[i][AdminNivel] > 1 && OnDuty[i] == 1)
            {
                SendClientMessage(i, -1, str);
                cont++;
            }
        }
        if(!cont) SendClientMessage(playerid, -1, "Su reporte no fue enviado, no contamos con administradores en servicio.");
        else {
            GenerarReporte(playerid, id, reporte);
        }
    }
    else SendClientMessage(playerid, -1, "Usar: /reportar [ID JUGADOR] [REPORTE].");
    return 1;
}

CMD:team(playerid, const params[])
{
	if(Sancion[playerid] == 1) return SendClientMessage(playerid, -1, "No puedes usar este comando estando sancionado");
	if(EnCombate[playerid] == 1) return SendClientMessage(playerid, -1, "No puedes cambiar tu equipo estando en combate");
	if(GetPVarInt(playerid, "Congelado")==1) return SCM(playerid,ROJO,"Estás congelado se te ha desactivado este comando");
	ShowPlayerDialog(playerid, CHANGETEAM, DIALOG_STYLE_TABLIST_HEADERS, "Cambiar tu equipo", EQUIPOS, "Cambiar", "Cancelar");
	return 1;
}

CMD:cinterior(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new interiorid;
	if(sscanf(params, "d", interiorid)) return SendClientMessage(playerid, ROJO, "Usa: /Cinterior [interior id]");
	SetPlayerInterior(playerid, interiorid);
	return 1;
}

CMD:spec(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, ROJO, "Usa: /Spec [id]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, OFFLINE);
	if(id == playerid) return SendClientMessage(playerid, ROJO, "No puedes espiarte a ti mismo");
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
	SetPlayerInterior(playerid, GetPlayerInterior(id));
	SendFormattedMessage(playerid,-1,"Comienzas a espiar a %s.",Nombre(id));
	TogglePlayerSpectating(playerid, 1);
	PlayerSpectatePlayer(playerid, id);
	SpecteandoA[playerid] = id;
	return 1;
}

CMD:specoff(playerid)
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	SendFormattedMessage(playerid,-1,"Dejaste de espiar a %s.",Nombre(SpecteandoA[playerid]));
	TogglePlayerSpectating(playerid, 0);
	SpecteandoA[playerid] = INVALID_PLAYER_ID;
	return 1;
}

CMD:congelar(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 2) return -1;
	new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, ROJO, "/Congelar [id]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "Jugador no conectado");
	SendFormattedMessage(playerid,-1,"Haz congelado a %s.",Nombre(id));
	format(text, 128, "El administrador %s te ha congelado", Nombre(playerid));
	SendClientMessage(id, -1, text);
	TogglePlayerControllable(id, 0);
	SetPVarInt(id, "Congelado", 1);
	return 1;
}

CMD:darchaleco(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new id,Float:chaleco;
	if(sscanf(params, "df", id,chaleco)) return SendClientMessage(playerid, ROJO, "Usa: /darchaleco [id] [chaleco]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "Jugador no conectado");
	SendFormattedMessage(playerid,-1,"Le haz dado %2.0f de chaleco a %s.",chaleco,Nombre(id));
	format(text, 128, "El administrador %s te ha dado %2.0f de chaleco.",Nombre(playerid),chaleco);
	SendClientMessage(id, -1, text);
	SetPlayerArmour(id, chaleco);
	return 1;
}

CMD:traer(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new id;
	new Float:Pos[3];
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, GRIS, "Usa: /Traer [id]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "Jugador no conectado");
	if(id == playerid) return SendClientMessage(playerid, ROJO, "No puedes traerte a ti mismo.");
	if(EnDuelo[id] == 1)return SendClientMessage(playerid, -1, "El jugador está en duelo.");
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	SetPlayerPos(id, Pos[0], Pos[1], Pos[2]+1);
	SetPlayerInterior(id, GetPlayerInterior(playerid));
	SetPlayerVirtualWorld(id, GetPlayerVirtualWorld(playerid));
	return 1;
}

CMD:traertodos(playerid)
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new Float:Pos[3];
	foreach(Player,i)
	{
		if(!EnDuelo[i])
		{
			GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
			SetPlayerPos(i, Pos[0],Pos[1], Pos[2]+1);
			SetPlayerInterior(i, GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
		}
	}
	SendClientMessage(playerid, -1, "Haz traido a todos a tu posición");
	return 1;
}


CMD:duty(playerid)
{
	if(Info[playerid][AdminNivel] < 2) return -1;
	if(OnDuty[playerid] == 1)
	{
		new adm[25];
		switch(Info[playerid][AdminNivel])
		{
			case 1: adm = "Youtuber";
			case 2: adm = "Ayudante";
			case 3: adm = "Moderador";
			case 4: adm = "Moderador Global";
			case 5: adm = "Moderador Técnico";
			case 6: adm = "Administrador";
			case 7: adm = "Fundador";
		}
		OnDuty[playerid] = 0;
		God[playerid] = 0;
		SetPlayerHealth(playerid, 100);
		SetPlayerColor(playerid, Colorduty[playerid]);
		SendClientMessage(playerid, -1, "Te has puesto off duty");
		SendFormattedMessageToAll(-1,"El (({8700FF}%s %s{FFFFFF})) se puso fuera de servicio.",adm,Nombre(playerid));
	}
	else
	{
		Colorduty[playerid] = GetPlayerColor(playerid);
		SetPlayerHealth(playerid, 100000);
		God[playerid] = 1;
		new adm[25],string[128];
		switch(Info[playerid][AdminNivel])
		{
			case 1: adm = "Youtuber";
			case 2: adm = "Ayudante";
			case 3: adm = "Moderador";
			case 4: adm = "Moderador Global";
			case 5: adm = "Moderador Técnico";
			case 6: adm = "Administrador";
			case 7: adm = "Fundador";
		}
		OnDuty[playerid] = 1;
		format(string, sizeof(string), "El (({8700FF}%s %s{FFFFFF})) se ha puesto en servicio, usa /re para reportar.", adm,Nombre(playerid));
		SendClientMessageToAll(-1, string);
		SetPlayerColor(playerid, MORADO);
	}
	return 1;
}

CMD:time(playerid,params[])
{
	new timeid;
	if(sscanf(params, "d", timeid)) return SendClientMessage(playerid, GRIS, "Usa: /Time [hora]");
	if(timeid > 24) return SendClientMessage(playerid, -1, "24 Horas");
	SetPlayerTime(playerid, timeid, 0);
	SetPVarInt(playerid, "horatmp", timeid);
	return 1;
}

CMD:crash(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 2) return -1;
	new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, GRIS, "Usa: /Crash [id]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, GRIS, "ID incorrecta o jugador no conectado.");
	GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 1000, 0);
	GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 2000, 1);
	GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 3000, 2);
	GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 4000, 3);
	GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
	GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 6000, 5);
	GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 7000, 6);
	new str[128];
	format(str, sizeof(str), "Has crasheado a %s", Nombre(id));
	SendClientMessage(playerid, -1, str);
	return 1;
}

CMD:killtodos(playerid)
{
	if(Info[playerid][AdminNivel] < 2) return -1;
	for(new i=0; i<GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && i != playerid)
		{
			SetPlayerHealth(i, 0);
		}
	}
	return 1;
}

CMD:pagar(playerid, const params[])
{
	new id,money,msj[128],dinero = Info[playerid][Dinero];
	if(sscanf(params, "dd", id,money)) return SendClientMessage(playerid, GRIS, "Usa: /Pagar [ID] [Cantidad]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, GRIS, "ID incorrecta o jugador no conectado.");
	if(id == playerid) return 1;
	if(dinero < money) return SendClientMessage(playerid, GRIS, "No tienes esa cantidad de dinero para enviar.");
	if(money == 0) return SendClientMessage(playerid, GRIS, "Cantidad inválida.");
	format(msj, sizeof(msj), "Se te ha descontado dinero por enviar a %s, Total: {3e9c35}%d$ ",Nombre(id),money);
	SendClientMessage(playerid, -1, msj);
	format(msj, sizeof(msj), "%s(%i) Te ha enviado dinero, Total: {3e9c35}%d$ ",Nombre(playerid),playerid,money);
	SendClientMessage(id, -1, msj);
	GivePlayerMoney(playerid, -money);
	GivePlayerMoney(id, money);
	Info[playerid][Dinero]-=money;
	Info[id][Dinero]+=money;
	return 1;
}

CMD:descongelarall(playerid)
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	SendClientMessage(playerid, -1, "Se han descongelado todos.");
	for(new i=0;i<GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && Info[i][Logged] == 1 && i != playerid)
		{
			TogglePlayerControllable(i, true);
			SetPVarInt(i, "Congelado", 0);
		}
	}
	return 1;
}

CMD:congelarall(playerid)
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	for(new i=0;i<GetMaxPlayers();i++)
	{
		if(IsPlayerConnected(i) && Info[i][Logged] == 1 && i != playerid)
		{
			TogglePlayerControllable(i, false);
			SetPVarInt(i, "Congelado", 1);
		}
	}
	SendClientMessage(playerid, -1, "Se han congelado todos.");
	return 1;
}


CMD:darvidaall(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new Float:health;
	if(sscanf(params, "f",health)) return SendClientMessage(playerid, -1, "Usa: /Darvidaall [cantidad]");
	if(health == 0) return SendClientMessage(playerid, -1, "Si quieres hacer esto usa /killtodos.");
	SendFormattedMessage(playerid,-1,"Le has dado %2.0f de vida a todos.",health);
	for(new i=0; i<GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && Info[i][Logged] == 1)
		{
			SetPlayerHealth(i, health);
		}
	}
	return 1;
}

CMD:darchalecoall(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new Float:armour;
	if(sscanf(params, "f",armour)) return SendClientMessage(playerid, -1, "Usa: /darchalecoall [cantidad]");

	for(new i=0; i<GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && Info[i][Logged] == 1)
		{
			SetPlayerArmour(i, armour);
		}

	}
	SendFormattedMessage(playerid,-1,"Le has dado %2.0f de chaleco a todos.",armour);
	return 1;
}

CMD:resetmoney(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, -1, "Usa: /resetmoney [id]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "Jugador no conectado");
	SendFormattedMessage(playerid,-1,"Le haz restablecido el dinero a %s.",Nombre(id));
	format(text, 128, "El administrador %s te ha restablecido tu dinero.", Nombre(playerid));
	ResetPlayerMoney(id);
	return 1;
}

CMD:setscore(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 5) return -1;
	new id,score;
	if(sscanf(params, "dd", id,score)) return SendClientMessage(playerid, -1, "Usa: /setscore [id] [score]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "Jugador no conectado");
	SendFormattedMessage(playerid,-1,"Le haz establecido %d de score a %s",score,Nombre(id));
	format(text, 128, "El administrador %s te ha establecido %d de score.",Nombre(playerid),score);
	SendClientMessage(id, -1, text);
	SetPlayerScore(id, score);
	Info[id][Score]=score;
	return 1;
}

CMD:setmoney(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 5) return -1;
	new id,money;
	if(sscanf(params, "dd", id,money)) return SendClientMessage(playerid, -1, "Usa: /Setmoney [id] [dinero]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "Jugador no conectado");
	SendFormattedMessage(playerid,-1,"Le haz establecido %d$ de dinero a %s.",money,Nombre(id));
	format(text, 128, "El administrador %s te ha establecido %d$ de dinero.",Nombre(playerid),money);
	SendClientMessage(id, -1, text);
	ResetPlayerMoney(id);
	GivePlayerMoney(id, money);
	Info[playerid][Dinero]=money;
	return 1;
}

CMD:dardinero(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 7) return -1;
	new id,money,razon[20],query[128];
	if(sscanf(params, "ddS(sin razón)[20]", id,money,razon)) return SendClientMessage(playerid, ROJO, "Usa: /Dardinero [id] [Dinero] [Razón(opcional)]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, GRIS, "ID incorrecta o jugador no conectado.");
	SendFormattedMessage(playerid,-1,"Le Haz dado %d$ a %s.",money,Nombre(id));
	format(text, 128, "El administrador %s te ha dado %d$", Nombre(playerid),money);
	SendClientMessage(id, -1, text);
	GivePlayerMoney(id, money);
	Info[id][Dinero]+=money;
	format(query, 128, "[INFO]: %s le dió (%d) de dinero a %s, razón: [ %s ].",Nombre(playerid),money,Nombre(id),razon);
	ASCM(0xFF4D71FF,query,2);
	GuardarArchivo("dar_dinero.log",query);
	return 1;
}

CMD:darscore(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 7) return -1;
	new id,score,razon[20],query[128];
	if(sscanf(params, "ddS(sin razón)[20]", id,score,razon)) return SendClientMessage(playerid, ROJO, "Usa: /Darscore [id] [Score] [Razón(opcional)]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, GRIS, "ID incorrecta o jugador no conectado.");
	SendFormattedMessage(playerid,-1,"Haz dado %d de score a %s.",score,Nombre(id));
	format(text, sizeof(text), "El administrador %s te ha dado %d de score.", Nombre(playerid),score);
	SendClientMessage(id, -1, text);
	SetPlayerScore(id, GetPlayerScore(id)+score);
	Info[id][Score] = GetPlayerScore(id)+score;
	format(query, 128, "[INFO]: %s le dió (%d) de score a %s, razón: [ %s ].",Nombre(playerid),score,Nombre(id),razon);
	ASCM(0xFF4D71FF,query,2);
	GuardarArchivo("dar_score.log",query);
	return 1;
}

CMD:quitararmas(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 2) return -1;
	new id;
	if(sscanf(params, "r", id)) return SendClientMessage(playerid, ROJO, "Usa: /Quitararmas [id/nombre]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "ID incorrecta o jugador no conectado.");
	SendFormattedMessage(playerid,-1,"Haz desarmado a %s.",Nombre(id));
	ResetPlayerWeapons(id);
	return 1;
}

CMD:desmutear(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 1) return -1;
	new id;
	if(sscanf(params, "r", id)) return SendClientMessage(playerid, ROJO, "Usa: /Desmutear [id/nombre]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "ID incorrecta o jugador no conectado.");
	if(Info[id][Muteado]==0) return SendClientMessage(playerid, -1, "El jugador no está silenciado");
	Info[id][Muteado] = 0;
	new string[128];
	format(string, sizeof(string), "%s Fue desilenciado.", Nombre(id));
	SendClientMessageToAll(-1, string);
	return 1;
}

CMD:mutear(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 1) return -1;
	new id,razon[128];
	if(sscanf(params, "rs[128]", id,razon)) return SendClientMessage(playerid, ROJO, "Usa: /Mutear [id/nombre] [Razón]");
	if(id == playerid) return SendClientMessage(playerid, ROJO, "No puedes mutearte a ti mismo");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "ID incorrecta o jugador no conectado.");
	Info[id][Muteado] = 1;
	new string[128];
	format(string, sizeof(string), "%s Fue silenciado por %s, razón: {FF0000}%s{FFFFFF}.",Nombre(id),Nombre(playerid),razon);
	SendClientMessageToAll(-1, string);
	return 1;
}


CMD:dararma(playerid,params[])
{
	if(Info[playerid][AdminNivel] <5) return -1;
	new id,weaponid,weapname[26];
	if(sscanf(params, "rd", id,weaponid)) return SendClientMessage(playerid, ROJO, "Usa: /Dararma [id/nombre] [Arma ID]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "ID incorrecta o jugador no conectado.");
	if(!IsValidWeapon(weaponid))return SendClientMessage(playerid, ROJO, "Arma inválida.");
	GetWeaponName(weaponid, weapname, sizeof(weapname));
	SendFormattedMessage(playerid,-1,"Le has dado el arma ID %d a %s.",weaponid,Nombre(id));
	format(text, sizeof(text), "%s Te ha dado el arma %s ID %d",Nombre(playerid),weapname,weaponid);
	SendClientMessage(id, -1, text);
	GivePlayerWeapon(id, weaponid, 100000);
	return 1;
}

CMD:descongelar(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 2) return -1;
	new id;
	if(sscanf(params, "d", id)) return SendClientMessage(playerid, ROJO, "Usa: /Descongelar [id]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "Jugador no conectado");
	SendFormattedMessage(playerid,-1,"Haz descongelado a %s.",Nombre(id));
	TogglePlayerControllable(id, 1);
	SetPVarInt(id, "Congelado", 0);
	return 1;
}

funcion bool:StartFly(playerid)
{
		if(OnFly[playerid])
		return false;
		OnFly[playerid] = true;
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		SetPlayerPos(playerid,x,y,z+5.0);
		ApplyAnimation(playerid,"PARACHUTE","PARA_steerR",6.1,1,1,1,1,0,1);
		Fly(playerid);
		return true;
}

CMD:volar(playerid)
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	StartFly(playerid);
	return 1;
}

funcion bool:StopFly(playerid)
{
		if(!OnFly[playerid])
		return false;
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		SetPlayerPos(playerid,x,y,z);
		OnFly[playerid] = false;
		return true;
}

CMD:dvolar(playerid)
{
	if(Info[playerid][AdminNivel] < 3) return -1;
	StopFly(playerid);
	return 1;
}

CMD:getcpos(playerid, params[])
{
 if(Info[playerid][AdminNivel] < 3) return -1;
 new Float:cxp, Float:cyp, Float:czp, str[256], fName[60];
 if(sscanf(params, "s[60]", fName)) return SendClientMessage(playerid, 0xFF0000, "Usage: /getcpos (coordinate_name) {FFFFFF} | Example: /getcpos sf camera point");
 GetPlayerCameraPos(playerid, cxp, cyp, czp);
 format(str, sizeof(str), "Camera coordinate name:%s | X:%f | Y:%f |Z:%f | Function: SetPlayerCameraPos(playerid, %f, %f, %f); /***/ \r\n", fName, cxp, cyp, czp, cxp, cyp, czp);
 new File:cpos = fopen("Camera_Coords.txt", io_append);
 if(cpos)
 {
  fwrite(cpos, str);
  fclose(cpos);
  SendClientMessage(playerid, 0xFF0000, "Camera position successfully generated!");
 }
 return 1;
}

CMD:kick(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 2) return -1;
	new id,Str[128],razon[128];
	if(sscanf(params, "ds[128]", id,razon)) return SendClientMessage(playerid, ROJO, "/Kick [id] [Razón]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "ID incorrecta o jugador no conectado");
	if(id == playerid) return SendClientMessage(playerid, ROJO, "No puedes patearte a ti mismo.");
	format(Str, sizeof(Str), "{FF0000}%s {FFFFFF}Fue pateado/kickeado del servidor, Razón: {FF0000}%s",Nombre(id),razon);
	SendClientMessageToAll(-1, Str);
	SetTimerEx("Kickear", 1000, false, "d", id);
	return 1;
}

CMD:nivel(playerid,params[])
{
	if(Info[playerid][AdminNivel] == 0) return -1;
	new tmp;
	if(sscanf(params, "d", tmp)) return SendClientMessage(playerid, -1, "Usa /nivel [1-7]");
	if(tmp >7) return SendClientMessage(playerid, -1, "Nivel incorrecto.");
	switch(tmp)
	{
		case 1:
		{
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, ""camarillo"Comandos nivel 1 Youtuber", ""cverde2"/mutear,/desmutear,/anuncio,/weaps", "Cerrar", "");
			return 1;
		}
		case 2:
		{
			if(Info[playerid][AdminNivel] == 1) return SendClientMessage(playerid, -1, "Solo ayudantes pueden ver /nivel 2.");
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, ""camarillo"Comandos administrativos nivel 2", ""cverde2"Todos los anteriores +\n/adv,/congelar,/descongelar,/musica,/crash,/san,/j,/announce2,/skin\n/kick,/killtodos,/quitararmas,/reportes,/qreportes,/m\nTeletransportarse marcando ubicación en el mapa.", "Cerrar", "");
			return 1;
		}
		case 3:
		{
			if(Info[playerid][AdminNivel] == 2) return SendClientMessage(playerid, -1, "Solo moderadores pueden ver /nivel 3.");
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, ""camarillo"Comandos administrativos nivel 3", ""cverde2"Todos los anteriores +\n/ann,/a,/god,/nogod,/slap,/cmundo,/cinterior,/congelarall,/descongelarall\n/ir,/traer,/spawn,/spec,/specoff,/traertodos,/liberar,/sancionados\n/volar,/dvolar,/resetmoney,/darchalecoall,/darvidaall,/cdl,/cc\n/crearevento,/abrirevento,/cerrarevento,/finevento,/eequipo,/oevento\n/uevento,/cevento,/dcevento,/traerevento,/earma,/eauto,/echaleco,/evida,/spawn", "Cerrar", "");

		}
		case 4:
		{
			if(Info[playerid][AdminNivel] == 3) return SendClientMessage(playerid, -1, "Solo moderadores globales pueden ver /nivel 4.");
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, ""camarillo"Comandos administrativos nivel 4", ""cverde2"Todos los anteriores +\n/car,/borrarautos,/respawncars,/timeall,/borrarautos,/a,/voz,/vozfem,/nc", "Cerrar", "");
		}
		case 5:
		{
			if(Info[playerid][AdminNivel] == 4) return SendClientMessage(playerid, -1, "Solo moderadores técnicos pueden ver /nivel 5.");
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, ""camarillo"Comandos administrativos nivel 5", ""cverde2"Todos los anteriores +\n/ban,/banm,/band,/darvida,/darchaleco,/setscore,/setmoney,/ncall", "Cerrar", "");
		}
		case 6:
		{
			if(Info[playerid][AdminNivel] == 5) return SendClientMessage(playerid, -1, "Solo administradores pueden ver /nivel 6.");
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, ""camarillo"Comandos administrativos nivel 6", ""cverde2"Todos los anteriores +\n/daradmin, /reiniciarsv, /mconfig, /banip, /ip,/move\n/F, /asay, /quitarvip, /guardarcuentas,/fakechat", "Cerrar", "");
		}
		case 7:
		{
			if(Info[playerid][AdminNivel] == 6) return SendClientMessage(playerid, -1, "Solo fundadores pueden ver /nivel 7.");
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, ""camarillo"Comandos administrativos nivel 7", ""cverde2"Todos los anteriores +\n/setadm - /cpanel, /darvip, /darcoins, /reiniciarsv, /darscore, /dardinero", "Cerrar", "");
		}

	}
	return 1;
}

CMD:ban(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 5) return -1;
	new id,string[128],Raz[128];
	if(sscanf(params, "ds[128]", id,Raz)) return SendClientMessage(playerid, GRIS, "Usa: /Ban [id] [Razón]");
	if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "ID incorrecta o jugador no conectado.");
	format(string, sizeof(string), "{ff0000}%s {ffffff}Fue baneado del servidor, Razón: {ff0000}%s.",Nombre(id),Raz);
	SendClientMessageToAll(-1, string);
	SetTimerEx("BanearEx", 1000, false, "d", id);
	return 1;
}

CMD:cdl(playerid, const params[])
{
	if(Info[playerid][AdminNivel] >= 3)
	{
		for(new i = 0; i < 15; i++)
		{
		    SendDeathMessage(10001,10001,0);
		}
		new string[128];
		format(string,sizeof(string),"El administrador %s ha limpiado el log de las muertes",Nombre(playerid));
		SendClientMessageToAll(AZUL,string);
		return 1;
	}
	else return -1;
}

CMD:creditos(playerid, const params[])
{
	new string[450],thanks[128];
	format(thanks, sizeof(thanks), "Damos las gracias a {cc33ff}%s{FFFFFF} por estar aquí",Nombre(playerid));
	strcat(string, "{ffffff}* Creditos Oficiales:\n");
	strcat(string, "• Dueños: {cc33ff}ecko - Dkyzer{ffffff}\n");
	strcat(string, "• Programador general: {cc33ff}eck0, Dkyzer{ffffff}\n");
	strcat(string, "• Optimización, edición y agregado de sistemas: {cc33ff}eck0{ffffff}\n");
	strcat(string, "• Mapeos: {cc33ff}Dkyzer{ffffff}\n");
	strcat(string, "• Página web: {cc33ff}tdm.darkshots.net{ffffff}.\n");
	strcat(string, "• Y lo ultimo más importante\n");
	strcat(string, thanks);
	ShowPlayerDialog(playerid, 2018, DIALOG_STYLE_MSGBOX, "Creditos", string, "Cerrar", "");
	PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
	return 1;
}

CMD:topv(playerid)
{
	mysql_pquery(con, "SELECT `Nombre`, `Score` FROM `usuarios` WHERE `Score` > 0 AND `VIP` = 1 ORDER BY `Score` DESC LIMIT 10", "OnShowScores2", "d", playerid);
	return 1;
}

CMD:top(playerid)
{
	mysql_pquery(con, "SELECT `Nombre`, `Score` FROM `usuarios` WHERE `Score` > 0 ORDER BY `Score` DESC LIMIT 10", "OnShowScores", "d", playerid);
	return 1;
}

funcion OnShowScores2(playerid)
{
	new rows = cache_num_rows(),string[300],Escore,nameplayer[MAX_PLAYER_NAME];
	if(rows > 0)
	{
		string = "{FFFFFF}Lista 10 mejores scores VIP\n\n";
		for(new i=0; i<rows; i++)
		{
			cache_get_value_name_int(i, "Score", Escore);
			cache_get_value_name(i, "Nombre", nameplayer, MAX_PLAYER_NAME);
			format(string, sizeof(string), "%s#%d\t%s  %d Score\n",string,i+1,nameplayer,Escore);
		}
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Top Scores", string, "Cerrar", "");
	}
	return 1;
}

funcion OnShowScores(playerid)
{
	new rows = cache_num_rows(),string[300],Escore,nameplayer[MAX_PLAYER_NAME];
	if(rows > 0)
	{
		string = "{FFFFFF}Lista 10 mejores scores\n\n";
		for(new i=0; i<rows; i++)
		{
			cache_get_value_name_int(i, "Score", Escore);
			cache_get_value_name(i, "Nombre", nameplayer, MAX_PLAYER_NAME);
			format(string, sizeof(string), "%s#%d\t%s  %d Score\n",string,i+1,nameplayer,Escore);
		}
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Top Scores", string, "Cerrar", "");
	}
	return 1;
}

CMD:miembros(playerid)
{
    switch(Owner[playerid])
    {
        case EnVenta:
        {
            mysql_pquery(con, "SELECT `Nombre`,`Owner`,`Autorizado` FROM `usuarios` WHERE `Invitado` = 52 ORDER BY `Owner` DESC",
                "OnMemberShow", "d", playerid);
        }

        case eTeam:
        {
            mysql_pquery(con, "SELECT `Nombre`,`Owner`,`Autorizado` FROM `usuarios` WHERE `Invitado` = 53 ORDER BY `Owner` DESC",
                "OnMemberShow", "d", playerid);
        }

        default:
        {
            SendClientMessage(playerid, -1, "No eres lider de ningun equipo.");
        }
    }
    return 1;
}

CMD:expulsaroff(playerid,params[])
{
	if(Owner[playerid] == 0)return SendClientMessage(playerid, -1, "No eres lider de ningun equipo.");
	new namedp[MAX_PLAYER_NAME],query[250];
	if(sscanf(params, "s[24]", namedp)) return SendClientMessage(playerid, -1, "Usa: /expulsaroff [nombre dp]");
	mysql_format(con, query, sizeof(query), "SELECT `Nombre`,`Invitado` FROM `usuarios` WHERE `Nombre` = '%s' AND `Invitado` = '%d'",namedp,Owner[playerid]);
	mysql_pquery(con, query, "OnMemberExit", "ds",playerid,namedp);
	return 1;
}

funcion OnMemberExit(playerid,name[])
{
	new rows = cache_num_rows(),frm[128];
	if(rows > 0)
	{
		{
			mysql_format(con, frm, 128, "UPDATE `usuarios` SET `Invitado` = '0',`Autorizado` = '0' WHERE `Nombre` = '%s'",name);
			mysql_query(con, frm);
			format(frm, 128, "Haz expulsado a %s de tu equipo verifique /miembros",name);
			SendClientMessage(playerid, -1, frm);
		}
	}
	else
	SendClientMessage(playerid, -1, "Ese nombre no pertenece a tu equipo vease /miembros");
	return 1;
}

CMD:admins(playerid, const params[])
{
	mysql_pquery(con, "SELECT `Nombre`, `AdminNivel`, `lastOn` FROM `usuarios` WHERE `AdminNivel` > 1 ORDER BY `AdminNivel` DESC", "OnShowAdmins", "d", playerid);
	return 1;
}

funcion OnMemberShow(playerid)
{
    new rows = cache_num_rows(), eBigString[750];
    if(rows > 0)
    {
        new ALevel, alevel2, name[MAX_PLAYER_NAME], AdmRank[35], rango, StatusPlayer[60];

        eBigString = "{FFFFFF}#.\t{FFFFFF}Member Name\t{FFFFFF}Rango\t{FFFFFF}Estado\n";

        for(new i = 0; i < rows; i++)
        {
            cache_get_value_name(i, "Nombre", name, 24);
            cache_get_value_name_int(i, "Owner", ALevel);
            cache_get_value_name_int(i, "Autorizado", alevel2);

            new isOnline = GetPlayerID(name);

            if(IsPlayerConnected(isOnline) && Info[isOnline][Logged] == 1)
                StatusPlayer = "{00CC00}• {FFFFFF}Online";
            else
                StatusPlayer = "{FF0000}• {FFFFFF}Offline";

            if(ALevel == Owner[playerid]) AdmRank = "Lider";
            else if(alevel2 == Owner[playerid]) AdmRank = "Sub Lider";
            else AdmRank = "User";

            switch(Owner[playerid])
            {
                case EnVenta:
                {
                    format(eBigString, sizeof(eBigString),
                    "%s{FFFFFF}#%d.\t{FF0000}%s\t{C0C0C0}%s(%d)\t%s\n",
                    eBigString, i+1, name, AdmRank, rango, StatusPlayer);
                }

                case eTeam:
                {
                    format(eBigString, sizeof(eBigString),
                    "%s{FFFFFF}#%d.\t{00AAFF}%s\t{C0C0C0}%s(%d)\t%s\n",
                    eBigString, i+1, name, AdmRank, rango, StatusPlayer);
                }
            }
        }

        ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "Miembros", eBigString, "Salir", "");
    }
    return 1;
}


CMD:youtubers(playerid)
{
	mysql_pquery(con, "SELECT `Nombre`, `AdminNivel`, `lastOn` FROM `usuarios` WHERE `AdminNivel` = 1 ORDER BY `AdminNivel` DESC", "OnShowYoutubers", "d", playerid);
	return 1;
}

funcion OnShowYoutubers(playerid)
{
	new rows = cache_num_rows(),eBigString[550];
	if(rows > 0)
	{
		new ALevel, name[MAX_PLAYER_NAME], StatusPlayer[60], LastOnline[30];
		eBigString = "{FFFFFF}#.\t{FFFFFF}Nombre\t{FFFFFF}Rango\t{FFFFFF}Estado\n";
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name_int(i, "AdminNivel", ALevel);
			cache_get_value_name(i, "Nombre", name,24);
			cache_get_value_name(i, "lastOn", LastOnline, 30);
			new isOnline = GetPlayerID(name);
			if(IsPlayerConnected(isOnline) && Info[isOnline][Logged] == 1) StatusPlayer = "{00CC00}• {FFFFFF}Online";
			else StatusPlayer = LastOnline;
			format(eBigString, sizeof(eBigString), "%s{FFFFFF}#%d.\t{C0C0C0}%s\tYT(%d)\t%s\n", eBigString,i+1,name,ALevel,StatusPlayer);
		}
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "Youtubers", eBigString, "Salir", "");
	}
	else SendClientMessage(playerid, -1, "No hay youtubers en este momento");
	return 1;
}

funcion OnShowAdmins(playerid)
{
	new rows = cache_num_rows(),eBigString[700];
	if(rows > 0)
	{
		new ALevel, name[MAX_PLAYER_NAME], AdmRank[35], StatusPlayer[60], LastOnline[30];
		eBigString = "{FFFFFF}#.\t{FFFFFF}Admin Name\t{FFFFFF}Rango\t{FFFFFF}Estado\n";
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name_int(i, "AdminNivel", ALevel);
			cache_get_value_name(i, "Nombre", name,24);
			cache_get_value_name(i, "lastOn", LastOnline, 30);
			new isOnline = GetPlayerID(name);
			if(IsPlayerConnected(isOnline)) StatusPlayer = "{00CC00}• {FFFFFF}Online"; else StatusPlayer = LastOnline;
			switch(ALevel)
			{
				case 1: AdmRank = "Youtuber";
				case 2: AdmRank = "Ayudante";
				case 3: AdmRank = "Moderador";
				case 4: AdmRank = "Moderador Global";
				case 5: AdmRank = "Moderador Técnico";
				case 6: AdmRank = "Administrador";
				case 7: AdmRank = "Fundador";
			}
			format(eBigString, sizeof(eBigString), "%s{FFFFFF}#%d.\t{C0C0C0}%s\t%s(%d)\t%s\n", eBigString,i+1,name,AdmRank,ALevel,StatusPlayer);
		}
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "Administradores", eBigString, "Salir", "");
	}
	else ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "Administradores", "{FFFFFF}#.\t{FFFFFF}Admin Name\t{FFFFFF}Rango\t{FFFFFF}Estado\n#.\tAnti Cheat\tSA\t{00FF00}ON", "Salir", "");
	return 1;
}

CMD:daradmin(playerid,params[])
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name, sizeof(Name));
	if(Info[playerid][AdminNivel] > 5 || !strcmp(Permiso,Name,true) || !strcmp(Permiso2,Name,true) || !strcmp(Permiso3,Name,true))
	{
		new id,nivel,msg[128];
		if(sscanf(params, "rd", id,nivel)) return SendClientMessage(playerid, GRIS, "Usa: /daradmin [ID/Nombre] [Nivel]");
		if(IsPlayerConnected(id)==0) return SendClientMessage(playerid, ROJO, "ID incorrecta o jugador no conectado.");
		if(!Info[id][Logged]) return SendClientMessage(playerid, -1, "El jugador no se ha identificado");
		if(nivel == Info[id][AdminNivel]) return SendClientMessage(playerid, ROJO, "El jugador ya tiene ese nivel de admin.");
		if(nivel > 7) return SendClientMessage(playerid,ROJO,"Nivel Incorrecto");
		Info[id][AdminNivel] = nivel;
		format(msg, sizeof(msg), "Haz puesto %s(%d) a %s",Rango(playerid), nivel,Nombre(id));
		SendClientMessage(playerid, VERDE, msg);
		new query[128];
		mysql_format(con, query, sizeof(query), "UPDATE `usuarios` SET `AdminNivel` = '%d' WHERE `Nombre` = '%s'",nivel,Nombre(id));
		mysql_query(con, query);
		format(query, 128, "[INFO]: %s ahora es %s(%d) gracias a %s.",Nombre(id),Rango(id),nivel,Nombre(playerid));
		ASCM(0xFF4D71FF,query,1);
		GuardarArchivo("dar_admin.log",query);
	}
	else return -1;
	return 1;
}

CMD:darvip(playerid, const params[])
{
	if(Info[playerid][AdminNivel] < 7) return -1;
	new id,dias;
	if(sscanf(params, "dd", id,dias)) return SendClientMessage(playerid, GRIS, "Usa: /darvip [id] [dias]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, GRIS, "Jugador no conectado");
	if(Info[id][VIP] == 1) return SendClientMessage(playerid, GRIS, "El jugador ya tiene vip");
	Info[id][VIP] = 1;
	Info[id][VIP_EXPIRE] = gettime()+86400*dias;
	SendFormattedMessage(playerid,-1,"Le haz otorgado vip a %s por %d días",Nombre(id),dias);
	format(text, sizeof(text), "El administrador %s te ha otorgado vip por %d días.", Nombre(playerid),dias);
	SendClientMessage(id, -1, text);
	new query[200];
	mysql_format(con, query, sizeof query, "UPDATE `usuarios` SET `VIP` = '1', `VIP_EXPIRE` = '%d' WHERE `Nombre` = '%s'",Info[id][VIP_EXPIRE],Nombre(playerid));
	mysql_query(con, query);
	return 1;
}

CMD:skin(playerid,params[])
{
	if(Info[playerid][AdminNivel] >= 2 || Info[playerid][VIP] ==1)
	{
		new id;
		if(sscanf(params, "d", id)) return SendClientMessage(playerid, GRIS, "Usa: /Skin [id]");
		if(id > 311 || id == 0) return SendClientMessage(playerid, -1, "Skin inválido");
		new msg[144];
		format(msg, sizeof msg, "{FFD700}%s {FFFFFF}usuario {FFD700}VIP{FFFFFF} cambiò su skin.", Nombre(playerid));
		SendClientMessageToAll(-1, msg);
		SetPlayerSkin(playerid, id);
		ClearAnimations(playerid);
		Info[playerid][Skin] = id;
		Info[playerid][SkinUsando] = 1;
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		new query[128];
		mysql_format(con, query, sizeof(query), "UPDATE `usuarios` SET `Skin` = '%d' WHERE `Nombre` = '%s'",id,Nombre(playerid));
		mysql_query(con, query);
		return 1;
	}
	else return SendClientMessage(playerid, -1, "Necesitas tener membresía vip para usar este comando.");
}

CMD:musica(playerid)
{
	if(Info[playerid][AdminNivel] < 2) return -1;
	ShowPlayerDialog(playerid, MUSICA, DIALOG_STYLE_INPUT, "Sistema de música v.1.0", "{FFFFFF}Introduce la url de la canción\nDebe terminar en .mp3", "Repro", "Cancelar");
	return 1;
}

CMD:ncall(playerid,params[])
{
	if(Info[playerid][AdminNivel]<5)return-1;
	new nce[128];
	if(sscanf(params, "s[128]", nce)) return SendClientMessage(playerid, -1, "Usa: /ncall [texto]");
	foreach(Player,i)
	{
		SendPlayerNotification(i,nce);
	}
	return 1;
}

CMD:games(playerid)
{
	ShowPlayerDialog(playerid, GAMES, DIALOG_STYLE_TABLIST_HEADERS, "Juegos", ".", "Unirse", "Cerrar");
	return 1;
}

CMD:nc(playerid,params[])
{
	if(Info[playerid][AdminNivel]<4)return-1;
	new nce[128],id;
	if(sscanf(params, "ds[128]",id, nce)) return SendClientMessage(playerid, -1, "Usa: /nc [id] [texto]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "Jugador no conectado");
	SendPlayerNotification(id,nce);
	return 1;
}

CMD:j(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 2) return -1;
	new texto[128];
	if(sscanf(params, "s[128]", texto)) return SendClientMessage(playerid, GRIS, "Usa: /j [Texto]");
	for(new i=0; i<GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && Info[i][AdminNivel] >= 2)
		{
			new string[128];
			format(string, sizeof(string), "Admin-Chat: [%i]%s: %s ",playerid,Nombre(playerid),texto);
			SendClientMessage(i, COLOR_CHICLE, string);
		}
	}
	return 1;
}

CMD:announce2(playerid, params[])
{
 	if(Info[playerid][AdminNivel] < 2) return -1;
	new style, time, msg[128];
    if(sscanf(params, "dds[128]", style, time, msg)) return SendClientMessage(playerid, GRIS, "Usa: /announce2 <estilo> <tiempo(segundos)> <texto>");
	if(style < 0 || style == 2 || style > 6) return SendClientMessage(playerid, ROJO, "Estilo inválido : 0 - 6");
	GameTextForAll(msg, 1000*time, style);
	return 1;
}

cmd:hora(playerid)
{
	new hour,minuite,second,string2[128]; gettime(hour,minuite,second);
	format(string2, sizeof(string2), "~b~|~w~%d:%d~g~|", hour, minuite);
	return GameTextForPlayer(playerid, string2, 5000, 1);
}

CMD:weaps(playerid, params[])
{
 	if(Info[playerid][AdminNivel] < 1 && !IsPlayerAdmin(playerid)) return -1;
	new player1, string[128], string2[64], WeapName[24], slot, weap, ammo, Count, x;
	if(sscanf(params, "r", player1)) return SendClientMessage(playerid, GRIS, "Usa: /weaps [playerid]");
	if(player1 == INVALID_PLAYER_ID) return SendClientMessage(playerid, ROJO, OFFLINE);
	format(string2, sizeof(string2), "[>> %s Armas (id:%d) <<]", Nombre(player1), player1);
	SendClientMessage(playerid, AZUL, string2);
	for (slot = 0; slot < 14; slot++)
	{
		GetPlayerWeaponData(player1, slot, weap, ammo);
		if( ammo != 0 && weap != 0) Count++;
	}
	if(Count < 1) return SendClientMessage(playerid, AZUL, "Jugador no tiene armas");
	if(Count >= 1)
	{
		for (slot = 0; slot < 14; slot++)
		{
			GetPlayerWeaponData(player1, slot, weap, ammo);
			if( ammo != 0 && weap != 0)
			{
				GetWeaponName(weap, WeapName, sizeof(WeapName) );
				if(ammo == 65535 || ammo == 1) format(string, sizeof(string), "%s%s (1)", string, WeapName );
				else format(string,sizeof(string), "%s%s (%d)", string, WeapName, ammo );
				x++;
				if(x >= 5)
				{
				    SendClientMessage(playerid, AZUL, string);
				    x = 0;
					format(string, sizeof(string), "");
				}
				else format(string, sizeof(string), "%s,  ", string);
			}
	    }
		if(x <= 4 && x > 0) {
			string[strlen(string)-3] = '.';
		    SendClientMessage(playerid, AZUL, string);
		}
    }
    return 1;
}


CMD:f(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 6) return -1;
	new texto[128];
	if(sscanf(params, "s[128]", texto)) return SendClientMessage(playerid, GRIS, "Usa: /f [Texto]");
	foreach(Player,i)
	{
		if(Info[i][AdminNivel] >= 6)
		{
			new string[128];
			format(string, sizeof(string), "Admin-Chat: [%i]%s: %s ",playerid,Nombre(playerid),texto);
			SendClientMessage(i, 0x38CC45FF, string);
		}
	}
	return 1;
}

funcion SetAdminDB(playerid,adm,ACC[])
{
	new query[128];
	if(cache_num_rows())
	{
		mysql_format(con, query, 128, "UPDATE `usuarios` SET `AdminNivel` = '%d' WHERE `Nombre` = '%s'",adm,ACC);
		mysql_query(con, query);
		new frm[128];
		format(frm, 128, "Haz seteado nivel %d a %s en la base de datos.",adm, ACC);
		SendClientMessage(playerid, -1, frm);
	}
	else
	{
		new frm[128];
		format(frm, 128, "La cuenta %s no existe en la base de datos.", ACC);
		SendClientMessage(playerid, -1, frm);
	}
}

CMD:setadm(playerid,params[])
{
	if(Info[playerid][AdminNivel] < 7) return -1;
	new ACC[MAX_PLAYER_NAME],adm;
	if(sscanf(params,"s[24]d",ACC,adm)) return SendClientMessage(playerid, ROJO, "Usa: /setadm [Nombre dp] [nivel]");
	if(adm > 6) return SendClientMessage(playerid, -1, "Nivel incorrecto");
	new query[128];
	mysql_format(con, query, 128, "SELECT * FROM `usuarios` WHERE `Nombre` = '%s'",ACC);
	mysql_pquery(con, query, "SetAdminDB", "dds",playerid,adm,ACC);
	return 1;
}

//Traducciones de comandos
/*alias:darvip("setvip");
alias:admins("staff","administradores");
alias:team("equipo","equipos");
alias:r("radio");
alias:creditos("credits","creadores","dueños","owners");
alias:pagar("pay","payto","enviardinero");
alias:cmds("comandos","commands","command");
alias:acciones("animations","animaciones");
alias:tienda("shop");
alias:est("stats","skills");
alias:prendas("toys","juguetes");
alias:mp("pm","mensaje","message","privado","private");
alias:config("configuracion","configuration");
alias:reportar("report","re");
alias:kill("suicidarme");
*/
public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(Info[playerid][AdminNivel] < 2) return 1;
	if (GetPlayerState(playerid) == 2)
	{
		return SetVehiclePos(GetPlayerVehicleID(playerid), fX, fY, fZ);
	}
	else
	{
		SetPlayerPos(playerid, fX, fY, fZ);
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(AntiSpam2(playerid,text)) return 0;
	if(OnDuty[playerid] && Info[playerid][AdminNivel] == 1)
	{
		new string[128];
		format(string, sizeof(string), "{d71e18}Youtuber {%06x}%s {ffffff}[%i]: %s",GetPlayerColor(playerid) >>> 8,Nombre(playerid),playerid,text);
		SendClientMessageToAll(-1, string);
		SetPlayerChatBubble(playerid, text, 0xFFFFFFFF, 100.0, 10000);
		return 0;
	}
	if(text[0] == '!' && Info[playerid][VIP] == 1)
	{
		new string[128];
		format(string, sizeof(string), "{ffff00}Chat-Vip: {%06x}%s {ffffff}[%i]: %s",GetPlayerColor(playerid) >>> 8,Nombre(playerid),playerid,text[1]);
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && Info[i][VIP] == 1) SendClientMessage(i, -1, string);
		}
		return 0;
	}
	if(ServerInfo[DisableChat] == 1)
	{
		SendClientMessage(playerid,ROJO,"El Chat ha sido desactivado");
		return 0;
	}
	if(Info[playerid][Muteado] == 1)
	{
		SendClientMessage(playerid, ROJO, "No tienes permiso para hablar.");
		return 0;
	}
	if(Info[playerid][Logged] == 0)
	{
		SendClientMessage(playerid, ROJO, "Debes identificarte primero.");
		return 0;
	}
	static LastText[MAX_PLAYERS][128];
	if(strfind(LastText[playerid], text, false) != -1) return SendClientMessage(playerid, -1, "No está permitido el flood."),0;//Esto nos verifica si el texto es igual.
	strmid(LastText[playerid],text,0,strlen(text),sizeof(LastText[]));
	new string[128];
	format(string, sizeof(string), "{%06x}%s {ffffff}[%i]: %s",GetPlayerColor(playerid) >>> 8,Nombre(playerid),playerid,text);
	SendClientMessageToAll(-1, string);
	SetPlayerChatBubble(playerid, text, 0xFFFFFFFF, 80.0, 10000);
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(Info[playerid][VIP])
	AddVehicleComponent(vehicleid, 1010);
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_PASSENGER || newstate == PLAYER_STATE_DRIVER) SetPlayerArmedWeapon(playerid, 0);
	if(oldstate == PLAYER_STATE_PASSENGER || oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT) SetPlayerArmedWeapon(playerid, 24);
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{

	// DS Heart: when picking a heart pickup, heal and remove it
	for (new __i = 0; __i < DS_HEART_MAX; __i++)
	{
	if (DS_HeartActive[__i] && DS_HeartPickup[__i] == pickupid)
	{
	DS_Heart_PickupHeal(playerid, __i);
	break;
	}
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && weaponid == 24)
	{
        fAutoC[playerid] ++;
        if(gettime() > GetPVarInt(playerid, "UmSegundo")) {
            SetPVarInt(playerid, "UmSegundo", gettime() + 1);
            fAutoC[playerid] = 0;
        }else{
            if(fAutoC[playerid] > 4) {
                SendClientMessage(playerid, 0xFF0000FF, "No se permite Auto-CBUG.");
                fAutoC[playerid] = 0;
            }
        }
    }
    return 1;
}
forward OcultarDamageTD(playerid);
public OcultarDamageTD(playerid)
{
    PlayerTextDrawHide(playerid, DamageInfoTD[playerid]);
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    if(IsPlayerInAnyVehicle(issuerid) && GetPlayerState(issuerid) == PLAYER_STATE_DRIVER) return 1;
    if(gTeam[playerid] != gTeam[issuerid] || !IsPlayerInAnyVehicle(issuerid))
    {
        ColocarCombate(issuerid);
        ColocarCombate(playerid);
    }
    if(issuerid != INVALID_PLAYER_ID)
    {
        if(gTeam[issuerid] != gTeam[playerid] || EnDuelo[issuerid] && EnDuelo[playerid])
        {
            if(weaponid > 21 && weaponid < 35) PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
        }
    }

    // ============================================================
    // DAMAGE INFORMER CUANDO VOS HACES DANO (VERDE, COMO YA LO TENIAS)
    // ============================================================
    if(issuerid != INVALID_PLAYER_ID)
    {
        new arma[32];
        NombreArma(weaponid, arma, sizeof arma);

        new str[64];
        format(str, sizeof str, "-%.0f (%s)", amount, arma);

        PlayerTextDrawSetString(issuerid, DamageInfoTD[issuerid], str);
        PlayerTextDrawColor(issuerid, DamageInfoTD[issuerid], 0x00FF00FF); // VERDE
        PlayerTextDrawShow(issuerid, DamageInfoTD[issuerid]);

        if(DamageTimer[issuerid]) KillTimer(DamageTimer[issuerid]);
        DamageTimer[issuerid] = SetTimerEx("OcultarDamageTD", 2000, false, "i", issuerid);
    }

    // ============================================================
    // DAMAGE INFORMER CUANDO TE HACEN DANO (ROJO)
    // ============================================================
    if(issuerid != INVALID_PLAYER_ID)
    {
        new arma2[32];
        NombreArma(weaponid, arma2, sizeof arma2);

        new str2[64];
        format(str2, sizeof str2, "-%.0f (%s)", amount, arma2);

        PlayerTextDrawSetString(playerid, DamageInfoTD[playerid], str2);
        PlayerTextDrawColor(playerid, DamageInfoTD[playerid], 0xFF0000FF); // ROJO
        PlayerTextDrawShow(playerid, DamageInfoTD[playerid]);

        if(DamageTimer[playerid]) KillTimer(DamageTimer[playerid]);
        DamageTimer[playerid] = SetTimerEx("OcultarDamageTD", 2000, false, "i", playerid);
    }

    return 1;
}



public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	foreach(Player,i)
	{
	    if(SpecteandoA[i] == playerid && GetPlayerState(i) == PLAYER_STATE_SPECTATING) // --- Si alguien lo está specteando ---
	    {
	        SetPlayerInterior(i,newinteriorid); // --- Le damos al spectante el interior que el jugador entró ---
	        SetPlayerVirtualWorld(i,GetPlayerVirtualWorld(playerid)); // --- Le damos al spectante el VirtualWrold que al jugador se le asignó ---
	    }
	}
	return 1;
}

funcion OnPlayerMakeCBug(playerid)
{
	TogglePlayerControllable(playerid, 0);
	SetTimerEx("ControlCBug", 2000, 0, "i", playerid);
	return 1;
}

funcion ControlCBug(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_NO))
	{
	    if(IsPlayerInAnyVehicle(playerid)) return 1;

	    new f = MAX_ARMAS + 1;

	    // Buscar arma cercana
	    for(new a = 0; a < sizeof(ObjCoords); a++)
	    {
	        if(IsPlayerInRangeOfPoint(playerid, 5.0, ObjCoords[a][0], ObjCoords[a][1], ObjCoords[a][2]))
	        {
	            f = a;
	            break;
	        }
	    }

	    if(f > MAX_ARMAS) return 1;

	    // BORRAR OBJETO DEL SUELO
	    if(Object[f] != INVALID_OBJECT_ID)
	    {
	        DestroyObject(Object[f]);
	        Object[f] = INVALID_OBJECT_ID;
	    }

	    // Limpiar coordenadas
	    ObjCoords[f][0] = 0.0;
	    ObjCoords[f][1] = 0.0;
	    ObjCoords[f][2] = 0.0;

	    // Dar arma al jugador
	    GivePlayerWeapon(playerid, ObjectID[f][0], 99999);

	    // Mostrar notificacion
	    new str[128];
	    format(str, sizeof(str), "~w~Recogiste un arma del suelo.");

	    PlayerTextDrawSetString(playerid, NOTIFICATION_MESSAGE[playerid][3], str);
	    PlayerTextDrawShow(playerid, NOTIFICATION_MESSAGE[playerid][3]);
	    SetTimerEx("HideCommandError", 3000, false, "i", playerid);

	    return 1;
	}

	if (PRESSED(KEY_CTRL_BACK))
	{
	    tirar_armas(playerid);

	    new str[128];
	    format(str, sizeof(str), "~w~Tiraste un arma al piso, usa la tecla ~y~N ~w~para recogerla.");

	    PlayerTextDrawSetString(playerid, NOTIFICATION_MESSAGE[playerid][3], str);
	    PlayerTextDrawShow(playerid, NOTIFICATION_MESSAGE[playerid][3]);

	    // Ocultar despues de 3 segundos
	    SetTimerEx("HideCommandError", 3000, false, "i", playerid);

	    return 1;
	}

	if (PRESSED(KEY_YES))
	{
	    // *** 1. Condición: El jugador DEBE estar en un vehículo Y DEBE ser VIP ***
	    if (IsPlayerInAnyVehicle(playerid) && Info[playerid][VIP])
	    {

	        // Anti-Cheats (temporal)
	        IgnorarAnticheat[playerid] = 1;

	        // Reparar el vehículo
	        RepairVehicle(GetPlayerVehicleID(playerid));

	        // Mensaje Global
	        new msg[144];
	        format(msg, sizeof msg, "{FFD700}%s {FFFFFF}usuario {FFD700}VIP{FFFFFF} reparó su coche.!", Nombre(playerid));
	        SendClientMessageToAll(-1, msg);

	        // Desactivar Anti-Cheats después de 1 segundo
	        SetTimerEx("DesactivarIgnorarAC", 1000, false, "d", playerid);

	        // 3. *** ACTIVAR/COMPROBAR ANTI-FLOOD ***

	        // Si IsPlayerFlooding2() es una función para *detectar* el abuso
	        if (IsPlayerFlooding2(playerid))
	        {
	            SendClientMessage(playerid, -1, "No abuses del repair car, {F2270C}(SE PUEDE REMOVER TU VIP)");
	        }

	        return 1;
	    }
	}


	if(newkeys & KEY_CROUCH) fAutoC[playerid] = 0;
    if(!pCBugging[playerid] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        if(PRESSED(KEY_FIRE))
        {
            switch(GetPlayerWeapon(playerid))
            {
                case WEAPON_DEAGLE, WEAPON_SHOTGUN, WEAPON_SNIPER:
                {
                    ptsLastFiredWeapon[playerid] = gettime();
                }
            }
        }
        else if(PRESSED(KEY_CROUCH))
        {
            if((gettime() - ptsLastFiredWeapon[playerid]) < 1)
            {
            	if(EnDuelo[playerid]) return 1;
            	if(CBUG_DISABLED) return 1;
                TogglePlayerControllable(playerid, false);
                pCBugging[playerid] = true;
                KillTimer(ptmCBugFreezeOver[playerid]);
                ptmCBugFreezeOver[playerid] = SetTimerEx("CBugFreezeOver", 3000, false, "i", playerid);
            }
        }
    }
    if(PRESSED(KEY_SECONDARY_ATTACK))
    {
    	if(IsPlayerInRangeOfPoint(playerid, 1.0, -1508.8748,2610.7014,55.8359))
    	{
    		if(EnCombate[playerid])return SendClientMessage(playerid, -1, "No puedes entrar a la tienda estando combate");
    		SetPlayerPos(playerid, 285.4720,-41.2397,1001.5156);
    		SetPlayerFacingAngle(playerid, 357.9003);
    		SetCameraBehindPlayer(playerid);
    		SetPlayerInterior(playerid, 1);
    		InShop[playerid]=1;
    		ResetPlayerWeapons(playerid);
    		return 1;
    	}
    	if(IsPlayerInRangeOfPoint(playerid, 1.0, 285.3824,-41.7269,1001.5156))
    	{
    		SetPlayerPos(playerid, -1508.8748,2610.7014,55.8359);
    		SetPlayerInterior(playerid, 0);
    		SetPlayerFacingAngle(playerid, 270.0212);
    		CargarArmas(playerid);
    		GivePlayerWeapon(playerid, 24, 99999);
    		InShop[playerid]=0;
    		return 1;
    	}
	    switch(gTeam[playerid])
	    {
	    	case TheWins:
	    	{
				if(IsPlayerInRangeOfPoint(playerid, 1.0, 460.5563,-88.5414,999.5547))
				{
					SetPlayerPos(playerid, -1511.8867,2695.1094,55.8359);
					SetPlayerFacingAngle(playerid, 355.8272);
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid, 0);
					SetCameraBehindPlayer(playerid);
					CargarMapa(playerid);
				}
	    	}
	    	case OldsGang:
	    	{
			    if(IsPlayerInRangeOfPoint(playerid, 1.0, 501.8928,-67.5638,998.7578)==0) return 1;
				{
					SetPlayerPos(playerid, -1450.0710,2562.9780,55.8359);
					SetPlayerFacingAngle(playerid, 134.5150);
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid, 0);
					SetCameraBehindPlayer(playerid);
					CargarMapa(playerid);
				}
	    	}
	    	case TheLegends:
	    	{
				if(IsPlayerInRangeOfPoint(playerid, 1.0, 460.5563,-88.5414,999.5547))
				{
					SetPlayerPos(playerid, -1446.2439,2635.9309,56.2543);
					SetPlayerFacingAngle(playerid, 355.8272);
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid, 0);
					SetCameraBehindPlayer(playerid);
					CargarMapa(playerid);
				}
	    	}
			case EnVenta:
	    	{
	    		if(IsPlayerInRangeOfPoint(playerid, 1.0, 2324.5098,-1149.5472,1050.7101))
				{
					SetPlayerPos(playerid, -1519.2839,2610.3296,55.8359);
					SetPlayerFacingAngle(playerid, 314.3066);
					SetPlayerInterior(playerid, 0);
					SetCameraBehindPlayer(playerid);
					CargarMapa(playerid);
					SetPlayerVirtualWorld(playerid, 0);
				}
	    	}
            case eTeam:
	    	{
	    		if(IsPlayerInRangeOfPoint(playerid, 1.0, 2324.5098,-1149.5472,1050.7101))
				{
					SetPlayerPos(playerid, -1514.8712,2521.2454,55.8625);
					SetPlayerFacingAngle(playerid, 314.3066);
					SetPlayerInterior(playerid, 0);
					SetCameraBehindPlayer(playerid);
					CargarMapa(playerid);
					SetPlayerVirtualWorld(playerid, 0);
				}
	    	}
	    }
	}
	return 1;
}

funcion armas()
{
	foreach(Player,i)
	{
		if(EDCON[i] || EscopetaON[i])
		{
			if(GetPlayerWeapon(i) != 25 && EscopetaON[i] == 1) {SetPlayerAttachedObject(i,7,349,1,  0.195999,-0.102999,0.088999,172.099899,-137.700027,0.800023, 1.000000, 1.000000, 1.000000);}
			if(GetPlayerWeapon(i) == 25 && EscopetaON[i] == 1) { RemovePlayerAttachedObject(i,7); }
			if(GetPlayerWeapon(i) != 27 && EDCON[i] == 1) {SetPlayerAttachedObject(i,7,351,1,  0.195999,-0.102999,0.088999,172.099899,-137.700027,0.800023, 1.000000, 1.000000, 1.000000);}
			if(GetPlayerWeapon(i) == 27 && EDCON[i] == 1) { RemovePlayerAttachedObject(i,7); }
		}
		if(RIFLEON[i] == 1 || SNIPERON[i])
		{
			if(GetPlayerWeapon(i) != 33 && RIFLEON[i] == 1) {SetPlayerAttachedObject(i,7,357,1,  0.195999,-0.102999,0.088999,172.099899,-137.700027,0.800023, 1.000000, 1.000000, 1.000000);}
			if(GetPlayerWeapon(i) == 33 && RIFLEON[i] == 1) { RemovePlayerAttachedObject(i,7); }
			if(GetPlayerWeapon(i) != 34 && SNIPERON[i] == 1) {SetPlayerAttachedObject(i,7,358,1,  0.195999,-0.102999,0.088999,172.099899,-137.700027,0.800023, 1.000000, 1.000000, 1.000000);}
			if(GetPlayerWeapon(i) == 34 && SNIPERON[i] == 1) { RemovePlayerAttachedObject(i,7); }
		}
	}
}

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle)
{
	printf("[ERROR] ID: %d - Error: %s - Callback - %s - Query: %s", errorid, error, callback, query);
	new str[128];
	format(str, 128, "[ERROR] ID: %d - Error: %s - Callback - %s - Query: %s", errorid, error, callback, query);
	foreach(Player,i)
	{
		if(Info[i][AdminNivel] >= 3) SendClientMessage(i, -1, str);
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	if(!success){
		new ip2[18],str[128];
		for(new p=0;p<MAX_PLAYERS;p++)
		{
			GetPlayerIp(p, ip2, sizeof(ip2));
			if(!strcmp(ip, ip2, true))
			{
				SendClientMessage(p, -1, "nv amiwito");
				format(str, sizeof str, "%s intentó acceder a rcon y fue pateado.",Nombre(p));
				ASCM(-1,str,3);
				Kick(p);
			}
		}
	}
	return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	if(response)
	{
		if(fScaleX > 2.0 || fScaleY > 2.0 || fScaleZ > 2.0 || fScaleX < 0.5 || fScaleY < 0.5 || fScaleZ < 0.5) return SendClientMessage(playerid, -1, "No puedes tener una prenda tan grande.");
		//printf("SetPlayerAttachedObject(playerid,%d,%d,%d,%f,%f,%f,%f,%f,%f,%f,%f,%f)",index,modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ);
		oInfo[playerid][index][fOffsetX1] = fOffsetX;
		oInfo[playerid][index][fOffsetY1] = fOffsetY;
		oInfo[playerid][index][fOffsetZ1] = fOffsetZ;
		oInfo[playerid][index][fRotX1] = fRotX;
		oInfo[playerid][index][fRotY1] = fRotY;
		oInfo[playerid][index][fRotZ1] = fRotZ;
		oInfo[playerid][index][fScaleX1] = fScaleX;
		oInfo[playerid][index][fScaleY1] = fScaleY;
		oInfo[playerid][index][fScaleZ1] = fScaleZ;
		new query[128];
		SetPlayerAttachedObject(playerid, index, modelid, boneid, oInfo[playerid][index][fOffsetX1], oInfo[playerid][index][fOffsetY1], oInfo[playerid][index][fOffsetZ1], oInfo[playerid][index][fRotX1], oInfo[playerid][index][fRotY1], oInfo[playerid][index][fRotZ1], oInfo[playerid][index][fScaleX1], oInfo[playerid][index][fScaleY1], oInfo[playerid][index][fScaleZ1]);
		mysql_format(con, query, sizeof(query), "SELECT * FROM `toys` WHERE `Index` = '%d' AND `Nombre` = '%s'", index, Nombre(playerid));
		mysql_pquery(con, query, "OnObjectSave", "iiii", playerid, index, modelid, boneid);
	}
	else
	{
		SendClientMessage(playerid, ROJO, "Cancelado.");
	}
	return 1;
}

funcion OnObjectSave(playerid, index, modelid, boneid)
{
	new query[450];
	if(!cache_num_rows())
	{
		mysql_format(con, query, sizeof(query), "INSERT INTO `toys` (`Nombre`,`Index`,`Model`,`Bone`,`OffsetX`,`OffsetY`,`OffsetZ`) VALUES ('%s','%d','%d','%d','%f','%f','%f')",Nombre(playerid), index, modelid, boneid, oInfo[playerid][index][fOffsetX1], oInfo[playerid][index][fOffsetY1], oInfo[playerid][index][fOffsetZ1]);
		mysql_pquery(con, query);
		mysql_format(con, query, sizeof(query), "UPDATE `toys` SET `Model` = %d,`Bone` = %d,`OffsetX` = %f,`OffsetY` = %f,`OffsetZ` = %f WHERE `Nombre` = '%s' AND `Index` = '%d'",modelid, boneid, oInfo[playerid][index][fOffsetX1], oInfo[playerid][index][fOffsetY1], oInfo[playerid][index][fOffsetZ1], Nombre(playerid), oInfo[playerid][index][index1]);
		mysql_pquery(con, query);
		mysql_format(con, query, sizeof(query), "UPDATE `toys` SET `RotX` = %f, `RotY` = %f, `RotZ` = %f, `ScaleX` = %f, `ScaleY` = %f, `ScaleZ` = %f WHERE `Nombre` = '%s' AND `Index` = '%d'",oInfo[playerid][index][fRotX1], oInfo[playerid][index][fRotY1], oInfo[playerid][index][fRotZ1], oInfo[playerid][index][fScaleX1], oInfo[playerid][index][fScaleY1], oInfo[playerid][index][fScaleZ1], Nombre(playerid), oInfo[playerid][index][index1]);
		mysql_pquery(con, query);
	}
}

public OnPlayerModelSelectionEx(playerid, response, extraid, modelid)
{
	return 1;
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
	if(listid == vehiculos || listid == aviones || listid == barcos)
	{
		if(response)
		{
			CarSpawner(playerid,modelid);
			return 1;
		}
	}
	if(listid == objectlist)
	{
		if(response)
		{
			new requerido = Info[playerid][Dinero];
			if(requerido < 250000) return SendClientMessage(playerid, -1, "Dinero insuficiente");
			for(new i=0; i<MAX_OBJECTS; i++)
			{
				if(oInfo[playerid][i][modelid1] == modelid) return SendClientMessage(playerid, -1, "Ya tienes esta prenda.");
				if(oInfo[playerid][i][used1] == false)
				if(IsPlayerAttachedObjectSlotUsed(playerid, i)==0)
				{
					inindex[playerid] = i;
					inmodel[playerid] = modelid;
					ShowPlayerDialog(playerid, 72, DIALOG_STYLE_LIST, "{0DFF00}Hueso", "Espina\nCabeza\nBrazo superior izquierdo\nBrazo superior derecho\nMano izquierda\nMano derecha\nLeft Tight\nRight Tight\nPie izquierdo\nPie derecho\nPantorrilla derecha\nPantorrilla izquierda\nAntebrazo izquierdo\nAntebrazo derecho\nHombro izquierdo\nHombro derecho\nCuello\nMandíbula", "Aceptar", "Cancelar");
					return 1;
				}
			}
		}
		else SCM(playerid,0xff0000ff,"Haz cancelado la compra");
		return 1;
	}
	if(listid == skinlist)
	{
		if(response)
		{
			new requerido = GetPlayerMoney(playerid);
			if(requerido >= 100000)
			{
				GivePlayerMoney(playerid,-100000);
				Info[playerid][Dinero]-=100000;
				Info[playerid][Skin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Info[playerid][SkinUsando] = 1;
				new query[128];
				mysql_format(con, query, 128, "UPDATE `usuarios` SET `Skin` = '%d' WHERE `Nombre` = '%s'",modelid,Nombre(playerid));
				mysql_query(con, query);
				SendClientMessage(playerid, GRIS, "Skin comprado y guardado");
			}
			else return SCM(playerid,0xff0000ff,"Dinero insuficiente");
		}
		else SendClientMessage(playerid, 0xFF0000FF, "Has cancelado la compra");
		return 1;
	}
	return 1;
}

stock BanearAC(playerid,reason[])
{
	SendFormattedMessageToAll(-1,"{FF0000}%s {FFFFFF}Fue baneado por el anticheat, razón: {ff0000}%s{ffffff}.",Nombre(playerid),reason);
	SetTimerEx("Banear", 500, false, "d", playerid);
}

stock KickearAC(playerid,reason[])
{
	SendFormattedMessageToAll(-1,"{FF0000}%s {FFFFFF}Fue pateado por el anticheat, razón: {ff0000}%s{ffffff}.",Nombre(playerid),reason);
	SetTimerEx("Kickear", 500, false, "d", playerid);
}
stock Float:Get3DDistance(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
    return floatsqroot((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2) + (z1-z2)*(z1-z2));
}


public OnPlayerUpdate(playerid)
{
    // Cambio de textdraw por combate
    if(EnCombate[playerid] == 1)
    {
        PlayerTextDrawHide(playerid, Textdraw0[playerid]);
        PlayerTextDrawShow(playerid, Textdraw3[playerid]);
    }
    else
    {
        PlayerTextDrawHide(playerid, Textdraw3[playerid]);
        PlayerTextDrawShow(playerid, Textdraw0[playerid]);
    }

    // Medición de FPS simulada con GetPlayerDrunkLevel
    new FPSSS = GetPlayerDrunkLevel(playerid);
    if (FPSSS < 100)
    {
        SetPlayerDrunkLevel(playerid, 2000);
    }
    else
    {
        new delta = FPSS[playerid] - FPSSS;
        if (delta > 0 && delta < 200) FPS[playerid] = delta;
        FPSS[playerid] = FPSSS; // actualizamos siempre
    }

    return 1;
}


funcion OnPlayerSave(playerid)
{
	if(!Info[playerid][Logged]) return 0;
	new Query[700],d,m,a;
	getdate(a, m, d);
	mysql_format(con, Query, sizeof(Query), "UPDATE `usuarios` SET `Skin` = '%d', `Score` = '%d', `Muertes` = '%d', `Coins` = '%d', `Dinero` = '%d', `Invitado` = '%d', `Autorizado` = '%d', `Owner` = '%d', `DuelosWin` = '%d', `DuelosLose` = '%d', `SancionTime` = '%d', `Sancionado` = '%d', `SanRazon` = '%s', `SkinUsando` = '%d', `VIP` = '%d', `VIP_EXPIRE` = '%d', `lastOn` = '%d/%d/%d' WHERE `Nombre` = '%s'",Info[playerid][Skin],Info[playerid][Score],Info[playerid][Muertes],Info[playerid][Coins],Info[playerid][Dinero],Invitado[playerid],Autorizado[playerid],Owner[playerid],Info[playerid][DuelosGanados],Info[playerid][DuelosPerdidos],Info[playerid][SancionTimeS]*1000,Sancion[playerid],Info[playerid][SanRazon],Info[playerid][SkinUsando],Info[playerid][VIP],Info[playerid][VIP_EXPIRE],d,m,a,Nombre(playerid));
	mysql_query(con, Query);
	mysql_format(con, Query, sizeof(Query), "UPDATE `armas` SET `ESCOPETA` = '%d', `EDC` = '%d', `MP5` = '%d', `M4` = '%d', `RIFLE` = '%d', `SNIPER` = '%d' WHERE `Nombre` = '%s'",EscopetaON[playerid],EDCON[playerid],MP5ON[playerid],M4ON[playerid],RIFLEON[playerid],SNIPERON[playerid],Nombre(playerid));
	mysql_query(con, Query);
	return 1;
}

funcion OnPlayerLoad(playerid)
{
	cache_get_value_name_int(0, "Dinero", Info[playerid][Dinero]);
	GivePlayerMoney(playerid, Info[playerid][Dinero]);
	cache_get_value_name_int(0, "Score", Info[playerid][Score]);
	SetPlayerScore(playerid, Info[playerid][Score]);
	cache_get_value_name(0, "SanRazon", Info[playerid][SanRazon], 18);
	cache_get_value_name_int(0, "Coins", Info[playerid][Coins]);
	cache_get_value_name_int(0, "VIP", Info[playerid][VIP]);
	cache_get_value_name_int(0, "VIP_EXPIRE", Info[playerid][VIP_EXPIRE]);
	cache_get_value_name_int(0, "RANDOM_TIME", Tiempo_Random[playerid]);
	cache_get_value_name_int(0, "AdminNivel", Info[playerid][AdminNivel]);
	cache_get_value_name_int(0, "Skin", Info[playerid][Skin]);
	cache_get_value_name_int(0, "SkinUsando", Info[playerid][SkinUsando]);
	cache_get_value_name_int(0, "EDC",Info[playerid][ComproEDC]);
	cache_get_value_name_int(0, "ESCOPETA", Info[playerid][ComproEscopeta]);
	cache_get_value_name_int(0, "MP5", Info[playerid][ComproMP5]);
	cache_get_value_name_int(0, "M4",Info[playerid][ComproM4]);
	cache_get_value_name_int(0, "SNIPER", Info[playerid][ComproSniper]);
	cache_get_value_name_int(0, "RIFLE", Info[playerid][ComproRifle]);
	cache_get_value_name_int(0, "Chaleco", Info[playerid][ComproChaleco]);
	cache_get_value_name_int(0, "Autorizado", Autorizado[playerid]);
	cache_get_value_name_int(0, "Owner", Owner[playerid]);
	cache_get_value_name_int(0, "Invitado", Invitado[playerid]);
	cache_get_value_name_int(0, "Muertes", Info[playerid][Muertes]);
	cache_get_value_name_int(0, "Sancionado", Sancion[playerid]);
	cache_get_value_name_int(0, "SancionTime",Info[playerid][SancionTime]);
	cache_get_value_name_int(0, "DuelosWin", Info[playerid][DuelosGanados]);
	cache_get_value_name_int(0, "DuelosLose", Info[playerid][DuelosPerdidos]);
	if(Info[playerid][SancionTime] > 0)
	{
		Info[playerid][SancionTimeS] = Info[playerid][SancionTime]/1000;
	}
	Info[playerid][Logged] = 1;
	new stringg[128];
	format(stringg,sizeof(stringg),"(((%s [%d] Se ha Logueado.)))",Nombre(playerid),playerid);
	MensajeParaAdmins(0xAFAFAFAA,stringg);
	if(Info[playerid][AdminNivel] > 0)
	{
		new texto[25],string2[128];
		switch(Info[playerid][AdminNivel])
		{
			case 1: texto = "Youtuber";
			case 2: texto = "Ayudante";
			case 3: texto = "Moderador";
			case 4: texto = "Moderador Global";
			case 5: texto = "Moderador Técnico";
			case 6: texto = "Administrador";
			case 7: texto = "Fundador";
		}
		format(string2,sizeof(string2),"{ccd9ff}Logueado correctamente como %s",texto);
		SendClientMessage(playerid,0xffffffff,string2);
	}
	if(Info[playerid][VIP] == 1)
	{
	    if(Info[playerid][VIP_EXPIRE] < gettime())
	    {
	        SendClientMessage(playerid, -1, "Tu cuenta VIP ha expirado.");
	        Info[playerid][VIP] = 0;
	        Info[playerid][VIP_EXPIRE] = 0;
	    }
	    else
	    {
	        // Mensaje VIP global
	        new msg[144];
	        format(msg, sizeof msg, "{FFD700}%s {FFFFFF}usuario {FFD700}VIP{FFFFFF} se ha conectado!", Nombre(playerid));
	        SendClientMessageToAll(-1, msg);
	    }
	}

	return 1;
}

funcion OnObjectLoad(playerid)
{
	new rows = cache_num_rows();
	if(rows > 0)
	{
		for(new i, j=cache_num_rows(); i<j; i++)
		{
			new in;
			cache_get_value_name_int(i, "Index", in);
			oInfo[playerid][in][index1] = in;
			cache_get_value_name_int(i, "Usando", oInfo[playerid][in][usando]);
			cache_get_value_name_float(i, "OffsetX",oInfo[playerid][in][fOffsetX1]);
			cache_get_value_name_float(i, "OffsetY", oInfo[playerid][in][fOffsetY1]);
			cache_get_value_name_float(i, "OffsetZ", oInfo[playerid][in][fOffsetZ1]);
			cache_get_value_name_int(i, "Model", oInfo[playerid][in][modelid1]);
			cache_get_value_name_int(i, "Bone", oInfo[playerid][in][bone1]);
			cache_get_value_name_float(i, "RotX", oInfo[playerid][in][fRotX1]);
			cache_get_value_name_float(i, "RotY", oInfo[playerid][in][fRotY1]);
			cache_get_value_name_float(i, "RotZ",oInfo[playerid][in][fRotZ1]);
			cache_get_value_name_float(i, "ScaleX", oInfo[playerid][in][fScaleX1]);
			cache_get_value_name_float(i, "ScaleY", oInfo[playerid][in][fScaleY1]);
			cache_get_value_name_float(i, "ScaleZ", oInfo[playerid][in][fScaleZ1]);
			oInfo[playerid][in][used1] = true;
		}
	}
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case SVRCONFIG:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(CBUG_DISABLED == 0) CBUG_DISABLED = 1;
						else CBUG_DISABLED = 0;
						callcmd::svrconfig(playerid);
					}
					case 1:
					{
						if(NombreI == 0) NombreI = 1;
						else NombreI = 0;
						callcmd::svrconfig(playerid);
					}
					case 2:
					{
						if(DuelosOff == 1) DuelosOff = 0;
						else DuelosOff = 1;
						callcmd::svrconfig(playerid);
					}
					case 3:
					{
						if(ServerInfo[DisableChat] == 0) ServerInfo[DisableChat] = 1;
						else ServerInfo[DisableChat] = 0;
						callcmd::svrconfig(playerid);
					}
				}
			}
		}
		case CLIMA:
		{
			if(response)
			{
				PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
				switch(listitem)
				{
					case 0: SetPlayerWeather(playerid, 0);
					case 1: SetPlayerWeather(playerid, 10);
					case 2: SetPlayerWeather(playerid, 11);
					case 3: SetPlayerWeather(playerid, 8);
					case 4: SetPlayerWeather(playerid, 9);
					case 5: SetPlayerWeather(playerid, 12);
					case 6: SetPlayerWeather(playerid, 16);
					case 7: SetPlayerWeather(playerid, 18);
				}
			}
		}
		case DIALOG_INTERIORS:
		{
		    if(response)
		    {
		        switch(listitem)
				{
					case 0: {	SetPlayerPos(playerid,386.5259, 173.6381, 1008.3828);		SetPlayerInterior(playerid,3); }
					case 1: {	SetPlayerPos(playerid,288.4723, 170.0647, 1007.1794);		SetPlayerInterior(playerid,3); }
					case 2: {	SetPlayerPos(playerid,372.5565, -131.3607, 1001.4922);		SetPlayerInterior(playerid,5); }
					case 3: {	SetPlayerPos(playerid,-1129.8909, 1057.5424, 1346.4141);	SetPlayerInterior(playerid,10); }
					case 4: {	SetPlayerPos(playerid,2233.9363, 1711.8038, 1011.6312);		SetPlayerInterior(playerid,1); }
					case 5: {	SetPlayerPos(playerid,2536.5322, -1294.8425, 1044.125);		SetPlayerInterior(playerid,2); }
					case 6: {	SetPlayerPos(playerid,1267.8407, -776.9587, 1091.9063);		SetPlayerInterior(playerid,5); }
		  			case 7: {	SetPlayerPos(playerid,-1421.5618, -663.8262, 1059.5569);	SetPlayerInterior(playerid,4); }
		   			case 8: {	SetPlayerPos(playerid,-1401.067, 1265.3706, 1039.8672);	 	SetPlayerInterior(playerid,16); }
		   			case 9: {	SetPlayerPos(playerid,285.8361, -39.0166, 1001.5156);		SetPlayerInterior(playerid,1); }
		    		case 10: {	SetPlayerPos(playerid,1727.2853, -1642.9451, 20.2254);		SetPlayerInterior(playerid,18); }
				}
			}
		}
	}
	if(dialogid == loquendoVoz2)
	{
		if(response)
		{
			new rep[400];
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				format(rep, sizeof(rep), "https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&tl=es&q=%s", inputtext);
				PlayAudioStreamForPlayer(i, rep, 0, 0, 0, 0, 0);
			}
		}
	}
	if(dialogid == loquendoVoz)
	{
		if(response)
		{
			new rep[400];
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				format(rep, sizeof(rep), "http://audio1.spanishdict.com/audio?lang=es&voice=Ximena&speed=25&text=%s", inputtext);
				PlayAudioStreamForPlayer(i, rep, 0, 0, 0, 0, 0);
			}
		}
	}
	switch(dialogid)
	{
		case D_REPORTES:
		{
			switch(GetPVarInt(playerid, "PDialog"))
			{//Sacamos en que paso se encuentra el dialog
				case 0:
				{//En el caso osea el listado de todos los reportes
					if(response)
					{//Si responde el dialgo
						if(Reportes[listitem][Activo] == true){//Verificamos si continua activo
	                        SetPVarInt(playerid, "listaselecc", listitem);
	                        new lista = listitem;
	                        new str[1024];
	                        if(strlen(Reportes[lista][TextReporte])>40){
	                            new detalles[40], detalles2[40];
	                            strmid(detalles, Reportes[lista][TextReporte], 0, 40);//Extraemos solo 40 letras de los detalles para que no sea tan largo el dialog y lo pasamos a otra linea
	                            strmid(detalles2, Reportes[lista][TextReporte], 40, strlen(Reportes[lista][TextReporte]));//Extraemos solo 40 letras de los detalles para que no sea tan largo el dialog y lo pasamos a otra linea
	                            format(str, sizeof(str), "Reporte:\nReportante: %s - Reportado: %s\nDetalles: %s\n%s.", Reportes[lista][Reportante], Reportes[lista][Reportado], detalles, detalles2);//Ponemos el formato del dialog
	                        }
	                        else{
	                            format(str, sizeof(str), "Reporte:\nReportante: %s - Reportado: %s\nDetalles: %s.", Reportes[lista][Reportante], Reportes[lista][Reportado], Reportes[lista][TextReporte]);//Ponemos el formato del dialog
	                        }
	                        ShowPlayerDialog(playerid, D_REPORTES, DIALOG_STYLE_MSGBOX, "Detalles Reporte", str, "Atender", "Atras");
	                        SetPVarInt(playerid, "PDialog", 1);
						}
						else{
	                        SendClientMessage(playerid, -1, "El reporte ya fue respondido, busque otro.");
	                        callcmd::reportes(playerid);
						}
					}
				}
				case 1:{//En caso mire el reporte
                	new lista = GetPVarInt(playerid, "listaselecc");
					if(response)
					{//Si lo atiende
	                    if(Reportes[lista][Activo] == true)
						{//Verificamos si continua activo
	                        Reportes[lista][Activo] = false;
	                        new str[140];
	                        if(IsPlayerConnected(GetPlayerID(Reportes[lista][Reportante]))&&IsPlayerConnected(GetPlayerID(Reportes[lista][Reportado]))){
	                            format(str, sizeof(str), "[REPORTE]: Atendiste el reporte, Reportante: %s(%d) - Reportado: %s(%d) se encuentran activos.",
	                                Reportes[lista][Reportante], GetPlayerID(Reportes[lista][Reportante]), Reportes[lista][Reportado], GetPlayerID(Reportes[lista][Reportado]));
	                            SendClientMessage(playerid, -1, str);
	                            format(str, sizeof(str), "[Reporte]: Su reporte está siendo atendido por el administrador %s.", NombrePJ(playerid));
	                            SendClientMessage(GetPlayerID(Reportes[lista][Reportante]), -1, str);
	                        }
	                        else if(!IsPlayerConnected(GetPlayerID(Reportes[lista][Reportante]))&&IsPlayerConnected(GetPlayerID(Reportes[lista][Reportado]))){
	                            format(str, sizeof(str), "[REPORTE]: Atendiste el reporte, Reportante: %s[Desconectado] - Reportado: %s(%d)[Conectado].",
	                                Reportes[lista][Reportante], Reportes[lista][Reportado], GetPlayerID(Reportes[lista][Reportado]));
	                            SendClientMessage(playerid, -1, str);
	                        }
	                        else if(IsPlayerConnected(GetPlayerID(Reportes[lista][Reportante]))&&!IsPlayerConnected(GetPlayerID(Reportes[lista][Reportado]))){
	                            format(str, sizeof(str), "[REPORTE]: Atendiste el reporte, Reportante: %s[Conectado] - Reportado: %s[Desconectado].",
	                                Reportes[lista][Reportante], GetPlayerID(Reportes[lista][Reportante]), Reportes[lista][Reportado]);
	                            SendClientMessage(playerid, -1, str);
	                            format(str, sizeof(str), "[Reporte]: Su reporte está siendo atendido por el administrador %s.", NombrePJ(playerid));
	                            SendClientMessage(GetPlayerID(Reportes[lista][Reportante]), -1, str);
	                        }
	                        else if(!IsPlayerConnected(GetPlayerID(Reportes[lista][Reportante]))&&!IsPlayerConnected(GetPlayerID(Reportes[lista][Reportado]))){
	                            format(str, sizeof(str), "[REPORTE]: Atendiste el reporte, Reportante: %s - Reportado: %s se encuentran desconectados.",
	                                Reportes[lista][Reportante], GetPlayerID(Reportes[lista][Reportante]), Reportes[lista][Reportado], GetPlayerID(Reportes[lista][Reportado]));
	                            SendClientMessage(playerid, -1, str);
	                        }
	                    }
						else{
                        	SendClientMessage(playerid, -1, "El reporte ya fue respondido por otro administrador, busque otro.");
                        	callcmd::reportes(playerid);
                    	}
                	}
                	else{
                    	callcmd::reportes(playerid);
                	}
            	}
        	}
        	return 1;
    	}
	}
	if(dialogid == INGRESO)
	{
		if(!response) Kick(playerid);
		if(response)
		{
			if(isnull(inputtext))
			{
				new info[128];
				format(info, sizeof(info), "\
				\\c{FFFFFF}Bienvenido, {09E627}%s\n \n{FFFFFF}Ingresa tu contraseña para continuar",Nombre(playerid));
				ShowPlayerDialog(playerid, INGRESO, DIALOG_STYLE_PASSWORD, "{B6003E}IDENTIFICATE", info, "{FFFFFF}Enviar", "{FFFFFF}Salir");
				return 1;
			}
			if(!strcmp(inputtext, Info[playerid][Contra], false))
			{
				Ingresar(playerid);
				SCM(playerid,-1,"Este servidor está en versión {E727F5}BETA{FFFFFF}, puedes dejar tu {E727F5}/sugerencia{FFFFFF}.");
				ShowPlayerDialog(playerid, TEAM, DIALOG_STYLE_TABLIST_HEADERS, "Elige tu equipo", EQUIPOS, "Elegir","");
			}
			else
			{
				new stringg[128];
				format(stringg,sizeof(stringg),"(((%s [%d] Puso su Contraseña Incorrecta.)))",Nombre(playerid),playerid);
				MensajeParaAdmins(0xAFAFAFAA,stringg);
				/*new string2[128];
				Info[playerid][FailLogin]++;
				if(Info[playerid][FailLogin] == MAX_FAIL_LOGINS)
				{
					format(string2, sizeof(string2), "%s Fue pateado del servidor razón: [Contraseña Incorrecta] Max: %d intentos", Nombre(playerid),MAX_FAIL_LOGINS );
					SendClientMessageToAll(ROJO, string2);
					Kick(playerid);
					return 1;
				}*/
				return ShowPlayerDialog(playerid, INGRESO, DIALOG_STYLE_INPUT, "Ingreso", "Haz introducido una contraseña incorrecta\nIntroducela correctamente y verifica las mayúsculas", "Enviar", "Salir");
			}
		}
	}
 	if(dialogid == REGISTRO)
	{
	    if(!response)
	        return Kick(playerid);

	    if(response)
	    {
	        if(strlen(inputtext) < 4)
	        {
	            ShowPlayerDialog(playerid, REGISTRO, DIALOG_STYLE_PASSWORD,
	                             "Registro",
	                             "{ffffff}Bienvenido. Registra una nueva cuenta, ingresa una contraseña mayor a 4 caracteres",
	                             "Enviar", "Salir");
	        }
	        else
	        {
	            // Lider "dkyzer"
	            if(strcmp("dkyzer", Nombre(playerid), true) == 0)
	            {
	                gTeam[playerid] = EnVenta;
	                Owner[playerid] = playerid;
	                Autorizado[playerid] = playerid;
	                Invitado[playerid] = 1;
	            }

	            // Lider "eckosys"
	            else if(strcmp("eckosys", Nombre(playerid), true) == 0)
	            {
	                gTeam[playerid] = eTeam;
	                Owner[playerid] = playerid;
	                Autorizado[playerid] = playerid;
	                Invitado[playerid] = 1;
	            }

	            // Para agregar más líderes: sigue el mismo patrón
	            else if(strcmp("nuevoLider", Nombre(playerid), true) == 0)
	            {
	                gTeam[playerid] = playerid;    // ID del nuevo team nombre
	                Owner[playerid] = playerid;
	                Autorizado[playerid] = playerid;
	                Invitado[playerid] = 1;
	            }

	            Registrar(playerid, inputtext);

	            SCM(playerid, 0x8400F7FF, "Este servidor esta en version BETA, puedes dejar tu /sugerencia.");

	            ShowPlayerDialog(playerid, TEAM, DIALOG_STYLE_TABLIST_HEADERS,
	                             "Elige tu equipo", EQUIPOS, "Elegir", "");
	        }
	    }
	}

	if(dialogid == CARS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: ShowModelSelectionMenu(playerid, vehiculos, "Vehiculos");
				case 1: ShowModelSelectionMenu(playerid, barcos, "Barcos");
				case 2: ShowModelSelectionMenu(playerid, aviones, "Aviones");
			}
		}
	}
	switch(dialogid)
	{
		case 70:
		{
			if(!response) return 0;
			new string1[10]; inindex[playerid] = listitem;
			if(oInfo[playerid][listitem][used1] == false) return ShowModelSelectionMenu(playerid, objectlist, "Selecciona una prenda");
			format(string1, sizeof(string1), "Slot %d", listitem+1);
			ShowPlayerDialog(playerid, 71, DIALOG_STYLE_LIST, string1, "Editar hueso\nEditar posición\nRemover prenda\nOcultar prenda\nUsar prenda", "Aceptar", "Cancelar");
		}
		case 71:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(oInfo[playerid][inindex[playerid]][usando] == 0) return SendClientMessage(playerid, -1, "La prenda está oculta, pontela para poder editar su posición.");
						ShowPlayerDialog(playerid, 74, DIALOG_STYLE_LIST, "{0DFF00}Hueso", "Espina\nCabeza\nBrazo superior izquierdo\nBrazo superior derecho\nMano izquierda\nMano derecha\nLeft Tight\nRight Tight\nPie izquierdo\nPie derecho\nPantorrilla derecha\nPantorrilla izquierda\nAntebrazo izquierdo\nAntebrazo derecho\nHombro izquierdo\nHombro derecho\nCuello\nMandíbula", "Aceptar", "Cancelar");
					}
					case 1:
					{
						if(oInfo[playerid][inindex[playerid]][usando] == 0) return SendClientMessage(playerid, -1, "La prenda está oculta, pontela para poder editar su posición.");
						EditAttachedObject(playerid, inindex[playerid]);
					}
					case 2:
					{
						ShowPlayerDialog(playerid, 73, DIALOG_STYLE_MSGBOX, ""warning"Advertencia", "{FFFFFF}¿Estás seguro de que quieres remover por completo esta prenda?\nEsta acción no tiene devolución", "Aceptar", "Cancelar");
					}
					case 3:
					{
						if(oInfo[playerid][inindex[playerid]][usando] == 0) return SendClientMessage(playerid, -1, "Ya tienes ocultada esta prenda.");
						RemovePlayerAttachedObject(playerid, inindex[playerid]);
						oInfo[playerid][inindex[playerid]][usando] = 0;
						new string[128];
						mysql_format(con, string, sizeof(string), "UPDATE `toys` SET `Usando` = '0' WHERE `Nombre` = '%s'",Nombre(playerid));
						mysql_query(con, string);
						format(string, sizeof(string), "Haz{FF0000} ocultado {FFFFFF}la prenda Slot %d", inindex[playerid]+1);
						SendClientMessage(playerid, -1, string);
					}
					case 4:
					{
						new string[128];
						mysql_format(con, string, sizeof(string), "UPDATE `toys` SET `Usando` = '1' WHERE `Nombre` = '%s'",Nombre(playerid));
						mysql_query(con, string);
						if(oInfo[playerid][inindex[playerid]][usando] == 1) return SendClientMessage(playerid, -1, "Ya estás usando esta prenda.");
						oInfo[playerid][inindex[playerid]][usando] = 1;
						SetPlayerAttachedObject(playerid, inindex[playerid], oInfo[playerid][inindex[playerid]][modelid1], oInfo[playerid][inindex[playerid]][bone1], oInfo[playerid][inindex[playerid]][fOffsetX1], oInfo[playerid][inindex[playerid]][fOffsetY1], oInfo[playerid][inindex[playerid]][fOffsetZ1], oInfo[playerid][inindex[playerid]][fRotX1], oInfo[playerid][inindex[playerid]][fRotY1], oInfo[playerid][inindex[playerid]][fRotZ1], oInfo[playerid][inindex[playerid]][fScaleX1], oInfo[playerid][inindex[playerid]][fScaleY1], oInfo[playerid][inindex[playerid]][fScaleZ1]);
					}
				}
			}
		}
		case 72:
		{
			if(response)
			{
				SetPlayerAttachedObject(playerid, inindex[playerid], inmodel[playerid], listitem+1);
				oInfo[playerid][inindex[playerid]][index1] = inindex[playerid];
				oInfo[playerid][inindex[playerid]][usando] = 1;
				oInfo[playerid][inindex[playerid]][modelid1] = inmodel[playerid];
				oInfo[playerid][inindex[playerid]][bone1] = listitem+1;
				oInfo[playerid][inindex[playerid]][used1] = true;
				EditAttachedObject(playerid, inindex[playerid]);
				GivePlayerMoney(playerid, -250000);
				Info[playerid][Dinero]-=250000;
			}
		}
		case 73:
		{
			if(response)
			{
				RemovePlayerAttachedObject(playerid, inindex[playerid]);
				oInfo[playerid][inindex[playerid]][used1] = false;
				oInfo[playerid][inindex[playerid]][usando] = 0;
				new string[80];
				format(string, sizeof(string), "Haz{FF0000} removido {FFFFFF}la prenda Slot %d, está {0DFF00}vacio.", inindex[playerid]+1);
				SendClientMessage(playerid, -1, string);
				mysql_format(con, string, sizeof(string), "DELETE FROM `toys` WHERE `Nombre` = '%s' AND `Index` = '%d'",Nombre(playerid),oInfo[playerid][inindex[playerid]][index1]);
				mysql_query(con, string);
			}
		}
		case 74:
		{
			SetPlayerAttachedObject(playerid, inindex[playerid], oInfo[playerid][inindex[playerid]][modelid1], listitem+1);
			oInfo[playerid][inindex[playerid]][bone1] = listitem+1;
			EditAttachedObject(playerid, inindex[playerid]);
		}
	}
	switch(dialogid)
	{
		case CONFIG:
		{
			if(!response) return 1;
			{
				switch(listitem)
				{
					case 0:
					{
						new Moni; Moni=Info[playerid][Dinero];
						if(NombreI == 0)
						{
							if(Moni>=450000)
							{
								ShowPlayerDialog(playerid,dialogname,DIALOG_STYLE_INPUT,"{cc33ff}NUEVO NOMBRE","{FFFFFF}Introduzca su nuevo nombre\nUn cambio de nombre tiene un costo de $450.000","Cambiar","Cancelar");
							}
							else SendClientMessage(playerid, ROJO, "Debes tener $450.000 de dinero para cambiarte el nombre");
						}
						else return SendClientMessage(playerid,ROJO,"El cambio de nombre fue desactivado por un {FFFFFF}Administrador");
					}
					case 1:
					{
						if(!response) return 1;
						if(response)
						{
							ShowPlayerDialog(playerid,dialogpass,DIALOG_STYLE_PASSWORD,"{cc33ff}NUEVA CONTRASEÑA","{FFFFFF}Introduzca su contraseña actual para continuar.","Cambiar","Cancelar");
						}
					}
					case 2:
					{
						if(ADpm[playerid] == 0)
						{
							SendClientMessage(playerid,0x00ff00FF,"Has desactivado los mensajes privados");
							ADpm[playerid] = 1;
							callcmd::config(playerid);
						}
						else
						{
							SendClientMessage(playerid,0x00ff00FF,"Has activado los mensajes privados");
							ADpm[playerid] = 0;
							callcmd::config(playerid);
						}
					}
					case 3:
					{
						if(NODUEL[playerid] == 0)
						{
							NODUEL[playerid] = 1;
							callcmd::config(playerid);
						}
						else
						{
							NODUEL[playerid] = 0;
							callcmd::config(playerid);
						}
					}
					case 4:
					{
						new formato[300];
						if(!Info[playerid][ComproEDC] && !Info[playerid][ComproEscopeta] && !Info[playerid][ComproM4] && !Info[playerid][ComproMP5] && !Info[playerid][ComproRifle] && !Info[playerid][ComproSniper]) return SendClientMessage(playerid, GRIS, "No tienes armas compradas");
						format(formato, sizeof(formato), "Arma\t\tEstado\nEscopeta\t%s\nSPAS\t%s\nMP5\t%s\nM4\t%s\nRifle\t%s\nSniper\t%s",EscopetaON[playerid] ? ("{00FF00}ON") : ("{FF0000}OFF"),EDCON[playerid] ? ("{00FF00}ON") : ("{FF0000}OFF"),MP5ON[playerid] ? ("{00FF00}ON") : ("{FF0000}OFF"),M4ON[playerid] ? ("{00FF00}ON") : ("{FF0000}OFF"),RIFLEON[playerid] ? ("{00FF00}ON") : ("{FF0000}OFF"),SNIPERON[playerid] ? ("{00FF00}ON") : ("{FF0000}OFF"));
						ShowPlayerDialog(playerid, 1501, DIALOG_STYLE_TABLIST_HEADERS, "Tus armas", formato, "Cambiar", "Cerrar");
					}
					case 5:
					{
						if(Info[playerid][Skin] < 1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ff0000}Error", "Necesitar tener un skin comprado\nVe a la tienda y compra uno.", "Cerrar", "");
						else
						{
							if(Info[playerid][SkinUsando] == 0) Info[playerid][SkinUsando] = 1;
							else Info[playerid][SkinUsando] = 0;
							callcmd::config(playerid);
						}
					}
				}
			}
		}
     case 1501:
		{
			if(response)
			{
				new query[250], formato[250], texto[96], nombreArma[20], activado = 0;
				switch(listitem)
				{
				    case 0:
				    {
				        if(Info[playerid][ComproEscopeta] == 0) return SendClientMessage(playerid, ROJO, "No hay arma en ese espacio.");
				        if(EscopetaON[playerid] == 1) { texto = "Escopeta Desactivada."; nombreArma = "ESCOPETA"; EscopetaON[playerid] = 0; }
				        else { activado = 1; texto = "Escopeta Activada."; nombreArma = "ESCOPETA"; EscopetaON[playerid] = 1; }
				    }
				    case 1:
				    {
				        if(Info[playerid][ComproEDC] == 0) return SendClientMessage(playerid, ROJO, "No hay arma en ese espacio.");
				        if(EDCON[playerid] == 1) { texto = "Escopeta de combate Desactivada."; nombreArma = "EDC"; EDCON[playerid] = 0; }
				        else { activado = 1; texto = "Escopeta de combate Activada."; nombreArma = "EDC"; EDCON[playerid] = 1; }
				    }
				    case 2:
				    {
				        if(Info[playerid][ComproMP5] == 0) return SendClientMessage(playerid, ROJO, "No hay arma en ese espacio.");
				        if(MP5ON[playerid] == 1) { texto = "MP5 Desactivada."; nombreArma = "MP5"; MP5ON[playerid] = 0; }
				        else { activado = 1; texto = "MP5 Activada."; nombreArma = "MP5"; MP5ON[playerid] = 1; }
				    }
				    case 3:
				    {
				        if(Info[playerid][ComproM4] == 0) return SendClientMessage(playerid, ROJO, "No hay arma en ese espacio.");
				        if(M4ON[playerid] == 1) { texto = "M4 Desactivada."; nombreArma = "M4"; M4ON[playerid] = 0; }
				        else { activado = 1; texto = "M4 Activada."; nombreArma = "M4"; M4ON[playerid] = 1; }
				    }
				    case 4:
				    {
				        if(Info[playerid][ComproRifle] == 0) return SendClientMessage(playerid, ROJO, "No hay arma en ese espacio.");
				        if(RIFLEON[playerid] == 1) { texto = "Rifle Desactivado."; nombreArma = "RIFLE"; RIFLEON[playerid] = 0; }
				        else { activado = 1; texto = "Rifle Activado."; nombreArma = "RIFLE"; RIFLEON[playerid] = 1; }
				    }
				    case 5:
				    {
				        if(Info[playerid][ComproSniper] == 0) return SendClientMessage(playerid, ROJO, "No hay arma en ese espacio.");
				        if(SNIPERON[playerid] == 1) { texto = "Sniper Desactivado."; nombreArma = "SNIPER"; SNIPERON[playerid] = 0; }
				        else { activado = 1; texto = "Sniper Activado."; nombreArma = "SNIPER"; SNIPERON[playerid] = 1; }
				    }
				}
				if(listitem != -1)
				{
				    if(activado == 1) SendClientMessage(playerid, VERDE, texto);
				    else SendClientMessage(playerid, ROJO, texto);
					mysql_format(con, query, 250, "UPDATE `armas` SET `%s` = '%d' WHERE `Nombre` = '%s'",nombreArma,activado,Nombre(playerid));
					mysql_query(con, query);
					mysql_format(con, query, 250, "UPDATE `usuarios` SET `%s` = '%d' WHERE `Nombre` = '%s'",nombreArma,activado,Nombre(playerid));
					mysql_query(con, query);
					format(formato, sizeof(formato), "Arma\t\tEstado\nEscopeta\t%s\nSPAS\t%s\nMP5\t%s\nM4\t%s\nRifle\t%s\nSniper\t%s",EscopetaON[playerid] ? ("{00FF00}ON") : ("{FF0000}OFF"),EDCON[playerid] ? ("{00FF00}ON") : ("{FF0000}OFF"),MP5ON[playerid] ? ("{00FF00}ON") : ("{FF0000}OFF"),M4ON[playerid] ? ("{00FF00}ON") : ("{FF0000}OFF"),RIFLEON[playerid] ? ("{00FF00}ON") : ("{FF0000}OFF"),SNIPERON[playerid] ? ("{00FF00}ON") : ("{FF0000}OFF"));
					ShowPlayerDialog(playerid, 1501, DIALOG_STYLE_TABLIST_HEADERS, "Tus armas", formato, "Cambiar", "Cerrar");
				}
			}
		}
	}
	if(dialogid == dialogpass)
	{
		if(!response) return 1;
		if(response)
		{
			if(strcmp(Info[playerid][Contra], inputtext, false))
			{
				ShowPlayerDialog(playerid,dialogpass,DIALOG_STYLE_PASSWORD,"{cc33ff}NUEVA CONTRASEÑA","{FFFFFF}Introduzca su contraseña actual para continuar.","Cambiar","Cancelar");
				return 1;
			}
			else
			{
				ShowPlayerDialog(playerid,dialogpass2,DIALOG_STYLE_PASSWORD,"{cc33ff}NUEVA CONTRASEÑA","{FFFFFF}Introduzca su nueva contraseña.\nDebe tener más de 4 carácteres","Cambiar","Cancelar");
				return 1;
			}
		}
	}
	if(dialogid == dialogpass2)
	{
		if(response)
		{
			if(strlen(inputtext) <= 4)
			{
				ShowPlayerDialog(playerid,dialogpass2,DIALOG_STYLE_PASSWORD,"{cc33ff}NUEVA CONTRASEÑA","{FFFFFF}Introduzca su nueva contraseña.\nDebe tener más de 4 carácteres","Cambiar","Cancelar");
				return 1;
			}
			new string2[128];
			mysql_format(con, string2, 128, "UPDATE `usuarios` SET `Contra` = '%s' WHERE `Nombre` = '%s'",inputtext,Nombre(playerid));
			mysql_query(con, string2);
			format(string2,sizeof(string2),"{FFFFFF}Recuerda Que La Siguiente Vez Que Juegues Debes\nIntroducir la siguiente contraseña:\n\n{FF0000}%s",inputtext);
			ShowPlayerDialog(playerid,78,DIALOG_STYLE_MSGBOX,"Nueva Contraseña",string2,"Aceptar","");
			format(Info[playerid][Contra], 129, "%s", inputtext);
			return 1;
		}
	}
	if(dialogid == dialogname)
	{
		if(response)
		{
			new nombre[MAX_PLAYER_NAME],string2[128],query[250];
			GetPlayerName(playerid, nombre, sizeof(nombre));
			format(string2,sizeof(string2),"{FFFFFF}%s (ID: %d) {94E021}Se ha cambiado el Nombre a: {FFFFFF}\"%s\" .",nombre,playerid,inputtext);
			SendClientMessageToAll(VERDE,string2);
			format(string2,sizeof(string2),"{FFFFFF}Recuerda Que La Siguiente Vez Que Jueges Debes\nIniciar En El Servidor Con El Nick De\n\n{FF0000}%s",inputtext);
			ShowPlayerDialog(playerid,78,DIALOG_STYLE_MSGBOX,"Nuevo NickName",string2,"Aceptar","");
			mysql_format(con, query, sizeof(query), "UPDATE `armas` SET `Nombre` = '%s' WHERE `Nombre` = '%s'",inputtext,Nombre(playerid));
			mysql_query(con, query);
			mysql_format(con, query, sizeof(query), "SELECT * FROM `toys` WHERE `Nombre` = '%s'",Nombre(playerid));
			mysql_pquery(con, query, "ToysNameChange", "ds", playerid,inputtext);
			GivePlayerMoney(playerid, -450000);
			Info[playerid][Dinero]-=450000;
		}
		return 1;
	}
	if(dialogid == SUGERENCIA)
	{
		if(!response) return 1;
		if(response)
		{
			ShowPlayerDialog(playerid, SUGERENCIA2, DIALOG_STYLE_INPUT, "{cc33ff}Sugerencias", "{FFFFFF}Escriba la sugerencia que desea dejarnos\nSe enviará a los administradores y se guardará en un log.", "Enviar", "Cerrar");
		}
	}
	if(dialogid == SUGERENCIA2)
	{
		if(response)
		{
			new mensaje[128];
			format(mensaje, sizeof(mensaje), "%s Ha dejado una sugerencia: %s.",Nombre(playerid),inputtext);
			MensajeParaAdmins(-1,mensaje);
			MensajeParaAdmins(-1,"Se guardó en un archivo Sugerencias.txt.");
			GuardarArchivo("Sugerencias",mensaje);
			SendClientMessage(playerid, -1, "¡Gracias por dejarnos tu sugerencia!.");
		}
	}
	if(dialogid == 1000 && response)
	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0: ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_INPUT, "Cambiar nombre servidor", "Introducir el nombre a cambiar.", "Cambiar", "Cancelar");
			case 1: ShowPlayerDialog(playerid, 1002, DIALOG_STYLE_INPUT, "Cambiar contraseña servidor", "Introducir la contraseña a cambiar.", "Cambiar", "Cancelar");
			case 2: ShowPlayerDialog(playerid, 1003, DIALOG_STYLE_INPUT, "Cambiar contraseña RCON", "Introducir la contraseña a cambiar", "Cambiar", "Cancelar");
			case 3: ShowPlayerDialog(playerid, 1004, DIALOG_STYLE_INPUT, "Banear usuario", "Introducir la id del usuario a banear", "Banear", "Cancelar");
			case 4: ShowPlayerDialog(playerid, 1005, DIALOG_STYLE_INPUT, "Banear IP", "Introducir IP a banear", "Banear", "Cancelar");
			case 5: ShowPlayerDialog(playerid, 1006, DIALOG_STYLE_INPUT, "Desban usuario", "Introducir el nombre exacto del usuario.", "Desban", "Cancelar");
			case 6: ShowPlayerDialog(playerid, 1007, DIALOG_STYLE_INPUT, "Desban IP", "Introducir IP exacta del desconectado", "Desban", "Cancelar");
			case 7: ShowPlayerDialog(playerid, 1008, DIALOG_STYLE_INPUT, "Patear usuario", "Introducir la id del usuario", "Patear", "Cancelar");
			case 8: ShowPlayerDialog(playerid, 1009, DIALOG_STYLE_INPUT, "Crashear usuario", "Introducir la id del usuario", "Crash", "Cancelar");
			case 9: ShowPlayerDialog(playerid, 1010, DIALOG_STYLE_INPUT, "Cambiar gmtext", "Introducir GameMode Texto", "Cambiar", "Cancelar");
			case 10: ShowPlayerDialog(playerid, 1011, DIALOG_STYLE_INPUT, "Cambiar Mapname", "Introducir MapName", "Cambiar", "Cancelar");
			case 11: ShowPlayerDialog(playerid, 1012, DIALOG_STYLE_INPUT, "Cambiar Web URL", "Introducir Dirección web url", "Cambiar", "Cancelar");
			case 12: ShowPlayerDialog(playerid, 1013, DIALOG_STYLE_INPUT, "Cambiar World Time", "Introducir tiempo del mundo", "Cambiar", "Cancelar");
			case 13: ShowPlayerDialog(playerid, 1014, DIALOG_STYLE_INPUT, "Cambiar Weather", "Introducir id del clima", "Cambiar", "Cancelar");
		}
	}
	//Funciones
	switch(dialogid)
	{
		case 1001:
		{
			if(!response) return 1;
			new str[40],str2[80],hostname[64];
			GetServerVarAsString("hostname", hostname, sizeof(hostname));
			format(str,sizeof(str),"hostname %s",inputtext);
			SendRconCommand(str);
			format(str2,sizeof(str2),"Has cambiado el hostname %s\nExitosamente a: %s",hostname,inputtext);
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{00FF00}Exito!",str2, "Cerrar","");
		}
		case 1002:
		{
			if(response) return 1;
			new str[40],str2[80];
			format(str,sizeof(str),"password %s",inputtext);
			SendRconCommand(str);
			format(str2, sizeof(str2), "Has seteado la contraseña del servidor a: %s",inputtext);
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{00ff00}Exito!",str2, "Cerrar", "");
		}
		case 1003:
		{
			if(!response) return 1;
			new str[40],str2[80];
			format(str, sizeof(str), "rcon_password %s", inputtext);
			format(str2, sizeof(str2), "Has cambiado la contraseña\n Rcon del servidor a: %s",inputtext);
			SendRconCommand(str);
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{00FF00}Exito!",str2, "Cerrar","");
		}
		case 1004:
		{
			if(!response) return 1;
			new id = strval(inputtext),str2[80],name[MAX_PLAYER_NAME];
			GetPlayerName(id, name, sizeof(name));
			if(id == playerid) return SendClientMessage(playerid, -1, "No puedes banearte a ti mismo.");
			if(IsPlayerConnected(id) == 0) return ShowPlayerDialog(playerid, 9, DIALOG_STYLE_MSGBOX, "Error", "El usuario con la id escrita no se encuentra conectado", "Cerrar", "");
			if(IsPlayerConnected(id) == 1)
			{
				format(str2, sizeof(str2), "Has baneado con exito a %s id: %d",name,id);
				Ban(id);
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{00FF00}Exito!", str2, "Cerrar", "");
			}
		}
		case 1005:
		{
			new str[40],str2[80];
			format(str, sizeof(str), "banip %s",inputtext);
			format(str2, sizeof(str2), "Has baneado con exito la siguiente IP: %d",inputtext);
			SendRconCommand(str);
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{00FF00}Exito!", str2, "Cerrar", "");
		}
		case 1006:
		{
			new str2[128];
			if(Desban(inputtext))
			{
				format(str2, sizeof(str2), "Has desbaneado la cuenta %s con exito!",inputtext);
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{00FF00}Exito!", str2, "Cerrar", "");
				return 1;
			}
			else if(resultadob==-1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Error", "La cuenta no existe!", "Cerrar", "");
			else return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Error", "La cuenta no está baneada!", "Cerrar", "");
		}
		case 1007:
		{
			if(!response) return 1;
			new ip = strval(inputtext),str[40],str2[80];
			format(str, sizeof(str), "unbanip %d",ip);
			SendRconCommand(str);
			format(str2, sizeof(str2), "Has desbaneado correctamente la siguiente IP: %d",ip);
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{00FF00}Exito!", str2, "Cerrar","");
		}
		case 1008:
		{
			if(!response) return 1;
			new str2[40],id,name[MAX_PLAYER_NAME];
			id = strval(inputtext);
			if(id == playerid) SendClientMessage(playerid, -1, "No puedes patearte a ti mismo");
			if(IsPlayerConnected(id)==0) return ShowPlayerDialog(playerid, 12, DIALOG_STYLE_MSGBOX, "{00ff00}Exito!", "La id del jugador escrita no está conectado", "Cerrar", "");
			if(IsPlayerConnected(id)==1)
			{
				GetPlayerName(id, name, sizeof(name));
				Kick(id);
				format(str2, sizeof(str2), "Has pateado a %s id: %d", name,id);
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{00ff00}Exito!", str2, "Cerrar", "");
			}
		}
		case 1009:
		{
			new id = strval(inputtext),name[MAX_PLAYER_NAME],str2[40];
			if(id == playerid) return SendClientMessage(playerid, -1, "No puedes crashearte a ti mismo");
			if(IsPlayerConnected(id)==0) return ShowPlayerDialog(playerid, 13, DIALOG_STYLE_MSGBOX, "Error", "La id del jugador escrita no está conectado", "Cerrar","");
			if(IsPlayerConnected(id)==1)
			{
				GetPlayerName(id, name, sizeof(name));
				GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 1000, 0);
				GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 2000, 1);
				GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 3000, 2);
				GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 4000, 3);
				GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
				GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 6000, 5);
				GameTextForPlayer(id, "•¤¶§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 7000, 6);
				format(str2, sizeof(str2), "Has crasheado a %s id: %d", name,id);
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{00FF00}Exito!", str2, "Cerrar", "");
			}
		}
		case 1010:
		{
		}
	}
	if(dialogid == DUELOSMENU2)
	{
		if (response)
		{
			if (Duelos[listitem+1][Libre] == 1)
			{
				SendClientMessage(playerid,-1,"Esa arena esta ocupada, espera a que termine el duelo ó escoje otra arena.");
				ShowPlayerDialog(playerid, DUELOSMENU2, DIALOG_STYLE_LIST,"Elige una arena","San Fierro\nAmmunation\nWarehouse\nFábrica\nEstadio Beisbol\nEscuela de autos\nLil' probe inn\nLas Venturas\nLas Venturas 2","Escojer", "Cancelar");
				return 1;
			}
			Duelos[listitem+1][DesaId] = playerid;
			Duelos[listitem+1][DesafiadoId] = GetPVarInt(playerid, "Invitado");
			ShowPlayerDialog(playerid, DUELOSMENU3, DIALOG_STYLE_LIST,"Elige las armas","Desert Eagle\nEscopeta de combate\nEscopeta\nMP5\nM4\nRifle\nSniper","Escojer", "Cancelar");
		}
		if(!response)
		{
			SetPVarInt(GetPVarInt(playerid, "Invitado"), "Invitado", INVALID_PLAYER_ID);
			SetPVarInt(playerid, "Invitado", INVALID_PLAYER_ID);
		}
		return 1;
	}
	if(dialogid == DUELOSMENU4)
	{
		if(response)
		{
			if(!IsNumeric(inputtext))
			{
				ShowPlayerDialog(playerid, DUELOSMENU4, DIALOG_STYLE_INPUT, "Apuesta", "{ffffff}Introduce la cantidad a apostar", "Enviar", "Cancelar");
				return 1;
			}
			if(Info[playerid][Dinero] < strval(inputtext))
			{
				ShowPlayerDialog(playerid, DUELOSMENU4, DIALOG_STYLE_INPUT, "Apuesta", "{ffffff}Introduce la cantidad a apostar", "Enviar", "Cancelar");
				SendClientMessage(playerid, 0xAAAAAAFF, "No tienes el dinero suficiente.");
				return 1;
			}
			if(Info[GetPVarInt(playerid, "Invitado")][Dinero] < strval(inputtext))
			{
				ShowPlayerDialog(playerid, DUELOSMENU4, DIALOG_STYLE_INPUT, "Apuesta", "{ffffff}Introduce la cantidad a apostar", "Enviar", "Cancelar");
				SendClientMessage(playerid, 0xAAAAAAFF, "El invitado no tiene el dinero suficiente.");
				return 1;
			}
			SetPVarInt(playerid, "Apuesta", strval(inputtext));
			if(isnull(inputtext)) SetPVarInt(playerid, "Apuesta", 0);
			new str[50],string2[128];
			for (new i = 1; i <=ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
					if(!isnull(inputtext))
					{
						SetPVarInt(Duelos[i][DesafiadoId], "Apuesta", strval(inputtext));
						SetPVarInt(Duelos[i][DesafiadoId], "Invitado", Duelos[i][DesafiadoId]);
						switch (Duelos[i][ArmasId])
						{
							case 1: str = "Desert Eagle";
							case 2: str = "Escopeta De Combate";
							case 3: str = "Escopeta";
							case 4: str = "MP5";
							case 5: str = "M4";
							case 6: str = "Rifle";
							case 7: str = "Sniper";
						}
						new asd[20];
						switch(i)
						{
							case 1: asd="San fierro";
							case 2: asd="Ammunation";
							case 3: asd="Warehouse";
							case 4: asd="Fábrica";
							case 5: asd="Estadio de beisbol";
							case 6: asd="Escuela de autos";
							case 7: asd="Lil' probe inn";
							case 8: asd="Las venturas";
							case 9: asd="Las venturas 2";
						}
						if(GetPVarInt(playerid, "Apuesta") == 0)
						format(string2,sizeof(string2),"%s Te ha desafiado a un duelo con %s en %s",Nombre(playerid),str,asd);
						else format(string2,sizeof(string2),"%s Te ha desafiado a un duelo con %s en la arena %d por {007B00}%d$",Nombre(playerid),str,i,GetPVarInt(playerid, "Apuesta"));
						SendClientMessage(Duelos[i][DesafiadoId], 0x3EC61CFF, string2);
						SendClientMessage(Duelos[i][DesafiadoId], 0x3EC61CFF, "Usa /aceptar duelo o /rechazar duelo");
						format(string2,sizeof(string2),"Tu invitación se envió con éxito a %s, el duelo se auto cancelará en 30s si no es aceptado.",Nombre(Duelos[i][DesafiadoId]));
						SendClientMessage(playerid,0x3EC61CFF,string2);
						SetPVarInt(playerid, "Enviado", 1);
						timerduelo[playerid] = SetTimerEx("CancelarDuelo", 30000, false, "d", playerid);
						break;
					}
				}
			}
		}
		if (!response)
		{
			for (new i=1; i<= ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
					SetPVarInt(GetPVarInt(playerid, "Invitado"), "Invitado", INVALID_PLAYER_ID);
					SetPVarInt(playerid, "Invitado", INVALID_PLAYER_ID);
					Duelos[i][DesaId] = -1;
					Duelos[i][ArmasId] = -1;
					Duelos[i][DesafiadoId] = -1;
					Duelos[i][Libre] = 0;
					break;
				}
			}
		}
	}
	if (dialogid == DUELOSMENU3)
	{
		if (response)
		{
			for (new i=1; i<= ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
					Duelos[i][ArmasId] = listitem+1;
					break;
				}
			}
			ShowPlayerDialog(playerid, DUELOSMENU4, DIALOG_STYLE_INPUT, "Apuesta", "{ffffff}Introduce la cantidad a apostar", "Enviar", "Cancelar");
		}
		if (!response)
		{
			for (new i=1; i<= ARENAS; i++)
			{
				if (Duelos[i][DesaId] == playerid)
				{
					SetPVarInt(GetPVarInt(playerid, "Invitado"), "Invitado", INVALID_PLAYER_ID);
					SetPVarInt(playerid, "Invitado", INVALID_PLAYER_ID);
					Duelos[i][DesaId] = -1;
					Duelos[i][ArmasId] = -1;
					Duelos[i][DesafiadoId] = -1;
					Duelos[i][Libre] = 0;
					return 1;
				}
			}
		}
	}
  	switch(dialogid)
	{
		case ARMAST:
		{
			new requerido = Info[playerid][Dinero], armaobtiene, dineroobjeto, nombrearma[20], query[128];
			if(!response) return ShowPlayerDialog(playerid,TIENDA,DIALOG_STYLE_TABLIST_HEADERS,"TIENDA","Item\t\tPrecio\n• Skins\t\t{00ff00}100.000$\n• Chaleco\t\t{00FF00}150.000$\n• Armas\n• Prendas\t\t {00ff00}250.000$","Comprar","Cerrar");
			switch(listitem)
			{
			    case 0:
			    {
			        if(Info[playerid][ComproEscopeta] == 1) return SCM(playerid,0xff0000ff,"Ya compraste esta arma!");
			        dineroobjeto = 150000;
			        nombrearma = "ESCOPETA";
				}
				case 1:
			    {
			        if(Info[playerid][ComproEDC] == 1) return SCM(playerid,0xff0000ff,"Ya compraste esta arma!");
			        dineroobjeto = 1000000;
			        nombrearma = "EDC";
				}
				case 2:
			    {
			        if(Info[playerid][ComproMP5] == 1) return SCM(playerid,0xff0000ff,"Ya compraste esta arma!");
			        dineroobjeto = 250000;
			        nombrearma = "MP5";
				}
				case 3:
			    {
			        if(Info[playerid][ComproM4] == 1) return SCM(playerid,0xff0000ff,"Ya compraste esta arma!");
			        dineroobjeto = 500000;
			        nombrearma = "M4";
				}
				case 4:
			    {
			        if(Info[playerid][ComproRifle] == 1) return SCM(playerid,0xff0000ff,"Ya compraste esta arma!");
			        dineroobjeto = 650000;
			        nombrearma = "RIFLE";
				}
				case 5:
			    {
			        if(Info[playerid][ComproSniper] == 1) return SCM(playerid,0xff0000ff,"Ya compraste esta arma!");
			        dineroobjeto = 2000000;
			        nombrearma = "SNIPER";
				}
			}
			if(requerido >= dineroobjeto)
			{
			    switch(listitem)
			    {
			        case 0: Info[playerid][ComproEscopeta] = 1,EscopetaON[playerid] = 1, armaobtiene = 25;
			        case 1: Info[playerid][ComproEDC] = 1,EDCON[playerid] = 1, armaobtiene = 27;
			        case 2: Info[playerid][ComproMP5] = 1,MP5ON[playerid] = 1, armaobtiene = 29;
			        case 3: Info[playerid][ComproM4] = 1,M4ON[playerid] = 1, armaobtiene = 31;
			        case 4: Info[playerid][ComproRifle] = 1,RIFLEON[playerid] = 1, armaobtiene = 33;
			        case 5: Info[playerid][ComproSniper] = 1,SNIPERON[playerid] = 1, armaobtiene = 34;
			    }
				mysql_format(con, query, sizeof(query), "UPDATE `usuarios` SET `%s` = '1' WHERE `Nombre` = '%s'",nombrearma,Info[playerid][ComproEscopeta],Nombre(playerid));
				mysql_query(con, query);
				GivePlayerMoney(playerid, -dineroobjeto);
				Info[playerid][Dinero] -= dineroobjeto;
				GivePlayerWeapon(playerid, armaobtiene, 99999);
			}
			else return SCM(playerid,0xff0000ff,"Dinero insuficiente");
		}
	}

	switch(dialogid)
	{
		case TIENDA:
		{
			if(!response)return 1;
			switch(listitem)
			{
				case 0: ShowModelSelectionMenu(playerid, skinlist, "SKINS");
				case 1:
				{
					new requerido = Info[playerid][Dinero];
					if(requerido > 150000)
					{
						Info[playerid][ComproChaleco] = 1;
						new query[128];
						mysql_format(con, query, sizeof(query), "UPDATE `usuarios` SET `Chaleco` = '%d' WHERE `Nombre` = '%s'",Info[playerid][ComproChaleco],Nombre(playerid));
						mysql_query(con, query);
						GivePlayerMoney(playerid,-150000);
						Info[playerid][Dinero]-=150000;
						SetPlayerArmour(playerid,100);
					}
					else return SCM(playerid,0xff0000ff,"No tienes el dinero suficiente");
				}
				case 2:
				{
					new Resultado[20], Escopeta[20],MP5[20],M4[20],Rifle[20],Sniper[20], strings[356];
					if(Info[playerid][ComproEDC] == 0) Resultado = "{00ff00}1.000.000$";
					if(Info[playerid][ComproEDC] == 1) Resultado = "{ff0000}COMPRADA";
					if(Info[playerid][ComproEscopeta] == 0) Escopeta = "{00ff00}150.000$";
					if(Info[playerid][ComproEscopeta] == 1) Escopeta = "{FF0000}COMPRADA";
					if(Info[playerid][ComproMP5] == 0) MP5 = "{00FF00}250.000$";
					if(Info[playerid][ComproMP5] == 1) MP5 = "{FF0000}COMPRADA";
					if(Info[playerid][ComproM4] == 0) M4 = "{00ff00}500.000$";
					if(Info[playerid][ComproM4] == 1) M4 = "{ff0000}COMPRADA";
					if(Info[playerid][ComproRifle] == 0) Rifle = "{00ff00}650.000$";
					if(Info[playerid][ComproRifle] == 1) Rifle = "{FF0000}COMPRADA";
					if(Info[playerid][ComproSniper] == 0) Sniper = "{00ff00}2.000.000$";
					if(Info[playerid][ComproSniper] == 1) Sniper = "{ff0000}COMPRADA";
					format(strings,sizeof(strings),"Arma\t\tPrecio\nEscopeta\t\t%s\nEscopeta de combate\t\t%s\nMP5\t\t%s\nM4\t\t%s\nRifle\t\t%s\nSniper\t\t%s",Escopeta,Resultado,MP5,M4,Rifle,Sniper);
					ShowPlayerDialog(playerid,ARMAST,DIALOG_STYLE_TABLIST_HEADERS,"Armas",strings,"Comprar","Atras");
				}
				case 3:
				{
					if(oInfo[playerid][4][used1] == true && oInfo[playerid][3][used1] == true && oInfo[playerid][2][used1] == true && oInfo[playerid][1][used1] == true && oInfo[playerid][0][used1] == true) return SendClientMessage(playerid, -1, "Ya no te quedan slots disponibles, maximo 5 prendas.");
					ShowModelSelectionMenu(playerid, objectlist, "Prendas");
				}
				case 4:
				{
					if(Info[playerid][VIP]==1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Membresía VIP", "{ffffff}Ya eres usuario VIP No puedes volver a comprar", "Cerrar", "");
					if(Info[playerid][Coins]<50) return SendClientMessage(playerid, -1, "Se necesita 50 monedas para obtener VIP.");
					ShowPlayerDialog(playerid, DIALOG_VIP, DIALOG_STYLE_MSGBOX, "{ffff00}Membresía VIP", "{6FBBC2}¿Estás seguro de que quieres comprar membresía VIP por 50 monedas?", "Comprar", "Cancelar");
				}
				case 5: ShowPlayerDialog(playerid, MONEDAS, DIALOG_STYLE_TABLIST_HEADERS, "Monedas", "Paquete\tPrecio\n• 10 Monedas\t{00ff00}220.000$\n• 20 Monedas\t{00ff00}310.000$\n• 30 Monedas\t{00ff00}450.000$\n• 40 Monedas\t{00ff00}545.000$\n• 50 Monedas\t{00ff00}650.000$", "Comprar", "Cancelar");
			}
		}
	}
	switch(dialogid)
	{
		case DIALOG_VIP:
		{
			if(response)
			{
				new query[200];
				mysql_format(con, query, sizeof query, "UPDATE `usuarios` SET `VIP` = '1', `VIP_EXPIRE` = '%d' WHERE `Nombre` = '%s'",2592000+gettime(),Nombre(playerid));
				mysql_query(con, query);
				Info[playerid][Coins]-=50;
				Info[playerid][VIP_EXPIRE] = 2592000+gettime();
				Info[playerid][VIP] = 1;
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ffff00}Nuevo Miembro VIP", "{6FBBC2}Felicidades ya perteneces al grupo VIP para ver ayuda usa {6FBBC3}/ayudavip\nTu membresía vip vencerá en un mes ejemplo: compraste hoy 15 el 15 del otro mes vence.", "Cerrar", "");
			}
		}
		case MONEDAS2:
		{
			if(response)
			{
				Info[playerid][Coins]+=10;
				SendClientMessage(playerid,-1,"Haz comprado 10 monedas por {3e9c35}220.000${FFFFFF} dolares.");
				GivePlayerMoney(playerid, -220000);
				Info[playerid][Dinero]-=220000;
			}
		}
		case MONEDAS3:
		{
			if(response)
			{
				Info[playerid][Coins]+=20;
				SendClientMessage(playerid,-1,"Haz comprado 20 monedas por {3e9c35}310.000${FFFFFF} dolares.");
				GivePlayerMoney(playerid, -310000);
				Info[playerid][Dinero]-=310000;
			}
		}
		case MONEDAS4:
		{
			if(response)
			{
				Info[playerid][Coins]+=30;
				SendClientMessage(playerid,-1,"Haz comprado 30 monedas por {3e9c35}450.000${FFFFFF} dolares.");
				GivePlayerMoney(playerid, -450000);
				Info[playerid][Dinero]-=450000;
			}
		}
		case MONEDAS5:
		{
			if(response)
			{
				Info[playerid][Coins]+=40;
				SendClientMessage(playerid,-1,"Haz comprado 40 monedas por {3e9c35}545.000${FFFFFF} dolares.");
				GivePlayerMoney(playerid, -545000);
				Info[playerid][Dinero]-=545000;
			}
		}
		case MONEDAS6:
		{
			if(response)
			{
				Info[playerid][Coins]+=50;
				SendClientMessage(playerid,-1,"Haz comprado 50 monedas por {3e9c35}650.000${FFFFFF} dolares.");
				GivePlayerMoney(playerid, -650000);
				Info[playerid][Dinero]-=650000;
			}
		}
	}
	if(dialogid == MONEDAS)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(Info[playerid][Dinero]<220000) return SendClientMessage(playerid, -1, "No tienes el dinero requerido");
					ShowPlayerDialog(playerid, MONEDAS2, DIALOG_STYLE_MSGBOX, ""warning"Advertencia", "{FFFFFF}¿Seguro que quieres comprar este paquete de 10 monedas por {3e9c35}220.000${ffffff}?", "Comprar", "Cancelar");
				}
				case 1:
				{
					if(Info[playerid][Dinero]<310000) return SendClientMessage(playerid, -1, "No tienes el dinero requerido");
					ShowPlayerDialog(playerid, MONEDAS3, DIALOG_STYLE_MSGBOX, ""warning"Advertencia", "{FFFFFF}¿Seguro que quieres comprar este paquete de 20 monedas por {3e9c35}310.000${ffffff}?", "Comprar", "Cancelar");
				}
				case 2:
				{
					if(Info[playerid][Dinero]<450000) return SendClientMessage(playerid, -1, "No tienes el dinero requerido");
					ShowPlayerDialog(playerid, MONEDAS4, DIALOG_STYLE_MSGBOX, ""warning"Advertencia", "{FFFFFF}¿Seguro que quieres comprar este paquete de 30 monedas por {3e9c35}450.000${ffffff}?", "Comprar", "Cancelar");
				}
				case 3:
				{
					if(Info[playerid][Dinero]<545000) return SendClientMessage(playerid, -1, "No tienes el dinero requerido");
					ShowPlayerDialog(playerid, MONEDAS5, DIALOG_STYLE_MSGBOX, ""warning"Advertencia", "{FFFFFF}¿Seguro que quieres comprar este paquete de 40 monedas por {3e9c35}545.000${ffffff}?", "Comprar", "Cancelar");
				}
				case 4:
				{
					if(Info[playerid][Dinero]<650000) return SendClientMessage(playerid, -1, "No tienes el dinero requerido");
					ShowPlayerDialog(playerid, MONEDAS6, DIALOG_STYLE_MSGBOX, ""warning"Advertencia", "{FFFFFF}¿Seguro que quieres comprar este paquete de 50 monedas por {3e9c35}650.000${ffffff}?", "Comprar", "Cancelar");
				}
			}
		}
	}
  	// ======================================================
// DIALOG EXPULSADO
// ======================================================
	if(dialogid == EXPULSADO)
	{
	    if(!response)
	        return ShowPlayerDialog(playerid, EXPULSADO, DIALOG_STYLE_TABLIST_HEADERS, "Cambia tu equipo", EQUIPOS, "Cambiar", "");

	    switch(listitem)
	    {
	        case 0: // OldsGang (publico)
	        {
	            if(CountTeamPlayers(OldsGang) >= 5)
	            {
	                SendClientMessage(playerid, -1, "No pueden haber mas miembros en ese equipo, elige otro.");
	                ShowPlayerDialog(playerid, EXPULSADO, DIALOG_STYLE_TABLIST_HEADERS, "Cambia tu equipo", EQUIPOS, "Cambiar","Cancelar");
	                return 1;
	            }
	            gTeam[playerid] = OldsGang;
	            SpawnPlayer(playerid);
	        }
	        case 1: // TheWins (publico)
	        {
	            if(CountTeamPlayers(TheWins) >= 5)
	            {
	                SendClientMessage(playerid, -1, "No pueden haber mas miembros en ese equipo, elige otro.");
	                ShowPlayerDialog(playerid, EXPULSADO, DIALOG_STYLE_TABLIST_HEADERS, "Cambia tu equipo", EQUIPOS, "Cambiar","Cancelar");
	                return 1;
	            }
	            gTeam[playerid] = TheWins;
	            SpawnPlayer(playerid);
	        }
	        case 2: // TheLegends (publico)
	        {
	            if(CountTeamPlayers(TheLegends) >= 5)
	            {
	                SendClientMessage(playerid, -1, "No pueden haber mas miembros en ese equipo, elige otro.");
	                ShowPlayerDialog(playerid, EXPULSADO, DIALOG_STYLE_TABLIST_HEADERS, "Cambia tu equipo", EQUIPOS, "Cambiar","Cancelar");
	                return 1;
	            }
	            gTeam[playerid] = TheLegends;
	            SpawnPlayer(playerid);
	        }
	        case 3: // EnVenta (privado) ID: 52
	        {
	            new teamID = 52;

	            // PERMITIR SI:
	            // Fue invitado al team
	            // O si es Owner
	            // O si es Autorizado
	            if(Invitado[playerid] != teamID &&
	               Owner[playerid] != teamID &&
	               Autorizado[playerid] != teamID)
	            {
	                SendClientMessage(playerid, ROJO, "Este team es privado, pidele invitacion al dueno.");
	                ShowPlayerDialog(playerid, EXPULSADO, DIALOG_STYLE_TABLIST_HEADERS, "Cambia tu equipo", EQUIPOS, "Cambiar","Cancelar");
	                return 1;
	            }

	            if(CountTeamPlayers(teamID) >= 5)
	            {
	                SendClientMessage(playerid, -1, "No pueden haber mas miembros en ese equipo, elige otro.");
	                ShowPlayerDialog(playerid, EXPULSADO, DIALOG_STYLE_TABLIST_HEADERS, "Cambia tu equipo", EQUIPOS, "Cambiar","Cancelar");
	                return 1;
	            }

	            gTeam[playerid] = teamID;
	            SpawnPlayer(playerid);
	        }
	        case 4: // eTeam (privado) ID: 53
	        {
	            new teamID = 53;

	            if(Invitado[playerid] != teamID &&
	               Owner[playerid] != teamID &&
	               Autorizado[playerid] != teamID)
	            {
	                SendClientMessage(playerid, ROJO, "Este team es privado, pidele invitacion al dueno.");
	                ShowPlayerDialog(playerid, EXPULSADO, DIALOG_STYLE_TABLIST_HEADERS, "Cambia tu equipo", EQUIPOS, "Cambiar","Cancelar");
	                return 1;
	            }

	            if(CountTeamPlayers(teamID) >= 5)
	            {
	                SendClientMessage(playerid, -1, "No pueden haber mas miembros en ese equipo, elige otro.");
	                ShowPlayerDialog(playerid, EXPULSADO, DIALOG_STYLE_TABLIST_HEADERS, "Cambia tu equipo", EQUIPOS, "Cambiar","Cancelar");
	                return 1;
	            }

	            gTeam[playerid] = teamID;
	            SpawnPlayer(playerid);
	        }
	    }
	    return 1;
	}



	// ======================================================
	// DIALOG CHANGETEAM
	// ======================================================
	if(dialogid == CHANGETEAM)
	{
	    if(!response)
	        return 1;

	    switch(listitem)
	    {
	        case 0: // OldsGang
	        {
	            if(CountTeamPlayers(OldsGang) >= 5)
	            {
	                SendClientMessage(playerid, -1, "No pueden haber mas miembros en ese equipo, elige otro.");
	                ShowPlayerDialog(playerid, CHANGETEAM, DIALOG_STYLE_TABLIST_HEADERS, "Cambiar tu equipo", EQUIPOS,"Cambiar","Cancelar");
	                return 1;
	            }
	            gTeam[playerid] = OldsGang;
	            SpawnPlayer(playerid);
	        }
	        case 1: // TheWins
	        {
	            if(CountTeamPlayers(TheWins) >= 5)
	            {
	                SendClientMessage(playerid, -1, "No pueden haber mas miembros en ese equipo, elige otro.");
	                ShowPlayerDialog(playerid, CHANGETEAM, DIALOG_STYLE_TABLIST_HEADERS, "Cambiar tu equipo", EQUIPOS,"Cambiar","Cancelar");
	                return 1;
	            }
	            gTeam[playerid] = TheWins;
	            SpawnPlayer(playerid);
	        }
	        case 2: // TheLegends
	        {
	            if(CountTeamPlayers(TheLegends) >= 5)
	            {
	                SendClientMessage(playerid, -1, "No pueden haber mas miembros en ese equipo, elige otro.");
	                ShowPlayerDialog(playerid, CHANGETEAM, DIALOG_STYLE_TABLIST_HEADERS, "Cambiar tu equipo", EQUIPOS,"Cambiar","Cancelar");
	                return 1;
	            }
	            gTeam[playerid] = TheLegends;
	            SpawnPlayer(playerid);
	        }
	        case 3: // EnVenta ID 52 (privado)
	        {
	            new teamID = 52;

	            if(Invitado[playerid] != teamID &&
	               Owner[playerid] != teamID &&
	               Autorizado[playerid] != teamID)
	            {
	                SendClientMessage(playerid, ROJO, "Este team es privado, pidele invitacion al dueno.");
	                ShowPlayerDialog(playerid, CHANGETEAM, DIALOG_STYLE_TABLIST_HEADERS, "Cambiar tu equipo", EQUIPOS,"Cambiar","Cancelar");
	                return 1;
	            }

	            if(CountTeamPlayers(teamID) >= 5)
	            {
	                SendClientMessage(playerid, -1, "No pueden haber mas miembros en ese equipo, elige otro.");
	                ShowPlayerDialog(playerid, CHANGETEAM, DIALOG_STYLE_TABLIST_HEADERS, "Cambiar tu equipo", EQUIPOS,"Cambiar","Cancelar");
	                return 1;
	            }

	            gTeam[playerid] = teamID;
	            SpawnPlayer(playerid);
	        }
	        case 4: // eTeam ID 53 (privado)
	        {
	            new teamID = 53;

	            if(Invitado[playerid] != teamID &&
	               Owner[playerid] != teamID &&
	               Autorizado[playerid] != teamID)
	            {
	                SendClientMessage(playerid, ROJO, "Este team es privado, pidele invitacion al dueno.");
	                ShowPlayerDialog(playerid, CHANGETEAM, DIALOG_STYLE_TABLIST_HEADERS, "Cambiar tu equipo", EQUIPOS,"Cambiar","Cancelar");
	                return 1;
	            }

	            if(CountTeamPlayers(teamID) >= 5)
	            {
	                SendClientMessage(playerid, -1, "No pueden haber mas miembros en ese equipo, elige otro.");
	                ShowPlayerDialog(playerid, CHANGETEAM, DIALOG_STYLE_TABLIST_HEADERS, "Cambiar tu equipo", EQUIPOS,"Cambiar","Cancelar");
	                return 1;
	            }

	            gTeam[playerid] = teamID;
	            SpawnPlayer(playerid);
	        }
	    }
	    return 1;
	}

	if(dialogid == TEAM)
	{
		if(!response) return Kick(playerid);
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(CountTeamPlayers(OldsGang)==5)
					{
						SendClientMessage(playerid, -1, "No pueden haber más miembros en ese equipo, elige otro");
						ShowPlayerDialog(playerid, TEAM, DIALOG_STYLE_TABLIST_HEADERS, "Elige tu equipo", EQUIPOS, "Elegir","");
						return 1;
					}
					gTeam[playerid] = OldsGang;
					SetSpawnInfo(playerid, OldsGang, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
					TogglePlayerSpectating(playerid, false);
				}
				case 1:
    {
					if(CountTeamPlayers(TheWins)==5)
					{
						SendClientMessage(playerid, -1, "No pueden haber más miembros en ese equipo, elige otro");
						ShowPlayerDialog(playerid, TEAM, DIALOG_STYLE_TABLIST_HEADERS, "Elige tu equipo", EQUIPOS, "Elegir","");
						return 1;
					}
					gTeam[playerid] = TheWins;
					SetSpawnInfo(playerid, TheWins, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
					TogglePlayerSpectating(playerid, false);
				}
				case 2:
				{
					if(CountTeamPlayers(TheLegends)==5)
					{
						SendClientMessage(playerid, -1, "No pueden haber más miembros en ese equipo, elige otro");
						ShowPlayerDialog(playerid, TEAM, DIALOG_STYLE_TABLIST_HEADERS, "Elige tu equipo", EQUIPOS, "Elegir","");
						return 1;
					}
					gTeam[playerid] = TheLegends;
					SetSpawnInfo(playerid, TheWins, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
					TogglePlayerSpectating(playerid, false);
				}
				case 3:
				{
					if(Invitado[playerid] != 1)
					{
						SendClientMessage(playerid, ROJO, "Este team es privado, pidele invitación al dueño.");
						ShowPlayerDialog(playerid, TEAM, DIALOG_STYLE_TABLIST_HEADERS, "Elige tu equipo", EQUIPOS, "Elegir", "");
					}
					else
					{
						gTeam[playerid] = EnVenta;
						SetSpawnInfo(playerid, EnVenta, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
						TogglePlayerSpectating(playerid, false);
					}
				}
                case 4:
				{
					if(Invitado[playerid] != 1)
					{
						SendClientMessage(playerid, ROJO, "Este team es privado, pidele invitación al dueño.");
						ShowPlayerDialog(playerid, TEAM, DIALOG_STYLE_TABLIST_HEADERS, "Elige tu equipo", EQUIPOS, "Elegir", "");
					}
					else
					{
						gTeam[playerid] = eTeam;
						SetSpawnInfo(playerid, eTeam, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
						TogglePlayerSpectating(playerid, false);
					}
				}
			}
		}
	}
	if(dialogid == MUSICA2)
	{
		if(response)
		{
			for(new i=0; i <GetMaxPlayers(); i++)
			{
				if(IsPlayerConnected(i))
				{
					if(Escuchando[i] == true) StopAudioStreamForPlayer(i);
					if(strlen(inputtext)>0)
					{
						SendFormattedMessage(i,-1,"Se escuchará la canción {38CC45}%s{ffffff} en unos segundos.",inputtext);
					}
					PlayAudioStreamForPlayer(i, Musica[playerid]);
					Escuchando[i] = true;
				}
			}
		}
	}
	if(dialogid == MUSICA)
	{
		if(!response) return 1;
		if(response)
		{
			ShowPlayerDialog(playerid, MUSICA2, DIALOG_STYLE_INPUT, "Nombre de la canción", "{FFFFFF}Escribe el nombre de la cancion\nSi no dejarlo vacio.", "Repro", "Cancelar");
			format(Musica[playerid], 90, "%s", inputtext);
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	new str[37],cadena[300],vip[3];
	format(str, sizeof(str), "Estadisticas de %s", Nombre(clickedplayerid));
	if(Info[clickedplayerid][VIP] > 0) { vip = "Si"; } else { vip = "No"; }
	new wanted = GetPlayerWantedLevel(clickedplayerid),dinero = Info[clickedplayerid][Dinero];
	format(cadena, sizeof(cadena), "{FFFFFF}» {cc33ff}Score: {ffffff}%d\n» {cc33ff}Dinero: {00A000}$%d\n{ffffff}» {cc33ff}Muertes: {ffffff}%d\n» {cc33ff}Coins: {ffffff}%d\n» {cc33ff}Vip: {ffffff}%s\n» {cc33ff}Búsqueda: {ffffff}%d\n» {cc33ff}Duelos Ganados: {ffffff}%d\n» {cc33ff}Duelos perdidos: {ffffff}%d\n",Info[clickedplayerid][Score],dinero,Info[clickedplayerid][Muertes],Info[clickedplayerid][Coins],vip,wanted,Info[clickedplayerid][DuelosGanados],Info[clickedplayerid][DuelosPerdidos]);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, str, cadena, "Cerrar", "");
	return 1;
}

//=====(STOCKS)=======
stock Config()
{
	if(!dini_Exists(AkaCuentas)) dini_Create(AkaCuentas);
	return 1;
}

funcion CancelarDuelo(playerid)
{
	if(GetPVarInt(playerid, "Enviado")==1 && IsPlayerConnected(playerid))
	{
		for(new i=1; i<=ARENAS; i++)
		{
			if(Duelos[i][DesaId] == playerid)
			{
				new frm[128];
				format(frm, 128, "El duelo entre tu y %s se auto canceló por no ser aceptado durante 30s",Nombre(Duelos[i][DesafiadoId]));
				SendClientMessage(playerid, -1, frm);
				format(frm, 128, "El duelo entre tu y %s se auto canceló por no ser aceptado durante 30s",Nombre(Duelos[i][DesaId]));
				SendClientMessage(Duelos[i][DesafiadoId], -1, frm);
				SetPVarInt(Duelos[i][DesafiadoId], "Invitado", INVALID_PLAYER_ID);
				SetPVarInt(Duelos[i][DesaId], "Invitado", INVALID_PLAYER_ID);
				Duelos[i][DesafiadoId] = -1;
				Duelos[i][DesaId] = -1;
				Duelos[i][ArmasId] = -1;
				Duelos[i][Libre] = 0;
				SetPVarInt(playerid, "Enviado", 0);
				KillTimer(timerduelo[playerid]);
				break;
			}
		}
	}
}

funcion AntiSpam2(playerid,text[])
{
	if(strfind(text, "exs", true) != -1 || strfind(text, ":7777", true) != -1 || strfind(text, "extreme shots", true) != -1 || strfind(text, "mega tdm", true) != -1 || strfind(text, "fc", true) != -1 || strfind(text, "exs-tdm.com", true) != -1 || strfind(text, "foro.exs-tdm.com", true) != -1)
	{
		SPAMADV[playerid]++;
		new str[128];
		format(str, 128, "Evita el spam haz dicho '"DARK"%s{ffffff}' tienes {ff0000}%d {ffffff}advertencia",text,SPAMADV[playerid]);
		SendClientMessage(playerid, -1, str);
		Spam(playerid);
		return 1;
	}
	return 0;
}

stock Spam(playerid)
{
	for(new i=0; i <GetMaxPlayers(); i++)
	{
		if(Info[playerid][AdminNivel] > 1)
		{
			if(IsPlayerConnected(i))
			{
				new streng[128];
				format(streng, sizeof(streng), "{FF0000}[ADV]: {FFFFFF}%s Está haciendo {FF0000}Spam",Nombre(playerid));
				SendClientMessage(i, -1, streng);
			}
		}
	}
	if(SPAMADV[playerid] == MAX_SPAM)
	{
		new streng[128];
		format(streng, sizeof(streng), "{ff0000}%s {ffffff}Ha sido pateado por maximo de {ff0000}%d {ffffff}advertencias de {ff0000}spam",Nombre(playerid),MAX_SPAM);
		SendClientMessageToAll(-1, streng);
		SetTimerEx("Kickear", 300, false, "d", playerid);
	}
	return 1;
}

funcion Fly(playerid)
{
	if(!IsPlayerConnected(playerid))
	return 1;
	new k, ud,lr;
	GetPlayerKeys(playerid,k,ud,lr);
	new Float:v_x,Float:v_y,Float:v_z,
	Float:x,Float:y,Float:z;
	if(ud < 0)      // forward
	{
	GetPlayerCameraFrontVector(playerid,x,y,z);
	v_x = x+0.1;
	v_y = y+0.1;
	}
	if(k & 128)     // down
	v_z = -0.2;
	else if(k & KEY_FIRE)   // up
	v_z = 0.2;
	if(k & KEY_WALK)        // slow
	{
	v_x /=5.0;
	v_y /=5.0;
	v_z /=5.0;
	}
	if(k & KEY_SPRINT)      // fast
	{
	v_x *=4.0;
	v_y *=4.0;
	v_z *=4.0;
	}
	if(v_z == 0.0)
	v_z = 0.025;
	SetPlayerVelocity(playerid,v_x,v_y,v_z);
	if(v_x == 0 && v_y == 0)
	{
	if(GetPlayerAnimationIndex(playerid) == 959)
	ApplyAnimation(playerid,"PARACHUTE","PARA_steerR",6.1,1,1,1,1,0,1);
	}
	else
	{
	GetPlayerCameraFrontVector(playerid,v_x,v_y,v_z);
	GetPlayerCameraPos(playerid,x,y,z);
	SetPlayerLookAt(playerid,v_x*500.0+x,v_y*500.0+y);
	if(GetPlayerAnimationIndex(playerid) != 959)
	ApplyAnimation(playerid,"PARACHUTE","FALL_SkyDive_Accel",6.1,1,1,1,1,0,1);
	}
	if(OnFly[playerid])
	SetTimerEx("Fly",100,false,"i",playerid);
	return 1;
}

funcion InitFly(playerid)
{
	OnFly[playerid] = false;
	return;
}

static SetPlayerLookAt(playerid,Float:x,Float:y)
{
	new Float:Px, Float:Py, Float: Pa;
	GetPlayerPos(playerid, Px, Py, Pa);
	Pa = floatabs(atan((y-Py)/(x-Px)));
	if (x <= Px && y >= Py) Pa = floatsub(180.0, Pa);
	else if (x < Px && y < Py) Pa = floatadd(Pa, 180.0);
	else if (x >= Px && y <= Py) Pa = floatsub(360.0, Pa);
	Pa = floatsub(Pa, 90.0);
	if (Pa >= 360.0) Pa = floatsub(Pa, 360.0);
	SetPlayerFacingAngle(playerid, Pa);
	return;
}

CargarHora(playerid)
{
	new hora,minutos;
	gettime(hora, minutos);
	SetPlayerTime(playerid, hora, minutos);
	return 1;
}

funcion mapa2(playerid)
{
	GameTextForPlayer(playerid, "~y~~h~Cargando..", 2000, 3);
	timermapa[playerid][2] = SetTimerEx("mapa3", 400, false, "d", playerid);
}

funcion mapa3(playerid)
{
	GameTextForPlayer(playerid, "~y~~h~Cargando...", 2000, 3);
	timermapa[playerid][0] = SetTimerEx("mapa1", 400, false, "d", playerid);
}

funcion mapa1(playerid)
{
	GameTextForPlayer(playerid, "~y~~h~Cargando.", 2000, 3);
	timermapa[playerid][1] = SetTimerEx("mapa2", 400, false, "d", playerid);
}

funcion CargarMapa(playerid)
{
	if(PrimeraSalida[playerid] == 1) return 1;
	PrimeraSalida[playerid] = 1;
	new cargando[20] = "~y~~h~Cargando.";
	TogglePlayerControllable(playerid,0);
	GameTextForPlayer(playerid, cargando, 2000, 3);
	SetTimerEx("mapa2", 500, false, "d", playerid);
	SetTimerEx("CargarMapa2",2500,0,"i", playerid);
	return 1;
}

funcion CargarMapa2(playerid)
{
	GameTextForPlayer(playerid, " ", 1, 3);
	KillTimer(timermapa[playerid][0]);
	KillTimer(timermapa[playerid][1]);
	KillTimer(timermapa[playerid][2]);
	TogglePlayerControllable(playerid, 1);
	return 1;
}

stock GetWeaponNameEx(weaponid)
{
	new wname[32];
	switch (weaponid)
	{
		case 0: wname = "Vacío";
		case 1: wname = "Manopla";
		case 2: wname = "Palo de golf";
		case 3: wname = "Palo de policia";
		case 4: wname = "Cuchillo";
		case 5: wname = "Bate de beisbol";
		case 6: wname = "Pala";
		case 7: wname = "Palo de billar";
		case 8: wname = "Katana";
		case 9: wname = "Motosierra";
		case 10: wname = "Consolador rosa";
		case 11: wname = "Vibrador blanco";
		case 12: wname = "Gran vibrador blanco";
		case 13: wname = "Vibrador plateado";
		case 14: wname = "Ramo de flores";
		case 15: wname = "Baston";
		case 16: wname = "Granada";
		case 17: wname = "Gas Lacrimógeno";
		case 18: wname = "Molotov";
		case 22: wname = "9mm";
		case 23: wname = "9mm con silenciador";
		case 24: wname = "Desert Eagle";
		case 25: wname = "Escopeta";
		case 26: wname = "Sawn Off";
		case 27: wname = "Escopeta de combate";
		case 28: wname = "UZI";
		case 29: wname = "MP5";
		case 30: wname = "AK-47";
		case 31: wname = "M4";
		case 32: wname = "TEC-9";
		case 33: wname = "Rifle";
		case 34: wname = "Sniper";
		case 35: wname = "Lanzacohetes";
		case 36: wname = "Bazooka";
		case 37: wname = "Lanzallamas";
		case 38: wname = "Minigun";
		case 39: wname = "Bomba";
		case 40: wname = "Detonador";
		case 41: wname = "Spray";
		case 42: wname = "Extintor De Incendios";
		case 43: wname = "Camara";
		case 44: wname = "Lentes de visión nocturna";
		case 45: wname = "Gafas termicas";
		case 46: wname = "Paracaídas";
		case 1000: wname="Cerveza x6 unidades";
		case 1001: wname="Vino x6 unidades";
		case 1002: wname="Sprunk x4 unidades";
		case 1429: wname="Tv Antigua";
		case 1518: wname="Tv Moderna";
		case 2912: wname="Caja de Madera";
		case 2190: wname="Computadora";
		case 1788: wname="Videocasetera";
		case 1790: wname="Bluray";
		case 2028: wname="Consola de juegos";
		case 2226: wname="Radio";
		case 1650: wname="Bidón de gasolina";
		case 9003: wname="Balde con agua";
		case 10000: wname="Caja de aquarius de 12 unidades";
	  	case 10001: wname="Caja de vino de 12 unidades";
	  	case 10002: wname="Caja de cerveza de 12 unidades";
 		case 10003: wname="Caja de sprunk de 12 unidades";
		case 10004: wname="Pizza completa";
		case 2702: wname="Pizza";
		case 11392: wname="Vacío";
		case 18897: wname="Bandana azul";
		case 18898: wname="Bandana verde";
		case 18899: wname="Bandana Rosa";
		case 18913: wname="Cubre boca verde";
		case 18917: wname="Cubre boca azul";
		case 18918: wname="Cubre boca negro";
		case 18939: wname="Gorra azul";
		case 18942: wname="Gorra ploma";
		case 18943: wname="Gorra verde";
		case 18961: wname="Gorra camionero";
		case 18962: wname="Sombrero negro";
		case 18964: wname="Chullo negro";
		case 19033: wname="Gafas negras";
		case 18971: wname="Sombrero blanco";
		case 18972: wname="Sombrero naranja";
		case 18974: wname="Antifaz";
		case 18976: wname="Casco azul";
		case 18979: wname="Casco morado";
		case 18978: wname="Casco blanco";
		case 18640: wname="Pelon";
		case 18645: wname="Casco abierto";
		case 18893: wname="Gorra pirata blanca";
		case 18895: wname="Gorra pirata negra";
		case 18915: wname="Cubre boca morado";
		case 18920: wname="Cubre boca amarillo";
		case 18949: wname="Sombrero verde";
		case 19022: wname="Lentes negros";
		case 19023: wname="Lentes azules";
		case 19025: wname="Lentes morado";
		case 19029: wname="Lentes verdes";
		case 19064: wname="Gorra de papa noel";
		case 19069: wname="Gorra negra";
		case 19078: wname="Loro";
		case 19136: wname="Sombrero y pelo";
		case 19352: wname="Sombrero elegante";
		case 19472: wname="Mascara de gas";
		case 19801: wname="Mascara";
		case 18963: wname="CJ";
		case 19528: wname="Sombrero de mago";
	}
	return wname;
}

funcion UltimaVez(playerid)
{
	new uhora[15],PMAM[15],uano[15];
	switch(Info[playerid][Mes])
	{
		case 1: uano = "Enero";
		case 2: uano = "Febrero";
		case 3: uano = "Marzo";
		case 4: uano = "Abril";
		case 5: uano = "Mayo";
		case 6: uano = "Junio";
		case 7: uano = "Julio";
		case 8: uano = "Agosto";
		case 9: uano = "Septiembre";
		case 10: uano = "Octubre";
		case 11: uano = "Noviembre";
		case 12: uano = "Diciembre";
	}
	switch(Info[playerid][Hora])
	{
		case 0: uhora = "12";
		case 1: uhora = "1";
		case 2: uhora = "2";
		case 3: uhora = "3";
		case 4: uhora = "4";
		case 5: uhora = "5";
		case 6: uhora = "6";
		case 7: uhora = "7";
		case 8: uhora = "8";
		case 9: uhora = "9";
		case 10: uhora = "10";
		case 11: uhora = "11";
		case 12: uhora = "12";
		case 13: uhora = "1";
		case 14: uhora = "2";
		case 15: uhora = "3";
		case 16: uhora = "4";
		case 17: uhora = "5";
		case 18: uhora = "6";
		case 19: uhora = "7";
		case 20: uhora = "8";
		case 21: uhora = "9";
		case 22: uhora = "10";
		case 23: uhora = "11";
		case 24: uhora = "12";
	}
	switch(Info[playerid][Hora])
	{
		case 0: PMAM = "AM";
		case 1: PMAM = "AM";
		case 2: PMAM = "AM";
		case 3: PMAM = "AM";
		case 4: PMAM = "AM";
		case 5: PMAM = "AM";
		case 6: PMAM = "AM";
		case 7: PMAM = "AM";
		case 8: PMAM = "AM";
		case 9: PMAM = "AM";
		case 10: PMAM = "AM";
		case 11: PMAM = "AM";
		case 12: PMAM = "PM";
		case 13: PMAM = "PM";
		case 14: PMAM = "PM";
		case 15: PMAM = "PM";
		case 16: PMAM = "PM";
		case 17: PMAM = "PM";
		case 18: PMAM = "PM";
		case 19: PMAM = "PM";
		case 20: PMAM = "PM";
		case 21: PMAM = "PM";
		case 22: PMAM = "PM";
		case 23: PMAM = "PM";
		case 24: PMAM = "AM";
	}
	new string[128];
	format(string, sizeof(string), "Tu ultima vez en el servidor fue el %d de %s del %d a la %s:%d %s",Info[playerid][Dia],uano,Info[playerid][Ano],uhora,Info[playerid][Minutos],PMAM);
	SendClientMessage(playerid, -1, string);
	return 1;
}

stock IsValidName(string[])
{
	for(new i = 0, j = strlen(string); i < j; i++)
	{
		switch(string[i])
		{
			case '0' .. '9': continue;
			case 'a' .. 'z': continue;
			case 'A' .. 'Z': continue;
			case '_': continue;
			case '$': continue;
			case '.': continue;
			case '=': continue;
			case '(': continue;
			case ')': continue;
			case '#': continue;
			case '@': continue;
			default: return 0;
		}
	}
	return 1;
}

stock IsValidWeapon(weaponid)
{
	if (weaponid > 0 && weaponid < 19 || weaponid > 21 && weaponid < 47) return 1;
	return 0;
}

stock IsCbugWeapon(playerid)
{
	new weaponID = GetPlayerWeapon(playerid);
	if(weaponID == 22 || weaponID == 24 || weaponID == 25 || weaponID == 27) return 1;
	return 0;
}

LimpiarJugadores(playerid)
{
	EnEvento[playerid] = 0;
	Level[playerid] = 0;
	Kills[playerid] = 0;
	OCoins[playerid] = 0;
	InShop[playerid]=0;
	ODinero[playerid] = 0;
	Info[playerid][pCar] = -1;
	Ofrecedor[playerid] = INVALID_PLAYER_ID;
	OnDuty[playerid] = 0;
	Info[playerid][Muteado] = 0;
	PrimeraSalida[playerid] = 0;
	SetPVarInt(playerid, "horatmp", -1);
	timerduelo[playerid] = 0;
	format(Info[playerid][SanRazon], 18, " ");
	SpecteandoA[playerid] = INVALID_PLAYER_ID;
	ViendoDuelo[playerid] = false;
	TimerSancion[playerid] = 0;
	SetPVarInt(playerid, "Apuesta", 0);
	SetPVarInt(playerid, "Enviado", 0);
	SetPVarInt(playerid, "Invitado",INVALID_PLAYER_ID);
	for(new i, j=MAX_OBJECTS; i<j; i++) { RemovePlayerAttachedObject(playerid, i); oInfo[playerid][i][used1] = false; oInfo[playerid][i][usando] = 0; }
	InitFly(playerid);
	Sancion[playerid] = 0;
	Info[playerid][SancionTime] = 0;
	Info[playerid][SancionTimeS] = 0;
	Info[playerid][Dinero] = 0;
	EscopetaON[playerid] = 0;
	EDCON[playerid] = 0;
	RIFLEON[playerid] = 0;
	SNIPERON[playerid] = 0;
	M4ON[playerid] = 0;
	MP5ON[playerid] = 0;
	Info[playerid][ADV] = 0;
	Invitacion[playerid] = 0;
	Owner[playerid] = 0;
	Invitado[playerid] = 0;
	EnDuelo[playerid] = 0;
	Autorizado[playerid] = 0;
	God[playerid] = 0;
	Info[playerid][DuelosGanados] = 0;
	Info[playerid][DuelosPerdidos] = 0;
	Info[playerid][Coins] = 0;
	Info[playerid][VIP_EXPIRE] = 0;
	Info[playerid][VIP] = 0;
	Info[playerid][ComproChaleco] = 0;
	Info[playerid][ComproMP5] = 0;
	Info[playerid][ComproM4] = 0;
	Info[playerid][ComproEscopeta] = 0;
	Info[playerid][ComproSniper] = 0;
	Info[playerid][ComproEDC] = 0;
	Info[playerid][ComproRifle] = 0;
	Info[playerid][Hide] = 0;
	Info[playerid][Skin] = 0;
	Info[playerid][AdminNivel] = 0;
	Info[playerid][Score] = 0;
	Info[playerid][Muertes] = 0;
	Info[playerid][Logged] = 0;
	return 1;
}

forward SetDuel(id1,id2,armas,arena);
public SetDuel(id1,id2,armas,arena)
{
	ClearAnimations(id1);
	ClearAnimations(id2);
	ResetPlayerWeapons(id1);
	ResetPlayerWeapons(id2);
	SetPlayerHealth(id1,100);
	SetPlayerHealth(id2,100);
	SetPlayerArmour(id1,100);
	SetPlayerArmour(id2,100);
	TogglePlayerControllable(id2,0);
	TogglePlayerControllable(id1,0);
	SetCameraBehindPlayer(id1);
	SetCameraBehindPlayer(id2);
	switch (arena)
	{
	  case 1: {
	  SetPlayerPos(id1,-1938.2274,957.2699,54.3729);
	  SetPlayerFacingAngle(id1, 359.735321);
	  SetPlayerInterior(id1, 0);
	  SetPlayerPos(id2,-1937.8655,981.0634,54.4375);
	  SetPlayerInterior(id2, 0);
	  SetPlayerFacingAngle(id2, 181.133682);
	  SetPlayerVirtualWorld(id1, 1);
	  SetPlayerVirtualWorld(id2, 1);
	}
	  case 2: {
	  SetPlayerPos(id1,285.3347,-13.3583,1001.5156);
	  SetPlayerPos(id2,298.7975,-13.2693,1001.5156);
	  SetPlayerInterior(id1, 1);
	  SetPlayerInterior(id2, 1);
	  SetPlayerVirtualWorld(id1, 1);
	  SetPlayerVirtualWorld(id2, 1);
	}
	  case 3: {
	  SetPlayerPos(id1,1410.6985,-22.9052,1000.9234);
	  SetPlayerInterior(id1, 1);
	  SetPlayerFacingAngle(id1, 89.3009);
	  SetPlayerPos(id2,1378.2769,-22.3161,1000.9258);
	  SetPlayerInterior(id2, 1);
	  SetPlayerFacingAngle(id2, 270.0725);
	  SetPlayerVirtualWorld(id1, 1);
	  SetPlayerVirtualWorld(id2, 1);
	}
	  case 4: {
		SetPlayerPos(id1,-1017.9586,-654.4362,32.0078);
		SetPlayerInterior(id1, 0);
		SetPlayerFacingAngle(id1, 359.0717);
		SetPlayerPos(id2, -1019.3083,-629.5671,32.0078);
		SetPlayerInterior(id2, 0);
		SetPlayerFacingAngle(id2, 173.9116);
		SetPlayerVirtualWorld(id1, 1);
		SetPlayerVirtualWorld(id2, 1);
	  }
	  case 5: {
		SetPlayerPos(id1, 1331.4880,2181.8652,11.0234);
		SetPlayerFacingAngle(id1, 182.109985);
		SetPlayerInterior(id1, 0);
		SetPlayerPos(id2, 1331.7467,2145.9272,11.0156);
		SetPlayerFacingAngle(id2, 6.328308);
		SetPlayerInterior(id2, 0);
		SetPlayerVirtualWorld(id1, 1);
		SetPlayerVirtualWorld(id2, 1);
	}
	case 6:{
		SetPlayerPos(id1, -2049.7791,-164.5495,35.3203);
		SetPlayerPos(id2, -2049.8645,-182.0845,35.3274);
		SetPlayerFacingAngle(id1, 177.2900);
		SetPlayerFacingAngle(id2, 357.6385);
		SetPlayerInterior(id1, 0);
		SetPlayerInterior(id2, 0);
		SetPlayerVirtualWorld(id1, 1);
		SetPlayerVirtualWorld(id2, 1);
	}
	case 7:
	{
		SetPlayerPos(id1, 8.0754,1529.7025,12.7500);
		SetPlayerFacingAngle(id1, 179.4647);
		SetPlayerInterior(id1, 0);
		SetPlayerPos(id2, 8.0116,1504.2655,12.7560);
		SetPlayerFacingAngle(id2, 350.8189);
		SetPlayerInterior(id2, 0);
		SetPlayerVirtualWorld(id1, 1);
		SetPlayerVirtualWorld(id2, 1);
	}
	case 8:
	{
		SetPlayerPos(id1, 2355.7268,2284.7751,27.5420);
		SetPlayerFacingAngle(id1, 274.8011);
		SetPlayerInterior(id1, 0);
		SetPlayerPos(id2, 2394.6292,2285.7441,27.5420);
		SetPlayerFacingAngle(id2, 93.6927);
		SetPlayerInterior(id2, 0);
		SetPlayerVirtualWorld(id1, 1);
		SetPlayerVirtualWorld(id2, 1);
	}
	case 9:
	{
		SetPlayerPos(id1, 2813.6411,2474.2856,17.6719);
		SetPlayerFacingAngle(id1, 315.7784);
		SetPlayerInterior(id1, 0);
		SetPlayerPos(id2, 2825.6643,2487.3535,17.6719);
		SetPlayerFacingAngle(id2, 138.2851);
		SetPlayerInterior(id2, 0);
		SetPlayerVirtualWorld(id1, 1);
		SetPlayerVirtualWorld(id2, 1);
	}
	}
	switch (armas)
	{
		case 1: {GivePlayerWeapon(id1,24,99999); GivePlayerWeapon(id2,24,99999); SetTimerEx("ComenzarDuelo",1500,false,"ii",id1,id2);}
		case 2: {GivePlayerWeapon(id1,27,99999); GivePlayerWeapon(id2,27,99999); SetTimerEx("ComenzarDuelo",1500,false,"ii",id1,id2);}
		case 3: {GivePlayerWeapon(id1,25,99999); GivePlayerWeapon(id2,25,99999); SetTimerEx("ComenzarDuelo",1500,false,"ii",id1,id2);}
		case 4: {GivePlayerWeapon(id1,29,99999); GivePlayerWeapon(id2,29,99999); SetTimerEx("ComenzarDuelo",1500,false,"ii",id1,id2);}
		case 5: {GivePlayerWeapon(id1,31,99999); GivePlayerWeapon(id2,31,99999); SetTimerEx("ComenzarDuelo",1500,false,"ii",id1,id2);}
		case 6: {GivePlayerWeapon(id1,33,99999); GivePlayerWeapon(id2,33,99999); SetTimerEx("ComenzarDuelo",1500,false,"ii",id1,id2);}
		case 7: {GivePlayerWeapon(id1,34,99999); GivePlayerWeapon(id2,34,99999); SetTimerEx("ComenzarDuelo",1500,false,"ii",id1,id2);}
	}
}

forward ComenzarDuelo(id1,id2);
public ComenzarDuelo(id1,id2)
{
	TogglePlayerControllable(id2,1);
	TogglePlayerControllable(id1,1);
	GameTextForPlayer(id1, "Go!", 3000, 3);
	GameTextForPlayer(id2, "Go!", 3000, 3);
}

//Some file functions
stock fcreate(file[]) {
	if (fexist(file)) return false;
	new File:f=fopen(file,io_write);
	if (f) {
		fclose(f);
		return true;
	}
	return false;
}

stock flineexist(file[],line[]) {
	if(strlen(line)==0 || strlen(line)+2>255) return false;
	new File:f=fopen(file,io_read);
	if(!f) return false;
	new tmp[255];
	while(fread(f,tmp))
	{
		if(tmp[strlen(line)]=='=' && !strcmp(tmp, line, true, strlen(line)))
		{
			fclose(f);
			return true;
		}
	}
	fclose(f);
	return false;
}

stock fstr(file[],line[]) {
	new tmp[255];
	if(strlen(line)==0 || strlen(line)+2>255) return tmp;
	new File:f=fopen(file,io_read);
	if(!f) return tmp;
	while(fread(f,tmp))
	{
		if(tmp[strlen(line)]=='=' && !strcmp(tmp, line, true, strlen(line)))
		{
			DINI_StripNewLine(tmp);
			strmid(tmp, tmp, strlen(line) + 1, strlen(tmp), 255);
			fclose(f);
			return tmp;
		}
	}
	fclose(f);
	return tmp;
}

stock GetNumberOfPlayersOnThisIP(test_ip[])
{
	new against_ip[32+1];
	new x = 0;
	new ip_count = 0;
	for(x=0; x<MAX_PLAYERS; x++) {
		if(IsPlayerConnected(x)) {
			GetPlayerIp(x,against_ip,32);
			if(!strcmp(against_ip,test_ip)) ip_count++;
		}
	}
	return ip_count;
}

funcion ConnectedPlayers()
{
	new Connected;
	foreach(Player,i) Connected++;
	return Connected;
}

stock DetectarSpam(SPAM[])
{
	new SSPAM;
	new CUENTAP,CUENTAN,CUENTADP,CUENTAGB;
	for(SSPAM = 0; SSPAM < strlen(SPAM); SSPAM ++)
	{
		if(SPAM[SSPAM] == '.') CUENTAP ++;
		if(SPAM[SSPAM] == '0' || SPAM[SSPAM] == '1' || SPAM[SSPAM] == '2' || SPAM[SSPAM] == '3' || SPAM[SSPAM] == '4' || SPAM[SSPAM] == '5' || SPAM[SSPAM] == '6' || SPAM[SSPAM] == '7' || SPAM[SSPAM] == '8' || SPAM[SSPAM] == '9') CUENTAN ++; //Cuenta los Numeros
		if(SPAM[SSPAM] == ':') CUENTADP ++;
		if(SPAM[SSPAM] == '_') CUENTAGB ++;
	}
	if(CUENTAP >= 2 && CUENTAN >= 5) return 1;
	if(CUENTAGB >= 2 && CUENTAN >= 5) return 1;
	if(CUENTADP >= 1 && CUENTAN >= 4) return 1;
	if(CUENTAN >= 5) return 1;
	if(strfind(SPAM, ".com", true) != -1 || strfind(SPAM, ".com.ar", true) != -1 || strfind(SPAM, "www.", true) != -1 || strfind(SPAM, ".org", true) != -1 || strfind(SPAM, ".net", true) != -1 || strfind(SPAM, ".es", true) != -1 || strfind(SPAM, ".tk", true) != -1) return 1;
	return 0;
}

stock UpdateConfig()
{
	if(!dini_Exists("Server/config/aka.txt")) {dini_Create("Server/config/aka.txt");}
	return 1;
}

stock fstrset(file[],line[],value[]) {
	if(strlen(line)==0 || strlen(line)+strlen(value)+2>255) return false;
	new File:f, File:f2;
	new tmp[255];
	new bool:wasset=false;
	format(tmp,sizeof(tmp),"%s.part",file);
	fremove(tmp);
	f=fopen(file,io_read);
	if(!f) return false;
	f2=fopen(tmp,io_write);
	if(!f2)
	{
		fclose(f);
		return false;
	}
	while(fread(f,tmp))
	{
		if(!wasset && tmp[strlen(line)]=='=' && !strcmp(tmp, line, true, strlen(line)))
		{
			format(tmp,sizeof(tmp),"%s=%s",line,value);
			wasset=true;
		}
		else
		{
			DINI_StripNewLine(tmp);
		}
		fwrite(f2,tmp);
		fwrite(f2,"\r\n");
	}
	if(!wasset)
	{
		format(tmp,sizeof(tmp),"%s=%s",line,value);
		fwrite(f2,tmp);
		fwrite(f2,"\r\n");
	}
	fclose(f);
	fclose(f2);
	format(tmp,sizeof(tmp),"%s.part",file);
	if(DINI_fcopytextfile(tmp,file)) return fremove(tmp);
	return false;
}

stock ReloadConfig()
{
	format(Prefix, 30, "%s",fstr(MSG_FILE, "Prefijo"));
	Cooldown = strval(fstr(MSG_FILE, "Cooldown"));
}

stock GetMessagesCount()
{
	new count, msg[20];
	for(new i, j=MAX_MSG; i<j; i++)
	{
		format(msg, sizeof(msg), "Mensaje%d", i+1);
		if(!flineexist(MSG_FILE, msg)) break;
		count++;
	}
	return count;
}

stock IsPlayerFlooding(playerid)
{
	if(GetTickCount() - iPlayerChatTime[playerid] < 3000) return 1;
	return 0;
}

stock IsPlayerFlooding2(playerid)
{
	if(GetTickCount() - iPlayerChatTime[playerid] < 180000) return 1;
	return 0;
}

stock IpToCountry_db(IpInfo[])
{
	new DB:database,DBResult:result,query[256];
	database = db_open(DATABASENAME);
	if(database)
	{
		if(strcmp("127.0.0.1", IpInfo, true) == 0)
		{
			query = "Localhost";
		} else {
			new
				IPsplit[4][10];
			if(sscanf(IpInfo, "p<.>s[10]s[10]s[10]s[10]", IPsplit[0], IPsplit[1], IPsplit[2], IPsplit[3])) { query = "Invalid IP"; }
			else {
				format(query, sizeof query, "\
				SELECT `Country`\
				FROM `countrydetected`\
				WHERE `Ip_From` <= ((16777216*%d) + (65536*%d) + (256*%d) + %d)\
				AND `Ip_to` >= ((16777216*%d) + (65536*%d) + (256*%d) + %d) LIMIT 1",
				strval(IPsplit[0]), strval(IPsplit[1]), strval(IPsplit[2]), strval(IPsplit[3]),
				strval(IPsplit[0]), strval(IPsplit[1]), strval(IPsplit[2]), strval(IPsplit[3]));

				result = db_query(database, query);
				if(!db_get_field_assoc(result, "Country", query, sizeof query))
				{
					query = "Desconocido";
				}
				db_free_result(result);
			}
		}
		db_close(database);
	} else query = "Failed. Not Open "DATABASENAME"";
	return query;
}

ReturnIP(playerid)
{
	new PlayerIP[17];
	GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
	return PlayerIP;
}

stock QuitarCombate(playerid)
{
	GangZoneHideForPlayer(playerid, GangZone);
	GangZoneStopFlashForPlayer(playerid, GangZone);
	EnCombate[playerid] = 0;
	TiempoCombate[playerid] = 0;
	KillTimer(TimerCombate[playerid]);
	return 1;
}

forward TextoCombate(playerid);
public TextoCombate(playerid)
{
	if(EnCombate[playerid] == 1)
	{
		if(TiempoCombate[playerid] > 0)
		{
			if(CColocado[playerid] == 0)
			{
				GangZoneShowForPlayer(playerid, GangZone, -1879048029);
				GangZoneFlashForPlayer(playerid, GangZone, -1879048029);
				TiempoCombate[playerid]--;
				CColocado[playerid] = 1;
			}
			else
			{
				GangZoneHideForPlayer(playerid, GangZone);
				GangZoneStopFlashForPlayer(playerid, GangZone);
				TiempoCombate[playerid]--;
				CColocado[playerid] = 0;
			}
		}
		else if(TiempoCombate[playerid] <= 0)
		{
			GangZoneHideForPlayer(playerid, GangZone);
			GangZoneStopFlashForPlayer(playerid, GangZone);
			TiempoCombate[playerid] = 0;
			CColocado[playerid] = 0;
			EnCombate[playerid] = 0;
			KillTimer(TimerCombate[playerid]);
		}
	}
	else if(EnCombate[playerid] == 0)
	{
		GangZoneHideForPlayer(playerid, GangZone);
		GangZoneStopFlashForPlayer(playerid, GangZone);
		TiempoCombate[playerid] = 0;
		CColocado[playerid] = 0;
		EnCombate[playerid] = 0;
		KillTimer(TimerCombate[playerid]);
	}
}

 stock ColocarCombate(playerid)
{
	if(EnDuelo[playerid] == 1) return 1;
	if(EnCombate[playerid] == 0)
	{
		TimerCombate[playerid] = SetTimerEx("TextoCombate",800,true,"d",playerid);
		EnCombate[playerid] = 1;
		TiempoCombate[playerid] = 30;
	}
	else if(EnCombate[playerid] == 1)
	{
		TiempoCombate[playerid] = 30;
	}
	return 1;
}

stock MensajeParaAdmins(color,string[])
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i))
		{
			if (Info[i][AdminNivel] >= 1) SendClientMessage(i, color, string);
		}
	}
	return 1;
}

stock GivePlayerScore(playerid,amount)
{
	SetPlayerScore(playerid,GetPlayerScore(playerid)+amount);
	return 1;
}

funcion GuardarArchivo(filename[],text[])
{
	new File:LAdminfile,string2[128], filepath[256], year,month,day, hour,minute,second;
	getdate(year,month,day); gettime(hour,minute,second);
	format(filepath,sizeof(filepath),"Server/logs/%s.txt",filename);
	LAdminfile = fopen(filepath,io_append);
	format(string2,sizeof(string2),"[%d.%d.%d %d:%d:%d] %s\r\n",day,month,year,hour,minute,second,text);
	fwrite(LAdminfile,string2);
	fclose(LAdminfile);
	return 1;
}

stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

stock Nombre(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name, MAX_PLAYER_NAME);
	return name;
}

stock Registrar(playerid,inputtext[])
{
	new clave[200],stringg[128],d,m,a;
	getdate(a, m, d);
	mysql_format(con, clave, sizeof(clave), "INSERT INTO `usuarios` (`Nombre`,`lastOn`,`Contra`,`Dinero`,`Coins`,`IP`) VALUES ('%s','%d/%d/%d','%s','0','0','%s')",Nombre(playerid),d,m,a,inputtext,ReturnIP(playerid));
	mysql_query(con, clave);
	mysql_format(con, clave, 128, "INSERT INTO `armas` (`Nombre`) VALUES ('%s') ",Nombre(playerid));
	mysql_query(con, clave);
	format(stringg,sizeof(stringg),"(((%s [%d] Se ha Registrado.)))",Nombre(playerid),playerid);
	MensajeParaAdmins(0xAFAFAFAA,stringg);
	Info[playerid][Logged] = 1;
}

funcion OnWeaponLoad(playerid)
{
	new rows = cache_num_rows();
	if(rows >0)
	{
		cache_get_value_name_int(0, "ESCOPETA", EscopetaON[playerid]);
		cache_get_value_name_int(0, "EDC", EDCON[playerid]);
		cache_get_value_name_int(0, "MP5", MP5ON[playerid]);
		cache_get_value_name_int(0, "M4", M4ON[playerid]);
		cache_get_value_name_int(0, "RIFLE", RIFLEON[playerid]);
		cache_get_value_name_int(0, "SNIPER", SNIPERON[playerid]);
	}
}

stock Ingresar(playerid)
{
	new query[128];
	mysql_format(con, query, sizeof(query), "SELECT * FROM `usuarios` WHERE `Nombre` = '%e'",Nombre(playerid));
	mysql_pquery(con, query, "OnPlayerLoad", "d",playerid);
	mysql_format(con, query, sizeof(query), "SELECT * FROM `armas` WHERE `Nombre` = '%e'",Nombre(playerid));
	mysql_pquery(con, query, "OnWeaponLoad", "d",playerid);
	mysql_format(con, query, sizeof(query), "SELECT * FROM `toys` WHERE `Nombre` = '%e'",Nombre(playerid));
	mysql_pquery(con, query, "OnObjectLoad", "d", playerid);
}

stock ResetPlayerVariables(playerid)
{
    // ** GENERAL
    pCBugging[playerid] = false;
    // ** TIMERS
    KillTimer(ptmCBugFreezeOver[playerid]);
    // ** TIMESTAMPS
    ptsLastFiredWeapon[playerid] = 0;
    return 1;
}

// ** FUNCTIONS
forward CBugFreezeOver(playerid);
public CBugFreezeOver(playerid)
{
    TogglePlayerControllable(playerid, true);
    pCBugging[playerid] = false;
    return 1;
}

stock CountTeamPlayers(team)
{
    new count;
    foreach(Player,i)
    {
        if(gTeam[i] == team)//if team id matches
        {
            count++;//add one to the count
        }
    }
    return count;
}

funcion TimerDuelo(playerid)
{
	SpawnPlayer(playerid);
}

Sancionar(playerid,reason[],min)
{
	new mensaje[300];
	format(mensaje, sizeof(mensaje), "{FF0000}%s {FFFFFF}Fue sancionado, Razón: {FF0000}%s",Nombre(playerid),reason);
	SendClientMessageToAll(-1, mensaje);
	format(mensaje, sizeof(mensaje), "Fuiste sancionado por %d minutos",min);
	SendClientMessage(playerid, -1, mensaje);
	SetPlayerPos(playerid, 222.7200,110.5350,999.0156);
	SetPlayerInterior(playerid, 10);
	ResetPlayerWeapons(playerid);
	SetPlayerVirtualWorld(playerid, 1+playerid);
	format(Info[playerid][SanRazon], 18, "%s", reason);
	Info[playerid][SancionTime] = min*60*1000;
	Info[playerid][SancionTimeS] = min*60;
	mysql_format(con, mensaje, 300, "UPDATE `usuarios` SET `Sancionado` = '1', `SancionTime` = '%d', `SanRazon` = '%s' WHERE `Nombre` = '%s'",Info[playerid][SancionTime],reason,Nombre(playerid));
	mysql_query(con, mensaje);
	TimerSancion2[playerid] = SetTimerEx("BajarTiempos", 1000, 1, "d", playerid);
	TimerSancion[playerid] = SetTimerEx("LibreSan", Info[playerid][SancionTime], false, "d", playerid);
	Sancion[playerid] = 1;
	return 1;
}

//stock usados
stock NombrePJ(playerid)
{
    new nombre[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nombre, sizeof(nombre));
    return nombre;
}

stock GetPlayerID(pName[])//Sacar la ID del jugador por nombre
{
    new playerid = INVALID_PLAYER_ID;
    sscanf(pName,"u",playerid);
    return playerid;
}

stock ClearReportes(){
    for(new i = 0; i < MAX_REPORTES; i++){//Realizamos un buscador con el for
        if(Reportes[i][Activo] == true){//Detectamos al administrador en servicio
            Reportes[i][Activo] = false;
        }
    }
    return 1;
}

stock Escritura(string[],string2[]){
    strmid(string,string2,0,strlen(string2),strlen(string2)+1);
    return 1;
}

stock GenerarReporte(reportante, reportado, reporte_txt[]){
    new cont = 0;//Creamos el new para iniciar una verificacion de envio de reporte
    for(new i = 0; i < MAX_REPORTES; i++){//Realizamos un buscador con el for
        if(Reportes[i][Activo] == false){//Detectamos al administrador en servicio
            Reportes[i][Activo] = true;//Decimos que está activo esta ID del reporte
            Escritura(Reportes[i][TextReporte], reporte_txt);//Escribimos dentro de la variable el reporte
            /*
                ¿Por que escribimos los nombres y no tomamos solo las id?
                -Es para detectar si el jugador continua conectado, así no confunden las id de algún usuario inocente.
            */
            Escritura(Reportes[i][Reportante], NombrePJ(reportante));//Escribimos el nombre del usuario que reporta
            Escritura(Reportes[i][Reportado], NombrePJ(reportado));//Escribimos el nombre del usuario reportado
            cont++;//Realizamos un conteo o cambio de variable a cont = 1; para verificar que se ejecuto el reporte.
            break;//Matamos el bucle para que no continue buscando
        }
    }
    if(!cont) SendClientMessage(reportante, -1, "No se puede generar un reporte ahora mismo, intente más tarde.");//Enviamos cuando no exista espacio libre en variables de reportes
    else SendClientMessage(reportante, -1, "Reporte fue enviado a la administración, espere que lo atiendan muchas gracias.");//Enviamos cuando se envie el reporte correctamente.
    return 1;
}

funcion Banear(playerid)
{
	return Ban(playerid);
}

funcion BanearEx(playerid,reason[])
{
	return BanEx(playerid,reason);
}

funcion Kickear(playerid)
{
	return Kick(playerid);
}

stock GetWeaponModel(weaponid)
{
	switch(weaponid)
	{
		case 1: return 331;
		case 2..8: return weaponid+331;
		case 9: return 341;
		case 10..15: return weaponid+311;
		case 16..18: return weaponid+326;
		case 22..29: return weaponid+324;
		case 30,31: return weaponid+325;
		case 32: return 372;
		case 33..45: return weaponid+324;
		case 46: return 371;
	}
	return 0;
}

stock IsVehicleOccupied(vehicleid)
{
    for (new i = 0; i < GetMaxPlayers(); i ++)
    {
        if (GetPlayerVehicleID(i) == vehicleid) return true;
    }
    return false;
}

funcion ToysNameChange(playerid,name[])
{
	new rows = cache_num_rows(),query[240];
	if(rows > 0)
	{
		mysql_format(con, query, sizeof(query), "UPDATE `toys` SET `Nombre` = '%s' WHERE `Nombre` = '%s'",name,Nombre(playerid));
		mysql_query(con, query);
	}
	mysql_format(con, query, sizeof(query), "UPDATE `usuarios` SET `Nombre` = '%s' WHERE `Nombre` = '%s'",name,Nombre(playerid));
	mysql_query(con, query);
	SetPlayerName(playerid, name);
}

stock ComprobarNivel(playerid)
{
	switch(Info[playerid][Score])
	{
		case 200:{ Info[playerid][ScoreNivel]++;}
	}
	return 1;
}

stock CreateVehicleForTeam(teamid, vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay)
{
    if(teamid == NO_TEAM) return false; // if the vehicle teamid is NO_TEAM(255), then this function won't work
    for(new slot; slot < MAX_VEHICLES; slot++)
    {
        if(team_vehicle[slot][v_exist] == false)//checks if the vehicle is not created, then only proceed or else catch another loop case!
        {
            //creat the main vehicle and store its id
            team_vehicle[slot][v_id] = AddStaticVehicle(vehicletype, x, y, z, rotation, color1, color2);
            team_vehicle[team_vehicle[slot][v_id]][v_team] = teamid;//storing the teamid
            team_vehicle[team_vehicle[slot][v_id]][v_exist] = true;//setting created value "yes", so this says that the vehicle is created!
            return team_vehicle[slot][v_id];//returns the vehicle id
        }
    }
    return true;
}

stock DestoryVehicleForTeam(vehicleid)
{
    DestroyVehicle(vehicleid);//destorying the vehicle
    team_vehicle[vehicleid][v_team] = NO_TEAM;//set for NO_TEAM
    team_vehicle[vehicleid][v_exist] = false;//the vehicle don't exist
    return true;
}

stock SendPlayerNotification(playerid,text_[])
{
    if (NotificationSlot[playerid][0] == 0)
    {
        PlayerTextDrawSetString(playerid,NOTIFICATION_MESSAGE[playerid][2], text_);
        PlayerTextDrawShow(playerid,NOTIFICATION_MESSAGE[playerid][2]);
        NotificationSlot[playerid][0] = 1;
        NotificationTime[playerid][0] = SetTimerEx("hideNotificationInSlot1", 7000, 0,"d",playerid);
    }
    else if (NotificationSlot[playerid][1] == 0)
    {
        PlayerTextDrawSetString(playerid,NOTIFICATION_MESSAGE[playerid][1], text_);
        PlayerTextDrawShow(playerid,NOTIFICATION_MESSAGE[playerid][1]);
        NotificationSlot[playerid][1] = 1;
        NotificationTime[playerid][1] = SetTimerEx("hideNotificationInSlot2", 7000, 0,"d",playerid);
    }
    else if (NotificationSlot[playerid][2] == 0)
    {
        PlayerTextDrawSetString(playerid,NOTIFICATION_MESSAGE[playerid][0], text_);
        PlayerTextDrawShow(playerid,NOTIFICATION_MESSAGE[playerid][0]);
        NotificationSlot[playerid][2] = 1;
        NotificationTime[playerid][2] = SetTimerEx("hideNotificationInSlot3", 7000, 0,"d",playerid);
        return 1;
    }
    if(NotificationSlot[playerid][0] == 1 && NotificationSlot[playerid][1] == 1 && NotificationSlot[playerid][2] == 1)
    {
        PlayerTextDrawSetString(playerid,NOTIFICATION_MESSAGE[playerid][3], text_);
        PlayerTextDrawShow(playerid,NOTIFICATION_MESSAGE[playerid][3]);
        NotificationTime[playerid][2] = SetTimerEx("hideNotificationInSlot4", 7000, 0,"d",playerid);
    }
    return 1;
}

forward hideNotificationInSlot1(playerid);
public hideNotificationInSlot1(playerid)
{
    PlayerTextDrawHide(playerid,NOTIFICATION_MESSAGE[playerid][2]);
    NotificationSlot[playerid][0] = 0;
    return 1;
}

forward hideNotificationInSlot2(playerid);
public hideNotificationInSlot2(playerid)
{
    PlayerTextDrawHide(playerid,NOTIFICATION_MESSAGE[playerid][1]);
    NotificationSlot[playerid][1] = 0;
    return 1;
}

forward hideNotificationInSlot3(playerid);
public hideNotificationInSlot3(playerid)
{
    PlayerTextDrawHide(playerid,NOTIFICATION_MESSAGE[playerid][0]);
    NotificationSlot[playerid][2] = 0;
    return 1;
}

forward hideNotificationInSlot4(playerid);
public hideNotificationInSlot4(playerid)
{
    PlayerTextDrawHide(playerid,NOTIFICATION_MESSAGE[playerid][3]);
    NotificationSlot[playerid][2] = 0;
    return 1;
}

stock Rango(playerid)
{
	new AdmRank[25];
	switch(Info[playerid][AdminNivel])
	{
		case 1: AdmRank = "Youtuber";
		case 2: AdmRank = "Ayudante";
		case 3: AdmRank = "Moderador";
		case 4: AdmRank = "Moderador Global";
		case 5: AdmRank = "Moderador Técnico";
		case 6: AdmRank = "Administrador";
		case 7: AdmRank = "Fundador";
	}
	return AdmRank;
}

IsPlayerBaned(playerid)
{
	new query[250];
	mysql_format(con, query, sizeof query, "SELECT * FROM `ipsban` WHERE `IP` = '%s'",ReturnIP(playerid));
	mysql_pquery(con, query, "BanCheck", "d",playerid);
}

funcion BanCheck(playerid)
{
	new rows = cache_num_rows(),Dias,msg[128],DIALOG[676],Horas,minn,UNIX,eazon[30],fecha[10],banby[MAX_PLAYER_NAME],IP[18];
	if(rows)
	{
		cache_get_value_name_int(0, "UNIX",UNIX);
		cache_get_value_name_int(0, "Dias",Dias);
		cache_get_value_name_int(0, "Horas",Horas);
		cache_get_value_name_int(0, "Minutos",minn);
		cache_get_value_name(0, "Razon", eazon, 30);
		cache_get_value_name(0, "bandate", fecha, 10);
		cache_get_value_name(0, "banby", banby, 24);
		cache_get_value_name(0, "IP", IP, 18);
		if(UNIX > gettime())
		{
			if(Dias>0) format(msg, 128, "Su dirección IP se encuentra baneada por %d días, razón: %s", Dias,eazon);
			if(Horas>0) format(msg, 128, "Su dirección IP se encuentra baneada por %d horas, razón: %s", Horas,eazon);
			if(minn>0)format(msg, 128, "Su dirección IP se encuentra baneada por %d minutos, razón: %s", minn,eazon);
			SendClientMessage(playerid, -1, msg);
			strcat(DIALOG, "{FFFFFF}Tu cuenta esta baneada de este servidor,\n\n");
			format(msg, sizeof(msg), "{FFFFFF}Usuario: {FF0000}%s\n", Nombre(playerid));
			strcat(DIALOG, msg);
			format(msg, sizeof(msg), "{FFFFFF}IP: {FF0000}%s\n", IP);
			strcat(DIALOG, msg);
			format(msg, sizeof(msg), "{FFFFFF}Baneado por: {FF0000}%s\n", banby);
			strcat(DIALOG, msg);
			format(msg, sizeof(msg), "{FFFFFF}Razón: {FF0000}%s\n", eazon);
			strcat(DIALOG, msg);
			format(msg, sizeof(msg), "{FFFFFF}Ban fecha: {FF0000}%s\n", fecha);
			strcat(DIALOG, msg);
			format(msg, sizeof(msg), "{FFFFFF}Tiempo restante: {FF0000}%s\n\n", ConvertirSeg(UNIX-gettime()));
			strcat(DIALOG, msg);
			strcat(DIALOG, "{FFFFFF}Si cree que fue prohibido de manera ilegal, presente una apelación en el grupo.\n");
			strcat(DIALOG, "Asegúrate de guardar una foto presionando F8.");
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Noticia", DIALOG, "OK", "");
			SetTimerEx("Kickear", 200, false, "d", playerid);
		}
		else
		{
			if(Dias==1) format(msg, sizeof(msg), "Ya han pasado %d dias, tu dirección IP Fue desbaneada correctamente.", Dias);
			else if(Dias>1) format(msg, sizeof(msg), "Ya ha pasado %d dia, tu dirección IP Fue desbaneada correctamente.", Dias);
			if(Horas==1) format(msg, sizeof(msg), "Ya ha pasado %d hora, tu dirección IP Fue desbaneada correctamente.", Horas);
			else if(Horas>1) format(msg, sizeof(msg), "Ya han pasado %d horas, tu dirección IP Fue desbaneada correctamente.", Horas);
			if(minn>0) format(msg, sizeof(msg), "Ya han pasado %d minutos, tu dirección IP Fue desbaneada correctamente.", minn);
			SendClientMessage(playerid, -1, msg);
			new query[250];
			mysql_format(con, query, sizeof query, "DELETE FROM `ipsban` WHERE `IP` = '%s'",ReturnIP(playerid));
			mysql_query(con, query);
		}
	}
}

ConvertirSeg(time) {
    new minutes;
    new seconds;
    new string[128];
    if(time > 59){
        minutes = floatround(time/60);
        seconds = floatround(time - minutes*60);
        if(seconds>9)format(string,sizeof(string),"%d:%d",minutes,seconds);
        else format(string,sizeof(string),"%d:0%d",minutes,seconds);
    }
    else{
        seconds = floatround(time);
        if(seconds>9)format(string,sizeof(string),"0:%d",seconds);
        else format(string,sizeof(string),"0:0%d",seconds);
    }
    return string;
}

funcion BajarTiempos(playerid)
{
	if(Info[playerid][SancionTimeS] > 0) { Info[playerid][SancionTimeS]--;}
}

stock VerTiempos(playerid,id)
{
	if(Info[id][SancionTimeS] > 0)
	{
		new string[128];
		if(Info[id][SancionTimeS] < 60) format(string, sizeof(string), "Tiempo restante: {00CC00}%ds", Info[id][SancionTimeS]);
		else if(Info[id][SancionTimeS] >= 60) format(string, sizeof(string), "Tiempo restante: {00CC00}%dm %ds", Info[id][SancionTimeS]/60, Info[id][SancionTimeS]%(60));
		SendClientMessage(playerid,-1,string);
	}
	//else return SCM(playerid,-1,"No estas en prisión/sala de sanción");
	return 1;
}

stock GetMonth(month)
{
	new mtext[20];
	switch(month)
	{
	    case 1: mtext = "Enero";
	    case 2: mtext = "Febrero";
	    case 3: mtext = "Marzo";
	    case 4: mtext = "Abril";
	    case 5: mtext = "Mayo";
	    case 6: mtext = "Junio";
	    case 7: mtext = "Julio";
	    case 8: mtext = "Agosto";
	    case 9: mtext = "Septiembre";
	    case 10: mtext = "Octubre";
	    case 11: mtext = "Noviembre";
	    case 12: mtext = "Diciembre";
	}
	return mtext;
}

funcion tirar_armas(playerid)
{
	new gunID = GetPlayerWeapon(playerid);
	if(gunID == 24) return 1;
	if(gunID != 0)
	{
		new f = MAX_ARMAS+1;
		for(new a = 0; a < sizeof(ObjCoords); a++)
		{
			if(ObjCoords[a][0] == 0.0)
			{
				f = a;
				break;
			}
		}
  		ObjectID[f][0] = gunID;
 		GetPlayerPos(playerid, ObjCoords[f][0], ObjCoords[f][1], ObjCoords[f][2]);
 		Object[f] = CreateObject(GunObjects[gunID][0],ObjCoords[f][0],ObjCoords[f][1],ObjCoords[f][2]-1,93.7,120.0,120.0);
 		removePlayerWeapon(playerid,gunID);
 		Objetop[playerid] = Object[f];
 		objcoordtimer[playerid][actv] = f;
 		SetTimerEx("desaparecer", 5000, false, "d", playerid);
	}
	return 1;
}

stock removePlayerWeapon(playerid, weaponid) return SetPlayerAmmo(playerid, weaponid, 0);

funcion desaparecer(playerid)
{
	for(new a = 0; a < sizeof(ObjCoords); a++)
	{
		if(a==objcoordtimer[playerid][actv])
		{
			ObjCoords[a][0] = 0.0;
			ObjCoords[a][1] = 0.0;
			ObjCoords[a][2] = 0.0;
			break;
		}
	}
	objcoordtimer[playerid][actv] = 0;
	DestroyObject(Objetop[playerid]);
}
CargarSpawn(playerid)
{
	switch(gTeam[playerid])
	{
		case OldsGang:
		{
			new skinsstar = random(7);
			switch(skinsstar)
			{
				case 0: SetPlayerSkin(playerid, 8);
				case 1: SetPlayerSkin(playerid, 6);
				case 2: SetPlayerSkin(playerid, 3);
				case 3: SetPlayerSkin(playerid, 2);
				case 4: SetPlayerSkin(playerid, 29);
				case 5: SetPlayerSkin(playerid, 24);
				case 6: SetPlayerSkin(playerid, 25);
			}
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerColor(playerid, 0x007CFFFF);
			SetPlayerPos(playerid, 501.980987,-69.150199,998.757812);
			SetPlayerInterior(playerid, 11);
		}
		case TheWins:
		{
			new skinsTheWins = random(6);
			switch(skinsTheWins)
			{
				case 0: SetPlayerSkin(playerid, 14);
				case 1: SetPlayerSkin(playerid, 15);
				case 2: SetPlayerSkin(playerid, 19);
				case 3: SetPlayerSkin(playerid, 20);
				case 4: SetPlayerSkin(playerid, 21);
				case 5: SetPlayerSkin(playerid, 22);
			}
			SetPlayerVirtualWorld(playerid, 2);
			SetPlayerColor(playerid, 0xFF7B00FF);
			SetPlayerPos(playerid, 457.304748,-88.428497,999.554687);
			SetPlayerInterior(playerid, 4);
		}
        case TheLegends:
		{
			new skinsTheWins = random(6);
			switch(skinsTheWins)
			{
				case 0: SetPlayerSkin(playerid, 14);
				case 1: SetPlayerSkin(playerid, 15);
				case 2: SetPlayerSkin(playerid, 19);
				case 3: SetPlayerSkin(playerid, 20);
				case 4: SetPlayerSkin(playerid, 21);
				case 5: SetPlayerSkin(playerid, 22);
			}
			SetPlayerVirtualWorld(playerid, 2);
			SetPlayerColor(playerid, ROJO);
			SetPlayerPos(playerid, 457.304748,-88.428497,999.554687);
			SetPlayerInterior(playerid, 4);
		}
  		case EnVenta:
		{
			new skinsvagancia = random(10);
			switch(skinsvagancia)
			{
				case 0: SetPlayerSkin(playerid, 230);
				case 1: SetPlayerSkin(playerid, 212);
				case 2: SetPlayerSkin(playerid, 160);
				case 3: SetPlayerSkin(playerid, 134);
				case 4: SetPlayerSkin(playerid, 137);
				case 5: SetPlayerSkin(playerid, 162);
				case 6: SetPlayerSkin(playerid, 200);
				case 7: SetPlayerSkin(playerid, 209);
				case 8: SetPlayerSkin(playerid, 239);
				case 9: SetPlayerSkin(playerid, 32);
			}
			SetPlayerVirtualWorld(playerid, 3);
			SetPlayerPos(playerid,2324.419921,-1145.568359,1050.710083);
			SetPlayerInterior(playerid,12);
			SetPlayerColor(playerid, 0xff00ffFF);
		}
        case eTeam:
		{
			new skinsvagancia = random(10);
			switch(skinsvagancia)
			{
				case 0: SetPlayerSkin(playerid, 230);
				case 1: SetPlayerSkin(playerid, 212);
				case 2: SetPlayerSkin(playerid, 160);
				case 3: SetPlayerSkin(playerid, 134);
				case 4: SetPlayerSkin(playerid, 137);
				case 5: SetPlayerSkin(playerid, 162);
				case 6: SetPlayerSkin(playerid, 200);
				case 7: SetPlayerSkin(playerid, 209);
				case 8: SetPlayerSkin(playerid, 239);
				case 9: SetPlayerSkin(playerid, 32);
			}
			SetPlayerVirtualWorld(playerid, 3);
			SetPlayerPos(playerid,2324.419921,-1145.568359,1050.710083);
			SetPlayerInterior(playerid,12);
			SetPlayerColor(playerid, MORADO);
		}
	}
}

stock GetTeamZoneName(teamid)
{
	new str[40];
	switch(teamid)
	{
		case EnVenta: str ="{FF0000}DarkShots ADM{FFFFFF}";
		case TheWins: str = "{FF7B00}66'The Wins{ffffff}";
		case TheLegends: str = "{F00707}The Legends{ffffff}";
		case OldsGang: str = "{007CFF}Old's Gang{ffffff}";
		case eTeam: str = "{6527F5}Demen$ia{ffffff}";
	}
	return str;
}

stock GetTeamZoneColor(teamid)
{
    switch(teamid)
    {
        case OldsGang: return 0x003FFFFF;
        case TheWins: return 0xFF7D00FF;
    }
    return -1;
}

stock SendFormatMessage(const iPlayer, const iColor, const szFormat[], { Float, _ }: ...)
{
    new iArgs = (numargs() - 3) << 2;
    if(iArgs)
    {
        static s_szBuf[144], s_iAddr1, s_iAddr2;
        #emit ADDR.PRI szFormat
        #emit STOR.PRI s_iAddr1
        for(s_iAddr2 = s_iAddr1 + iArgs, iArgs += 12; s_iAddr2 != s_iAddr1; s_iAddr2 -= 4)
        {
            #emit LOAD.PRI s_iAddr2
            #emit LOAD.I
            #emit PUSH.PRI
        }
        #emit CONST.PRI s_szBuf
        #emit PUSH.S szFormat
        #emit PUSH.C 144
        #emit PUSH.PRI
        #emit PUSH.S iArgs
        #emit SYSREQ.C format
        #emit LCTRL 4
        #emit LOAD.S.ALT iArgs
        #emit ADD.C 4
        #emit ADD
        #emit SCTRL 4
        return (iPlayer != -1) ? SendClientMessage(iPlayer, iColor, s_szBuf) : SendClientMessageToAll(iColor, s_szBuf);
    }
    return (iPlayer != -1) ? SendClientMessage(iPlayer, iColor, szFormat) : SendClientMessageToAll(iColor, szFormat);
}

/*
stock IsPlayerInZone(playerid, zoneid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    return (x > ZoneInfo[zoneid][zMinX] && x < ZoneInfo[zoneid][zMaxX] && y > ZoneInfo[zoneid][zMinY] && y < ZoneInfo[zoneid][zMaxY]);
}

stock GetPlayersInZone(zoneid, teamid)
{
    new count;
    foreach(Player,i)
    {
        if(GetPlayerTeam(i) == teamid && IsPlayerInZone(i, zoneid))
        {
            count++;
        }
    }
    return count;
}

funcion ZoneTimer()
{
    for(new i=0; i < sizeof(ZoneInfo); i++) // loop all zones
    {
        if(ZoneAttacker[i] != -1) // zone is being attacked
        {
            if(GetPlayersInZone(i, ZoneAttacker[i]) >= MIN_MEMBERS_TO_START_WAR) // team has enough members in the zone
            {
                ZoneAttackTime[i]++;
                foreach(Player,j)
                {
                	if(GetPlayerZone(j)==i && gTeam[j] == ZoneAttacker[i])
                	{
                		PlayerTextDrawShow(j, zonas[j]);
                		ShowProgressBarForPlayer(j, barz[i]);
                		SetProgressBarValue(barz[i],ZoneAttackTime[i]);
						UpdateProgressBar(barz[i],j);
                	}
                }
                if(ZoneAttackTime[i] == TAKEOVER_TIME) // zone has been under attack for enough time and attackers take over the zone
                {
                    GangZoneStopFlashForAll(ZoneID[i]);
                    GangZoneShowForAll(ZoneID[i], GetTeamZoneColor(ZoneAttacker[i])); // update the zone color for new team
                    new stre[128];
	                foreach(Player,j)
	                {
	                	if(GetPlayerZone(j)==i && gTeam[j] == ZoneAttacker[i])
	                	{
	                    SetProgressBarValue(barz[i],0);
	                    UpdateProgressBar(barz[i],j);
	                    HideProgressBarForPlayer(j,barz[i]);
	                    format(stre, 128, "La Zona %s fue Conquistada por %s",GetTeamZoneName(ZoneInfo[i][zTeam]),GetTeamZoneName(gTeam[j]));
	                    GivePlayerMoney(j, 5000);
	                    Info[j][Dinero]+=5000;
	                    PlayerTextDrawHide(j, zonas[j]);
	                	}
	                }
	                SendClientMessageToAll(-1, stre);
	                ZoneInfo[i][zTeam] = ZoneAttacker[i];
                	ZoneAttacker[i] = -1;
                }
            }
            else // attackers failed to take over the zone
            {
            	foreach(Player,j)
	            {
	               if(gTeam[j] == ZoneAttacker[i])
	               {
			        	PlayerTextDrawHide(j, zonas[j]);
			        	SetProgressBarValue(barz[i],0);
			            UpdateProgressBar(barz[i],j);
			            HideProgressBarForPlayer(j,barz[i]);
			            GangZoneStopFlashForAll(ZoneID[i]);
			            ZoneAttacker[i] = -1;
			        }
			    }
            }
        }
        else // check if somebody is attacking
        {
            for(new t=0; t < sizeof(Teams); t++)
            {
                if(Teams[t] != ZoneInfo[i][zTeam] && GetPlayersInZone(i, Teams[t]) >= MIN_MEMBERS_TO_START_WAR) // if there are enough enemies in the zone
                {
                    ZoneAttacker[i] = Teams[t];
                    ZoneAttackTime[i] = 0;
                    GangZoneFlashForAll(ZoneID[i], GetTeamZoneColor(ZoneAttacker[i]));
                }
            }
        }
    }
}

stock GetPlayerZone(playerid)
{
    for(new i=0; i < sizeof(ZoneInfo); i++)
    {
        if(IsPlayerInZone(playerid, i))
        {
            return i;
        }
    }
    return -1;
}
*/

PlayerTextDraws(playerid)
{
	/*
	zonas[playerid] = CreatePlayerTextDraw(playerid, 227.999923, 341.973571, "Conquistando la zona...");
	PlayerTextDrawLetterSize(playerid, zonas[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, zonas[playerid], 1);
	PlayerTextDrawColor(playerid, zonas[playerid], -1);
	PlayerTextDrawSetShadow(playerid, zonas[playerid], 0);
	PlayerTextDrawSetOutline(playerid, zonas[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, zonas[playerid], 51);
	PlayerTextDrawFont(playerid, zonas[playerid], 1);
	PlayerTextDrawSetProportional(playerid, zonas[playerid], 1);
	*/

	NOTIFICATION_MESSAGE[playerid][0] = CreatePlayerTextDraw(playerid,15.000000, 295.000000, "_");
    PlayerTextDrawBackgroundColor(playerid,NOTIFICATION_MESSAGE[playerid][0], 0x00000088);
    PlayerTextDrawFont(playerid,NOTIFICATION_MESSAGE[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid,NOTIFICATION_MESSAGE[playerid][0], 0.268999, 1.419165);
    PlayerTextDrawColor(playerid,NOTIFICATION_MESSAGE[playerid][0], -1);
    PlayerTextDrawSetOutline(playerid,NOTIFICATION_MESSAGE[playerid][0], 0);
    PlayerTextDrawSetProportional(playerid,NOTIFICATION_MESSAGE[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid,NOTIFICATION_MESSAGE[playerid][0], 0);
    PlayerTextDrawUseBox(playerid,NOTIFICATION_MESSAGE[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid,NOTIFICATION_MESSAGE[playerid][0], 0x00000088);
    PlayerTextDrawTextSize(playerid,NOTIFICATION_MESSAGE[playerid][0], 142.000000, 0.000000);
    PlayerTextDrawSetSelectable(playerid,NOTIFICATION_MESSAGE[playerid][0], 0);

    NOTIFICATION_MESSAGE[playerid][1] = CreatePlayerTextDraw(playerid,15.000000, 246.000000, "_");
    PlayerTextDrawBackgroundColor(playerid,NOTIFICATION_MESSAGE[playerid][1], 0x00000088);
    PlayerTextDrawFont(playerid,NOTIFICATION_MESSAGE[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid,NOTIFICATION_MESSAGE[playerid][1], 0.268999, 1.419165);
    PlayerTextDrawColor(playerid,NOTIFICATION_MESSAGE[playerid][1], -1);
    PlayerTextDrawSetOutline(playerid,NOTIFICATION_MESSAGE[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid,NOTIFICATION_MESSAGE[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid,NOTIFICATION_MESSAGE[playerid][1], 0);
    PlayerTextDrawUseBox(playerid,NOTIFICATION_MESSAGE[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid,NOTIFICATION_MESSAGE[playerid][1], 0x00000088);
    PlayerTextDrawTextSize(playerid,NOTIFICATION_MESSAGE[playerid][1], 142.000000, 0.000000);
    PlayerTextDrawSetSelectable(playerid,NOTIFICATION_MESSAGE[playerid][1], 0);

    NOTIFICATION_MESSAGE[playerid][2] = CreatePlayerTextDraw(playerid,15.000000, 197.000000, "_");
    PlayerTextDrawBackgroundColor(playerid,NOTIFICATION_MESSAGE[playerid][2], 0x00000088);
    PlayerTextDrawFont(playerid,NOTIFICATION_MESSAGE[playerid][2], 1);
    PlayerTextDrawLetterSize(playerid,NOTIFICATION_MESSAGE[playerid][2], 0.268999, 1.419165);
    PlayerTextDrawColor(playerid,NOTIFICATION_MESSAGE[playerid][2], -1);
    PlayerTextDrawSetOutline(playerid,NOTIFICATION_MESSAGE[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid,NOTIFICATION_MESSAGE[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid,NOTIFICATION_MESSAGE[playerid][2], 0);
    PlayerTextDrawUseBox(playerid,NOTIFICATION_MESSAGE[playerid][2], 1);
    PlayerTextDrawBoxColor(playerid,NOTIFICATION_MESSAGE[playerid][2], 0x00000088);
    PlayerTextDrawTextSize(playerid,NOTIFICATION_MESSAGE[playerid][2], 142.000000, 0.000000);
    PlayerTextDrawSetSelectable(playerid,NOTIFICATION_MESSAGE[playerid][2], 0);

    NOTIFICATION_MESSAGE[playerid][3] = CreatePlayerTextDraw(playerid, 320.000000, 370.833435, "_");
    PlayerTextDrawLetterSize(playerid, NOTIFICATION_MESSAGE[playerid][3], 0.236499, 1.057499);
    PlayerTextDrawAlignment(playerid, NOTIFICATION_MESSAGE[playerid][3], 2);
    PlayerTextDrawColor(playerid, NOTIFICATION_MESSAGE[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, NOTIFICATION_MESSAGE[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, NOTIFICATION_MESSAGE[playerid][3], 1);
    PlayerTextDrawBackgroundColor(playerid, NOTIFICATION_MESSAGE[playerid][3], 255);
    PlayerTextDrawFont(playerid, NOTIFICATION_MESSAGE[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, NOTIFICATION_MESSAGE[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, NOTIFICATION_MESSAGE[playerid][3], 0);

 	Textdraw0[playerid] = CreatePlayerTextDraw(playerid, 43.750000, 430.080413, "DarkShots - TDM");
	PlayerTextDrawLetterSize(playerid, Textdraw0[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Textdraw0[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw0[playerid], 0xFFFFFFFF); // blanco
	PlayerTextDrawSetShadow(playerid, Textdraw0[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw0[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw0[playerid], 255);
	PlayerTextDrawFont(playerid, Textdraw0[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw0[playerid], 1);

	Textdraw1[playerid] = CreatePlayerTextDraw(playerid, 173.000000, 431.000000, "]");
	PlayerTextDrawLetterSize(playerid, Textdraw1[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Textdraw1[playerid], -1);
	PlayerTextDrawColor(playerid, Textdraw1[playerid], 0xFF00FFFF); // ff00ff
	PlayerTextDrawSetShadow(playerid, Textdraw1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw1[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw1[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw1[playerid], 2);
	PlayerTextDrawSetProportional(playerid, Textdraw1[playerid], 1);

	Textdraw2[playerid] = CreatePlayerTextDraw(playerid, 28.125000, 430.826751, "]");
	PlayerTextDrawLetterSize(playerid, Textdraw2[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Textdraw2[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw2[playerid], 0xFF00FFFF); // ff00ff
	PlayerTextDrawSetShadow(playerid, Textdraw2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw2[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw2[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw2[playerid], 2);
	PlayerTextDrawSetProportional(playerid, Textdraw2[playerid], 1);

	Textdraw3[playerid] = CreatePlayerTextDraw(playerid, 43.750000, 430.080413, "DarkShots - TDM");
	PlayerTextDrawLetterSize(playerid, Textdraw3[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Textdraw3[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw3[playerid], 0xFFFFFFFF); // blanco
	PlayerTextDrawSetShadow(playerid, Textdraw3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw3[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw3[playerid], 144);
	PlayerTextDrawFont(playerid, Textdraw3[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw3[playerid], 1);

	/*
    LogoTD = TextDrawCreate(620.000000, 431.000000, "DarkShots - Servidor TDM");
	TextDrawBackgroundColor(LogoTD, 255);
	TextDrawLetterSize(LogoTD, 0.220000, 1.000000);
	TextDrawColor(LogoTD, 0xFFFFFFFF);
	TextDrawFont(LogoTD, 1);
	TextDrawSetProportional(LogoTD, 1);
	TextDrawSetOutline(LogoTD, 0);
	TextDrawAlignment(LogoTD, 3);
	TextDrawSetShadow(LogoTD, 1);
	TextDrawSetSelectable(LogoTD, 0);
	*/
}

stock ASCM(color, text[], aLevel = 2)
{
    foreach(Player,i)
    {
        if(Info[i][AdminNivel] >= aLevel)
        SendClientMessage(i, color, text);
    }
    return 1;
}

GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if(strfind(aVehicleNames[i], vname, true) != -1)
		return i + 400;
	}
	return -1;
}

Desban(name[])
{
	new IPE[18],result,Query[250],str[128];
	mysql_format(con, Query, 128, "SELECT `Nombre`,`IP`,`Baneado` FROM `usuarios` WHERE `Nombre` = '%s'",name);
	mysql_query(con, Query);
	if(cache_num_rows())
	{
		cache_get_value_name_int(0, "Baneado", result);
		if(result)
		{
			cache_get_value_name(0, "IP", IPE);
			format(str, sizeof(str), "unbanip %s", IPE);
			SendRconCommand(str);
			SendRconCommand("reloadbans");
			resultadob = 1;
			return 1;
		}
		else {resultadob = 0; return 0;}
	}
	else {resultadob=-1; return -1;}
}
