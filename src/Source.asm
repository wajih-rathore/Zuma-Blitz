.MODEL flat, stdcall
.STACK 4096

INCLUDE irvine32.inc
INCLUDE macros.inc
INCLUDELIB winmm.lib

EXTERN SetConsoleOutputCP@4 : PROC
EXTERN GetStdHandle@4 : PROC
EXTERN PlaySound@12 : PROC

PlaySound PROTO, pszsound:PTR BYTE, hmod:DWORD, fdwsound:DWORD


.DATA
;///////////////////////////// SYSTEM CONSTANTS /////////////////////////////////
    CP_UTF8 EQU 65001                  ; UTF-8 encoding constant for console
    STD_OUTPUT_HANDLE EQU -11          ; Standard output handle constant
    PATH_LENGTH EQU 225                ; Length of ball movement paths
    MAX_BALLS EQU 80                   ; Maximum number of balls in game
    SPAWN_DELAY EQU 0                 ; Delay between ball spawns
    ;GAME_SPEED_DELAY EQU 50            ; Game loop delay for speed control
    DIM_COLOR EQU 8                    ; Gray color for static path
    ACTIVE_COLOR EQU 10                ; Light Green for moving balls
    BOX_WIDTH EQU 40                   ; Width of dialog boxes
    BOX_HEIGHT EQU 10                  ; Height of dialog boxes
    BOX_TOP_LEFT_X EQU 40              ; Starting X for dialog boxes
    BOX_TOP_LEFT_Y EQU 10              ; Starting Y for dialog boxes

    
    FIREBALL_DELAY    EQU 10    
    BALL_MOVE_SPEED   EQU 50   ; for controlling ball speed
    LEVEL2_SPEED      EQU 30   ; Faster speed for level 2


;///////////////////////////// GAME STATE VARIABLES ////////////////////////////
    game_score db 0                    ; Current game score
    game_lives db 3                    ; Player lives remaining
    game_levelInfo db 1                ; Current game level
    game_over_flag db 0                ; Game over state flag
    pause_flag db 0                    ; Pause state flag
    high_score DWORD 0                 ; Highest score achieved
    combo_count DWORD 0                ; Current combo counter
    progress DWORD 0                   ; Level progress tracking

;///////////////////////////// PLAYER VARIABLES ///////////////////////////////
    xPos db 47                         ; Player X position
    yPos db 13                         ; Player Y position
    xDir db 0                          ; Player X direction
    yDir db 0                          ; Player Y direction
    direction db "d"                   ; Player facing direction
    username db 16 dup(0)              ; Player name storage

;///////////////////////////// BALL SYSTEM ///////////////////////////////////
    ; Ball Structure Definition
    BallStruct STRUCT
        xPos      BYTE ?               ; Ball X position
        yPos      BYTE ?               ; Ball Y position 
        pathIndex DWORD ?              ; Position in path
        active    BYTE ?               ; Active status
        color     BYTE ?               ; Ball color
    BallStruct ENDS

    ; Ball related offsets
    Ball_xPos     EQU 0               ; xPos offset in BallStruct
    Ball_yPos     EQU 1               ; yPos offset in BallStruct
    Ball_pathIndex EQU 2              ; pathIndex offset in BallStruct
    Ball_active   EQU 6               ; active flag offset in BallStruct
    Ball_color    EQU 7               ; color offset in BallStruct

    ; Ball arrays and counters
    balls BallStruct MAX_BALLS DUP (<>) ; Array of ball structures
    path_counter db PATH_LENGTH DUP(0)  ; Track balls per position
    spawn_counter DWORD 0               ; Ball spawn timing counter
    last_spawn_time DWORD 0             ; Last spawn timestamp


;///////////////////////////// PATH COORDINATES //////////////////////////////
path_x  db 102, 100, 98, 96, 94, 92, 90, 88, 86, 84    ; First 10 values
        db 82,  80,  78, 76, 74, 72, 70, 68, 66, 64      ; Next 10 values
        db 62,  60,  58, 56, 54, 52, 50, 48, 46, 44      ; Next 10 values
        db 42,  40,  38, 36, 34, 32, 30, 28, 26, 24      ; Next 10 values
        db 22,  20,  18, 16, 14, 12, 10,  8,  6,  6         ; Next 10 values
        db  6,   6,   6,  6,  6,  6,  6,  6,  6,  7         ; next 10 values 
        db  8,   9,  10, 11, 12, 14, 16, 18, 20, 22	 ; next 10 values
        db 24,  26,  28, 30, 32, 34, 36, 38, 40, 42	 ; next 10 values
        db 44, 46, 48, 50, 52, 54, 56, 58, 60, 62	 ; next 10 values
        db 64, 66, 68, 70, 72, 74, 76, 78, 80, 82  ; next 10 values
        db 84, 86, 88, 89, 90, 91, 92, 93, 94, 94  ; next 10 values
        db 94, 94, 94, 94, 94, 94, 94, 92, 90, 88  ; next 10 values
        db 86, 84, 82, 80, 78, 76, 74, 72, 70, 68  ; next 10 values
        db 66, 64, 62, 60, 58, 56, 54, 52, 50, 48  ; next 10 values
        db 46, 44, 42, 40, 38, 36, 34, 32, 30, 28  ; next 10 values
        db 26, 24, 22, 20, 18, 16, 16, 16, 16, 16   ; next 10 values
        db 16, 16, 16, 16, 16, 17, 18, 19, 20, 22  ; next 10 values
        db 24, 26, 28, 30, 32, 34, 36, 38, 40, 42  ; next 10 values
        db 44, 46, 48, 50, 52, 54, 56, 58, 60, 62  ; next 10 values
        db 64, 66, 68, 70, 72, 74, 76, 78, 80, 81  ; next 10 values
        db 82, 83, 84, 85, 85, 85, 85, 85, 85, 85  ; next 10 values
        db 83, 81, 79, 77, 75, 73, 71, 69, 67, 65  ; next 10 values
        db 63, 61, 59, 57, 55, 53, 51, 49, 47, 45  ; next 10 values

; Y coordinates array (move down gradually)
path_y  db 9, 8, 7, 6, 5, 4, 3, 3, 3, 3                ; First 10 values
        db 3, 3, 3, 3, 3, 3, 3, 3, 3, 3                ; Next 10 values
        db 3, 3, 3, 3, 3, 3, 3, 3, 3, 3                ; Next 10 values
        db 3, 3, 3, 3, 3, 3, 3, 3, 3, 3                ; Next 10 values
        db 3, 3, 3, 4, 5, 6, 7, 8, 9, 10               ; next 10 values 
        db 11, 12, 13, 14, 15, 16, 17, 18, 19, 20       ; next 10 values
        db 21, 22, 23 ,24, 25, 26, 26 ,26 ,26, 26		; next 10 values
        db 26, 26, 26, 26 ,26 ,26, 26, 26, 26, 26		; next 10 values
        db 26, 26, 26, 26 ,26 ,26, 26, 26, 26, 26		; next 10 values
        db 26, 26, 26, 26 ,26 ,26, 26, 26, 26, 26		; next 10 values
        db 26, 26, 25, 24, 23, 22, 21, 20, 19, 18		; next 10 values
        db 17, 16, 15, 14, 13, 12, 11, 10, 9, 8		; next 10 values
        db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7			; next 10 values
        db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7			; next 10 values
        db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7			; next 10 values
        db 7, 7, 8, 9, 10, 11, 12, 13, 14, 15		; next 10 values
        db 14, 15, 16, 17, 18, 19, 20, 21, 22, 22		; next 10 values
        db 22, 22, 22, 22, 22, 22, 22, 22, 22, 22		; next 10 values
        db 22, 22, 22, 22, 22, 22, 22, 22, 22, 22		; next 10 values
        db 22, 22, 22, 22, 22, 22, 22, 22, 22, 21		; next 10 values
        db 20, 19, 18, 17, 16, 15, 14, 14, 14, 14		; next 10 values
        db 14, 14, 14, 14, 14, 14, 14, 14, 14, 14		; next 10 values
        db 14, 14, 14, 14, 14, 14, 14, 14, 14, 14		; next 10 values



; X coordinates array (zig-zag pattern, moving left-to-right and right-to-left alternately)
    path_x2 db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9             ; First row (left to right)
           db 9, 8, 7, 6, 5, 4, 3, 2, 1, 0             ; Second row (right to left)
           db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9             ; Third row (left to right)
           db 9, 8, 7, 6, 5, 4, 3, 2, 1, 0             ; Fourth row (right to left)
           db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9             ; Fifth row (left to right)
           db 9, 8, 7, 6, 5, 4, 3, 2, 1, 0             ; Sixth row (right to left)
           db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9             ; Seventh row (left to right)
           db 9, 8, 7, 6, 5, 4, 3, 2, 1, 0             ; Eighth row (right to left)
           db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9             ; Ninth row (left to right)
           db 9, 8, 7, 6, 5, 4, 3, 2, 1, 0             ; Tenth row (right to left)

; Y coordinates array (zig-zag pattern, moving down each row)
    path_y2 db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0             ; First row
           db 1, 1, 1, 1, 1, 1, 1, 1, 1, 1             ; Second row
           db 2, 2, 2, 2, 2, 2, 2, 2, 2, 2             ; Third row
           db 3, 3, 3, 3, 3, 3, 3, 3, 3, 3             ; Fourth row
           db 4, 4, 4, 4, 4, 4, 4, 4, 4, 4             ; Fifth row
           db 5, 5, 5, 5, 5, 5, 5, 5, 5, 5             ; Sixth row
           db 6, 6, 6, 6, 6, 6, 6, 6, 6, 6             ; Seventh row
           db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7             ; Eighth row
           db 8, 8, 8, 8, 8, 8, 8, 8, 8, 8             ; Ninth row
           db 9, 9, 9, 9, 9, 9, 9, 9, 9, 9             ; Tenth row

        	

;///////////////////////////// COLORS AND VISUALS ///////////////////////////
    ; Colors
    DIM_COLOR    EQU 8   ; Gray color for static path
    ACTIVE_COLOR EQU 10  ; Light Green for moving balls

; New color pattern for the balls
ball_colors db 12, 14, 10, 13, 11, 15, 4, 2, 6, 5    ; 1-10
           db 13, 12, 14, 11, 10, 4, 15, 6, 2, 5     ; 11-20
           db 14, 13, 11, 12, 15, 2, 4, 5, 10, 6     ; 21-30
           db 11, 12, 15, 14, 4, 13, 6, 10, 5, 2     ; 31-40
           db 15, 11, 13, 12, 2, 14, 5, 4, 6, 10     ; 41-50
           db 12, 15, 11, 14, 10, 4, 13, 2, 5, 6     ; 51-60
           db 14, 12, 15, 13, 4, 11, 6, 10, 2, 5     ; 61-70
           db 11, 14, 12, 15, 10, 13, 2, 4, 6, 5     ; 71-80
last_ball_index DWORD 0    ; Add this to track last spawned ball's position
SPAWN_DISTANCE EQU 1


    color_red db 4
    color_green db 2
    color_yellow db 14
    current_color db 4
    emitter_color1 db 2
    emitter_color2 db 4
    ;fire_color db 14

;///////////////////////////// UI ELEMENTS //////////////////////////////////
    ; Menu Strings
    choice1 db "1.  START GAME", 0ah, 0
    choice2 db "2.  INSTRUCTIONS", 0ah, 0
    choice3 db "3.  HIGHSCORES", 0ah, 0
    choice4 db "4.  EXIT GAME", 0ah, 0
    choiceask db "Enter Your Choice:  ", 0

    ; Game UI Strings
    scorestring db "Score: ",0
    livesstring db "Lives: ",0
    ;namestring db "Player Name: ", 0
    pausestring db "~*~*~ GAME PAUSED ~*~*~", 0ah, 0

;///////////////////////////// FILE HANDLING ////////////////////////////////
    filename db "highscores.txt", 0
    filehandle DWORD ?
    buffer_size = 100
    writebuffer db buffer_size DUP(?)
    readbuffer db buffer_size DUP(?)

;///////////////////////////// SCREEN BUFFER ///////////////////////////////
    screen_buffer db 4000 dup(?)        ; Screen content buffer
    screen_attrs  db 4000 dup(?)        ; Screen attributes buffer



;///////////////////////////// WALL DEFINITIONS /////////////////////////////////
    ; Wall boundary constants 
    LEFT_WALL_BOUNDARY   db 0         ; Used in FireBall, collision detection
    RIGHT_WALL_BOUNDARY  db 103       ; Used in FireBall, collision detection
    UPPER_WALL_BOUNDARY  db 0         ; Used in FireBall, collision detection
    LOWER_WALL_BOUNDARY  db 28        ; Used in FireBall, collision detection

;///////////////////////////// DISPLAY & UI STRINGS ////////////////////////////
    ; Score and status display strings
    scoreStr db "Score: ", 0          ; Used in score display
    levelStr db " Level: ", 0         ; Used in level display
    score_text db "Score: ", 0        ; Used in UpdateScoreDisplay
    level_text db "LEVEL ", 0         ; Used in DrawWalls
    ;scorestring db "Score: ",0        ; Duplicate - consolidate
    ;livesstring db "Lives: ",0        ; Used in lives display
    namestring db "Player Name: ", 0  ; Used in name display
    name_prompt db "Enter your name: ", 0 ; Used in GetPlayerName
    tempStr db 16 DUP(0)             ; Temporary string buffer

;///////////////////////////// PROJECTILE SYSTEM //////////////////////////////
    ; Fire/projectile properties
    fire_symbol db '*'               ; Symbol for fired projectile
    fire_color db 14                 ; Color of fired projectile (yellow)
    fire_col db 0                    ; Current projectile column
    fire_row db 0                    ; Current projectile row
    cursor_col db 0                  ; Current cursor column position
    cursor_row db 0                  ; Current cursor row position

;///////////////////////////// GAME STATE TRACKERS ////////////////////////////
    ; Game state counters and flags
    counter1 db 0                    ; Used in PrintPlayer
    counter2 db 0                    ; Used in PrintPlayer
    inputChar db 0                   ; Current input character
    startinput db ?                  ; Used in menu input

;///////////////////////////// FILE HANDLING /////////////////////////////////
    ; File operations
    buffer db 100 dup (?)           ; General purpose buffer
    exitstring db "Press Any Key to Exit", 0 ; Exit prompt

;///////////////////////////// SCREEN DRAWING ////////////////////////////////
    ; Screen elements
    ground db "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", 0
    ground1 db "|",0ah,0
    ground2 db "|",0

    ; Box drawing elements
    box_top     db "┌────────────────────────────────────────┐", 0Ah, 0
    box_side    db "│                                        │", 0Ah, 0
    box_bottom  db "└────────────────────────────────────────┘", 0Ah, 0


;////////////////////////////// Sound constants//////////////////////////////////
SND_FILENAME     equ 00020000h   ; Play from file
SND_ASYNC        equ 00000001h   ; Play asynchronously
SND_LOOP         equ 00000008h   ; Loop the sound
SND_NOSTOP       equ 00000010h   ; Don't stop currently playing sound

; Sound file path
menuMusic db "..\\assets\\music2.wav",0


;///////////////////////ASCII ART STRINGS///////////////////////////////////// 



    ; Example Unicode Art
    UnicodeArt db "  ██████╗  █████╗ ███╗   ███╗███████╗", 0Ah
               db " ██╔════╝ ██╔══██╗████╗ ████║██╔════╝", 0Ah
               db " ██║  ███╗███████║██╔████╔██║█████╗  ", 0Ah
               db " ██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ", 0Ah
               db " ╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗", 0Ah
               db "  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝", 0Ah, 0

zumablitz1 db " ███████╗██╗   ██╗███╗   ███╗ █████╗     ██████╗ ██╗     ██╗████████╗███████╗", 0ah, 0
zumablitz2 db " ╚══███╔╝██║   ██║████╗ ████║██╔══██╗    ██╔══██╗██║     ██║╚══██╔══╝╚══███╔╝", 0ah, 0
zumablitz3 db "   ███╔╝ ██║   ██║██╔████╔██║███████║    ██████╔╝██║     ██║   ██║     ███╔╝ ", 0ah, 0
zumablitz4 db "  ███╔╝  ██║   ██║██║╚██╔╝██║██╔══██║    ██╔══██╗██║     ██║   ██║    ███╔╝  ", 0ah, 0
zumablitz5 db " ███████╗╚██████╔╝██║ ╚═╝ ██║██║  ██║    ██████╔╝███████╗██║   ██║   ███████╗", 0ah, 0
zumablitz6 db " ╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝    ╚═════╝ ╚══════╝╚═╝   ╚═╝   ╚══════╝", 0ah, 0
zumablitz7 db "                                                                             ", 0ah, 0



    level11 db " ___      _______  __   __  _______  ___        ____  ", 0ah, 0
    level12 db "|   |    |    ___||  | |  ||    ___||   |      |    | ", 0ah, 0
    level13 db "|   |    |   |___ |  |_|  ||   |___ |   |       |   | ", 0ah, 0
    level14 db "|   |___ |    ___||       ||    ___||   |___    |   | ", 0ah, 0
    level15 db "|       ||   |___  |     | |   |___ |       |   |   | ", 0ah, 0
    level16 db "|_______||_______|  |___|  |_______||_______|   |___| ", 0ah, 0

    level21 db " ___      _______  __   __  _______  ___        _______ ", 0ah, 0
    level22 db "|   |    |    ___||  | |  ||    ___||   |      |____   |", 0ah, 0
    level23 db "|   |    |   |___ |  |_|  ||   |___ |   |       ____|  |", 0ah, 0
    level24 db "|   |___ |    ___||       ||    ___||   |___   | ______|", 0ah, 0
    level25 db "|       ||   |___  |     | |   |___ |       |  | |_____ ", 0ah, 0
    level26 db "|_______||_______|  |___|  |_______||_______|  |_______|", 0ah, 0

    level31 db " ___      _______  __   __  _______  ___        _______ ", 0ah, 0
    level32 db "|   |    |    ___||  | |  ||    ___||   |      |___    |", 0ah, 0
    level33 db "|   |    |   |___ |  |_|  ||   |___ |   |       ___|   |", 0ah, 0
    level34 db "|   |___ |    ___||       ||    ___||   |___   |___    |", 0ah, 0
    level35 db "|       ||   |___  |     | |   |___ |       |   ___|   |", 0ah, 0
    level36 db "|_______||_______|  |___|  |_______||_______|  |_______|", 0ah, 0

level1_1 db " █▓▒░░    ██      ███████ ██    ██ ███████ ██            ██     ░░▒▓█", 0ah, 0
level1_2 db " █▓▒░░    ██      ██      ██    ██ ██      ██           ███     ░░▒▓█", 0ah, 0
level1_3 db " █▓▒░░    ██      █████   ██    ██ █████   ██            ██     ░░▒▓█", 0ah, 0
level1_4 db " █▓▒░░    ██      ██       ██  ██  ██      ██            ██     ░░▒▓█", 0ah, 0
level1_5 db " █▓▒░░    ███████ ███████   ████   ███████ ███████       ██     ░░▒▓█", 0ah, 0

level2_1 db " █▓▒░░    ██      ███████ ██    ██ ███████ ██          ██████   ░░▒▓█", 0ah, 0
level2_2 db " █▓▒░░    ██      ██      ██    ██ ██      ██               ██  ░░▒▓█", 0ah, 0
level2_3 db " █▓▒░░    ██      █████   ██    ██ █████   ██           █████   ░░▒▓█", 0ah, 0
level2_4 db " █▓▒░░    ██      ██       ██  ██  ██      ██          ██       ░░▒▓█", 0ah, 0
level2_5 db " █▓▒░░    ███████ ███████   ████   ███████ ███████     ███████  ░░▒▓█", 0ah, 0

level3_1 db " █▓▒░░    ██      ███████ ██    ██ ███████ ██          ██████   ░░▒▓█", 0ah, 0
level3_2 db " █▓▒░░    ██      ██      ██    ██ ██      ██               ██  ░░▒▓█", 0ah, 0
level3_3 db " █▓▒░░    ██      █████   ██    ██ █████   ██           █████   ░░▒▓█", 0ah, 0
level3_4 db " █▓▒░░    ██      ██       ██  ██  ██      ██               ██  ░░▒▓█", 0ah, 0
level3_5 db " █▓▒░░    ███████ ███████   ████   ███████ ███████     ██████   ░░▒▓█", 0ah, 0



pause1_1 db " █▓▒░░    ██████  ███████ ███████ ██    ██ ███    ███ ███████        ░░▒▓█", 0ah, 0
pause1_2 db " █▓▒░░    ██   ██ ██      ██      ██    ██ ████  ████ ██             ░░▒▓█", 0ah, 0
pause1_3 db " █▓▒░░    ██████  █████   ███████ ██    ██ ██ ████ ██ █████          ░░▒▓█", 0ah, 0
pause1_4 db " █▓▒░░    ██   ██ ██           ██ ██    ██ ██  ██  ██ ██             ░░▒▓█", 0ah, 0
pause1_5 db " █▓▒░░    ██   ██ ███████ ███████  ██████  ██      ██ ███████        ░░▒▓█", 0ah, 0

pause2_1 db " █▓▒░░    ██████  ███████ ███████ ████████  █████  ██████  ████████  ░░▒▓█", 0ah, 0
pause2_2 db " █▓▒░░    ██   ██ ██      ██         ██    ██   ██ ██   ██    ██     ░░▒▓█", 0ah, 0
pause2_3 db " █▓▒░░    ██████  █████   ███████    ██    ███████ ██████     ██     ░░▒▓█", 0ah, 0
pause2_4 db " █▓▒░░    ██   ██ ██           ██    ██    ██   ██ ██   ██    ██     ░░▒▓█", 0ah, 0
pause2_5 db " █▓▒░░    ██   ██ ███████ ███████    ██    ██   ██ ██   ██    ██     ░░▒▓█", 0ah, 0

pause3_1 db " █▓▒░░                 ███████ ██   ██ ██ ████████                   ░░▒▓█", 0ah, 0
pause3_2 db " █▓▒░░                 ██       ██ ██  ██    ██                      ░░▒▓█", 0ah, 0
pause3_3 db " █▓▒░░                 █████     ███   ██    ██                      ░░▒▓█", 0ah, 0
pause3_4 db " █▓▒░░                 ██       ██ ██  ██    ██                      ░░▒▓█", 0ah, 0
pause3_5 db " █▓▒░░                 ███████ ██   ██ ██    ██                      ░░▒▓█", 0ah, 0



    levelc1 db "    __    _______    __________       ________    _________    ____  __________ ", 0ah, 0
    levelc2 db "   / /   / ____/ |  / / ____/ /      / ____/ /   / ____/   |  / __ \/ ____/ __ \", 0ah, 0
    levelc3 db "  / /   / __/  | | / / __/ / /      / /   / /   / __/ / /| | / /_/ / __/ / / / /", 0ah, 0
    levelc4 db " / /___/ /___  | |/ / /___/ /___   / /___/ /___/ /___/ ___ |/ _, _/ /___/ /_/ / ", 0ah, 0
    levelc5 db "/_____/_____/  |___/_____/_____/   \____/_____/_____/_/  |_/_/ |_/_____/_____/  ", 0ah, 0
                                                                 
    youwin1 db " /$$     /$$ /$$$$$$  /$$   /$$       /$$      /$$ /$$$$$$ /$$   /$$", 0ah, 0
    youwin2 db "|  $$   /$$//$$__  $$| $$  | $$      | $$  /$ | $$|_  $$_/| $$$ | $$", 0ah, 0
    youwin3 db " \  $$ /$$/| $$  \ $$| $$  | $$      | $$ /$$$| $$  | $$  | $$$$| $$", 0ah, 0
    youwin4 db "  \  $$$$/ | $$  | $$| $$  | $$      | $$/$$ $$ $$  | $$  | $$ $$ $$", 0ah, 0
    youwin5 db "   \  $$/  | $$  | $$| $$  | $$      | $$$$_  $$$$  | $$  | $$  $$$$", 0ah, 0
    youwin6 db "    | $$   | $$  | $$| $$  | $$      | $$$/ \  $$$  | $$  | $$\  $$$", 0ah, 0
    youwin7 db "    | $$   |  $$$$$$/|  $$$$$$/      | $$/   \  $$ /$$$$$$| $$ \  $$", 0ah, 0
    youwin8 db "    |__/    \______/  \______/       |__/     \__/|______/|__/  \__/", 0ah, 0
                                                     
    advance db "Press Any Key to Advance", 0ah, 0                                                                                       

    gameover1 db " _____ _____ _____ _____ _________ _____ _____ _____ _____ ", 0ah, 0
    gameover2 db "|| G ||| A ||| M ||| E |||       ||| O ||| V ||| E ||| R ||", 0ah, 0
    gameover3 db "||___|||___|||___|||___|||_______|||___|||___|||___|||___||", 0ah, 0
    gameover4 db "|/___\|/___\|/___\|/___\|/_______\|/___\|/___\|/___\|/___\|", 0ah, 0

     

    
    

    hsstring db "~*~*~ HIGHSCORES ~*~*~", 0ah, 0

    nameinput db "Enter your name:  ", 0
    ;username db 16 dup (?)
    
 





        combined_instructions db "                                 ~*~*~ WELCOME TO ZUMBA GAME INSTRUCTIONS ~*~*~", 0Dh, 0Ah
    db 0Dh, 0Ah
    db 0Dh, 0Ah
    db "1. Movement Controls: Use the following keys to rotate your player in any direction:", 0Dh, 0Ah
    db "   - Q: Rotate Left", 0Dh, 0Ah
    db "   - W: Move Up", 0Dh, 0Ah
    db "   - E: Rotate Right", 0Dh, 0Ah
    db "   - A: Move Left", 0Dh, 0Ah
    db "   - D: Move Right", 0Dh, 0Ah
    db "   - Z: Rotate Down-Left", 0Dh, 0Ah
    db "   - X: Rotate Down", 0Dh, 0Ah
    db "   - C: Rotate Down-Right", 0Dh, 0Ah
    db 0Dh, 0Ah
    db "2. Shooting: Press the SPACEBAR to fire colored balls at the moving chain.", 0Dh, 0Ah
    db "   - Aim carefully to align balls of the same color to create chain reactions and score points!", 0Dh, 0Ah
    db 0Dh, 0Ah
    db "3. Game Objective: Your goal is to strategically match colors and create chain reactions.", 0Dh, 0Ah
    db "   - The more chains you create, the higher your score will be!", 0Dh, 0Ah
    db 0Dh, 0Ah
    db "4. Danger Zone: Keep an eye on the danger zone as the balls approach.", 0Dh, 0Ah
    db "   - If the balls reach this zone, it's game over!", 0Dh, 0Ah
    db 0Dh, 0Ah
    db "5. Scoring Strategy: Plan your shots wisely to maximize your score.", 0Dh, 0Ah
    db "   - Delayed eliminations and chain reactions yield the highest bonuses!", 0Dh, 0Ah
    db 0Dh, 0Ah
    db "6. Have Fun: Enjoy the game and challenge yourself to beat your high score!", 0Dh, 0Ah
    db 0Dh, 0Ah
    db "                                 Press 1 to START GAME and 2 to go back to MAIN MENU: ", 0Dh, 0Ah, 0
    newline BYTE 0Dh, 0Ah, 0         


    wall1 db "##########", 0

    wall2 db "#", 0

    temp db ?

   
    score db 0
    blank db " ",0

    
    lives db 3



  ; New Walls Arrays - Each array represents a single line of the wall
    walls1      db "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                db   "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓", 0ah, 0
    walls2      db "┃                                                                                                      ┃", 0ah, 0
    walls3      db "┃                                                                                                      ┃", 0ah, 0
    walls4      db "┃                                                                                                      ┃", 0ah, 0
    walls5      db "┃                                                                                                      ┃", 0ah, 0
    walls6      db "┃                                                                                                      ┃", 0ah, 0
    walls7      db "┃                                                                                                      ┃", 0ah, 0
    walls8      db "┃                                                                                                      ┃", 0ah, 0
    walls9      db "┃                                                                                                      ┃", 0ah, 0
    walls10     db "┃                                                                                                      ┃", 0ah, 0
    walls11     db "┃                                                                                                      ┃", 0ah, 0
    walls12     db "┃                                                                                                      ┃", 0ah, 0
    walls13     db "┃                                                                                                      ┃", 0ah, 0
    walls14     db "┃                                                                                                      ┃", 0ah, 0
    walls15     db "┃                                                                                                      ┃", 0ah, 0
    walls16     db "┃                                                                                                      ┃", 0ah, 0
    walls17     db "┃                                                                                                      ┃", 0ah, 0
    walls18     db "┃                                                                                                      ┃", 0ah, 0
    walls20     db "┃                                                                                                      ┃", 0ah, 0
    walls21     db "┃                                                                                                      ┃", 0ah, 0
    walls22     db "┃                                                                                                      ┃", 0ah, 0
    walls23     db "┃                                                                                                      ┃", 0ah, 0
    walls24     db "┃                                                                                                      ┃", 0ah, 0
    walls25     db "┃                                                                                                      ┃", 0ah, 0
    walls26     db "┃                                                                                                      ┃", 0ah, 0
    walls27     db "┃                                                                                                      ┃", 0ah, 0
    walls28     db "┃                                                                                                      ┃", 0ah, 0
    walls29     db "┃                                                                                                      ┃", 0ah, 0
    walls30     db "┃                                                                                                      ┃", 0ah, 0
    walls31     db "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                db "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ ", 0




    ; Redesigned Unicode box for a 120x30 console
    UnicodeWallsPart1a BYTE "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    UnicodeWallsPart1b BYTE "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓", 0  
    UnicodeWallsPart2 BYTE  "┃                                                                                                                      ┃", 0
    UnicodeWallsPart3 BYTE  "┃                                                                                                                      ┃", 0
    UnicodeWallsPart4 BYTE  "┃                                                                                                                      ┃", 0
    UnicodeWallsPart5 BYTE  "┃                                                                                                                      ┃", 0
    UnicodeWallsPart6 BYTE  "┃                                                                                                                      ┃", 0
    UnicodeWallsPart7 BYTE  "┃                                                                                                                      ┃", 0
    UnicodeWallsPart8 BYTE  "┃                                                                                                                      ┃", 0
    UnicodeWallsPart9 BYTE  "┃                                                                                                                      ┃", 0
    UnicodeWallsPart10 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart11 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart12 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart13 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart14 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart15 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart16 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart17 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart18 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart19 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart20 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart21 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart22 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart23 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart24 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart25 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart26 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart27 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart28 BYTE "┃                                                                                                                      ┃", 0
    UnicodeWallsPart29a BYTE "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    UnicodeWallsPart29b BYTE "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛", 0 



    ; Box dimensions
    BOX_WIDTH      EQU 40
    BOX_HEIGHT     EQU 10
    BOX_TOP_LEFT_X EQU 40     ; (120 - 40) / 2
    BOX_TOP_LEFT_Y EQU 10     ; (30 - 10) / 2

        



gameover1_1 db " █▓▒░░     ██████   █████  ███    ███ ███████    ░░▒▓█", 0ah, 0
gameover1_2 db " █▓▒░░    ██       ██   ██ ████  ████ ██         ░░▒▓█", 0ah, 0
gameover1_3 db " █▓▒░░    ██   ███ ███████ ██ ████ ██ █████      ░░▒▓█", 0ah, 0
gameover1_4 db " █▓▒░░    ██    ██ ██   ██ ██  ██  ██ ██         ░░▒▓█", 0ah, 0
gameover1_5 db " █▓▒░░     ██████  ██   ██ ██      ██ ███████    ░░▒▓█", 0ah, 0
gameover1_5a db" █▓▒░░                                           ░░▒▓█", 0ah, 0
gameover2_1 db " █▓▒░░      ██████  ██    ██ ███████ ██████      ░░▒▓█", 0ah, 0
gameover2_2 db " █▓▒░░     ██    ██ ██    ██ ██      ██   ██     ░░▒▓█", 0ah, 0
gameover2_3 db " █▓▒░░     ██    ██ ██    ██ █████   ██████      ░░▒▓█", 0ah, 0
gameover2_4 db " █▓▒░░     ██    ██  ██  ██  ██      ██   ██     ░░▒▓█", 0ah, 0
gameover2_5 db " █▓▒░░      ██████    ████   ███████ ██   ██     ░░▒▓█", 0ah, 0


    wave_pattern db " ▂▃▄▅▆▇█▇▆▅▄▃▂ ", 0

box_pattern DB "    ╭━━━━━━━╮      ╭━━━━━━━╮", 0
box_line1   DB "   ╭╯       ╰╮    ╭╯       ╰╮", 0
box_line2   DB "  ╭╯         ╰╮  ╭╯         ╰╮", 0
box_line3   DB " ╭╯           ╰╮╭╯           ╰╮", 0
box_line4   DB "╯              ╰╯              ╰", 0

    ; Username buffer (already defined)
    ; username db 16 dup (?)

    ; Player sprites
    player_right BYTE "   ", 0
                 BYTE " O-", 0
                 BYTE "   ", 0

    player_left BYTE "   ", 0
                BYTE "-O ", 0
                BYTE "   ", 0

    player_up BYTE " | ", 0
              BYTE " O ", 0
              BYTE "   ", 0

    player_down BYTE "   ", 0
                BYTE " O ", 0
                BYTE " | ", 0

    player_upright BYTE "  /", 0
                   BYTE " O ", 0
                   BYTE "   ", 0

    player_upleft BYTE "\  ", 0
                  BYTE " O ", 0
                  BYTE "   ", 0

    player_downright BYTE "   ", 0
                     BYTE " O ", 0
                     BYTE "  \", 0

    player_downleft BYTE "   ", 0
                    BYTE " O ", 0
                    BYTE "/  ", 0

    ; Sprite Definitions
; Each sprite consists of 3 lines

sprites_up      BYTE " | ", 0ah, " O ", 0ah, "   ", 0
sprites_down    BYTE "   ", 0ah, " O ", 0ah, " | ", 0
sprites_left    BYTE "   ", 0ah, "-O ", 0ah, "   ", 0
sprites_right   BYTE "   ", 0ah, " O-", 0ah, "   ", 0
sprites_upleft   BYTE " / ", 0ah, "O  ", 0ah, "   ", 0
sprites_upright  BYTE " \\ ", 0ah, "  O", 0ah, "   ", 0
sprites_downleft BYTE "   ", 0ah, " O ", 0ah, " / ", 0
sprites_downright BYTE "   ", 0ah, " O ", 0ah, " \\", 0



COMMENT @

    ; Player's starting position
    xPos db 47
    yPos db 13

    xDir db 0
    yDir db 0

    ; Player direction and input
    inputChar db 0
    direction db "d"
    combo_count DWORD 0
    ;;high_score DWORD 0
    progress DWORD 0

    ; Colors


    ; Emitter properties
    emitter_symbol db "#"
    emitter_row db 0
    emitter_col db 1

; Fireball properties
    fire_symbol db '*'    ; Symbol to represent the fireball
    fire_color db 14      ; Color code for the fireball (yellow)
    fire_col db 0         ; Fireball's current column position
    fire_row db 0         ; Fireball's current row position

 ; Cursor positions for drawing
    cursor_col db 0
    cursor_row db 0

    ; Wall boundaries
    LEFT_WALL_BOUNDARY   db 0
    RIGHT_WALL_BOUNDARY  db 103
    UPPER_WALL_BOUNDARY  db 0
    LOWER_WALL_BOUNDARY  db 28

    ; Input character
    ;inputChar db 0

     ; Strings for display
    score_text db "Score: ", 0
    level_text db "LEVEL ", 0

    ; Game variables
    game_score db 0
    game_lives db 3
    game_levelInfo db 1

    ; Counters
    counter1 db 0
    counter2 db 0

; --------------------------    BALLS    -------------------------

    ; Update the ball structure definition
    BallStruct STRUCT
        xPos      BYTE ?    ; X position
        yPos      BYTE ?    ; Y position 
        pathIndex DWORD ?   ; Current position in path
        active    BYTE ?    ; Is ball active
        color     BYTE ?    ; Ball color
    BallStruct ENDS

    

     PATH_LENGTH EQU 225  ; Number of positions in the path

     MAX_BALLS EQU 30

; X coordinates array (move from right to left in a curve)








    ; Time between ball spawns
    SPAWN_DELAY EQU 50
    last_spawn_time DWORD 0
    spawn_counter DWORD 0
    game_over_flag db 0
    pause_flag db 0   ; Flag to track pause state
    GAME_SPEED_DELAY EQU 50
path_counter db PATH_LENGTH DUP(0)  ; Track balls passed through each position
    screen_buffer db 4000 dup(?) ; Buffer to store screen contents
    screen_attrs  db 4000 dup(?) ; Buffer to store screen attributes
        ; Array of 30 balls using the updated BallStruct
    balls BallStruct MAX_BALLS DUP (<>)

    ; Define BallStruct field offsets
    Ball_xPos     EQU 0   ; Offset for xPos within BallStruct
    Ball_yPos     EQU 1   ; Offset for yPos within BallStruct
    Ball_pathIndex EQU 2  ; Offset for pathIndex within BallStruct
    Ball_active   EQU 6   ; Offset for active flag within BallStruct
    Ball_color    EQU 7   ; Offset for color within BallStruct


    

    ; Color for static path
    DIM_COLOR EQU 8      ; Gray color
    ACTIVE_COLOR EQU 10  ; Light Green for moving balls





;--------------------------------------------------------------------------------

filename db "highscores.txt", 0
filehandle DWORD ?
buffer_size = 100
writebuffer db buffer_size DUP(?)

readbuffer db buffer_size DUP(?)
scoreStr db "Score: ", 0
levelStr db " Level: ", 0

tempStr db 16 DUP(0)

@


.CODE


;//////////   MUSIC IMPLEMENTATION   //////////
PlayMenuMusic PROC
    INVOKE PlaySound, OFFSET menuMusic, NULL, SND_FILENAME OR SND_ASYNC OR SND_LOOP
    ret
PlayMenuMusic ENDP

StopMusic PROC
    INVOKE PlaySound, NULL, NULL, NULL
    ret
StopMusic ENDP




SetUTF8Console PROC
    ; Set the console code page to UTF-8
    push CP_UTF8
    call SetConsoleOutputCP@4
    ret
SetUTF8Console ENDP




PrintBox PROC
    mov edx, OFFSET UnicodeWallsPart1a
    call WriteString

    mov edx, OFFSET UnicodeWallsPart2
    call WriteString

    mov edx, OFFSET UnicodeWallsPart3
    call WriteString

    mov edx, OFFSET UnicodeWallsPart4
    call WriteString

    mov edx, OFFSET UnicodeWallsPart5
    call WriteString

    mov edx, OFFSET UnicodeWallsPart6
    call WriteString

    mov edx, OFFSET UnicodeWallsPart7
    call WriteString

    mov edx, OFFSET UnicodeWallsPart8
    call WriteString

    mov edx, OFFSET UnicodeWallsPart9
    call WriteString

    mov edx, OFFSET UnicodeWallsPart10
    call WriteString

    mov edx, OFFSET UnicodeWallsPart11
    call WriteString

    mov edx, OFFSET UnicodeWallsPart12
    call WriteString

    mov edx, OFFSET UnicodeWallsPart13
    call WriteString

    mov edx, OFFSET UnicodeWallsPart14
    call WriteString

    mov edx, OFFSET UnicodeWallsPart15
    call WriteString

    mov edx, OFFSET UnicodeWallsPart16
    call WriteString

    mov edx, OFFSET UnicodeWallsPart17
    call WriteString

    mov edx, OFFSET UnicodeWallsPart18
    call WriteString

    mov edx, OFFSET UnicodeWallsPart19
    call WriteString

    mov edx, OFFSET UnicodeWallsPart20
    call WriteString

    mov edx, OFFSET UnicodeWallsPart21
    call WriteString

    mov edx, OFFSET UnicodeWallsPart22
    call WriteString

    mov edx, OFFSET UnicodeWallsPart23
    call WriteString

    mov edx, OFFSET UnicodeWallsPart24
    call WriteString

    mov edx, OFFSET UnicodeWallsPart25
    call WriteString

    mov edx, OFFSET UnicodeWallsPart26
    call WriteString

    mov edx, OFFSET UnicodeWallsPart27
    call WriteString

    mov edx, OFFSET UnicodeWallsPart27
    call WriteString

    mov edx, OFFSET UnicodeWallsPart28
    call WriteString

    mov edx, OFFSET UnicodeWallsPart29a
    call WriteString

    ret
PrintBox ENDP

PrintWave PROC
    push eax
    push edx

    ; Set color (e.g., cyan)
    mov eax, cyan
    call SetTextColor

    mov dl, 10      ; X position
    mov dh, 24      ; Y position 
    call Gotoxy

    mov edx, OFFSET wave_pattern
    call WriteString

    mov dl, 90      ; X position
    mov dh, 24      ; Y position 
    call Gotoxy

    mov edx, OFFSET wave_pattern
    call WriteString


    mov eax, white
    call SetTextColor

    pop edx
    pop eax
    ret
PrintWave ENDP

PrintWings PROC
    push eax
    push edx

    ; Set color (e.g., cyan)
    mov eax, cyan
    call SetTextColor

    ; Print first line (Left box)
    mov dl, 5      ; X position
    mov dh, 20      ; Y position
    call Gotoxy
    mov edx, OFFSET box_pattern
    call WriteString

    ; Print first line (Right box)
    mov dl, 80      ; X position
    mov dh, 20     ; Y position
    call Gotoxy
    mov edx, OFFSET box_pattern
    call WriteString

    ; Print second line
    mov dl, 10      ; X position
    mov dh, 21      ; Y position
    call Gotoxy
    mov edx, OFFSET box_line1
    call WriteString

    mov dl, 90      ; X position
    mov dh, 21      ; Y position
    call Gotoxy
    mov edx, OFFSET box_line1
    call WriteString

    ; Print third line
    mov dl, 10
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET box_line2
    call WriteString

    mov dl, 90
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET box_line2
    call WriteString

    ; Print fourth line
    mov dl, 10
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET box_line3
    call WriteString

    mov dl, 90
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET box_line3
    call WriteString

    ; Print fifth line
    mov dl, 10
    mov dh, 24
    call Gotoxy
    mov edx, OFFSET box_line4
    call WriteString

    mov dl, 90
    mov dh, 24
    call Gotoxy
    mov edx, OFFSET box_line4
    call WriteString

    ; Reset text color to white
    mov eax, white
    call SetTextColor

    pop edx
    pop eax
    ret
PrintWings ENDP


drawMenu PROC

    call PlayMenuMusic


    call clrscr

    call printbox

    mov eax, green
    call settextcolor

    mov dl, 20
    mov dh, 4
    call gotoxy

    mov edx, offset zumablitz1
    call writestring

    mov eax, 100
    call delay

    mov dl, 20
    mov dh, 5
    call gotoxy

    mov edx, offset zumablitz2
    call writestring

    mov eax, 100
    call delay

    mov dl, 20
    mov dh, 6
    call gotoxy

    mov edx, offset zumablitz3
    call writestring

    mov eax, 100
    call delay

    mov dl, 20
    mov dh, 7
    call gotoxy

    mov edx, offset zumablitz4
    call writestring

    mov eax, 100
    call delay

    mov dl, 20
    mov dh, 8
    call gotoxy

    mov edx, offset zumablitz5
    call writestring

    mov eax, 100
    call delay

    mov dl, 20
    mov dh, 9
    call gotoxy

    mov edx, offset zumablitz6
    call writestring

    mov eax, 100
    call delay

    mov dl, 20
    mov dh, 10
    call gotoxy

    mov edx, offset zumablitz7
    call writestring

    call PrintWave

    mov eax, 100
    call delay

    mov eax, white
    call settextcolor

    mov dl, 50
    mov dh, 14
    call gotoxy

    mov eax, 100
    call delay


ret
drawMenu ENDP


askforChoice PROC
    mov edx, offset choice1
    call writestring

    mov dl, 50
    mov dh, 16
    call gotoxy
    mov edx, offset choice2
    call writestring

    mov dl, 50
    mov dh, 18
    call gotoxy
    mov edx, offset choice3
    call writestring

    mov dl, 50
    mov dh, 20
    call gotoxy
    mov edx, offset choice4
    call writestring

    ;mov dl, 45
    ;mov dh, 23
    ;call gotoxy
    ;mov edx, offset choiceask
    ;call writestring

input_loop:
    ; Use ReadKey instead of ReadInt
    call ReadKey
    
    cmp al, '1'
    je choice_1
    cmp al, '2'
    je choice_2
    cmp al, '3'
    je choice_3
    cmp al, '4'
    je choice_4
    jmp input_loop

choice_1:
    mov eax, 1
    ret
choice_2:
    mov eax, 2
    ret
choice_3:
    mov eax, 3
    ret
choice_4:
    mov eax, 4
    ret

askforChoice ENDP


GetPlayerName PROC
    pushad



    ; Clear the screen
    call clrscr

    mov eax, red
    call settextcolor

    call printbox

    ; Set text color for the input box (e.g., White)
    mov eax, white + (black * 16)
    call SetTextColor

    ; Draw the top border of the box
    mov dl, BOX_TOP_LEFT_X    ; X position
    mov dh, BOX_TOP_LEFT_Y    ; Y position
    call gotoxy
    mov edx, OFFSET box_top
    call WriteString

    ; Draw the side borders of the box
    mov ecx, BOX_HEIGHT - 2   ; Number of side lines to draw
    mov esi, OFFSET box_side

draw_box_middle:
    mov dl, BOX_TOP_LEFT_X    ; X position
    mov dh, BOX_TOP_LEFT_Y
    add dh, 1                  ; Move down one line
    call gotoxy
    mov edx, esi
    call WriteString
    inc dh                     ; Move to next line
    loop draw_box_middle

    ; Draw the bottom border of the box
    mov dl, BOX_TOP_LEFT_X    ; X position
    mov dh, BOX_TOP_LEFT_Y
    add dh, BOX_HEIGHT - 1    ; Y position
    call gotoxy
    mov edx, OFFSET box_bottom
    call WriteString

    ; Position cursor for name input
    mov dl, BOX_TOP_LEFT_X + 2
    mov dh, BOX_TOP_LEFT_Y + (BOX_HEIGHT / 2)
    call Gotoxy

    mov dl, BOX_TOP_LEFT_X +12
    mov dh, BOX_TOP_LEFT_Y + 3
    call Gotoxy

    ; Display prompt
    mov edx, OFFSET name_prompt
    call WriteString
    
    call PrintWave

    mov dl, BOX_TOP_LEFT_X +12
    mov dh, BOX_TOP_LEFT_Y + 5
    call Gotoxy

    ; Read the username (max 15 chars)
    mov edx, OFFSET username
    mov ecx, 15
    call ReadString

    popad
    ret
GetPlayerName ENDP


SaveHighScore PROC
    pushad
    
    ; Create/Open file for append
    mov edx, OFFSET filename
    call CreateOutputFile
    mov filehandle, eax
    
    ; Check if file opened successfully
    cmp eax, INVALID_HANDLE_VALUE
    je save_exit
    
    ; Clear buffer
    mov edi, OFFSET writebuffer
    mov ecx, buffer_size
    mov al, 0
    rep stosb
    
    ; Start writing to buffer
    mov edi, OFFSET writebuffer
    
    ; Copy username
    mov esi, OFFSET username
copy_name:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    cmp al, 0
    jne copy_name
    
    ; Add separator
    dec edi                 ; Back up over null
    mov BYTE PTR [edi], ':'
    inc edi
    mov BYTE PTR [edi], ' '
    inc edi
    
    ; Add score directly (single digit)
    mov al, score
    add al, '0'            ; Convert to ASCII
    mov [edi], al
    inc edi
    
    ; Add level info
    mov BYTE PTR [edi], ' '
    inc edi
    mov BYTE PTR [edi], 'L'
    inc edi
    mov BYTE PTR [edi], ':'
    inc edi
    mov BYTE PTR [edi], ' '
    inc edi
    
    ; Add level number
    mov al, game_levelInfo
    add al, '0'            ; Convert to ASCII
    mov [edi], al
    inc edi
    
    ; Add newline
    mov BYTE PTR [edi], 0Dh    ; CR
    inc edi
    mov BYTE PTR [edi], 0Ah    ; LF
    inc edi
    
    ; Write to file
    mov edx, OFFSET writebuffer
    mov ecx, edi
    sub ecx, OFFSET writebuffer
    mov eax, filehandle
    call WriteToFile
    
    ; Close file
    mov eax, filehandle
    call CloseFile
    
save_exit:
    popad
    ret
SaveHighScore ENDP


DisplayHighScores PROC
    pushad
    
    call clrscr
    
    ; Display title
    mov edx, OFFSET hsstring
    call WriteString
    call Crlf
    call Crlf
    
    ; Open file for reading
    mov edx, OFFSET filename
    call OpenInputFile      ; Use Irvine's OpenInputFile
    mov filehandle, eax
    
    ; Read and display scores
read_loop:
    mov edx, OFFSET readbuffer
    mov ecx, buffer_size
    call ReadFromFile      ; Use Irvine's ReadFromFile
    jc done_reading        ; If carry flag set, end of file
    
    mov edx, OFFSET readbuffer
    call WriteString       ; Display the scores
    jmp read_loop
    
done_reading:
    mov eax, filehandle
    call CloseFile
    
    ; Wait for key press
    mov edx, OFFSET exitstring
    call WriteString
    call ReadChar
    
    popad
    ret
DisplayHighScores ENDP

displayInstructions PROC
    call clrscr
    call PrintBox
    
    ; Title animation
    mov eax, yellow
    call SetTextColor
    mov dl, 45
    mov dh, 2
    call Gotoxy
    mWrite "GAME INSTRUCTIONS"
    mov eax, 200
    call Delay

    ; Movement Controls
    mov eax, white
    call SetTextColor
    mov dl, 35
    mov dh, 5
    call Gotoxy
    mWrite "【 Movement Controls 】"
    mov eax, 100
    call Delay
    
    mov eax, cyan
    call SetTextColor
    mov dl, 35
    mov dh, 7
    call Gotoxy
    mWrite "Q - Rotate Left    W - Move Up    E - Rotate Right"
    mov eax, 100
    call Delay
    
    mov dl, 35
    mov dh, 8
    call Gotoxy
    mWrite "A - Move Left                     D - Move Right"
    mov eax, 100
    call Delay
    
    mov dl, 35
    mov dh, 9
    call Gotoxy
    mWrite "Z - Rotate Down    X - Move Down  C - Rotate Right"
    mov eax, 100
    call Delay
    
    ; Shooting Instructions
    mov eax, green
    call SetTextColor
    mov dl, 35
    mov dh, 12
    call Gotoxy
    mWrite "【 Shooting Mechanics 】"
    mov eax, 100
    call Delay
    
    mov eax, white
    call SetTextColor
    mov dl, 35
    mov dh, 13
    call Gotoxy
    mWrite "► SPACEBAR - Fire balls at the chain"
    mov dl, 35
    mov dh, 14
    call Gotoxy
    mWrite "► Match 3 or more balls of same color to destroy them"
    mov dl, 35
    mov dh, 15
    call Gotoxy
    mWrite "► Chain reactions give bonus points!"
    mov eax, 100
    call Delay
    
    ; Game Rules
    mov eax, red
    call SetTextColor
    mov dl, 35
    mov dh, 18
    call Gotoxy
    mWrite "【 Game Rules 】"
    mov eax, 100
    call Delay
    
    mov eax, white
    call SetTextColor
    mov dl, 35
    mov dh, 19
    call Gotoxy
    mWrite "► Stop balls before they reach the end"
    mov dl, 35
    mov dh, 20
    call Gotoxy
    mWrite "► Each level increases ball speed"
    mov dl, 35
    mov dh, 21
    call Gotoxy
    mWrite "► Press P to pause the game"
    mov eax, 100
    call Delay
    
    ; Navigation Options
    mov eax, yellow
    call SetTextColor
    mov dl, 35
    mov dh, 24
    call Gotoxy
    mWrite "Press 1 to START GAME"
    mov dl, 35
    mov dh, 25
    call Gotoxy
    mWrite "Press 2 for MAIN MENU"
    mov eax, 200
    call Delay

input_loop:
    call ReadKey
    
    cmp al, '1'
    je start_game
    cmp al, '2'
    je return_menu
    jmp input_loop

start_game:
    mov eax, 1          ; Return 1 to indicate start game
    ret                 ; Return to main              
    
return_menu:
    call main            ; Return to main menu
    ret

displayInstructions ENDP


DisplayLevels PROC
    ; Display all three levels
    mov dl, 30
    mov dh, 5
    call gotoxy
    
    ; Level 1 ASCII
    mov edx, OFFSET level11
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 6
    call gotoxy
    mov edx, OFFSET level12
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 7
    call gotoxy
    mov edx, OFFSET level13
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 8
    call gotoxy
    mov edx, OFFSET level14
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 9
    call gotoxy
    mov edx, OFFSET level15
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 10
    call gotoxy
    mov edx, OFFSET level16
    call writestring
    
    ; Level 2 ASCII
    mov dl, 30
    mov dh, 13
    call gotoxy
    mov edx, OFFSET level21
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 14
    call gotoxy
    mov edx, OFFSET level22
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 15
    call gotoxy
    mov edx, OFFSET level23
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 16
    call gotoxy
    mov edx, OFFSET level24
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 17
    call gotoxy
    mov edx, OFFSET level25
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 18
    call gotoxy
    mov edx, OFFSET level26
    call writestring
    
    ; Level 3 ASCII
    mov dl, 30
    mov dh, 21
    call gotoxy
    mov edx, OFFSET level31
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 22
    call gotoxy
    mov edx, OFFSET level32
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 23
    call gotoxy
    mov edx, OFFSET level33
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 24
    call gotoxy
    mov edx, OFFSET level34
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 25
    call gotoxy
    mov edx, OFFSET level35
    call writestring

    mov edx, 0
    mov dl, 30
    mov dh, 26
    call gotoxy
    mov edx, OFFSET level36
    call writestring

    ret
DisplayLevels ENDP

; Update gameP to use new procedure name
gameP PROC
    ; Initial setup
    mov ebx, 1  ; Track current level (1,2,3)
    
show_levels:
    call clrscr
    call PrintBox    ; Draw border
    
    ; Display title centered
    mov eax, yellow
    call SetTextColor
    mov dl, 52       ; Centered X position
    mov dh, 2
    call Gotoxy
    mWrite "SELECT LEVEL"
    
    ; Display Level 1
    mov dl, 25
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET level1_1
    cmp ebx, 1
    je highlight_level1
    mov eax, white
    jmp print_level1
highlight_level1:
    mov eax, yellow
print_level1:
    call SetTextColor
    call WriteString
    
    ; Continue Level 1 (5 lines)
    mov dl, 25
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET level1_2
    call WriteString
    
    mov dl, 25
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET level1_3
    call WriteString
    
    mov dl, 25
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET level1_4
    call WriteString

    mov dl, 25
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET level1_5
    call WriteString
    
    ; Display Level 2
    mov dl, 25
    mov dh, 13       ; Adjusted Y position
    call Gotoxy
    mov edx, OFFSET level2_1
    cmp ebx, 2
    je highlight_level2
    mov eax, white
    jmp print_level2
highlight_level2:
    mov eax, yellow
print_level2:
    call SetTextColor
    call WriteString
    
    ; Continue Level 2 (5 lines)
    mov dl, 25
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET level2_2
    call WriteString
    
    mov dl, 25
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET level2_3
    call WriteString
    
    mov dl, 25
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET level2_4
    call WriteString

    mov dl, 25
    mov dh, 17
    call Gotoxy
    mov edx, OFFSET level2_5
    call WriteString
    
    ; Display Level 3
    mov dl, 25
    mov dh, 21       ; Adjusted Y position
    call Gotoxy
    mov edx, OFFSET level3_1
    cmp ebx, 3
    je highlight_level3
    mov eax, white
    jmp print_level3
highlight_level3:
    mov eax, yellow
print_level3:
    call SetTextColor
    call WriteString
    
    ; Continue Level 3 (5 lines)
    mov dl, 25
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET level3_2
    call WriteString
    
    mov dl, 25
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET level3_3
    call WriteString
    
    mov dl, 25
    mov dh, 24
    call Gotoxy
    mov edx, OFFSET level3_4
    call WriteString

    mov dl, 25
    mov dh, 25
    call Gotoxy
    mov edx, OFFSET level3_5
    call WriteString
    

COMMENT @

    ; Instructions
    mov eax, white
    call SetTextColor
    mov dl, 38
    mov dh, 27
    call Gotoxy
    mWrite "Press 1-3 to select level and Enter"

@
    
get_input:
    call ReadChar
    
    ; Handle number keys
    cmp al, '1'
    jne try_2
    mov ebx, 1
    jmp show_levels
    
try_2:
    cmp al, '2'
    jne try_3
    mov ebx, 2
    jmp show_levels
    
try_3:
    cmp al, '3'
    jne try_enter
    mov ebx, 3
    jmp show_levels
    
try_enter:
    cmp al, 13        ; Check for Enter key
    je select_level
    jmp get_input
    
select_level:
    mov temp, bl      ; Store selected level
    ret
    
gameP ENDP




PauseScreen PROC
    pushad
    mov ebx, 1      ; Track selected option (1,2,3)
    
show_pause_menu:
    call clrscr
    call PrintBox    ; Draw border

    ; Display title centered
    mov eax, yellow
    call SetTextColor
    mov dl, 52
    mov dh, 2
    call Gotoxy
    mWrite "GAME PAUSED"
    
    ; Display Resume option with ASCII art
    mov dl, 25
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET pause1_1
    cmp ebx, 1
    je highlight_resume
    mov eax, white
    jmp print_resume
highlight_resume:
    mov eax, yellow
print_resume:
    call SetTextColor
    call WriteString
    
    ; Continue Resume ASCII (5 lines)
    mov dl, 25
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET pause1_2
    call WriteString
    
    mov dl, 25
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET pause1_3
    call WriteString
    
    mov dl, 25
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET pause1_4
    call WriteString
    
    mov dl, 25
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET pause1_5
    call WriteString
    
    ; Display Restart option
    mov dl, 25
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET pause2_1
    cmp ebx, 2
    je highlight_restart
    mov eax, white
    jmp print_restart
highlight_restart:
    mov eax, yellow
print_restart:
    call SetTextColor
    call WriteString
    
    ; Continue Restart ASCII (5 lines)
    mov dl, 25
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET pause2_2
    call WriteString
    
    mov dl, 25
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET pause2_3
    call WriteString
    
    mov dl, 25
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET pause2_4
    call WriteString
    
    mov dl, 25
    mov dh, 17
    call Gotoxy
    mov edx, OFFSET pause2_5
    call WriteString
    
    ; Display Exit option
    mov dl, 25
    mov dh, 21
    call Gotoxy
    mov edx, OFFSET pause3_1
    cmp ebx, 3
    je highlight_exit
    mov eax, white
    jmp print_exit
highlight_exit:
    mov eax, yellow
print_exit:
    call SetTextColor
    call WriteString
    
    ; Continue Exit ASCII (5 lines)
    mov dl, 25
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET pause3_2
    call WriteString
    
    mov dl, 25
    mov dh, 23
    call Gotoxy
    mov edx, OFFSET pause3_3
    call WriteString
    
    mov dl, 25
    mov dh, 24
    call Gotoxy
    mov edx, OFFSET pause3_4
    call WriteString
    
    mov dl, 25
    mov dh, 25
    call Gotoxy
    mov edx, OFFSET pause3_5
    call WriteString
    
    COMMENT @

    ; Instructions
    mov eax, white
    call SetTextColor
    mov dl, 38
    mov dh, 27
    call Gotoxy
    mWrite "Press 1-3 to select option"
    
    mov dl, 38
    mov dh, 28
    call Gotoxy
    mov eax, yellow
    call SetTextColor
    mWrite "Selected: "
    mov al, bl
    add al, '0'
    call WriteChar
    
    mov dl, 38
    mov dh, 29
    call Gotoxy
    mov eax, white
    call SetTextColor
    mWrite "Press Enter to confirm"

@
    
pause_input:
    call ReadChar
    
    cmp al, '1'
    jne try_pause2
    mov ebx, 1
    jmp show_pause_menu
    
try_pause2:
    cmp al, '2'
    jne try_pause3
    mov ebx, 2
    jmp show_pause_menu
    
try_pause3:
    cmp al, '3'
    jne try_pause_enter
    mov ebx, 3
    jmp show_pause_menu
    
try_pause_enter:
    cmp al, 13
    je select_pause_option
    jmp pause_input
    
select_pause_option:
    cmp ebx, 1
    je resume_game
    cmp ebx, 2
    je restart_game
    cmp ebx, 3
    je exit_game

resume_game:
    ; Redraw entire game state
    call clrscr
    call DrawWalls
    call DrawStaticPath
    
    ; Redraw all balls
    mov ecx, MAX_BALLS
    xor esi, esi
redraw_balls:
    push ecx
    mov al, BYTE PTR [balls + esi*8 + Ball_active]
    cmp al, 1
    jne skip_ball
    call DrawBall
skip_ball:
    inc esi
    pop ecx
    loop redraw_balls

    ; Redraw UI elements
    call DisplayControls
    call DisplayHighScore
    call DisplayTips
    call DisplayStats
    ;call DisplayArt
    call DisplayPlayerName
    call PrintPlayer
    
    mov BYTE PTR [pause_flag], 0
    popad
    ret

restart_game:
    popad
    call InitialiseScreen
    ret

exit_game:
    INVOKE ExitProcess, 0

PauseScreen ENDP





SaveScreenState PROC
    pushad
    
    ; Save current screen contents and attributes
    mov edi, OFFSET screen_buffer
    mov esi, OFFSET screen_attrs
    mov ecx, 2000  ; 80x25 screen size
    
    ; Save character and attribute for each position
    mov dx, 0      ; Start at (0,0)
save_loop:
    push ecx
    call Gotoxy
    
    ; Get character at current position by reading directly
    call ReadChar  ; Irvine32's ReadChar for non-blocking read
    mov [edi], al  ; Save character
    inc edi
    
    ; Save current text color as attribute
    call GetTextColor ; Irvine32's GetTextColor 
    mov [esi], al  ; Save attribute
    inc esi
    
    inc dl         ; Move to next column
    cmp dl, 80     ; Check if end of row
    jne save_continue
    mov dl, 0      ; Reset column
    inc dh         ; Move to next row
    
save_continue:
    pop ecx
    loop save_loop
    
    popad
    ret
SaveScreenState ENDP







RestoreScreenState PROC
    pushad
    
    ; Restore screen contents and attributes
    mov esi, OFFSET screen_buffer
    mov edi, OFFSET screen_attrs
    mov ecx, 2000  ; 80x25 screen size
    
    ; Restore character and attribute for each position
    mov dx, 0      ; Start at (0,0)
restore_loop:
    push ecx
    call Gotoxy
    
    mov al, [esi]  ; Get saved character
    push eax
    mov al, [edi]  ; Get saved attribute
    call SetTextColor
    pop eax
    call WriteChar ; Restore character with attribute
    
    inc esi
    inc edi
    
    inc dl         ; Move to next column
    cmp dl, 80     ; Check if end of row
    jne restore_continue
    mov dl, 0      ; Reset column
    inc dh         ; Move to next row
    
restore_continue:
    pop ecx
    loop restore_loop
    
    popad
    ret
RestoreScreenState ENDP






CheckBallCollision PROC
    ; Input: dl = x position, dh = y position
    ; Output: al = 1 if collision, 0 if no collision
    ; ebx = index of hit ball
    pushad                  ; Preserve all registers
    
    xor ebx, ebx           ; Ball index = 0
    mov ecx, MAX_BALLS     ; Check all balls
    
check_balls:
    ; Check if ball is active
    cmp BYTE PTR [balls + ebx*8 + Ball_active], 1
    jne next_ball
    
    ; Compare positions
    mov al, BYTE PTR [balls + ebx*8 + Ball_xPos]
    cmp al, dl
    jne next_ball
    mov al, BYTE PTR [balls + ebx*8 + Ball_yPos]
    cmp al, dh
    jne next_ball
    
    ; Found collision
    mov [esp + 28], ebx    ; Store ball index for return
    mov BYTE PTR [esp + 24], 1  ; Set al = 1 for return
    popad
    mov al, 1              ; Set collision found
    ret
    
next_ball:
    inc ebx
    loop check_balls
    
    ; No collision found
    popad
    xor al, al            ; Set no collision
    ret
CheckBallCollision ENDP





UpdateScore PROC
    ; Input: al = 1 if ball hit, 0 if just fired
    push eax
    
    ; Update score based on hit type
    cmp al, 1
    je ball_hit
    
    ; Just fired - add 1 point
    inc BYTE PTR [score]
    jmp check_high_score
    
ball_hit:
    ; Hit ball - add 5 points
    add BYTE PTR [score], 5
    
check_high_score:
    ; Update high score if current score is higher
    movzx eax, BYTE PTR [score]
    cmp eax, high_score
    jle score_updated
    mov high_score, eax
    
score_updated:
    pop eax
    ret
UpdateScore ENDP






FireBall PROC
    ; Increment score once for firing
    inc BYTE PTR [score]
    call UpdateScoreDisplay   ; Update score display immediately

    ; Initialize fireball direction based on player's direction
    ; Set initial fireball position based on player's position
    mov dl, xPos     ; Fire column starts at the player's X position
    mov dh, yPos     ; Fire row starts at the player's Y position


    add dl, 1        
    add dh, 1

    mov fire_col, dl  ; Save the fire column position
    mov fire_row, dh  ; Save the fire row position

    ; Determine direction of fireball based on player direction
    mov al, direction
    cmp al, 'w'
    je fire_up

    cmp al, 'x'
    je fire_down

    cmp al, 'a'
    je fire_left

    cmp al, 'd'
    je fire_right

    cmp al, 'q'
    je fire_upleft

    cmp al, 'e'
    je fire_upright

    cmp al, 'z'
    je fire_downleft

    cmp al, 'c'
    je fire_downright

    jmp end_fire   ; If none of the directions match, end fire

fire_up:
    mov xDir, 0
    mov yDir, -1
    jmp start_fire

fire_down:
    mov xDir, 0
    mov yDir, 1
    jmp start_fire

fire_left:
    mov xDir, -1
    mov yDir, 0
    jmp start_fire

fire_right:
    mov xDir, 1
    mov yDir, 0
    jmp start_fire

fire_upleft:
    mov xDir, -1
    mov yDir, -1
    jmp start_fire

fire_upright:
    mov xDir, 1
    mov yDir, -1
    jmp start_fire

fire_downleft:
    mov xDir, -1
    mov yDir, 1
    jmp start_fire

fire_downright:
    mov xDir, 1
    mov yDir, 1
    jmp start_fire

start_fire:
    ; Adjust initial position to be just outside the player sprite
    add dl, xDir
    add dh, yDir

fire_loop:
    ; Check for wall boundaries
    mov al, BYTE PTR [LEFT_WALL_BOUNDARY]
    cmp dl, al
    jle end_fire

    mov al, BYTE PTR [RIGHT_WALL_BOUNDARY]
    cmp dl, al
    jge end_fire

    mov al, BYTE PTR [UPPER_WALL_BOUNDARY]
    cmp dh, al
    jle end_fire

    mov al, BYTE PTR [LOWER_WALL_BOUNDARY]
    cmp dh, al
    jge end_fire

    ; Increment score for firing
    ;inc BYTE PTR [score]
    ;call UpdateScoreDisplay   ; Update score on screen

    ; Move cursor to new position
    mov cursor_col, dl
    mov cursor_row, dh
    call GoToXY

    ; Draw fire symbol
    movzx eax, fire_color
    call SetTextColor
    mov al, fire_symbol
    call WriteChar

    ; Check for collision with balls
    push edx                ; Save current position
    call CheckBallCollision
    pop edx                ; Restore position
    cmp al, 1
    je handle_hit

    ; Delay for animation effect
    mov eax, FIREBALL_DELAY
    call Delay

    ; Erase previous position
    call GoToXY
    
    ; Check if current position is on path
    push edx            
    call IsPathPosition
    pop edx             
    cmp al, 1
    je redraw_path

    ; Not on path, just print space
    mov al, ' '
    jmp draw_char

handle_hit:
    ; Ball hit - update score and deactivate ball
    mov BYTE PTR [balls + ebx*8 + Ball_active], 0
    add BYTE PTR [score], 5    ; Add 5 points for hitting ball
    call UpdateScoreDisplay    ; Update score display

    ; Redraw path marker at collision point
    push edx            ; Save current position
    mov eax, DIM_COLOR
    call SetTextColor
    call GoToXY        ; Position is still in dl, dh
    mov al, 'O'        ; Path marker character
    call WriteChar
    pop edx            ; Restore position

    jmp end_fire

redraw_path:
    ; On path, redraw path marker
    mov eax, DIM_COLOR
    call SetTextColor
    mov al, 'O'

draw_char:
    call WriteChar

    ; Update position
    add dl, xDir
    add dh, yDir
    jmp fire_loop

end_fire:
    ret
FireBall ENDP




UpdateScoreDisplay PROC
    pushad
    
    ; Save cursor position
    mov dl, cursor_col
    mov dh, cursor_row
    push edx
    
    ; Move to score position
    mov dl, 105
    mov dh, 2
    call Gotoxy
    
    ; Display "Score: "
    mWrite "Score: "
    
    ; Display score in blue
    mov eax, Blue + (black * 16)
    call SetTextColor
    movzx eax, BYTE PTR [score]
    call WriteDec
    
    ; Restore text color
    mov eax, white + (black * 16)
    call SetTextColor
    
    ; Restore cursor position
    pop edx
    mov cursor_col, dl
    mov cursor_row, dh
    call Gotoxy
    
    popad
    ret
UpdateScoreDisplay ENDP



DisplayControls PROC
    mov dl, 105
    mov dh, 5
    call Gotoxy

    ; Title in bright white
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mWrite "Controls:"

    ; Basic controls in cyan
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    inc dh
    call Gotoxy
    mWrite "W - Up"
    inc dh
    call Gotoxy
    mWrite "A - Left"
    inc dh
    call Gotoxy
    mWrite "S - Down"
    inc dh
    call Gotoxy
    mWrite "D - Right"
    inc dh
    call Gotoxy
    
    ; Special controls in light red for emphasis
    mov eax, lightRed + (black * 16)
    call SetTextColor
    mWrite "Space - Shoot"
    inc dh
    call Gotoxy
    mWrite "P - Pause Game"

    mov eax, white + (black * 16)
    call SetTextColor
    ret
DisplayControls ENDP



DisplayHighScore PROC
    mov dl, 105
    mov dh, 12
    call Gotoxy

    ; Title in gold
    mov eax, yellow + (black * 16)  
    call SetTextColor
    mWrite "High Score:"
    
    ; Score in bright green
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    inc dh
    call Gotoxy
    mov eax, high_score
    call WriteDec

    mov eax, white + (black * 16)
    call SetTextColor
    ret
DisplayHighScore ENDP



DisplayTips PROC
    mov dl, 105
    mov dh, 15
    call Gotoxy

    ; Title in bright white
    mov eax, lightGray + (black * 16)
    call SetTextColor  
    mWrite "Tip:"

    ; Tips in light blue
    mov eax, lightBlue + (black * 16)
    call SetTextColor
    inc dh
    call Gotoxy
    mWrite "Match colors"
    inc dh
    call Gotoxy
    mWrite "for combos!"

    mov eax, white + (black * 16)
    call SetTextColor
    ret
DisplayTips ENDP



DisplayStats PROC
    mov dl, 105
    mov dh, 19
    call Gotoxy

    ; Title in bright white
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mWrite "Combo Count:"

    ; Count in bright magenta
    mov eax, lightMagenta + (black * 16)
    call SetTextColor
    inc dh
    call Gotoxy
    mov eax, combo_count
    call WriteDec

    mov eax, white + (black * 16)
    call SetTextColor
    ret
DisplayStats ENDP



DisplayArt PROC
    mov dl, 105
    mov dh, 22
    call Gotoxy

    ; Art in bright cyan
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    mWrite " /\_/\ "
    inc dh
    call Gotoxy
    mWrite "( o.o )"
    inc dh
    call Gotoxy
    mWrite " > ^ < "

    mov eax, white + (black * 16)
    call SetTextColor
    ret
DisplayArt ENDP



DisplayObjective PROC
    mov dl, 105
    mov dh, 26
    call Gotoxy

    ; Title in bright white 
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mWrite "Objective:"

    ; Text in light green
    mov eax, lightGreen + (black * 16)
    call SetTextColor
    inc dh
    call Gotoxy
    mWrite "Clear all balls!"

    mov eax, white + (black * 16)
    call SetTextColor
    ret
DisplayObjective ENDP

DisplayPlayerName PROC
    call crlf

    mov dl, 105
    mov dh, 27
    call Gotoxy

    ; Title in bright white
    mov eax, lightGray + (black * 16)
    call SetTextColor
    mWrite "Player:"

    ; Name in bright cyan
    mov eax, lightCyan + (black * 16)
    call SetTextColor
    inc dh
    call Gotoxy
    mov edx, OFFSET username
    call WriteString

    mov eax, white + (black * 16)
    call SetTextColor
    ret
DisplayPlayerName ENDP



; Display a simple progress bar
DisplayProgress PROC
    mov dl, 105
    mov dh, 29
    call Gotoxy

    mWrite "Progress:"
    inc dh
    call Gotoxy

    ; Simple progress bar logic
    mov ecx, 10        ; Total units in the progress bar
    mov eax, progress  ; progress is a variable tracking progress
    cdq
    div ecx
    mov ebx, eax       ; Number of units to fill

    ; Draw filled units
    mov eax, Green + (Black * 16)
    call SetTextColor
    mov ecx, ebx
draw_filled:
    mov al, '#'
    call WriteChar
    loop draw_filled

    ; Draw empty units
    mov eax, Gray + (Black * 16)
    call SetTextColor
    mov ecx, 10
    sub ecx, ebx
draw_empty:
    mov al, '-'
    call WriteChar
    loop draw_empty

    ret
DisplayProgress ENDP






DrawWalls PROC
    ; Set the console to UTF-8 encoding
    call SetUTF8Console

    ; Clear the screen before drawing walls
    call clrscr

    call clrscr

    mov dl,105
	mov dh,2
	call Gotoxy
	mWrite <"Score: ">
	mov eax, Blue + (black * 16)
	call SetTextColor
	mov al, score
	call WriteDec

    mov eax, White + (black * 16)
	call SetTextColor

	mov dl,105
	mov dh,3
	call Gotoxy
	mWrite <"Lives: ">
	mov eax, Red + (black * 16)
	call SetTextColor
	mov al, lives
	call WriteDec

	mov eax, white + (black * 16)
	call SetTextColor

	mov dl,105
	mov dh,1
	call Gotoxy

	mWrite "LEVEL " 
	mov al, game_levelInfo
    call WriteDec

    mov dl, 0
    mov dh, 0
    call Gotoxy


    ; Set text color for walls (e.g., White)
    mov eax, DIM_COLOR
    call SetTextColor

    ; Draw each wall line individually
    mov edx, OFFSET walls1
    call WriteString

    mov edx, OFFSET walls2
    call WriteString

    mov edx, OFFSET walls3
    call WriteString

    mov edx, OFFSET walls4
    call WriteString

    mov edx, OFFSET walls5
    call WriteString

    mov edx, OFFSET walls6
    call WriteString

    mov edx, OFFSET walls7
    call WriteString

    mov edx, OFFSET walls8
    call WriteString

    mov edx, OFFSET walls9
    call WriteString

    mov edx, OFFSET walls10
    call WriteString

    mov edx, OFFSET walls11
    call WriteString

    mov edx, OFFSET walls12
    call WriteString

    mov edx, OFFSET walls13
    call WriteString

    mov edx, OFFSET walls14
    call WriteString

    mov edx, OFFSET walls15
    call WriteString

    mov edx, OFFSET walls16
    call WriteString

    mov edx, OFFSET walls17
    call WriteString

    mov edx, OFFSET walls18
    call WriteString

    mov edx, OFFSET walls20
    call WriteString

    mov edx, OFFSET walls21
    call WriteString

    mov edx, OFFSET walls22
    call WriteString

    mov edx, OFFSET walls23
    call WriteString

    mov edx, OFFSET walls24
    call WriteString

    mov edx, OFFSET walls25
    call WriteString

    mov edx, OFFSET walls26
    call WriteString

    mov edx, OFFSET walls27
    call WriteString

    mov edx, OFFSET walls28
    call WriteString

    mov edx, OFFSET walls29
    call WriteString

    mov edx, OFFSET walls30
    call WriteString

    mov edx, OFFSET walls31
    call WriteString

    ; Optionally reset text color to default (White)
    mov eax, white + (black * 16)
    call SetTextColor

    ret
DrawWalls ENDP


PrintPlayer PROC
    mov eax, brown + (black * 16)
    call SetTextColor

    mov al, direction
    cmp al, "w"
    je print_up

    cmp al, "x"
    je print_down

    cmp al, "a"
    je print_left

    cmp al, "d"
    je print_right

    cmp al, "q"
    je print_upleft

    cmp al, "e"
    je print_upright

    cmp al, "z"
    je print_downleft

    cmp al, "c"
    je print_downright

    ret

    print_up:
        mov esi, offset player_up
        jmp print

    print_down:
        mov esi, offset player_down
        jmp print

    print_left:
        mov esi, offset player_left
        jmp print

    print_right:
        mov esi, offset player_right
        jmp print

    print_upleft:
        mov esi, offset player_upleft
        jmp print

    print_upright:
        mov esi, offset player_upright
        jmp print

    print_downleft:
        mov esi, offset player_downleft
        jmp print

    print_downright:
        mov esi, offset player_downright
        jmp print

    print:
    mov dl, xPos
    mov dh, yPos
    call GoToXY

    mov counter1, 3
	mov counter2, 4
	movzx ecx, counter1
	printcolumn:
		mov counter1, cl
		movzx ecx, counter2
		printrow:
			mov eax, [esi]
			call WriteChar
            
			inc esi
		loop printrow

		movzx ecx, counter1

		mov dl, xPos
		inc dh
		call Gotoxy
	loop printcolumn
    
ret
PrintPlayer ENDP




MovePlayer PROC
    push    eax
    push    ebx
    push    ecx
    push    edx

    ; Check for key press
    call    ReadKey          ; Non-blocking key read
    mov     inputChar, al

    ; Handle input
    cmp     inputChar, VK_SPACE
    je      shoot
    cmp     inputChar, 'p'
    je      paused
    cmp     inputChar, 'w'
    je      move_up
    cmp     inputChar, 'a'
    je      move_left
    cmp     inputChar, 'x'
    je      move_down
    cmp     inputChar, 'd'
    je      move_right
    cmp     inputChar, 'q'
    je      rotate_left
    cmp     inputChar, 'e'
    je      rotate_right
    cmp     inputChar, 'z'
    je      rotate_down_left
    cmp     inputChar, 'c'
    je      rotate_down_right
    jmp     no_action        ; No valid input

move_up:
    mov     direction, 'w'
    call    PrintPlayer
    jmp     end_move

move_left:
    mov     direction, 'a'
    call    PrintPlayer
    jmp     end_move

move_down:
    mov     direction, 'x'
    call    PrintPlayer
    jmp     end_move

move_right:
    mov     direction, 'd'
    call    PrintPlayer
    jmp     end_move

rotate_left:
    mov     direction, 'q'
    call    PrintPlayer
    jmp     end_move

rotate_right:
    mov     direction, 'e'
    call    PrintPlayer
    jmp     end_move

rotate_down_left:
    mov     direction, 'z'
    call    PrintPlayer
    jmp     end_move

rotate_down_right:
    mov     direction, 'c'
    call    PrintPlayer
    jmp     end_move

shoot:
    call    FireBall
    jmp     end_move

paused:
    ; Immediately show pause screen
    call clrscr
    call PauseScreen
    jmp end_move


no_action:
    ; No valid input was pressed
    ; Continue without action
    jmp     end_move

end_move:
    pop     edx
    pop     ecx
    pop     ebx
    pop     eax
    ret
MovePlayer ENDP




; Draw the static path
DrawStaticPath PROC
    push eax
    push ebx
    push ecx
    push edx

    ; Set dim color for static path
    mov eax, DIM_COLOR
    call SetTextColor

    ; Draw 'O' at each path coordinate
    mov ecx, PATH_LENGTH
    xor esi, esi        ; Path index

draw_path_loop:
    ; Get coordinates
    mov dl, [path_x + esi]    ; X position
    mov dh, [path_y + esi]    ; Y position
    call Gotoxy
    
    ; Draw the 'O' character
    mov al, 'O'
    call WriteChar
    
    inc esi
    loop draw_path_loop

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DrawStaticPath ENDP


InitializeBalls PROC
    mov     ecx, MAX_BALLS            ; Set loop counter to MAX_BALLS (30)
    xor     esi, esi                  ; Initialize ball index to 0
    mov     edi, MAX_BALLS            ; Set reverse index base (30)

    ;mov     BYTE PTR [balls + esi * 8 + Ball_active], 1

init_loop:
    ; Initialize pathIndex for each ball to esi
    mov     DWORD PTR [balls + esi * 8 + Ball_pathIndex], esi

    ; Set the ball as active
    mov     BYTE PTR [balls + esi * 8 + Ball_active], 0

    ; Calculate reverse_index = (MAX_BALLS - 1) - esi
    mov     ebx, edi                  ; EBX = MAX_BALLS (30)
    dec     ebx                        ; EBX = MAX_BALLS - 1 (29)
    sub     ebx, esi                   ; EBX = 29 - esi

    ; Assign color from ball_colors array using reverse_index
    mov     al, [ball_colors + ebx]    ; Load color from ball_colors[29 - esi]
    mov     BYTE PTR [balls + esi * 8 + Ball_color], al   ; Set ball's color

    ; Increment ball index
    inc     esi                         ; Move to next ball index
    loop    init_loop                   ; Decrement ECX and loop if not zero




    ret
InitializeBalls ENDP






DrawBall PROC
    push    eax
    push    ebx
    push    edx

    ; Retrieve color and set it
    mov al, BYTE PTR [balls + esi*8 + Ball_color]
    ;movzx eax, al
    call SetTextColor

    ; Get position and move cursor there
    mov dl, BYTE PTR [balls + esi*8 + Ball_xPos]    ; X position to dl
    mov dh, BYTE PTR [balls + esi*8 + Ball_yPos]    ; Y position to dh
    call Gotoxy

    ; Draw the ball
    mov al, 'O'
    call WriteChar

    pop     edx
    pop     ebx
    pop     eax
    ret
DrawBall ENDP




IsPathPosition PROC
    ; Inputs:
    ;   dl - current x position
    ;   dh - current y position
    ; Output:
    ;   al - 1 if on path, 0 otherwise

    push    esi
    push    edi
    push    ecx

    mov     esi, OFFSET path_x
    mov     edi, OFFSET path_y
    mov     ecx, PATH_LENGTH

    xor     al, al          ; Default to not on path

CheckLoop:
    cmp     dl, [esi]
    jne     NotMatch
    cmp     dh, [edi]
    jne     NotMatch
    mov     al, 1           ; Found a match
    jmp     DoneCheck

NotMatch:
    inc     esi
    inc     edi
    dec     ecx
    jnz     CheckLoop

DoneCheck:
    pop     ecx
    pop     edi
    pop     esi
    ret
IsPathPosition ENDP



;========================================================================
; EraseBall Procedure
; Purpose: Erases a ball while handling overlapping balls and path markers
; Input: ESI = Index of ball to erase
; Output: Updates screen display
; Modifies: Screen display only, preserves registers
;========================================================================
EraseBall PROC
    pushad              ; Save all registers

    ;----------------------------------------
    ; Get Current Position
    ;----------------------------------------
    mov dl, BYTE PTR [balls + esi*8 + Ball_xPos]    ; X position
    mov dh, BYTE PTR [balls + esi*8 + Ball_yPos]    ; Y position
    call Gotoxy

    ;----------------------------------------
    ; Check For Overlapping Balls
    ;----------------------------------------
    push esi           ; Save current ball index
    xor ebx, ebx      ; Initialize check counter

check_overlapping:
    cmp ebx, MAX_BALLS
    je no_overlap
    
    ; Skip checking against self
    cmp ebx, esi
    je next_ball
    
    ; Check if ball is active and at same position
    mov al, BYTE PTR [balls + ebx*8 + Ball_active]
    cmp al, 1
    jne next_ball
    
    ; Compare X position
    mov al, BYTE PTR [balls + ebx*8 + Ball_xPos]
    cmp al, dl
    jne next_ball
    
    ; Compare Y position
    mov al, BYTE PTR [balls + ebx*8 + Ball_yPos]
    cmp al, dh
    jne next_ball
    
    ; Found overlapping ball
    mov eax, ebx      ; Save found ball index
    pop esi           ; Restore original ball index
    push eax          ; Save overlapping ball index
    jmp draw_overlap

next_ball:
    inc ebx
    jmp check_overlapping

    ;----------------------------------------
    ; No Overlapping Balls - Draw Path
    ;----------------------------------------
no_overlap:
    pop esi           ; Restore ball index
    mov eax, DIM_COLOR
    call SetTextColor
    mov al, 'O'      ; Path marker
    jmp draw_char

    ;----------------------------------------
    ; Handle Overlapping Ball
    ;----------------------------------------
draw_overlap:
    pop ebx          ; Get overlapping ball index
    mov al, BYTE PTR [balls + ebx*8 + Ball_color]
    call SetTextColor
    mov al, 'O'      ; Ball character

    ;----------------------------------------
    ; Update Screen
    ;----------------------------------------
draw_char:
    call WriteChar

    ;----------------------------------------
    ; Cleanup & Exit
    ;----------------------------------------
    popad            ; Restore all registers
    ret
EraseBall ENDP


;========================================================================
; FindNextBallAtPosition Procedure
; Purpose: Finds the next active ball at the current path position
; Input: ESI = Current ball index
; Output: AL = Color of next ball (or DIM_COLOR if none found)
; Modifies: AL only, preserves other registers
;========================================================================
FindNextBallAtPosition PROC
    ;----------------------------------------
    ; Save registers & setup
    ;----------------------------------------
    push ecx                    ; Save counter
    push esi                    ; Save current ball index
    
    mov ecx, MAX_BALLS         ; Set search limit
    
    ;----------------------------------------
    ; Get reference position
    ;----------------------------------------
    mov eax, DWORD PTR [balls + esi*8 + Ball_pathIndex]    ; Current pathIndex
    
    ;----------------------------------------
    ; Search loop
    ;----------------------------------------
search_loop:
    inc esi                    ; Move to next ball
    cmp esi, MAX_BALLS        ; Check array bounds
    jb check_ball
    xor esi, esi              ; Wrap to start if at end
    
    ;----------------------------------------
    ; Ball validation
    ;----------------------------------------
check_ball:
    ; Check if ball is active
    cmp BYTE PTR [balls + esi*8 + Ball_active], 1
    jne next_ball
    
    ; Check if at same position
    cmp DWORD PTR [balls + esi*8 + Ball_pathIndex], eax
    jne next_ball
    
    ;----------------------------------------
    ; Ball found handler
    ;----------------------------------------
    mov al, BYTE PTR [balls + esi*8 + Ball_color]    ; Get ball color
    jmp found_ball
    
    ;----------------------------------------
    ; Continue search
    ;----------------------------------------
next_ball:
    loop search_loop
    
    ;----------------------------------------
    ; No ball found handler
    ;----------------------------------------
    mov al, DIM_COLOR         ; Return default color

found_ball:
    ;----------------------------------------
    ; Restore & return
    ;----------------------------------------
    pop esi                   ; Restore registers
    pop ecx
    ret
FindNextBallAtPosition ENDP







;========================================================================
; GameOverScreen Procedure
; Purpose: Displays game over screen with scores and options
; Input: None
; Output: Handles game restart or exit
; Modifies: Game state variables for restart
;========================================================================
GameOverScreen PROC
    pushad                          ; Save all registers

    ; Save final score before transition
    call SaveHighScore             ; Store score in high scores file

;----------------------------------------
; Screen Setup & Initial Animation
;----------------------------------------
show_screen:
    call clrscr                    ; Clear screen
    call PrintBox                  ; Draw border box
    
    ; Animated title display
    mov eax, red                   ; Set title color
    call SetTextColor
    mov dl, 52                     ; Center position
    mov dh, 2
    call Gotoxy
    mWrite "GAME OVER"
    
;----------------------------------------
; GAME ASCII Art Animation
;----------------------------------------
    
    ; Display GAME ASCII
    mov dl, 30
    mov dh, 5
    call Gotoxy
    mov edx, OFFSET gameover1_1
    mov eax, yellow
    call SetTextColor
    call WriteString
    
    mov dl, 30
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET gameover1_2
    call WriteString
    
    mov dl, 30
    mov dh, 7
    call Gotoxy
    mov edx, OFFSET gameover1_3
    call WriteString
    
    mov dl, 30
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET gameover1_4
    call WriteString
    
    mov dl, 30
    mov dh, 9
    call Gotoxy
    mov edx, OFFSET gameover1_5
    call WriteString

    mov dl, 30
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET gameover1_5a
    call WriteString

    mov dl, 30
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET gameover1_5a
    call WriteString

    mov dl, 30
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET gameover1_5a
    call WriteString
    
    ; Display OVER ASCII
    mov dl, 30
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET gameover2_1
    call WriteString
    
    mov dl, 30
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET gameover2_2
    call WriteString
   
    mov dl, 30
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET gameover2_3
    call WriteString
    
    mov dl, 30
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET gameover2_4
    call WriteString
    
    mov dl, 30
    mov dh, 17
    call Gotoxy
    mov edx, OFFSET gameover2_5
    call WriteString
    

;----------------------------------------
; Score Display & Statistics
;----------------------------------------
    ; Show final score with color
    mov eax, white
    call SetTextColor
    mov dl, 50
    mov dh, 20
    call Gotoxy
    mWrite "Final Score: "
    mov eax, blue                  ; Highlight score
    call SetTextColor
    movzx eax, score
    call WriteDec

;----------------------------------------
; Menu Options Display
;----------------------------------------
    mov eax, white
    call SetTextColor
    mov dl, 40
    mov dh, 25
    call Gotoxy
    mWrite "1. Return to Main Menu"
    
    mov dl, 40
    mov dh, 26
    call Gotoxy
    mWrite "2. Exit Game"

;----------------------------------------
; Input Processing Loop
;----------------------------------------
input_loop:
    call ReadChar                 ; Get user choice
    
    cmp al, '1'
    je restart_from_menu
    cmp al, '2'
    je exit_game
    jmp input_loop               ; Invalid input, try again

;----------------------------------------
; Game Exit Handler
;----------------------------------------    
exit_game:
    INVOKE ExitProcess, 0        ; Clean exit

;----------------------------------------
; Game Restart Handler
;----------------------------------------
restart_from_menu:
    ; Reset all game state variables
    mov BYTE PTR [game_over_flag], 0
    mov DWORD PTR [spawn_counter], 0
    mov BYTE PTR [score], 0
    mov BYTE PTR [lives], 3
    
    ; Clear path tracking array
    mov ecx, PATH_LENGTH
    xor esi, esi
clear_path_counter:
    mov BYTE PTR [path_counter + esi], 0
    inc esi
    loop clear_path_counter

    ; Reset all balls to inactive state
    mov ecx, MAX_BALLS
    xor esi, esi
reset_balls:
    mov BYTE PTR [balls + esi*8 + Ball_active], 0
    mov DWORD PTR [balls + esi*8 + Ball_pathIndex], 0
    mov BYTE PTR [balls + esi*8 + Ball_xPos], 0
    mov BYTE PTR [balls + esi*8 + Ball_yPos], 0
    inc esi
    loop reset_balls

    ; Clean screen and restore default colors
    call clrscr
    mov eax, white + (black * 16)
    call SetTextColor
    
    ; Return to main menu
    call DrawMenu
    call askforChoice
    
    popad                        ; Restore registers
    ret
GameOverScreen ENDP





;========================================================================
; UpdateBalls Procedure
; Purpose: Updates position and state of all active balls
; Input: None
; Output: Updated ball positions, potential game over state
;========================================================================
UpdateBalls PROC
    pushad                      ; Save all registers

    mov ecx, MAX_BALLS
    xor esi, esi               ; Ball index = 0

update_loop:
    ; Skip inactive balls
    cmp BYTE PTR [balls + esi * 8 + Ball_active], 0
    je next_ball

    ; Save current pathIndex
    mov eax, DWORD PTR [balls + esi * 8 + Ball_pathIndex]
    
    ; Check path end (game over condition)
    cmp eax, PATH_LENGTH
    jge set_game_over
    
    ; Update ball position
    push esi
    call EraseBall             ; Clear old position
    pop esi
    
    ; Move ball forward
    inc DWORD PTR [balls + esi * 8 + Ball_pathIndex]
    mov eax, DWORD PTR [balls + esi * 8 + Ball_pathIndex]
    
    ; Update coordinates
    mov bl, [path_x + eax]
    mov BYTE PTR [balls + esi * 8 + Ball_xPos], bl
    mov bl, [path_y + eax]
    mov BYTE PTR [balls + esi * 8 + Ball_yPos], bl
    
    ; Draw at new position
    push esi
    call DrawBall
    pop esi

next_ball:
    inc esi
    dec ecx
    jnz update_loop
    jmp update_exit

set_game_over:
    mov BYTE PTR [game_over_flag], 1

update_exit:
    popad
    ret
UpdateBalls ENDP




;========================================================================
; SpawnNewBall Procedure
; Purpose: Creates a new ball in the game with randomized properties
; Input: None
; Output: New ball added to balls array if space available
;========================================================================
SpawnNewBall PROC
    pushad                      ; Save all registers
    
    ; Check if maximum balls reached
    mov eax, [last_ball_index]
    cmp eax, MAX_BALLS
    jge spawn_exit
    
    ; Find next available slot
    xor esi, esi               ; Initialize counter
find_slot:
    cmp BYTE PTR [balls + esi * 8 + Ball_active], 0
    je found_slot
    inc esi
    cmp esi, MAX_BALLS
    jl find_slot
    jmp spawn_exit
    
found_slot:
    ; Initialize new ball
    mov BYTE PTR [balls + esi * 8 + Ball_active], 1    ; Set active
    mov DWORD PTR [balls + esi * 8 + Ball_pathIndex], 0 ; Start at beginning
    mov BYTE PTR [balls + esi * 8 + Ball_xPos], 0      ; Initial X
    mov BYTE PTR [balls + esi * 8 + Ball_yPos], 0      ; Initial Y
    
    ; Set ball color from array
    mov eax, [last_ball_index]
    mov bl, [ball_colors + eax]
    mov BYTE PTR [balls + esi * 8 + Ball_color], bl
    
    ; Update spawn counter
    inc DWORD PTR [last_ball_index]
    
spawn_exit:
    popad
    ret
SpawnNewBall ENDP



;========================================================================
; Initialize Game Screen
; Sets up the game environment including:
; - Clearing previous game state
; - Initializing ball positions
; - Drawing game elements
; - Setting up UI components
;========================================================================
InitialiseScreen PROC
    ; Reset path tracking system
    mov ecx, PATH_LENGTH
    xor esi, esi
clear_path_counter:
    mov BYTE PTR [path_counter + esi], 0
    inc esi
    loop clear_path_counter

    ; Initialize ball states to inactive
    mov ecx, MAX_BALLS
    xor esi, esi
clear_balls:
    mov BYTE PTR [balls + esi*8 + Ball_active], 0
    mov DWORD PTR [balls + esi*8 + Ball_pathIndex], 0
    mov BYTE PTR [balls + esi*8 + Ball_xPos], 0
    mov BYTE PTR [balls + esi*8 + Ball_yPos], 0
    inc esi
    loop clear_balls

    ; Reset ball spawning index
    mov DWORD PTR [last_ball_index], 0

    ; Draw game environment
    call DrawWalls        ; Draw game boundaries
    call DrawStaticPath   ; Draw ball path
    call InitializeBalls  ; Setup initial balls

    ; Spawn initial set of balls
    mov ecx, 3               ; Start with 3 balls
initial_spawn_loop:
    push ecx
    call SpawnNewBall
    pop ecx
    mov eax, 0              ; Minimal delay between spawns
    call Delay
    loop initial_spawn_loop

    ; Initialize player position
    call PrintPlayer

    ; Setup UI elements
    call DisplayControls
    call DisplayHighScore
    call DisplayTips
    call DisplayStats
    call DisplayArt
    call DisplayPlayerName

    ret
InitialiseScreen ENDP




;========================================================================
; Game Loop
; Handles continuous game execution including:
; - Player input processing
; - Ball movement and spawning
; - Game state updates
; - Level-based speed adjustments
;========================================================================
GameLoop PROC
game_loop_start:
    ; Process player input and update position
    call MovePlayer

    ; Update all active balls positions
    call UpdateBalls

    ; Check for game over condition
    mov al, [game_over_flag]
    cmp al, 1
    je exit_game_loop

    ; Ball spawning logic
    mov eax, [spawn_counter]
    add eax, 1
    mov [spawn_counter], eax
    cmp eax, SPAWN_DELAY
    jl skip_spawn
    
    ; Reset spawn counter and create new ball
    mov [spawn_counter], 0
    call SpawnNewBall

skip_spawn:
    ; Adjust game speed based on current level
    mov al, game_levelInfo
    cmp al, 2
    je use_level2_speed
    
    ; Set movement delay based on level
    mov eax, BALL_MOVE_SPEED     ; Level 1 speed
    jmp apply_delay

use_level2_speed:
    mov eax, LEVEL2_SPEED        ; Level 2 speed (faster)

apply_delay:
    call Delay
    jmp game_loop_start

exit_game_loop:
    ret
GameLoop ENDP




;========================================================================
; Main Game Procedure
; Controls the overall game flow including:
; - Main menu and navigation
; - Game initialization
; - Level selection
; - Game state management
;========================================================================
main PROC
    ; Initialize console for UTF-8 character support
    call SetUTF8Console

menu_start:
    ; Display main menu and handle user selection
    call DrawMenu
    call askforChoice

    ; Process menu selection
    cmp eax, 1
    je new_game        ; Start new game
    
    cmp eax, 2
    je instructions    ; Show instructions
    
    cmp eax, 3
    je showhighscores ; Display high scores
    
    cmp eax, 4
    je exitGame       ; Exit application

showhighscores:
    call DisplayHighScores
    jmp menu_start

instructions:
    call displayInstructions
    cmp eax, 1              ; Check if user wants to start game
    je new_game             ; Start new game if selected
    jmp menu_start          ; Otherwise return to menu

new_game:
    ; Initialize new game sequence
    call GetPlayerName          ; Get player name
    call gameP                  ; Select game level
    call InitialiseScreen      ; Setup game environment
    call GameLoop             ; Start main game loop

    ; Check if game ended
    mov al, [game_over_flag]
    cmp al, 1
    je show_game_over
    jmp new_game

show_game_over:
    call GameOverScreen        ; Display game over screen
    jmp menu_start            ; Return to main menu

exitGame:
    call StopMusic            ; Stop background music
    INVOKE ExitProcess, 0     ; Exit application

    ret
main ENDP

end main