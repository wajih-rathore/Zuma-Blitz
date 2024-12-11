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
          BYTE "|                                              ---                                                     |", 0
          BYTE "|                                             |   |                                                    |", 0
          BYTE "|                                             |   |                                                    |", 0
          BYTE "|                                             |   |                                                    |", 0
          BYTE "|                                              ---                                                     |", 0
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
    fire_color db 14

    ; Emitter properties
    emitter_symbol db "#"
    emitter_row db 0
    emitter_col db 1

; Fireball properties
    fire_symbol db '*'    ; Symbol to represent the fireball
    ;fire_color db 14      ; Color code for the fireball (yellow)
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

    MAX_BALLS EQU 30

     PATH_LENGTH EQU 225  ; Number of positions in the path

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

    

    ; Time between ball spawns
    SPAWN_DELAY EQU 50000
    last_spawn_time DWORD 0

        ; Array of 30 balls using the updated BallStruct
    balls BallStruct MAX_BALLS DUP (<>)

    ; Field offsets within BallStruct
    Ball_xPos     EQU 0
    Ball_yPos     EQU 1
    Ball_stepIdx  EQU 2
    Ball_active   EQU 6
    Ball_color    EQU 7

    Comment @

    ; Color for static path
    DIM_COLOR EQU 8      ; Gray color
    ACTIVE_COLOR EQU 10  ; Light Green for moving balls

@


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


gameP PROC
    call clrscr
    
    ; Initial position for level selection
    mov ebx, 1  ; Track current level (1,2,3)
    
display_levels:
    ; Clear screen each time to refresh
    call clrscr
    
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
    
    ; -------------------------------------------------------------------------------------------------------

    ; Clear previous cursor position and draw new one
    mov eax, yellow   
    call SetTextColor
    
    ; Calculate cursor position based on current level
    mov dl, 18        ; X position 
    mov dh, 8         ; Base Y position for level 1
    
    cmp ebx, 1
    je draw_cursor
    
    cmp ebx, 2
    jne check_level3
    mov dh, 16        ; Y position for level 2
    jmp draw_cursor
    
check_level3:
    mov dh, 24        ; Y position for level 3
    
draw_cursor:
    call Gotoxy
    mov al, '>'
    call WriteChar
    
    mov eax, white    
    call SetTextColor
    
get_input:
    mov eax, 0
    call ReadKey      
    
    ; Handle up arrow
    cmp ax, 4800h     
    jne try_down
    cmp ebx, 1        ; At top?
    je get_input      ; Yes, ignore
    dec ebx           ; No, move up
    jmp display_levels
    
try_down:
    cmp ax, 5000h     ; Down arrow?
    jne try_enter
    cmp ebx, 3        ; At bottom?
    je get_input      ; Yes, ignore
    inc ebx           ; No, move down
    jmp display_levels
    
try_enter:
    cmp ax, 1C0Dh     ; Enter?
    jne get_input
    
    mov temp, bl      ; Store selection
    ret               
    
gameP ENDP


FireBall PROC
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
    mov al, [LEFT_WALL_BOUNDARY]
    cmp dl, al
    jle end_fire

    mov al, [RIGHT_WALL_BOUNDARY]
    cmp dl, al
    jge end_fire

    mov al, [UPPER_WALL_BOUNDARY]
    cmp dh, al
    jle end_fire

    mov al, [LOWER_WALL_BOUNDARY]
    cmp dh, al
    jge end_fire

    ; Move cursor to new position
    mov cursor_col, dl
    mov cursor_row, dh
    call GoToXY

    ; Draw fire symbol
    movzx eax, fire_color
    call SetTextColor
    mov al, fire_symbol
    call WriteChar

    ; Delay for animation effect
    mov eax, 50
    call Delay

    ; Erase the fire symbol before moving to the next position
    call GoToXY
    mov al, ' '
    call WriteChar

    ; Update fireball position for next iteration
    add dl, xDir
    add dh, yDir

    ; Loop back to continue moving the fireball
    jmp fire_loop

end_fire:
    ret
FireBall ENDP

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
    mov dx, 0
    call GoToXY

    checkInput:

    mov eax, 5
    call Delay

    ; Check for key press
    mov eax, 0
    call ReadKey
    mov inputChar, al

    cmp inputChar, VK_SPACE
    je shoot

    cmp inputChar, VK_ESCAPE
    je paused

    cmp inputChar, "w"
    je move

    cmp inputChar, "a"
    je move

    cmp inputChar, "x"
    je move

    cmp inputChar, "d"
    je move

    cmp inputChar, "q"
    je move

    cmp inputChar, "e"
    je move

    cmp inputChar, "z"
    je move

    cmp inputChar, "c"
    je move

    ; if character is invalid, check for a new keypress
    jmp checkInput

    move:
        mov al, inputChar
        mov direction, al
        jmp chosen

    paused:
        ; call your pause menu here... once you make it. for now, this will exit the game.
        ret
        
    shoot:
        call FireBall

    chosen:
        call PrintPlayer
        call MovePlayer

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
InitializeBalls PROC
    mov ecx, MAX_BALLS
    xor esi, esi        ; Ball index

init_loop:
    ; Set initial position (100,1)
    mov BYTE PTR [balls + esi*8 + BallStruct.xPos], 100
    mov BYTE PTR [balls + esi*8 + BallStruct.yPos], 1
    
    ; Start inactive except first ball
    mov BYTE PTR [balls + esi*8 + BallStruct.active], 0
    
    ; Set pathIndex to 0
    mov DWORD PTR [balls + esi*8 + BallStruct.pathIndex], 0
    
    ; Set color (Light Green = 10)
    mov BYTE PTR [balls + esi*8 + BallStruct.color], 10
    
    inc esi
    loop init_loop
    
    ; Activate and draw first ball
    mov BYTE PTR [balls + 0 + BallStruct.active], 1
    xor esi, esi    ; Set ESI to 0 for first ball
    call DrawBall   ; Draw the first ball
    
    ret
InitializeBalls ENDP

; DrawBall Procedure
DrawBall PROC
    push eax
    push ebx
    push edx

    ; Retrieve color and set it
    mov al, BYTE PTR [balls + esi*8 + BallStruct.color]
    movzx eax, al
    call SetTextColor

    ; Get position and move cursor there
    mov dl, BYTE PTR [balls + esi*8 + BallStruct.xPos]    ; X position to dl
    mov dh, BYTE PTR [balls + esi*8 + BallStruct.yPos]    ; Y position to dh
    call Gotoxy

    ; Draw the ball
    mov al, 'O'
    call WriteChar

    pop edx
    pop ebx
    pop eax
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



; EraseBall Procedure
EraseBall PROC
    ; Preserve all registers that might be altered
    push    eax
    push    ebx
    push    ecx
    push    edx
    push    esi
    push    edi

    ; Get current fireball position
    mov     dl, BYTE PTR [balls + esi*8 + BallStruct.xPos]
    mov     dh, BYTE PTR [balls + esi*8 + BallStruct.yPos]

    ; Check if the current position is on the path
    call    IsPathPosition
    cmp     al, 1
    jne     NotOnPath

    ; If on path, redraw the path character 'O'
    mov     al, 'O'
    mov     ah, DIM_COLOR   ; Set path color
    call    WriteChar
    jmp     EndErase

NotOnPath:
    ; If not on path, erase by writing a space
    mov     al, ' '
    mov     ah, 7           ; Default color (white)
    call    WriteChar

EndErase:
    ; Restore preserved registers
    pop     edi
    pop     esi
    pop     edx
    pop     ecx
    pop     ebx
    pop     eax
    ret
EraseBall ENDP


; UpdateBalls Procedure
UpdateBalls PROC USES eax ebx ecx edx esi
    ; Static spawn timer
    mov eax, [last_spawn_time]
    inc eax
    mov [last_spawn_time], eax
    
    ; Spawn check - every 50 updates
    cmp eax, 50
    jge do_spawn          
    jmp update_active_balls
    
do_spawn:
    ; Reset timer and spawn new ball
    mov [last_spawn_time], 0
    call SpawnNewBall
    
update_active_balls:
    mov ecx, MAX_BALLS
    xor esi, esi        ; Ball index

update_loop:
    ; Check if ball is active
    cmp BYTE PTR [balls + esi*8 + BallStruct.active], 1
    jne short_jump_next    

    ; Get current path index
    mov eax, DWORD PTR [balls + esi*8 + BallStruct.pathIndex]
    
    ; Check if reached end of path
    cmp eax, PATH_LENGTH
    jge short_jump_deactivate
    
    ; Update position from path arrays
    mov bl, [path_x + eax]    ; Get X coordinate
    mov BYTE PTR [balls + esi*8 + BallStruct.xPos], bl
    
    mov bl, [path_y + eax]    ; Get Y coordinate
    mov BYTE PTR [balls + esi*8 + BallStruct.yPos], bl
    
    ; Set active color and update the position
    mov eax, ACTIVE_COLOR
    call SetTextColor
    
    ; Move cursor and draw ball
    mov dl, BYTE PTR [balls + esi*8 + BallStruct.xPos]
    mov dh, BYTE PTR [balls + esi*8 + BallStruct.yPos]
    call Gotoxy
    
    mov al, 'O'
    call WriteChar
    
    ; Increment path index
    inc DWORD PTR [balls + esi*8 + BallStruct.pathIndex]
    
    ; Add delay for visible movement
    mov eax, 5000    
    call Delay
    
    jmp short_jump_next

short_jump_deactivate:
    jmp deactivate_ball

short_jump_next:
    jmp next_ball
    
deactivate_ball:
    mov BYTE PTR [balls + esi*8 + BallStruct.active], 0
    
    ; Reset color to dim when ball deactivates
    mov eax, DIM_COLOR
    call SetTextColor
    
    mov dl, BYTE PTR [balls + esi*8 + BallStruct.xPos]
    mov dh, BYTE PTR [balls + esi*8 + BallStruct.yPos]
    call Gotoxy
    
    mov al, 'O'
    call WriteChar
    
next_ball:
    inc esi
    dec ecx                 ; Decrement counter
    jnz update_loop        ; Jump if not zero (replace loop instruction)
    
    ret
UpdateBalls ENDP

; Helper procedure to spawn new balls
SpawnNewBall PROC
    push ecx
    push esi
    
    ; Find inactive ball
    mov ecx, MAX_BALLS
    xor esi, esi
    
find_inactive:
    cmp BYTE PTR [balls + esi*8 + BallStruct.active], 0
    je spawn_this_ball
    inc esi
    loop find_inactive
    jmp done_spawn    ; No inactive balls found
    
spawn_this_ball:
    mov BYTE PTR [balls + esi*8 + BallStruct.active], 1
    mov DWORD PTR [balls + esi*8 + BallStruct.pathIndex], 0
    
    ; Set initial position
    mov BYTE PTR [balls + esi*8 + BallStruct.xPos], 100
    mov BYTE PTR [balls + esi*8 + BallStruct.yPos], 1
    
    ; Draw the new ball
    call DrawBall
    
done_spawn:
    pop esi
    pop ecx
    ret
SpawnNewBall ENDP

; GameLoop Procedure
GameLoop PROC
    loop1:
        ; Update moving balls first
        call UpdateBalls

        ; Handle player input and movements
        call MovePlayer

        ; Control game speed - shorter delay for smoother animation
        ;mov eax, 50000         ; Adjusted delay value
        ;call Delay

        jmp loop1             ; Repeat the loop

    ret
GameLoop ENDP

; Modified InitialiseScreen to include static path
InitialiseScreen PROC
    ; Draw the level layout
    call DrawWall

    ; Draw the static path first
    call DrawStaticPath

    ; Initialize ball positions
    call InitializeBalls

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

comment @

    call DrawMenu
    call askforChoice

    cmp eax, 1
    je startgame

    cmp eax, 2
    je instructions

    cmp eax, 3
    je showhighscores

    cmp eax, 4
    je exitGame

showhighscores:
    ; Code to display highscores
    ret

instructions:
    call displayInstructions
    ret

    @

startgame:
    call InitialiseScreen 
    call InitializeBalls   ; Set up the game screen and balls
    call GameLoop           ; Start the main game loop
    ret

exitGame:
    INVOKE ExitProcess, 0
main ENDP

end main