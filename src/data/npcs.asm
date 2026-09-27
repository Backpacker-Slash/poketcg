; When you press the A button in front of something it will find a data entry somewhere on this list
; it will then jump to the pointer in the data item. All jumps lead to an RST20 operation.
; The Deck IDs are used for the challenge hall
NPCHeaderPointers:
	table_width 2
	dw DrMasonNPCHeader
	dw DrMasonNPCHeader
	dw Ronald1NPCHeader
	dw IshiharaNPCHeader
	dw ImakuniNPCHeader
	dw DrMasonNPCHeader
	dw DrMasonNPCHeader
	dw SamNPCHeader
	dw Tech1NPCHeader
	dw Tech2NPCHeader
	dw Tech3NPCHeader
	dw Tech4NPCHeader
	dw Tech5NPCHeader
	dw Tech6NPCHeader
	dw Clerk1NPCHeader
	dw Clerk2NPCHeader
	dw Clerk3NPCHeader
	dw Clerk4NPCHeader
	dw Clerk5NPCHeader
	dw Clerk6NPCHeader
	dw Clerk7NPCHeader
	dw Clerk8NPCHeader
	dw Clerk9NPCHeader
	dw ChrisNPCHeader
	dw MichaelNPCHeader
	dw JessicaNPCHeader
	dw MitchNPCHeader
	dw MatthewNPCHeader
	dw RyanNPCHeader
	dw AndrewNPCHeader
	dw GeneNPCHeader
	dw SaraNPCHeader
	dw AmandaNPCHeader
	dw JoshuaNPCHeader
	dw AmyNPCHeader
	dw JenniferNPCHeader
	dw NicholasNPCHeader
	dw BrandonNPCHeader
	dw IsaacNPCHeader
	dw BrittanyNPCHeader
	dw KristinNPCHeader
	dw HeatherNPCHeader
	dw NikkiNPCHeader
	dw RobertNPCHeader
	dw DanielNPCHeader
	dw StephanieNPCHeader
	dw Murray1NPCHeader
	dw JosephNPCHeader
	dw DavidNPCHeader
	dw ErikNPCHeader
	dw RickNPCHeader
	dw JohnNPCHeader
	dw AdamNPCHeader
	dw JonathanNPCHeader
	dw KenNPCHeader
	dw CourtneyNPCHeader
	dw SteveNPCHeader
	dw JackNPCHeader
	dw RodNPCHeader
	dw Clerk10NPCHeader
	dw GiftCenterClerkNPCHeader
	dw Man1NPCHeader
	dw Woman1NPCHeader
	dw Chap1NPCHeader
	dw Gal1NPCHeader
	dw Lass1NPCHeader
	dw Chap2NPCHeader
	dw Lass2NPCHeader
	dw Pappy1NPCHeader
	dw Lad1NPCHeader
	dw Lad2NPCHeader
	dw Chap3NPCHeader
	dw Clerk12NPCHeader
	dw Clerk13NPCHeader
	dw HostNPCHeader
	dw Specs1NPCHeader
	dw ButchNPCHeader
	dw Granny1NPCHeader
	dw Lass3NPCHeader
	dw Man2NPCHeader
	dw Pappy2NPCHeader
	dw Lass4NPCHeader
	dw Hood1NPCHeader
	dw Granny2NPCHeader
	dw Gal2NPCHeader
	dw Lad3NPCHeader
	dw Gal3NPCHeader
	dw Chap4NPCHeader
	dw Man3NPCHeader
	dw Specs2NPCHeader
	dw Specs3NPCHeader
	dw Woman2NPCHeader
	dw ManiaNPCHeader
	dw Pappy3NPCHeader
	dw Gal4NPCHeader
	dw ChampNPCHeader
	dw Hood2NPCHeader
	dw Lass5NPCHeader
	dw Chap5NPCHeader
	dw AaronNPCHeader
	dw GuideNPCHeader
	dw Tech7NPCHeader
	dw Tech8NPCHeader
	; dw TorchNPCHeader
	; dw LegendaryCardTopLeftNPCHeader
	; dw LegendaryCardTopRightNPCHeader
	; dw LegendaryCardLeftSparkNPCHeader
	; dw LegendaryCardBottomLeftNPCHeader
	; dw LegendaryCardBottomRightNPCHeader
	; dw LegendaryCardRightSparkNPCHeader
	dw DummyNPCHeader
	dw DummyNPCHeader
	dw Murray2NPCHeader
	dw Ronald2NPCHeader
	dw Ronald3NPCHeader
	dw DummyNPCHeader
	assert_table_length NUM_NPCS

DrMasonNPCHeader:
	db NPC_DRMASON
	db $00;SPRITE_OW_DRMASON
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_WHITE_NPC_UP
	db $00
	dw $00;Script_DrMason
	tx DrMasonNPCName
	db $00
	db $00
	db $00
	db $00

Ronald1NPCHeader:
	db NPC_RONALD1
	db $00;SPRITE_OW_RONALD
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Ronald
	tx RonaldNPCName
	db RONALD_PIC
	db INVINCIBLE_RONALD_DECK_ID
	db MUSIC_RONALD
	db MUSIC_MATCH_START_2

Ronald2NPCHeader:
	db NPC_RONALD2
	db $00;SPRITE_OW_RONALD
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Ronald
	tx RonaldNPCName
	db RONALD_PIC
	db INVINCIBLE_RONALD_DECK_ID
	db MUSIC_RONALD
	db MUSIC_MATCH_START_2

Ronald3NPCHeader:
	db NPC_RONALD3
	db $00;SPRITE_OW_RONALD
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Ronald
	tx RonaldNPCName
	db RONALD_PIC
	db INVINCIBLE_RONALD_DECK_ID
	db MUSIC_RONALD
	db MUSIC_MATCH_START_2

IshiharaNPCHeader:
	db NPC_ISHIHARA
	db $00;SPRITE_OW_ISHIHARA
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_PURPLE_NPC_UP
	db $00
	dw $00;Script_Ishihara
	tx IshiharaNPCName
	db $00
	db $00
	db $00
	db $00

ImakuniNPCHeader:
	db NPC_IMAKUNI
	db $00;SPRITE_OW_IMAKUNI
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Imakuni
	tx ImakuniNPCName
	db IMAKUNI_PIC
	db IMAKUNI_DECK_ID
	db MUSIC_IMAKUNI
	db MUSIC_MATCH_START_1

SamNPCHeader:
	db NPC_SAM
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Sam
	tx SamNPCName
	db SAM_PIC
	db SAMS_NORMAL_DECK_ID
	db MUSIC_DUEL_THEME_1
	db MUSIC_MATCH_START_1

Tech1NPCHeader:
	db NPC_TECH1
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Tech1
	tx TechNPCName
	db $00
	db $00
	db $00
	db $00

Tech2NPCHeader:
	db NPC_TECH2
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Tech2
	tx TechNPCName
	db $00
	db $00
	db $00
	db $00

Tech3NPCHeader:
	db NPC_TECH3
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Tech3
	tx TechNPCName
	db $00
	db $00
	db $00
	db $00

Tech4NPCHeader:
	db NPC_TECH4
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Tech4
	tx TechNPCName
	db $00
	db $00
	db $00
	db $00

Tech5NPCHeader:
	db NPC_TECH5
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Tech5
	tx TechNPCName
	db $00
	db $00
	db $00
	db $00

Tech6NPCHeader:
	db NPC_TECH6
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Tech6
	tx TechNPCName
	db $00
	db $00
	db $00
	db $00

Clerk1NPCHeader:
	db NPC_CLERK1
	db $00;SPRITE_OW_CLERK
	db $00;SPRITE_ANIM_SGB_CLERK_NPC_UP
	db $00;SPRITE_ANIM_CGB_CLERK_NPC_UP
	db $00
	dw $00;Script_Clerk1
	tx ClerkNPCName2
	db $00
	db $00
	db $00
	db $00

Clerk2NPCHeader:
	db NPC_CLERK2
	db $00;SPRITE_OW_CLERK
	db $00;SPRITE_ANIM_SGB_CLERK_NPC_UP
	db $00;SPRITE_ANIM_CGB_CLERK_NPC_UP
	db $00
	dw $00;Script_Clerk2
	tx ClerkNPCName2
	db $00
	db $00
	db $00
	db $00

Clerk3NPCHeader:
	db NPC_CLERK3
	db $00;SPRITE_OW_CLERK
	db $00;SPRITE_ANIM_SGB_CLERK_NPC_UP
	db $00;SPRITE_ANIM_CGB_CLERK_NPC_UP
	db $00
	dw $00;Script_Clerk3
	tx ClerkNPCName2
	db $00
	db $00
	db $00
	db $00

Clerk4NPCHeader:
	db NPC_CLERK4
	db $00;SPRITE_OW_CLERK
	db $00;SPRITE_ANIM_SGB_CLERK_NPC_UP
	db $00;SPRITE_ANIM_CGB_CLERK_NPC_UP
	db $00
	dw $00;Script_Clerk4
	tx ClerkNPCName2
	db $00
	db $00
	db $00
	db $00

Clerk5NPCHeader:
	db NPC_CLERK5
	db $00;SPRITE_OW_CLERK
	db $00;SPRITE_ANIM_SGB_CLERK_NPC_UP
	db $00;SPRITE_ANIM_CGB_CLERK_NPC_UP
	db $00
	dw $00;Script_Clerk5
	tx ClerkNPCName2
	db $00
	db $00
	db $00
	db $00

Clerk6NPCHeader:
	db NPC_CLERK6
	db $00;SPRITE_OW_CLERK
	db $00;SPRITE_ANIM_SGB_CLERK_NPC_UP
	db $00;SPRITE_ANIM_CGB_CLERK_NPC_UP
	db $00
	dw $00;Script_Clerk6
	tx ClerkNPCName2
	db $00
	db $00
	db $00
	db $00

Clerk7NPCHeader:
	db NPC_CLERK7
	db $00;SPRITE_OW_CLERK
	db $00;SPRITE_ANIM_SGB_CLERK_NPC_UP
	db $00;SPRITE_ANIM_CGB_CLERK_NPC_UP
	db $00
	dw $00;Script_Clerk7
	tx ClerkNPCName2
	db $00
	db $00
	db $00
	db $00

Clerk8NPCHeader:
	db NPC_CLERK8
	db $00;SPRITE_OW_CLERK
	db $00;SPRITE_ANIM_SGB_CLERK_NPC_UP
	db $00;SPRITE_ANIM_CGB_CLERK_NPC_UP
	db $00
	dw $00;Script_Clerk8
	tx ClerkNPCName2
	db $00
	db $00
	db $00
	db $00

Clerk9NPCHeader:
	db NPC_CLERK9
	db $00;SPRITE_OW_CLERK
	db $00;SPRITE_ANIM_SGB_CLERK_NPC_UP
	db $00;SPRITE_ANIM_CGB_CLERK_NPC_UP
	db $00
	dw $00;Script_Clerk9
	tx ClerkNPCName2
	db $00
	db $00
	db $00
	db $00

ChrisNPCHeader:
	db NPC_CHRIS
	db $00;SPRITE_OW_MANIA
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_WHITE_NPC_UP
	db $00
	dw $00;Script_Chris
	tx ChrisNPCName
	db CHRIS_PIC
	db MUSCLES_FOR_BRAINS_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

MichaelNPCHeader:
	db NPC_MICHAEL
	db $00;SPRITE_OW_MANIA
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_WHITE_NPC_UP
	db $00
	dw $00;Script_Michael
	tx MichaelNPCName
	db MICHAEL_PIC
	db HEATED_BATTLE_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

JessicaNPCHeader:
	db NPC_JESSICA
	db $00;SPRITE_OW_LASS3
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_GREEN_NPC_UP
	db $00
	dw $00;Script_Jessica
	tx JessicaNPCName
	db JESSICA_PIC
	db LOVE_TO_BATTLE_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

MitchNPCHeader:
	db NPC_MITCH
	db $00;SPRITE_OW_MITCH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Mitch
	tx MitchNPCName
	db MITCH_PIC
	db FIRST_STRIKE_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_2

MatthewNPCHeader:
	db NPC_MATTHEW
	db $00;SPRITE_OW_MANIA
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Matthew
	tx MatthewNPCName
	db MATTHEW_PIC
	db HARD_POKEMON_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

RyanNPCHeader:
	db NPC_RYAN
	db $00;SPRITE_OW_BOY
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_WHITE_NPC_UP
	db $00
	dw $00;Script_Ryan
	tx RyanNPCName
	db RYAN_PIC
	db EXCAVATION_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

AndrewNPCHeader:
	db NPC_ANDREW
	db $00;SPRITE_OW_MAN
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Andrew
	tx AndrewNPCName
	db ANDREW_PIC
	db BLISTERING_POKEMON_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

GeneNPCHeader:
	db NPC_GENE
	db $00;SPRITE_OW_GENE
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_RED_NPC_UP
	db $00
	dw $00;Script_Gene
	tx GeneNPCName
	db GENE_PIC
	db ROCK_CRUSHER_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_2

SaraNPCHeader:
	db NPC_SARA
	db $00;SPRITE_OW_SWIMMER
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Sara
	tx SaraNPCName
	db SARA_PIC
	db WATERFRONT_POKEMON_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

AmandaNPCHeader:
	db NPC_AMANDA
	db $00;SPRITE_OW_SWIMMER
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Amanda
	tx AmandaNPCName
	db AMANDA_PIC
	db LONELY_FRIENDS_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

JoshuaNPCHeader:
	db NPC_JOSHUA
	db $00;SPRITE_OW_JOSHUA
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_WHITE_NPC_UP
	db $00
	dw $00;Script_Joshua
	tx JoshuaNPCName
	db JOSHUA_PIC
	db SOUND_OF_THE_WAVES_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

AmyNPCHeader:
	db NPC_AMY
	db $00;SPRITE_OW_AMY
	db $00;SPRITE_ANIM_SGB_AMY_LAYING
	db $00;SPRITE_ANIM_CGB_AMY_LAYING
	db NPC_FLAG_DIRECTIONLESS
	dw $00;Script_Amy
	tx AmyNPCName
	db AMY_PIC
	db GO_GO_RAIN_DANCE_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_2

JenniferNPCHeader:
	db NPC_JENNIFER
	db $00;SPRITE_OW_GIRL
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Jennifer
	tx JenniferNPCName
	db JENNIFER_PIC
	db PIKACHU_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

NicholasNPCHeader:
	db NPC_NICHOLAS
	db $00;SPRITE_OW_HOOD
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_RED_NPC_UP
	db $00
	dw $00;Script_Nicholas
	tx NicholasNPCName
	db NICHOLAS_PIC
	db BOOM_BOOM_SELFDESTRUCT_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

BrandonNPCHeader:
	db NPC_BRANDON
	db $00;SPRITE_OW_HOOD
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_RED_NPC_UP
	db $00
	dw $00;Script_Brandon
	tx BrandonNPCName
	db BRANDON_PIC
	db POWER_GENERATOR_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

IsaacNPCHeader:
	db NPC_ISAAC
	db $00;SPRITE_OW_ISAAC
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Isaac
	tx IsaacNPCName
	db ISAAC_PIC
	db ZAPPING_SELFDESTRUCT_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_2

BrittanyNPCHeader:
	db NPC_BRITTANY
	db $00;SPRITE_OW_GIRL
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Brittany
	tx BrittanyNPCName
	db BRITTANY_PIC
	db ETCETERA_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

KristinNPCHeader:
	db NPC_KRISTIN
	db $00;SPRITE_OW_LASS2
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_RED_NPC_UP
	db $00
	dw $00;Script_Kristin
	tx KristinNPCName
	db KRISTIN_PIC
	db FLOWER_GARDEN_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

HeatherNPCHeader:
	db NPC_HEATHER
	db $00;SPRITE_OW_LASS1
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_PURPLE_NPC_UP
	db $00
	dw $00;Script_Heather
	tx HeatherNPCName
	db HEATHER_PIC
	db KALEIDOSCOPE_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

NikkiNPCHeader:
	db NPC_NIKKI
	db $00;SPRITE_OW_NIKKI
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_GREEN_NPC_UP
	db $00
	dw $00;Script_Nikki
	tx NikkiNPCName
	db NIKKI_PIC
	db FLOWER_POWER_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_2

RobertNPCHeader:
	db NPC_ROBERT
	db $00;SPRITE_OW_BOY
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Robert
	tx RobertNPCName
	db ROBERT_PIC
	db GHOST_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

DanielNPCHeader:
	db NPC_DANIEL
	db $00;SPRITE_OW_LAD
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_GREEN_NPC_UP
	db $00
	dw $00;Script_Daniel
	tx DanielNPCName
	db DANIEL_PIC
	db NAP_TIME_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

StephanieNPCHeader:
	db NPC_STEPHANIE
	db $00;SPRITE_OW_GIRL
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Stephanie
	tx StephanieNPCName
	db STEPHANIE_PIC
	db STRANGE_POWER_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

Murray1NPCHeader:
	db NPC_MURRAY1
	db $00;SPRITE_OW_MURRAY
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_PINK_NPC_UP
	db $00
	dw $00;Script_Murray
	tx MurrayNPCName
	db MURRAY_PIC
	db STRANGE_PSYSHOCK_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_2

Murray2NPCHeader:
	db NPC_MURRAY2
	db $00;SPRITE_OW_MURRAY
	db $00;SPRITE_ANIM_LIGHT_NPC_LEFT
	db $00;SPRITE_ANIM_PINK_NPC_LEFT
	db NPC_FLAG_DIRECTIONLESS
	dw $00;Script_Murray
	tx MurrayNPCName
	db MURRAY_PIC
	db STRANGE_PSYSHOCK_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_2

JosephNPCHeader:
	db NPC_JOSEPH
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Joseph
	tx JosephNPCName
	db JOSEPH_PIC
	db FLYIN_POKEMON_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

DavidNPCHeader:
	db NPC_DAVID
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_David
	tx DavidNPCName
	db DAVID_PIC
	db LOVELY_NIDORAN_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

ErikNPCHeader:
	db NPC_ERIK
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;db SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Erik
	tx ErikNPCName
	db ERIK_PIC
	db POISON_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

RickNPCHeader:
	db NPC_RICK
	db $00;SPRITE_OW_RICK
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Rick
	tx RickNPCName
	db RICK_PIC
	db WONDERS_OF_SCIENCE_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_2

JohnNPCHeader:
	db NPC_JOHN
	db $00;SPRITE_OW_LAD
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_GREEN_NPC_UP
	db $00
	dw $00;Script_John
	tx JohnNPCName
	db JOHN_PIC
	db ANGER_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

AdamNPCHeader:
	db NPC_ADAM
	db $00;SPRITE_OW_SPECS
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_PURPLE_NPC_UP
	db $00
	dw $00;Script_Adam
	tx AdamNPCName
	db ADAM_PIC
	db FLAMETHROWER_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

JonathanNPCHeader:
	db NPC_JONATHAN
	db $00;SPRITE_OW_BOY
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Jonathan
	tx JonathanNPCName
	db JONATHAN_PIC
	db RESHUFFLE_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_1

KenNPCHeader:
	db NPC_KEN
	db $00;SPRITE_OW_KEN
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_RED_NPC_UP
	db $00
	dw $00;Script_Ken
	tx KenNPCName
	db KEN_PIC
	db FIRE_CHARGE_DECK_ID
	db MUSIC_DUEL_THEME_2
	db MUSIC_MATCH_START_2

CourtneyNPCHeader:
	db NPC_COURTNEY
	db $00;SPRITE_OW_COURTNEY
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_PINK_NPC_UP
	db $00
	dw $00;Script_Courtney
	tx CourtneyNPCName
	db COURTNEY_PIC
	db LEGENDARY_MOLTRES_DECK_ID
	db MUSIC_DUEL_THEME_3
	db MUSIC_MATCH_START_3

SteveNPCHeader:
	db NPC_STEVE
	db $00;SPRITE_OW_STEVE
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_INDIGO_NPC_UP
	db $00
	dw $00;Script_Steve
	tx SteveNPCName
	db STEVE_PIC
	db LEGENDARY_ZAPDOS_DECK_ID
	db MUSIC_DUEL_THEME_3
	db MUSIC_MATCH_START_3

JackNPCHeader:
	db NPC_JACK
	db $00;SPRITE_OW_JACK
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_WHITE_NPC_UP
	db $00
	dw $00;Script_Jack
	tx JackNPCName
	db JACK_PIC
	db LEGENDARY_ARTICUNO_DECK_ID
	db MUSIC_DUEL_THEME_3
	db MUSIC_MATCH_START_3

RodNPCHeader:
	db NPC_ROD
	db $00;SPRITE_OW_ROD
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Rod
	tx RodNPCName
	db ROD_PIC
	db LEGENDARY_DRAGONITE_DECK_ID
	db MUSIC_DUEL_THEME_3
	db MUSIC_MATCH_START_3

Clerk10NPCHeader:
	db NPC_CLERK10
	db $00;SPRITE_OW_CLERK
	db $00;SPRITE_ANIM_SGB_CLERK_NPC_UP
	db $00;SPRITE_ANIM_CGB_CLERK_NPC_UP
	db $00
	dw $00;Script_Clerk10
	tx ClerkNPCName
	db $00
	db $00
	db $00
	db $00

GiftCenterClerkNPCHeader:
	db NPC_GIFT_CENTER_CLERK
	db $00;SPRITE_OW_CLERK
	db $00;SPRITE_ANIM_SGB_CLERK_NPC_UP
	db $00;SPRITE_ANIM_CGB_CLERK_NPC_UP
	db $00
	dw $00;Script_GiftCenterClerk
	tx ClerkNPCName
	db $00
	db $00
	db $00
	db $00

Man1NPCHeader:
	db NPC_MAN1
	db $00;SPRITE_OW_MAN
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Man1
	tx ManNPCName
	db $00
	db $00
	db $00
	db $00

Woman1NPCHeader:
	db NPC_WOMAN1
	db $00;SPRITE_OW_WOMAN
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_RED_NPC_UP
	db $00
	dw $00;Script_Woman1
	tx WomanNPCName
	db $00
	db $00
	db $00
	db $00

Chap1NPCHeader:
	db NPC_CHAP1
	db $00;SPRITE_OW_CHAP
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_GREEN_NPC_UP
	db $00
	dw $00;Script_Chap1
	tx ChapNPCName
	db $00
	db $00
	db $00
	db $00

Gal1NPCHeader:
	db NPC_GAL1
	db $00;SPRITE_OW_GAL
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Gal1
	tx GalNPCName
	db $00
	db $00
	db $00
	db $00

Lass1NPCHeader:
	db NPC_LASS1
	db $00;SPRITE_OW_LASS2
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_RED_NPC_UP
	db $00
	dw $00;Script_Lass1
	tx LassNPCName
	db $00
	db $00
	db $00
	db $00

Chap2NPCHeader:
	db NPC_CHAP2
	db $00;SPRITE_OW_CHAP
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_GREEN_NPC_UP
	db $00
	dw $00;Script_Chap2
	tx ChapNPCName
	db $00
	db $00
	db $00
	db $00

Lass2NPCHeader:
	db NPC_LASS2
	db $00;SPRITE_OW_LASS2
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_RED_NPC_UP
	db $00
	dw $00;Script_Lass2
	tx LassNPCName
	db $00
	db $00
	db $00
	db $00

Pappy1NPCHeader:
	db NPC_PAPPY1
	db $00;SPRITE_OW_PAPPY
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_PURPLE_NPC_UP
	db $00
	dw $00;Script_Pappy1
	tx PappyNPCName
	db $00
	db $00
	db $00
	db $00

Lad1NPCHeader:
	db NPC_LAD1
	db $00;SPRITE_OW_LAD
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_GREEN_NPC_UP
	db $00
	dw $00;Script_Lad1
	tx LadNPCName
	db $00
	db $00
	db $00
	db $00

Lad2NPCHeader:
	db NPC_LAD2
	db $00;SPRITE_OW_BOY
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Lad2
	tx LadNPCName
	db $00
	db $00
	db $00
	db $00

Chap3NPCHeader:
	db NPC_CHAP3
	db $00;SPRITE_OW_CHAP
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_GREEN_NPC_UP
	db $00
	dw $00;Script_Chap3
	tx ChapNPCName
	db $00
	db $00
	db $00
	db $00

Clerk12NPCHeader:
	db NPC_CLERK12
	db $00;SPRITE_OW_GAL
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Clerk12
	tx ClerkNPCName2
	db $00
	db $00
	db $00
	db $00

Clerk13NPCHeader:
	db NPC_CLERK13
	db $00;SPRITE_OW_GAL
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Clerk13
	tx ClerkNPCName2
	db $00
	db $00
	db $00
	db $00

HostNPCHeader:
	db NPC_HOST
	db $00;SPRITE_OW_GAL
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Host
	tx HostNPCName
	db $00
	db $00
	db $00
	db $00

Specs1NPCHeader:
	db NPC_SPECS1
	db $00;SPRITE_OW_SPECS
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_PURPLE_NPC_UP
	db $00
	dw $00;Script_Specs1
	tx SpecsNPCName
	db $00
	db $00
	db $00
	db $00

ButchNPCHeader:
	db NPC_BUTCH
	db $00;SPRITE_OW_BUTCH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Butch
	tx ButchNPCName
	db $00
	db $00
	db $00
	db $00

Granny1NPCHeader:
	db NPC_GRANNY1
	db $00;SPRITE_OW_GRANNY
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Granny1
	tx GrannyNPCName
	db $00
	db $00
	db $00
	db $00

Lass3NPCHeader:
	db NPC_LASS3
	db $00;SPRITE_OW_LASS1
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_PURPLE_NPC_UP
	db $00
	dw $00;Script_Lass3
	tx LassNPCName
	db $00
	db $00
	db $00
	db $00

Man2NPCHeader:
	db NPC_MAN2
	db $00;SPRITE_OW_MAN
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Man2
	tx ManNPCName
	db $00
	db $00
	db $00
	db $00

Pappy2NPCHeader:
	db NPC_PAPPY2
	db $00;SPRITE_OW_PAPPY
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_PURPLE_NPC_UP
	db $00
	dw $00;Script_Pappy2
	tx PappyNPCName
	db $00
	db $00
	db $00
	db $00

Lass4NPCHeader:
	db NPC_LASS4
	db $00;SPRITE_OW_LASS1
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_PURPLE_NPC_UP
	db $00
	dw $00;Script_Lass4
	tx LassNPCName
	db $00
	db $00
	db $00
	db $00

Hood1NPCHeader:
	db NPC_HOOD1
	db $00;SPRITE_OW_HOOD
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_RED_NPC_UP
	db $00
	dw $00;Script_Hood1
	tx HoodNPCName
	db $00
	db $00
	db $00
	db $00

Granny2NPCHeader:
	db NPC_GRANNY2
	db $00;SPRITE_OW_GRANNY
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Granny2
	tx GrannyNPCName
	db $00
	db $00
	db $00
	db $00

Gal2NPCHeader:
	db NPC_GAL2
	db $00;SPRITE_OW_GAL
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Gal2
	tx GalNPCName
	db $00
	db $00
	db $00
	db $00

Lad3NPCHeader:
	db NPC_LAD3
	db $00;SPRITE_OW_LAD
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_GREEN_NPC_UP
	db $00
	dw $00;Script_Lad3
	tx LadNPCName
	db $00
	db $00
	db $00
	db $00

Gal3NPCHeader:
	db NPC_GAL3
	db $00;SPRITE_OW_GAL
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Gal3
	tx GalNPCName
	db $00
	db $00
	db $00
	db $00

Chap4NPCHeader:
	db NPC_CHAP4
	db $00;SPRITE_OW_CHAP
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_GREEN_NPC_UP
	db $00
	dw $00;Script_Chap4
	tx ChapNPCName
	db $00
	db $00
	db $00
	db $00

Man3NPCHeader:
	db NPC_MAN3
	db $00;SPRITE_OW_MAN
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Man3
	tx ManNPCName
	db $00
	db $00
	db $00
	db $00

Specs2NPCHeader:
	db NPC_SPECS2
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Specs2
	tx SpecsNPCName
	db $00
	db $00
	db $00
	db $00

Specs3NPCHeader:
	db NPC_SPECS3
	db $00;SPRITE_OW_SPECS
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_PURPLE_NPC_UP
	db $00
	dw $00;Script_Specs3
	tx SpecsNPCName
	db $00
	db $00
	db $00
	db $00

Woman2NPCHeader:
	db NPC_WOMAN2
	db $00;SPRITE_OW_WOMAN
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_RED_NPC_UP
	db $00
	dw $00;Script_Woman2
	tx WomanNPCName
	db $00
	db $00
	db $00
	db $00

ManiaNPCHeader:
	db NPC_MANIA
	db $00;SPRITE_OW_MANIA
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_WHITE_NPC_UP
	db $00
	dw $00;Script_Mania
	tx ManiaNPCName
	db $00
	db $00
	db $00
	db $00

Pappy3NPCHeader:
	db NPC_PAPPY3
	db $00;SPRITE_OW_PAPPY
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_PURPLE_NPC_UP
	db $00
	dw $00;Script_Pappy3
	tx PappyNPCName
	db $00
	db $00
	db $00
	db $00

Gal4NPCHeader:
	db NPC_GAL4
	db $00;SPRITE_OW_GAL
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Gal4
	tx GalNPCName
	db $00
	db $00
	db $00
	db $00

ChampNPCHeader:
	db NPC_CHAMP
	db $00;SPRITE_OW_MANIA
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_WHITE_NPC_UP
	db $00
	dw $00;Script_Champ
	tx ChampNPCName
	db $00
	db $00
	db $00
	db $00

Hood2NPCHeader:
	db NPC_HOOD2
	db $00;SPRITE_OW_HOOD
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_RED_NPC_UP
	db $00
	dw $00;Script_Hood2
	tx HoodNPCName
	db $00
	db $00
	db $00
	db $00

Lass5NPCHeader:
	db NPC_LASS5
	db $00;SPRITE_OW_LASS3
	db $00;SPRITE_ANIM_DARK_NPC_UP
	db $00;SPRITE_ANIM_GREEN_NPC_UP
	db $00
	dw $00;Script_Lass5
	tx LassNPCName
	db $00
	db $00
	db $00
	db $00

Chap5NPCHeader:
	db NPC_CHAP5
	db $00;SPRITE_OW_CHAP
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_GREEN_NPC_UP
	db $00
	dw $00;Script_Chap5
	tx ChapNPCName
	db $00
	db $00
	db $00
	db $00

AaronNPCHeader:
	db NPC_AARON
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Aaron
	tx AaronNPCName
	db AARON_PIC
	db LIGHTNING_AND_FIRE_DECK_ID
	db MUSIC_DUEL_THEME_1
	db MUSIC_MATCH_START_1

GuideNPCHeader:
	db NPC_GUIDE
	db $00;SPRITE_OW_MAN
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_YELLOW_NPC_UP
	db $00
	dw $00;Script_Guide
	tx GuideNPCName
	db $00
	db $00
	db $00
	db $00

Tech7NPCHeader:
	db NPC_TECH7
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Tech7
	tx TechNPCName
	db $00
	db $00
	db $00
	db $00

Tech8NPCHeader:
	db NPC_TECH8
	db $00;SPRITE_OW_TECH
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_BLUE_NPC_UP
	db $00
	dw $00;Script_Tech8
	tx TechNPCName
	db $00
	db $00
	db $00
	db $00

; TorchNPCHeader:
; 	db NPC_TORCH
; 	db $00;SPRITE_OW_TORCH
; 	db $00;SPRITE_ANIM_TORCH
; 	db $00;SPRITE_ANIM_TORCH
; 	db NPC_FLAG_DIRECTIONLESS
; 	dw $00;Script_Torch

; LegendaryCardTopLeftNPCHeader:
; 	db NPC_LEGENDARY_CARD_TOP_LEFT
; 	db $00;SPRITE_OW_LEGENDARY_CARD
; 	db $00;SPRITE_ANIM_SGB_CARD_TOP_LEFT
; 	db $00;SPRITE_ANIM_CGB_CARD_TOP_LEFT
; 	db NPC_FLAG_DIRECTIONLESS | NPC_FLAG_UNKNOWN
; 	dw $00;Script_LegendaryCardTopLeft

; LegendaryCardTopRightNPCHeader:
; 	db NPC_LEGENDARY_CARD_TOP_RIGHT
; 	db $00;SPRITE_OW_LEGENDARY_CARD
; 	db $00;SPRITE_ANIM_SGB_CARD_TOP_RIGHT
; 	db $00;SPRITE_ANIM_CGB_CARD_TOP_RIGHT
; 	db NPC_FLAG_DIRECTIONLESS | NPC_FLAG_UNKNOWN
; 	dw $00;Script_LegendaryCardTopRight

; LegendaryCardLeftSparkNPCHeader:
; 	db NPC_LEGENDARY_CARD_LEFT_SPARK
; 	db $00;SPRITE_OW_LEGENDARY_CARD
; 	db $00;SPRITE_ANIM_SGB_CARD_LEFT_SPARK
; 	db $00;SPRITE_ANIM_CGB_CARD_LEFT_SPARK
; 	db NPC_FLAG_DIRECTIONLESS | NPC_FLAG_UNKNOWN
; 	dw $00;Script_LegendaryCardLeftSpark

; LegendaryCardBottomLeftNPCHeader:
; 	db NPC_LEGENDARY_CARD_BOTTOM_LEFT
; 	db $00;SPRITE_OW_LEGENDARY_CARD
; 	db $00;SPRITE_ANIM_SGB_CARD_BOTTOM_LEFT
; 	db $00;SPRITE_ANIM_CGB_CARD_BOTTOM_LEFT
; 	db NPC_FLAG_DIRECTIONLESS | NPC_FLAG_UNKNOWN
; 	dw $00;Script_LegendaryCardBottomLeft

; LegendaryCardBottomRightNPCHeader:
; 	db NPC_LEGENDARY_CARD_BOTTOM_RIGHT
; 	db $00;SPRITE_OW_LEGENDARY_CARD
; 	db $00;SPRITE_ANIM_SGB_CARD_BOTTOM_RIGHT
; 	db $00;SPRITE_ANIM_CGB_CARD_BOTTOM_RIGHT
; 	db NPC_FLAG_DIRECTIONLESS | NPC_FLAG_UNKNOWN
; 	dw $00;Script_LegendaryCardBottomRight

; LegendaryCardRightSparkNPCHeader:
; 	db NPC_LEGENDARY_CARD_RIGHT_SPARK
; 	db $00;SPRITE_OW_LEGENDARY_CARD
; 	db $00;SPRITE_ANIM_SGB_CARD_RIGHT_SPARK
; 	db $00;SPRITE_ANIM_CGB_CARD_RIGHT_SPARK
; 	db NPC_FLAG_DIRECTIONLESS | NPC_FLAG_UNKNOWN
; 	dw $00;Script_LegendaryCardRightSpark

DummyNPCHeader:
	db $00
	db $00;SPRITE_OW_PLAYER
	db $00;SPRITE_ANIM_LIGHT_NPC_UP
	db $00;SPRITE_ANIM_RED_NPC_UP
	db $00
