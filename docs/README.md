# Zuma-Blitz MASM Assembly Project (Irvine32)

This project is a 32-bit assembly language game, "Zuma-Blitz," built using the Microsoft Macro Assembler (MASM) and Kip Irvine's Irvine32 library. It's a console-based game inspired by Zuma, involving ball shooting mechanics, path-following balls, color matching, and scoring. The project is configured to work with the included Irvine32 library.

## Project Directory Structure

The project is organized into the following directories:

- **src/** - Contains the source code files (`.asm` files)
- **assets/** - Game assets such as audio files
- **docs/** - Documentation (including this README)
- **lib/** - External libraries, including the Irvine32 library
- **build/** - Build outputs for different configurations

## Prerequisites

- **Visual Studio 2022** (Community, Professional, or Enterprise) with:
  - **Desktop development with C++** workload installed, including the MASM component.
- **Irvine32 Library** (included in the repository):
  - The Irvine32 library files (`Irvine32.lib`, `Irvine32.inc`, etc.) are included in the `lib\Irvine32\irvine\examples\Lib32` directory.




## How to Clone and Set Up

1. **Clone the Repository**:
   ```bash
   git clone <your-repository-url>
   cd Zuma-Blitz
   ```

2. **Open the Project in Visual Studio 2022**:
   - Double-click `Zuma-Blitz.sln` to open the project in Visual Studio 2022.

3. **Set Solution Platform to x86 (Win32)**:
   - The project **MUST** be built for the x86 platform because Irvine32 is a 32-bit library.
   - In Visual Studio, locate the **Solution Platforms** dropdown (toolbar, next to the Start button).
   - Select **x86**. If unavailable:
     - Go to **Build > Configuration Manager**.
     - In **Active solution platform**, select **<New...>**, choose **x86**, copy settings from **Win32** (if available), and check **Create new project platforms**.
     - Click **OK** and **Close**.

4. **Verify Project Configuration**:
   - The project is preconfigured to use the Irvine32 library included in `lib\Irvine32\irvine\examples\Lib32`.
   - If the project fails to build, check the following settings:
     - Right-click the project in **Solution Explorer** and select **Properties**.
     - Under **Configuration Properties > VC++ Directories**:
       - **Include Directories**: Ensure it includes `$(ProjectDir)lib\Irvine32\irvine\examples\Lib32`.
       - **Library Directories**: Ensure it includes `$(ProjectDir)lib\Irvine32\irvine\examples\Lib32`.
     - Under **Linker > General**:
       - **Additional Library Directories**: Ensure it includes `$(ProjectDir)lib\Irvine32\irvine\examples\Lib32`.     - Under **Linker > Input**:
       - **Additional Dependencies**: Ensure it includes `$(ProjectDir)lib\Irvine32\irvine\examples\Lib32\irvine32.lib`.
     - Under **Microsoft Macro Assembler > General**:
       - **Include Paths**: Ensure it includes `$(ProjectDir)lib\Irvine32\irvine\examples\Lib32`.
     - Click **Apply** and **OK**.
   - **Configure .asm Files**:
     - In **Solution Explorer**, right-click each `.asm` file (e.g., `Source.asm`) and select **Properties**.
     - Set **Item Type** to **Microsoft Macro Assembler**.
     - Ensure **Excluded from Build** is set to **No**.
     - Click **Apply** and **OK**.
   - **Enable MASM Build Customization**:
     - Right-click the project, select **Build Dependencies > Build Customizations**.
     - Check **masm (.targets, .props)** and click **OK**.

5. **Build the Solution**:
   - Press **Ctrl+Shift+B** or go to **Build > Build Solution**.

6. **Run the Application**:
   - Press **F5** (Debug) or **Ctrl+F5** (Run without debugging).

## Project Configuration Details

- **Irvine32 Library**: Included in `lib\Irvine32\irvine\examples\Lib32`.
- **Include Paths**: Set to `$(ProjectDir)lib\Irvine32\irvine\examples\Lib32`.
- **Library Paths**: Set to `$(ProjectDir)lib\Irvine32\irvine\examples\Lib32`.
- **Dependencies**: Links `Irvine32.lib` from the local lib folder, and uses system versions of `kernel32.lib` and `user32.lib`.
- **Build Output**: Generates files in the `build\Debug` or `build\Release` directory.
- **Assembly Listing**: Generates a `.lst` file in the project directory for debugging.
- **Platform**: Configured for **x86 (Win32)**, as Irvine32 is 32-bit only.

## Troubleshooting

- **LNK1107: invalid or corrupt file**:
  - This error is often caused when building for the wrong platform. Make sure you're building for **x86** in the Solution Platform dropdown.
  - If you still see this error with kernel32.lib, check if you have a text file named kernel32.lib in your Irvine32\irvine\examples\Lib32 directory. This should be renamed to kernel32.lib.txt, as the system should use Windows SDK's kernel32.lib instead.
  - The project file should use `$(CoreLibraryDependencies)` rather than explicitly listing kernel32.lib and user32.lib in AdditionalDependencies.
- **LNK1104: cannot open file 'Irvine32.lib'** or **A1000: cannot open file: Irvine32.inc**:
  - Ensure the **x86** platform is selected.
  - Verify path references in the project file are correctly pointing to `$(ProjectDir)lib\Irvine32\irvine\examples\Lib32`.
  - Check both Debug and Release configurations (some settings might only be applied to one configuration).
- **LNK1107: invalid or corrupt file**:
  - Likely building for x64. Switch to **x86** in **Configuration Manager**.
- **MASM not found**:
  - Ensure the **Desktop development with C++** workload and MASM component are installed via Visual Studio Installer.
- **Unicode/UTF-8 Errors (e.g., A2044: invalid character in file)**:
  - Open the `.asm` file in Visual Studio.
  - Go to **File > Save As**, click the arrow next to **Save**, and select **Save with Encoding...**.
  - Choose **UTF-8 without signature** (no BOM) and save.
- **General Build Errors**:
  - Confirm `.asm` files are set to **Microsoft Macro Assembler** in properties.
  - Verify the Irvine32.lib path is correct in **Linker > Input > Additional Dependencies**.

## Additional Notes

- **Directory Structure**: The project follows a clean organization with source files in `src/`, libraries in `lib/`, assets in `assets/`, documentation in `docs/`, and build outputs in `build/`.
- **32-bit Only**: Irvine32 is incompatible with x64; always use the x86 platform.
- **Debugging**: Use Visual Studio's debugger with breakpoints and check the `.lst` file for assembly listing.
- **Tasks**: Implemented in `.asm` files in the `src/` directory. Refer to source files for details.
- **MASM Documentation**: See the [MASM32 website](http://www.masm32.com/) or Kip Irvine's documentation for more information.

## Recommended Resources

- **Official Irvine Documentation**: Visit [Kip Irvine's Assembly Language website](http://www.kipirvine.com/asm/) for comprehensive documentation, examples, and resources for the Irvine32 library.

- **Recommended VS Code Extensions**:
  - [MASM](https://marketplace.visualstudio.com/items?itemName=blindtiger.masm) - Microsoft Macro Assembler language support
  - [MASM/TASM](https://marketplace.visualstudio.com/items?itemName=xsro.masm-tasm) - Provides support for running MASM/TASM in DOSBox
  - [x86 and x86_64 Assembly](https://marketplace.visualstudio.com/items?itemName=13xforever.language-x86-64-assembly) - Syntax highlighting for x86 assembly
  - [ASM Code Lens](https://marketplace.visualstudio.com/items?itemName=maziac.asm-code-lens) - Provides code lens, references, and hover information

## Implemented Features

### Game Core Mechanics
- **Ball Shooting System**: Fire colored balls to match and eliminate other balls in the path
- **Path Movement System**: Balls follow a predefined path through the game area
- **Color Matching Logic**: Match 3 or more of the same color to eliminate balls
- **Collision Detection**: System to detect ball-to-ball collisions
- **Score Tracking**: Points earned for shooting and eliminating balls

### Player Controls
- **8-Directional Movement**: Player can move in 8 directions using WASD and diagonal keys
- **Directional Shooting**: Fireball shoots in the direction the player is facing
- **Keyboard Input Handling**: Real-time input processing for responsive controls

### Game States
- **Menu System**: Main menu with options for New Game, Instructions, High Scores, and Exit
- **Level Selection**: Multiple levels with increasing difficulty
- **Pause System**: Ability to pause gameplay with a dedicated pause menu
- **Game Over Screen**: End-game display with final score

### Visual Elements
- **Unicode Art**: Decorative graphics using Unicode characters
- **ASCII Title Screens**: Game title and menu displayed in ASCII art
- **Colored Text**: Different colors for various game elements
- **Wall Drawing**: Game boundary walls using Unicode box-drawing characters
- **Player Sprites**: Different sprites for each direction the player can face

### Audio
- **Background Music**: Music playback using the Windows API
- **Sound Integration**: Support for in-game sound effects

### Data Management
- **High Score System**: Persistent storage of high scores in a text file
- **Player Name Entry**: Player can enter their name for the high score list
- **Screen State Management**: Save and restore screen state for smooth transitions

### UI Elements
- **Score Display**: Real-time score display during gameplay
- **Lives Counter**: Visual indicator of remaining lives
- **Progress Bar**: Shows level completion progress
- **Game Instructions**: Comprehensive game instructions with controls
- **Game Tips**: Helpful tips displayed during gameplay

### Special Features
- **UTF-8 Console Support**: For proper display of Unicode characters
- **Box Drawing Functions**: Creates visually appealing UI elements
- **Multiple Color Schemes**: Different colors for different game elements
- **Level Difficulty System**: Different speeds and patterns based on level
