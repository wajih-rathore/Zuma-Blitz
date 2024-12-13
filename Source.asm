include irvine32.inc
includelib winmm.lib
include macros.inc

PlaySound proto, pszsound:ptr byte, hmod:dword, fdwsound:dword

.data


    zumbaintro1 db " ________      ___  ___      _____ ______       ________      ________     ", 0ah, 0
    zumbaintro2 db "|\_____  \    |\  \|\  \    |\   _ \  _   \    |\   __  \    |\   __  \    ", 0ah, 0
    zumbaintro3 db " \|___/  /|   \ \  \\\  \   \ \  \\\__\ \  \   \ \  \|\ /_   \ \  \|\  \   ", 0ah, 0
    zumbaintro4 db "     /  / /    \ \  \\\  \   \ \  \\|__| \  \   \ \   __  \   \ \   __  \  ", 0ah, 0
    zumbaintro5 db "    /  /_/__    \ \  \\\  \   \ \  \    \ \  \   \ \  \|\  \   \ \  \ \  \ ", 0ah, 0
    zumbaintro6 db "   |\________\   \ \_______\   \ \__\    \ \__\   \ \_______\   \ \__\ \__\", 0ah, 0
    zumbaintro7 db "    \|_______|    \|_______|    \|__|     \|__|    \|_______|    \|__|\|__|", 0ah, 0


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

    choice1 db "1.  START GAME", 0ah, 0
    choice2 db "2.  INSTRUCTIONS", 0ah, 0
    choice3 db "3.  HIGHSCORES", 0ah, 0
    choice4 db "4.  EXIT GAME", 0ah, 0
    choiceask db "Enter Your Choice:  ", 0
     
    pausestring db "~*~*~ GAME PAUSED ~*~*~", 0ah, 0
    pause1 db "1.  RESUME GAME", 0ah, 0
    pause2 db "2.  RESTART GAME", 0ah, 0
    pause3 db "3.  EXIT GAME", 0ah, 0
    
    startinput db ?

    hsstring db "~*~*~ HIGHSCORES ~*~*~", 0ah, 0

    nameinput db "Enter your name:  ", 0
    username db 16 dup (?)
    
    buffer db 100 dup (?)
    namestring db "Player Name: ", 0
    exitstring db "Press Any Key to Exit", 0

    ground db "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", 0
    ground1 db "|",0ah,0
    ground2 db "|",0

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
    newline BYTE 0Dh, 0Ah, 0         ; Newline characters


    wall1 db "##########", 0

    wall2 db "#", 0

    temp db ?

    scorestring db "Score: ",0
    score db 0
    blank db " ",0

    livesstring db "Lives: ",0
    lives db 3
    high_score DWORD 0


    ; Level layout
    walls BYTE " ______________________________________________________________________________________________________ ", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|                                                                                                      |", 0
          BYTE "|______________________________________________________________________________________________________|", 0

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
    color_red db 4
    color_green db 2
    color_yellow db 14
    current_color db 4
    emitter_color1 db 2
    emitter_color2 db 4
    ;fire_color db 14

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
        	


    ; Colors
    DIM_COLOR    EQU 8   ; Gray color for static path
    ACTIVE_COLOR EQU 10  ; Light Green for moving balls

ball_colors db 4, 4, 4, 4, 4, 4, 14, 1, 5, 4    ; Colors for balls 1-10
            db 2, 14, 1, 5, 4, 2, 14, 1, 5, 4    ; Colors for balls 11-20
            db 2, 14, 1, 5, 4, 2, 2, 2, 2, 8     ; Colors for balls 21-30



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


    Comment @

    ; Color for static path
    DIM_COLOR EQU 8      ; Gray color
    ACTIVE_COLOR EQU 10  ; Light Green for moving balls

@



;--------------------------------------------------------------------------------

filename db "highscores.txt", 0
filehandle DWORD ?
buffer_size = 100
writebuffer db buffer_size DUP(?)

readbuffer db buffer_size DUP(?)
scoreStr db "Score: ", 0
levelStr db " Level: ", 0

tempStr db 16 DUP(0)

.code


drawMenu PROC
    
    ;mov eax, 1500
    ;call delay
    
    call clrscr

    mov eax, green
    call settextcolor

    mov dl, 15
    mov dh, 3
    call gotoxy

    mov edx, offset zumbaintro1
    call writestring

    ;mov eax, 300
    ;call delay

    mov dl, 15
    mov dh, 4
    call gotoxy

    mov edx, offset zumbaintro2
    call writestring

    ;mov eax, 300
    ;call delay

    mov dl, 15
    mov dh, 5
    call gotoxy

    mov edx, offset zumbaintro3
    call writestring

    ;mov eax, 300
    ;call delay

    mov dl, 15
    mov dh, 6
    call gotoxy

    mov edx, offset zumbaintro4
    call writestring

    ;mov eax, 300
    ;call delay

    mov dl, 15
    mov dh, 7
    call gotoxy

    mov edx, offset zumbaintro5
    call writestring

    ;mov eax, 300
    ;call delay

    mov dl, 15
    mov dh, 8
    call gotoxy

    mov edx, offset zumbaintro6
    call writestring

    ;mov eax, 300
    ;call delay

    mov dl, 15
    mov dh, 9
    call gotoxy

    mov edx, offset zumbaintro7
    call writestring

    ;mov eax, 300
    ;call delay

    mov eax, white
    call settextcolor

    mov dl, 50
    mov dh, 14
    call gotoxy

    ;mov eax, 100
    ;call delay


ret
drawMenu ENDP


askforChoice PROC

    mov edx, offset choice1
    call writestring

    mov dl, 50
    mov dh, 16
    call gotoxy

    ;mov eax, 100
    ;call delay

    mov edx, offset choice2
    call writestring

    mov dl, 50
    mov dh, 18
    call gotoxy

    ;mov eax, 100
    ;call delay

    mov edx, offset choice3
    call writestring

    mov dl, 50
    mov dh, 20
    call gotoxy

    ;mov eax, 100
    ;call delay

    mov edx, offset choice4
    call writestring

    mov dl, 45
    mov dh, 23
    call gotoxy

    ;mov eax, 300
    ;call delay

    mov edx, offset choiceask
    call writestring

    mov eax, offset startinput 
    call Readint


ret
askforChoice endp


GetPlayerName PROC
    pushad
    
    call clrscr
    
    ; Display prompt
    mov edx, OFFSET nameinput
    call WriteString
    
    ; Get username
    mov edx, OFFSET username
    mov ecx, 15          ; Max 15 chars
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
    ; Clear screen before displaying instructions
    call clrscr

    ; Initialize registers
    mov esi, OFFSET combined_instructions ; Point ESI to the start of the string

    ; Loop through the string character by character
print_loop:
    ;mov eax, 10
    ;call Delay

    mov al, [esi]             ; Load the current character into AL
    cmp al, 0                 ; Check if it's the null terminator
    je done                   ; If yes, exit the loop

    ;call CheckKeyPress        ; Check if Tab key is pressed
    ;cmp al, 09h               ; Compare pressed key with Tab key (ASCII 09h)
    ;je print_remaining        ; If Tab is pressed, jump to print_remaining


    call WriteChar            ; Print the character
    inc esi                   ; Move to the next character
    jmp print_loop            ; Repeat the loop

print_remaining:
    ; Directly print the remaining string
    mov edx, esi              ; Point EDX to the current position in the string
    call WriteString          ; Print the remaining string
    jmp done                  ; Skip to the end


done:
    ; Print a newline for better formatting
    mov edx, OFFSET newline
    call WriteString    

askForInput:
    ; Prompt user for input
    mov edx, offset choiceask
    call writestring

    ; Read integer input
    mov eax, offset startinput 
    call Readint

    ; Check the input value
    cmp eax, 1
    je startgame

    cmp eax, 2
    je menu

    ; If input is not 1 or 2, loop back to ask again
    jmp askForInput

    startgame: 
        ;call startgame
        ret
        
    menu:
        call clrscr
		call main

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
    call clrscr
    
    ; Initial position for level selection
    mov ebx, 1  ; Track current level (1,2,3)
    
show_levels:
    call clrscr
    call DisplayLevels
    mov eax, yellow   
    call SetTextColor
    
get_input:
    call ReadChar
    
    ; Handle number keys for level selection
    cmp al, '1'
    jne try_2
    mov ebx, 1        ; Select level 1
    mov dl, 27        ; X position for cursor (adjusted)
    mov dh, 8         ; Y position for level 1
    jmp show_cursor
    
try_2:
    cmp al, '2'
    jne try_3
    mov ebx, 2        ; Select level 2
    mov dl, 27        ; X position for cursor (adjusted)
    mov dh, 16        ; Y position for level 2
    jmp show_cursor
    
try_3:
    cmp al, '3'
    jne try_enter
    mov ebx, 3        ; Select level 3
    mov dl, 27        ; X position for cursor (adjusted)
    mov dh, 24        ; Y position for level 3
    jmp show_cursor
    
try_enter:
    cmp al, 13        ; Check for Enter key
    je select_level
    jmp get_input     ; If not recognized, keep waiting
    
show_cursor:
    call clrscr       ; Clear screen
    call DisplayLevels ; Redisplay levels
    call Gotoxy
    mov al, '>'       ; Draw cursor
    call WriteChar
    jmp get_input
    
select_level:
    mov temp, bl      ; Store selected level
    ret
    
gameP ENDP

; Add pause menu procedure
PauseScreen PROC
    ; Save current positions
    pushad

    ; Display pause menu
    call clrscr
    
    mov eax, green + (black * 16)
    call settextcolor

    ; Display pause menu title centered
    mov dl, 30
    mov dh, 10
    call gotoxy
    mov edx, offset pausestring
    call writestring

    ; Display options
    mov dl, 30
    mov dh, 15
    call gotoxy
    mov edx, offset pause1    ; "1. RESUME GAME"
    call writestring

    mov dl, 30
    mov dh, 17
    call gotoxy
    mov edx, offset pause2    ; "2. RESTART GAME"
    call writestring

    mov dl, 30
    mov dh, 19
    call gotoxy
    mov edx, offset pause3    ; "3. EXIT GAME"
    call writestring

pause_input_loop:
    call ReadChar
    
    cmp al, '1'
    je resume_game
    cmp al, '2'
    je restart_game
    cmp al, '3'
    je exit_game
    jmp pause_input_loop

resume_game:
    ; Redraw entire game state in correct order
    call clrscr
    call DrawWall            ; Draw level layout first
    call DrawStaticPath      ; Draw the path
    
    ; Redraw all balls in their current positions
    mov ecx, MAX_BALLS
    xor esi, esi
redraw_balls:
    push ecx
    mov al, BYTE PTR [balls + esi*8 + Ball_active]
    cmp al, 1
    jne skip_ball
    call DrawBall           ; Draw active balls
skip_ball:
    inc esi
    pop ecx
    loop redraw_balls

    mov eax, yellow
    call SetTextColor

    ; Redraw all UI elements
    call DisplayControls
    call DisplayHighScore
    call DisplayTips
    call DisplayStats
    call DisplayArt
    ;call DisplayObjective
    ;call DisplayProgress
    call DisplayPlayerName
    call PrintPlayer       ; Draw player last
    
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
    ;call CheckBallCollision
    pop edx                ; Restore position
    cmp al, 1
    je handle_hit

    ; Delay for animation effect
    mov eax, 10
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

; Add new procedure to update score display
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


; Display game controls on the right side
DisplayControls PROC
    mov dl, 105     ; Start column on the right
    mov dh, 5       ; Starting row position
    call Gotoxy

    mWrite "Controls:"
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
    mWrite "Space - Shoot"
    ret
DisplayControls ENDP

; Display high score
DisplayHighScore PROC
    mov dl, 105
    mov dh, 12
    call Gotoxy

    mWrite "High Score:"
    inc dh
    call Gotoxy

    mov eax, high_score
    call WriteDec
    ret
DisplayHighScore ENDP

; Display gameplay tips
DisplayTips PROC
    mov dl, 105
    mov dh, 15
    call Gotoxy

    mWrite "Tip:"
    inc dh
    call Gotoxy
    mWrite "Match colors"
    inc dh
    call Gotoxy
    mWrite "for combos!"
    ret
DisplayTips ENDP

; Display combo count
DisplayStats PROC
    mov dl, 105
    mov dh, 19
    call Gotoxy

    mWrite "Combo Count:"
    inc dh
    call Gotoxy

    mov eax, combo_count
    call WriteDec
    ret
DisplayStats ENDP

DisplayArt PROC
    mov dl, 105
    mov dh, 22
    call Gotoxy

    mWrite " /\_/\ "
    inc dh
    call Gotoxy
    mWrite "( o.o )"
    inc dh
    call Gotoxy
    mWrite " > ^ < "
    ret
DisplayArt ENDP

DisplayObjective PROC
    mov dl, 105
    mov dh, 26
    call Gotoxy

    mWrite "Objective:"
    inc dh
    call Gotoxy
    mWrite "Clear all balls!"
    ret
DisplayObjective ENDP


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

; Display player name
DisplayPlayerName PROC
    mov dl, 105
    mov dh, 41
    call Gotoxy

    mWrite "Player:"
    inc dh
    call Gotoxy

    mov edx, OFFSET username
    call WriteString
    ret
DisplayPlayerName ENDP



DrawWall PROC
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

	mov eax, gray + (black*16)
	call SetTextColor

	mov dl, 0
	mov dh, 0
	call Gotoxy

	mov esi, offset walls

	mov counter1, 58
	mov counter2, 105
	movzx ecx, counter1
	printcolumn:
		mov counter1, cl
		movzx ecx, counter2
		printrow:
			mov eax, [esi]
			call WriteChar
            
			inc esi
		loop printrow
		
        dec counter1
		movzx ecx, counter1

		mov dl, 0
		inc dh
		call Gotoxy
	loop printcolumn

	ret
DrawWall ENDP

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

; InitializeBalls Procedure 

; InitializeBalls Procedure
; Initialize balls with unique colors and set them as active
InitializeBalls PROC
    mov     ecx, MAX_BALLS            ; Set loop counter to MAX_BALLS (30)
    xor     esi, esi                  ; Initialize ball index to 0
    mov     edi, MAX_BALLS            ; Set reverse index base (30)

init_loop:
    ; Initialize pathIndex for each ball to esi
    mov     DWORD PTR [balls + esi * 8 + Ball_pathIndex], esi

    ; Set the ball as active
    mov     BYTE PTR [balls + esi * 8 + Ball_active], 1

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





; DrawBall Procedure
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




.code
; Update EraseBall procedure
EraseBall PROC
    pushad

    ; Get current ball position
    mov dl, BYTE PTR [balls + esi*8 + Ball_xPos]
    mov dh, BYTE PTR [balls + esi*8 + Ball_yPos]
    
    ; Move cursor to ball's position
    call Gotoxy

    ; Get ball's pathIndex
    mov eax, DWORD PTR [balls + esi*8 + Ball_pathIndex]
    
    ; Increment counter for this path position
    inc BYTE PTR [path_counter + eax]
    
    ; Check active balls at this position
    push esi
    mov ebx, 0          ; Counter for active balls
    mov ecx, MAX_BALLS
count_active:
    cmp BYTE PTR [balls + ecx*8 + Ball_active], 1
    jne next_count
    cmp DWORD PTR [balls + ecx*8 + Ball_pathIndex], eax
    jne next_count
    inc ebx             ; Found an active ball at this position
next_count:
    loop count_active
    pop esi

    ; If no active balls remain at this position, use gray
    cmp ebx, 0
    je use_gray
    
    ; Otherwise get next ball's color
    push esi
    call FindNextBallAtPosition
    pop esi
    movzx eax, al
    jmp draw_marker

use_gray:
    mov eax, DIM_COLOR

draw_marker:
    call SetTextColor
    mov al, 'O'
    call WriteChar

    popad
    ret
EraseBall ENDP

; New helper procedure to find next ball at current position
FindNextBallAtPosition PROC
    push ecx
    push esi
    
    ; Start checking from current ball onwards
    mov ecx, MAX_BALLS
    
    ; Get current pathIndex
    mov eax, DWORD PTR [balls + esi*8 + Ball_pathIndex]
    
search_loop:
    inc esi
    cmp esi, MAX_BALLS
    jb check_ball
    xor esi, esi        ; Wrap around to start
    
check_ball:
    ; Check if ball is active and at this position
    cmp BYTE PTR [balls + esi*8 + Ball_active], 1
    jne next_ball
    
    cmp DWORD PTR [balls + esi*8 + Ball_pathIndex], eax
    jne next_ball
    
    ; Found a ball - return its color
    mov al, BYTE PTR [balls + esi*8 + Ball_color]
    jmp found_ball
    
next_ball:
    loop search_loop
    
    ; No ball found - return gray color
    mov al, DIM_COLOR
    
found_ball:
    pop esi
    pop ecx
    ret
FindNextBallAtPosition ENDP


GameOverScreen PROC
    pushad                      ; Save all registers

    
    ; Save score before showing game over screen
    call SaveHighScore

show_screen:
    call clrscr                ; Clear the screen

    ; Set green background and white text
    mov eax, green
    call settextcolor

    mov dl, 25                 ; X position
    mov dh, 10                 ; Y position
    call gotoxy

    ; Display "GAME OVER" ASCII Art
    mov edx, offset gameover1
    call writestring

    mov dl, 25
    mov dh, 11
    call gotoxy
    mov edx, offset gameover2
    call writestring

    mov dl, 25
    mov dh, 12
    call gotoxy
    mov edx, offset gameover3
    call writestring

    mov dl, 25
    mov dh, 13
    call gotoxy
    mov edx, offset gameover4
    call writestring

    ; Display options
    mov dl, 30
    mov dh, 15
    call gotoxy
    mov edx, offset exitstring
    call writestring

    mov dl, 30
    mov dh, 17
    call gotoxy
    mov edx, offset choiceask  ; "Enter Your Choice:  "
    call writestring

    ; Display choices
    mov dl, 30
    mov dh, 18
    call gotoxy
    mwrite <"1.  Go to main menu">

    mov dl, 30
    mov dh, 20
    call gotoxy
    mwrite <"2.  Exit Game">

input_loop:
    call ReadChar              ; Use ReadChar instead of ReadKey
    
    cmp al, '1'
    je restart_from_menu
    cmp al, '2'
    je exit_game
    jmp input_loop            ; Invalid input, keep waiting
    
exit_game:
    INVOKE ExitProcess, 0

restart_from_menu:
    ; Reset game state variables
    mov BYTE PTR [game_over_flag], 0  
    mov DWORD PTR [spawn_counter], 0
    mov BYTE PTR [score], 0
    mov BYTE PTR [lives], 3
    
    ; Clear path counter array
    mov ecx, PATH_LENGTH
    xor esi, esi
clear_path_counter:
    mov BYTE PTR [path_counter + esi], 0
    inc esi
    loop clear_path_counter

    ; Clear and reset all balls
    mov ecx, MAX_BALLS
    xor esi, esi
reset_balls:
    mov BYTE PTR [balls + esi*8 + Ball_active], 0
    mov DWORD PTR [balls + esi*8 + Ball_pathIndex], 0
    mov BYTE PTR [balls + esi*8 + Ball_xPos], 0
    mov BYTE PTR [balls + esi*8 + Ball_yPos], 0
    inc esi
    loop reset_balls

    ; Clear screen and reset colors
    call clrscr
    mov eax, black + (black * 16)
    call SetTextColor
    
    ; Draw menu and get choice
    call DrawMenu
    call askforChoice
    
    popad
    ret
GameOverScreen ENDP
; UpdateBalls Procedure

UpdateBalls PROC
    push    eax
    push    ebx
    push    ecx
    push    edx
    push    esi

    mov     ecx, MAX_BALLS
    xor     esi, esi            ; Ball index = 0

update_loop:
    ; Check if the current ball is active
    mov     al, BYTE PTR [balls + esi * 8 + Ball_active]
    cmp     al, 1
    jne     next_ball           ; Skip inactive balls

    ; Erase previous position
    push    esi
    call    EraseBall
    pop     esi

    ; Update pathIndex and positions
    mov     eax, DWORD PTR [balls + esi * 8 + Ball_pathIndex]
    inc     eax
    cmp     eax, PATH_LENGTH
    jge     set_game_over        ; Set game over flag
    mov     DWORD PTR [balls + esi * 8 + Ball_pathIndex], eax

    mov     bl, [path_x + eax]
    mov     BYTE PTR [balls + esi * 8 + Ball_xPos], bl
    mov     bl, [path_y + eax]
    mov     BYTE PTR [balls + esi * 8 + Ball_yPos], bl

    ; Draw the ball with color from 'ball_color'
    push    esi
    call    DrawBall
    pop     esi

    jmp     continue_update

set_game_over:
    mov     BYTE PTR [game_over_flag], 1 ; Set game over
    jmp     continue_update

continue_update:
    inc     esi
    loop    update_loop
    jmp     end_update

next_ball:
    inc     esi
    loop    update_loop

check_all_balls:
    ; Existing code if any

end_update:
    pop     esi
    pop     edx
    pop     ecx
    pop     ebx
    pop     eax
    ret
UpdateBalls ENDP


; Helper procedure to spawn new balls
SpawnNewBall PROC
    push ecx
    push esi
    push edi

    ; Check if starting position is free
    lea     edi, [balls]          ; Pointer to balls array
    xor     ecx, ecx              ; Start at first ball
    mov     esi, MAX_BALLS

check_start:
    cmp     DWORD PTR [edi + ecx * 8 + Ball_pathIndex], 0
    jne     position_occupied
    cmp     BYTE PTR [edi + ecx * 8 + Ball_active], 1
    je      position_occupied
    inc     ecx
    cmp     ecx, esi
    jl      check_start
    jmp     can_spawn

position_occupied:
    ; Starting position is occupied; do not spawn
    jmp     done_spawn

can_spawn:
    ; Find inactive ball
    mov     ecx, MAX_BALLS
    xor     esi, esi

find_inactive:
    cmp BYTE PTR [balls + esi * 8 + BallStruct.active], 0
    je spawn_this_ball
    inc     esi
    loop find_inactive
    jmp     done_spawn    ; No inactive balls found

spawn_this_ball:
    mov BYTE PTR [balls + esi*8 + BallStruct.active], 1
    mov DWORD PTR [balls + esi*8 + BallStruct.pathIndex], 0

    ; Set initial position based on path arrays
    mov     al, [path_x]          ; path_x[0]
    mov     BYTE PTR [balls + esi*8 + Ball_xPos], al
    mov     al, [path_y]          ; path_y[0]
    mov     BYTE PTR [balls + esi*8 + Ball_yPos], al

    ; Set color from ball_colors array
    ;mov al, [ball_colors + esi]
    ;mov BYTE PTR [balls + esi*8 + Ball_color], al

    ; Draw the new ball
    call DrawBall

done_spawn:
    pop     edi
    pop     esi
    pop     ecx
    ret
SpawnNewBall ENDP


; GameLoop Procedure
GameLoop PROC
game_loop_start:
    ; Handle player input and movements
    call MovePlayer

    ; Update moving balls
    call UpdateBalls

    ; Check if game over flag is set
    mov al, [game_over_flag]
    cmp al, 1
    je exit_game_loop

    ; Existing spawn logic
    mov eax, [spawn_counter]
    add eax, 1
    mov [spawn_counter], eax
    cmp eax, SPAWN_DELAY
    jl skip_spawn
    
    mov [spawn_counter], 0
    call SpawnNewBall

skip_spawn:
    mov eax, GAME_SPEED_DELAY
    call Delay
    jmp game_loop_start



exit_game_loop:
    ret
GameLoop ENDP


; Modified InitialiseScreen to include static path
InitialiseScreen PROC
    ; Reset path counter array first
    mov ecx, PATH_LENGTH
    xor esi, esi
clear_path_counter:
    mov BYTE PTR [path_counter + esi], 0
    inc esi
    loop clear_path_counter

    ; Reset all ball states
    mov ecx, MAX_BALLS
    xor esi, esi
clear_balls:
    mov BYTE PTR [balls + esi*8 + Ball_active], 0
    mov DWORD PTR [balls + esi*8 + Ball_pathIndex], 0
    mov BYTE PTR [balls + esi*8 + Ball_xPos], 0
    mov BYTE PTR [balls + esi*8 + Ball_yPos], 0
    inc esi
    loop clear_balls


    ; Draw the level layout
    call DrawWall

    ; Draw the static path first
    call DrawStaticPath

    ; Initialize ball positions
    call InitializeBalls


        ; Spawn initial balls
    mov     ecx, 3               ; Number of initial balls
initial_spawn_loop:
    call    SpawnNewBall
    loop    initial_spawn_loop



    ; Set the initial player cannon position
    call PrintPlayer

    ; Display additional information
    call DisplayControls
    call DisplayHighScore
    call DisplayTips
    call DisplayStats
    call DisplayArt
    call DisplayPlayerName

    ret
InitialiseScreen ENDP
; Main Procedure
main PROC

menu_start:


    call DrawMenu
    call askforChoice

    cmp eax, 1
    je new_game

    cmp eax, 2
    je instructions

    cmp eax, 3
    je showhighscores

    cmp eax, 4
    je exitGame

showhighscores:
    call DisplayHighScores
    jmp menu_start

instructions:
    call displayInstructions
    ret



new_game:
    call GetPlayerName
    call gameP
    ;call clrscr                 ; Clear screen before starting
    call InitialiseScreen      ; Set up fresh game screen
    call GameLoop             

    mov al, [game_over_flag]
    cmp al, 1
    je show_game_over
    jmp new_game

show_game_over:
    call GameOverScreen        ; Show game over screen
    jmp menu_start            ; Return to menu after reset


    ret

exitGame:
    INVOKE ExitProcess, 0
main ENDP

end main