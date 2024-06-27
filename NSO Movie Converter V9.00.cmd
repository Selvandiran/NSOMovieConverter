::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: NAS Streaming Optimized Movie Converter - By Selvandiran Marimuthu
::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
@echo off
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Set Program Version
set Program_Version=V9.00
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Changelog:
:: - Added Changelog & Future Update in batch file. - V8 Beta
:: - Removed Dependencies (Major Program Update) - V8 Beta
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: - Add Support to Change Voices. - V8 Final
:: - Add Chimes/Sounds/Voices. - V8 Final
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: - Add Support to Adjust Voice Speed. - V9 Alpha
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: - Add Support for automatic removal if filename/extension doesn't match (Trash) - V9 Beta
:: - Add Support for Filename Checker for Watch Folders (Filename Compliance) - V9 Beta
:: - Friendlier Variable Names & Optimized Variable Use- V9 Beta
:: - Optimized Program (Super Major Program Update) - V9 Beta
:: - Add Support for Adobe Media Encoder Autostart - PENDING
:: - Added Line Break for Programming Sectioning - V9 Beta
:: - Add Blocking File Support for Future Uses - V9 Beta
:: - UI Placement and UX Improgements - V9 Beta
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Future Updates:
:: - Intranet Support (Recommended)
:: - Blocking File Handler (Optional)
:: - Release Application (Super Low Chance)
:: - Port Application to Better Language (Definitely Far Fetched)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:: PROGRAM CONFIGURATION & DIRECTORY SETTING

:: Set to 1 if you want to  enable additional verbose for debugging.
set /A Debug_Mode=0

:: Available Voices: Microsoft David Desktop, Microsoft Hazel Desktop, Microsoft Zira Desktop, Microsoft Richard Desktop. Speed from -10 (Slowest) --> 0 (Windows Default) --> 2 (Program Default) --> 10 (Fastest)
set Speech_Voice=Microsoft Richard Desktop
set Speech_Voice_Speed=2

:: Set your watch folder where you will be dropping your movies and/or subtitle files. This is where it all happens...
set NSO_Watch_Folder=E:\NAS Streaming Optimized Movie Converter Folder
set NSO_Watch_Folder_Drive=E:

:: Set the directory where the movie will be moved in case it doesn't fit the resolution and bitrate to be "heat-shrinked"...
set Adobe_Watch_Folder=E:\Adobe Watch Folder

:: Set the Adobe Media Encoder executable file in the program files to automatically open Adobe Media Encoder in case a file is sent to the Adobe Watch Folder.
set Adobe_ME_App=C:\Program Files\Adobe\Adobe Media Encoder 2022\Adobe Media Encoder.exe

:: Set the directory where files will be moved if they're missing subtitle file/subtitle confirmation file. Also applicable for solo subtitle file/subtitle confirmation file.
set Blocking_Folder=E:\NAS Streaming Optimized Movie Converter Folder\Blocking Files

::Set the directory which ffmpeg.exe and ffprobe.exe is in. Download if you don't have, lazy prick...
set FFmpeg_Folder=C:\FFmpeg\bin

:: Set the directory which blink1-tool.exe is in. Oh so fancy :)
set Blink_Folder=C:\blink1-tool-v2.3.0

:: HDD preferred as it has high read/write cycles, must if you are a gamer! We don't wanna waste IOPS don't we...
set Temporary_Folder=F:\Movie Converter Files\Temp Files

:: Used to backup originals of the converted movies. No, we cannot use Recycle Bin!!!
set Archive_Folder=F:\Movie Converter Files\Movie Archive

:: Used to backup converted movies before uploading to NAS. What would happen if your Wi-Fi is down? We got your back...
set Converted_Folder=F:\Movie Converter Files\Converted Files

:: Of course, your NAS. Wait you have a server instead? :(
set NAS_Folder=192.168.100.132\SeL\Movies\Unprocessed Movies

:: We gotta make some sound to make sure our program doesn't sleep...
set Sound_Folder=F:\Movie Converter Files\Alerts

title NAS Streaming Optimized Movie Converter - By: Selvandiran Marimuthu [%Program_Version%]

IF %Debug_Mode% NEQ 1 GOTO DEBUG_1_END
mode con: cols=135 lines=54
echo.
echo #####################################################################################################################################
echo ### PROGRAM CONFIGURATION AND DIRECTORY SETTING                                                                                     #
echo #####################################################################################################################################
echo.
echo   - Debug Mode        : %Debug_Mode%
echo   - Program Version   : %Program_Version%
echo   - Speech Voice      : %Speech_Voice%
echo   - Speech Voice Speed: %Speech_Voice_Speed%
echo   - NSO Watch Folder  : %NSO_Watch_Folder%
echo   - Adobe Watch Folder: %Adobe_Watch_Folder%
echo   - Blocking Folder   : %Blocking_Folder%
echo   - FFmpeg Folder     : %FFmpeg_Folder%
echo   - Blink Folder      : %Blink_Folder%
echo   - Temporary Folder  : %Temporary_Folder%
echo   - Archive Folder    : %Archive_Folder%
echo   - Converted Folder  : %Converted_Folder%
echo   - NAS Folder        : %NAS_Folder%
echo   - Sound Folder      : %Sound_Folder%
echo.
echo _________________________________________________________________________________________________________________________END_OF_LINE_
echo #####################################################################################################################################
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%Speech_Voice%'); $speak.Rate=%Speech_Voice_Speed%; $speak.Speak('Debug Mode Turned On');"
:DEBUG_1_END
IF %Debug_Mode% EQU 0 (mode con: cols=135 lines=14)


::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: INITIAL SCREEN / SPLASH SCREEN (HEY HI, HOW ARE YOU?)
%NSO_Watch_Folder_Drive%
cd %NSO_Watch_Folder%
%Blink_Folder%\blink1-tool -q --id all --on
color F4
echo.
echo  ####################################################################################################################################
echo. 
echo            e   e                         ,e,            e88'Y88                                              d8                  
echo           d8b d8b     e88 88e  Y8b Y888P  "   ,e e,    d888  'Y  e88 88e  888 8e  Y8b Y888P  ,e e,  888,8,  d88    ,e e,  888,8, 
echo          e Y8b Y8b   d888 888b  Y8b Y8P  888 d88 88b  C8888     d888 888b 888 88b  Y8b Y8P  d88 88b 888 "  d88888 d88 88b 888 "  
echo         d8b Y8b Y8b  Y888 888P   Y8b "   888 888   ,   Y888  ,d Y888 888P 888 888   Y8b "   888   , 888     888   888   , 888    
echo        d888b Y8b Y8b  "88 88"     Y8P    888  "YeeP"    "88,d88  "88 88"  888 888    Y8P     "YeeP" 888     888    "YeeP" 888    
echo.
echo        Made By: Selvandiran Marimuthu                                                                             Version: %Program_Version%
echo.
echo  ########################################################### INITIALIZING ###########################################################

%FFmpeg_Folder%\ffplay -loglevel quiet -autoexit -nodisp "%Sound_Folder%\startup_sound.wav" | %Blink_Folder%\blink1-tool -q --id all -t 30 --random=550

set /A Color_Step_Value=1
set /A R_Value=255
set /A G_Value=255
set /A B_Value=255
set /A Color_Light_Speed=15

%Blink_Folder%\blink1-tool -q --id all --on

::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: MAIN SCREEN (YOU GONNA SEE ME A LOT)
:START_PROGRAM

IF %Debug_Mode% EQU 1 timeout /t 3
title NAS Streaming Optimized Movie Converter - By: Selvandiran Marimuthu [%Program_Version%]...
cls
color F5
echo            e   e                         ,e,            e88'Y88                                              d8                  
echo           d8b d8b     e88 88e  Y8b Y888P  "   ,e e,    d888  'Y  e88 88e  888 8e  Y8b Y888P  ,e e,  888,8,  d88    ,e e,  888,8, 
echo          e Y8b Y8b   d888 888b  Y8b Y8P  888 d88 88b  C8888     d888 888b 888 88b  Y8b Y8P  d88 88b 888 "  d88888 d88 88b 888 "  
echo         d8b Y8b Y8b  Y888 888P   Y8b "   888 888   ,   Y888  ,d Y888 888P 888 888   Y8b "   888   , 888     888   888   , 888    
echo        d888b Y8b Y8b  "88 88"     Y8P    888  "YeeP"    "88,d88  "88 88"  888 888    Y8P     "YeeP" 888     888    "YeeP" 888    
echo  ------------------------------------------------------------------------------------------------------------------------------------
echo %date%, %time% - Scanning for New Movies...

::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

:COLOR_STEP_1
IF %Color_Step_Value% NEQ 1 GOTO COLOR_STEP_2
%Blink_Folder%\blink1-tool -q --id all --rgb %R_Value%,%G_Value%,%B_Value%
set /A G_Value=%G_Value%-%Color_Light_Speed%
set /A B_Value=%B_Value%-%Color_Light_Speed%
IF %Debug_Mode% EQU 1 echo [DEBUG] Step 1, R: %R_Value%, G: %G_Value%, B: %B_Value%
IF %G_Value% LEQ 0 set /A Color_Step_Value=2

:COLOR_STEP_2
IF %Color_Step_Value% NEQ 2 GOTO COLOR_STEP_3
%Blink_Folder%\blink1-tool -q --id all --rgb %R_Value%,%G_Value%,%B_Value%
set /A G_Value=%G_Value%+%Color_Light_Speed%
IF %Debug_Mode% EQU 1 echo [DEBUG] Step 2, R: %R_Value%, G: %G_Value%, B: %B_Value%
IF %G_Value% GEQ 255 set /A Color_Step_Value=3

:COLOR_STEP_3
IF %Color_Step_Value% NEQ 3 GOTO COLOR_STEP_4
%Blink_Folder%\blink1-tool -q --id all --rgb %R_Value%,%G_Value%,%B_Value%
set /A R_Value=%R_Value%-%Color_Light_Speed%
IF %Debug_Mode% EQU 1 echo [DEBUG] Step 3, R: %R_Value%, G: %G_Value%, B: %B_Value%
IF %R_Value% LEQ 0 set /A Color_Step_Value=4

:COLOR_STEP_4
IF %Color_Step_Value% NEQ 4 GOTO COLOR_STEP_5
%Blink_Folder%\blink1-tool -q --id all --rgb %R_Value%,%G_Value%,%B_Value%
set /A B_Value=%B_Value%+%Color_Light_Speed%
IF %Debug_Mode% EQU 1 echo [DEBUG] Step 4, R: %R_Value%, G: %G_Value%, B: %B_Value%
IF %B_Value% GEQ 255 set /A Color_Step_Value=5

:COLOR_STEP_5
IF %Color_Step_Value% NEQ 5 GOTO COLOR_STEP_6
%Blink_Folder%\blink1-tool -q --id all --rgb %R_Value%,%G_Value%,%B_Value%
set /A G_Value=%G_Value%-%Color_Light_Speed%
IF %Debug_Mode% EQU 1 echo [DEBUG] Step 5, R: %R_Value%, G: %G_Value%, B: %B_Value%
IF %G_Value% LEQ 0 set /A Color_Step_Value=6

:COLOR_STEP_6
IF %Color_Step_Value% NEQ 6 GOTO COLOR_STEP_7
%Blink_Folder%\blink1-tool -q --id all --rgb %R_Value%,%G_Value%,%B_Value%
set /A R_Value=%R_Value%+%Color_Light_Speed%
IF %Debug_Mode% EQU 1 echo [DEBUG] Step 6, R: %R_Value%, G: %G_Value%, B: %B_Value%
IF %R_Value% GEQ 255 set /A Color_Step_Value=7

:COLOR_STEP_7
IF %Color_Step_Value% NEQ 7 GOTO COLOR_STEP_8
%Blink_Folder%\blink1-tool -q --id all --rgb %R_Value%,%G_Value%,%B_Value%
set /A G_Value=%G_Value%+%Color_Light_Speed%
IF %Debug_Mode% EQU 1 echo [DEBUG] Step 7, R: %R_Value%, G: %G_Value%, B: %B_Value%
IF %G_Value% GEQ 255 set /A Color_Step_Value=8

:COLOR_STEP_8
IF %Color_Step_Value% NEQ 8 GOTO COLOR_STEP_1
set /A Color_Step_Value=1

::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

move "%Adobe_Watch_Folder%\Output\*" "%NSO_Watch_Folder%"  1> nul 2>nul

set Original_Filename=null
dir /a:-D /b > "%Temporary_Folder%\temp.var" 2>nul
set /p Original_Filename=<"%Temporary_Folder%\temp.var"
echo %Original_Filename%> "%Temporary_Folder%\temp.var" 2>nul
FOR %%? IN ("%Temporary_Folder%\temp.var") DO (SET /A Filename_Length=%%~z? - 2)

IF %Debug_Mode% EQU 1 echo [DEBUG] Original Filename: %Original_Filename%
IF %Debug_Mode% EQU 1 echo [DEBUG] Filename Length: %Filename_Length%

IF %Filename_Length% EQU 4 echo No Files Found...
IF %Filename_Length% EQU 4 GOTO START_PROGRAM

::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: GET FILE EXTENSION (WHAT IS THIS?)

title NAS Streaming Optimized Movie Converter - By: Selvandiran Marimuthu [%Program_Version%] ~ Processing: %Original_Filename%

set /A Global_Variable_Int_1=0
set /A Global_Variable_Int_2=%Filename_Length%-3
set Extension_Type=%Original_Filename%

:FILENAME_EXTENSION_FOR_LOOP_START
set /A Global_Variable_Int_1+=1
set Extension_Type=%Extension_Type:~1%
IF %Debug_Mode% EQU 1 echo [DEBUG] Extension Process: %Extension_Type%
IF %Global_Variable_Int_1% GEQ %Global_Variable_Int_2% GOTO FILENAME_EXTENSION_FOR_LOOP_END
GOTO FILENAME_EXTENSION_FOR_LOOP_START
:FILENAME_EXTENSION_FOR_LOOP_END

IF %Debug_Mode% EQU 1 echo [DEBUG] Saved Extension Type: %Extension_Type%

::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: EXTENSION CHECKER (IS IT A MOVIE OR A SUBTITLE?)

IF %Extension_Type% EQU mkv GOTO :FILENAME_CHECKER
IF %Extension_Type% EQU avi GOTO :FILENAME_CHECKER
IF %Extension_Type% EQU .ts GOTO :FILENAME_CHECKER
IF %Extension_Type% EQU peg GOTO :FILENAME_CHECKER
IF %Extension_Type% EQU ebm GOTO :FILENAME_CHECKER
IF %Extension_Type% EQU mov GOTO :FILENAME_CHECKER
IF %Extension_Type% EQU mp4 GOTO :FILENAME_CHECKER
IF %Extension_Type% EQU srt GOTO :FILENAME_CHECKER
IF %Extension_Type% EQU txt GOTO :FILENAME_CHECKER
MOVE "%Original_Filename%" "Trash\[UNSUPPORTED FILE] %Original_Filename%"
GOTO START_PROGRAM

::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: FILENAME CHECKER (ARE YOU DUMB?)
:FILENAME_CHECKER

IF %Extension_Type% EQU mkv set File_Name=%Original_Filename:~0,-4%
IF %Extension_Type% EQU avi set File_Name=%Original_Filename:~0,-4%
IF %Extension_Type% EQU .ts set File_Name=%Original_Filename:~0,-3%
IF %Extension_Type% EQU peg set File_Name=%Original_Filename:~0,-5%
IF %Extension_Type% EQU ebm set File_Name=%Original_Filename:~0,-5%
IF %Extension_Type% EQU mov set File_Name=%Original_Filename:~0,-4%
IF %Extension_Type% EQU mp4 set File_Name=%Original_Filename:~0,-4%
IF %Extension_Type% EQU srt set File_Name=%Original_Filename:~0,-4%
IF %Extension_Type% EQU txt set File_Name=%Original_Filename:~0,-4%

IF %Debug_Mode% EQU 1 echo [DEBUG] Removed File Extension: %File_Name%

IF %Extension_Type% EQU mkv set Global_Variable_Int_1=4
IF %Extension_Type% EQU avi set Global_Variable_Int_1=4
IF %Extension_Type% EQU .ts set Global_Variable_Int_1=3
IF %Extension_Type% EQU peg set Global_Variable_Int_1=5
IF %Extension_Type% EQU ebm set Global_Variable_Int_1=5
IF %Extension_Type% EQU mov set Global_Variable_Int_1=4
IF %Extension_Type% EQU mp4 set Global_Variable_Int_1=4
IF %Extension_Type% EQU srt set Global_Variable_Int_1=4
IF %Extension_Type% EQU txt set Global_Variable_Int_1=4

set /A Global_Variable_Int_2=0
set /A Global_Variable_Int_3=%Filename_Length%-%Global_Variable_Int_1%-6
set Year_Value=%File_Name%

IF %Debug_Mode% EQU 1 echo [DEBUG] Set Reduction Counter: %Global_Variable_Int_3%/%Filename_Length%

:YEAR_VALUE_FOR_LOOP_START
set /A Global_Variable_Int_2+=1
set Year_Value=%Year_Value:~1%
IF %Debug_Mode% EQU 1 echo [DEBUG] Year Value: %Year_Value%
IF %Global_Variable_Int_2% GEQ %Global_Variable_Int_3% GOTO YEAR_VALUE_FOR_LOOP_END
GOTO YEAR_VALUE_FOR_LOOP_START
:YEAR_VALUE_FOR_LOOP_END

IF %Debug_Mode% EQU 1 echo [DEBUG] Saved Year Value (With Bracket): %Year_Value%

set Global_Variable_Char_1=(
set Global_Variable_Char_2=)
set /A Global_Variable_Int_1=1

IF %Year_Value:~0,-5%X NEQ %Global_Variable_Char_1%X set /A Global_Variable_Int_1=0
IF %Year_Value:~5%X NEQ %Global_Variable_Char_2%X set /A Global_Variable_Int_1=0
IF %Year_Value:~1,-1% LSS 1980 set /A Global_Variable_Int_1=0
IF %Year_Value:~1,-1% GTR %date:~10% set /A Global_Variable_Int_1=0

IF %Debug_Mode% EQU 1 echo [DEBUG] Front Bracket: %Year_Value:~0,-5%
IF %Debug_Mode% EQU 1 echo [DEBUG] End Bracket: %Year_Value:~5%
IF %Debug_Mode% EQU 1 echo [DEBUG] Year Value (Without Bracket): %Year_Value:~1,-1%
IF %Debug_Mode% EQU 1 echo [DEBUG] Current Year Value: %date:~10%
IF %Debug_Mode% EQU 1 echo [DEBUG] Filename Error (0 = Failed): %Global_Variable_Int_1%

IF %Global_Variable_Int_1% EQU 0 MOVE "%Original_Filename%" "Trash\[WRONG FILENAME] %Original_Filename%"

::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: PRE-CONVERSION PROCESS FOR MP4 AND NON-MP4 (FAILURE TO PLAN IS A PLAN TO FAILURE)
move "%Original_Filename%" "locked.test" 1>nul 2>nul

(dir /b *.test > "%Temporary_Folder%\temp.var") > nul 2>nul
set /p Global_Variable_Char_1=<"%Temporary_Folder%\temp.var"

IF "%Global_Variable_Char_1%" NEQ "locked.test" echo  -  - Movie File is Locked. Waiting for File to Unlock...
IF "%Global_Variable_Char_1%" NEQ "locked.test" %FFmpeg_Folder%\ffplay -loglevel quiet -autoexit -nodisp "%Sound_Folder%\warning.wav" | %Blink_Folder%\blink1-tool -q --id all --rgb 255,0,0 --flash 3
IF "%Global_Variable_Char_1%" NEQ "locked.test" GOTO START_PROGRAM
move "locked.test" "%Original_Filename%" 1>nul 2>nul

set /A CONVERTED_MOVIE_STATUS=0
set /A Global_Variable_Int_1=0
set /A Global_Variable_Int_2=0

IF %Extension_Type% EQU mkv GOTO CONVERT_NON_MP4
IF %Extension_Type% EQU avi GOTO CONVERT_NON_MP4
IF %Extension_Type% EQU .ts GOTO CONVERT_NON_MP4
IF %Extension_Type% EQU peg GOTO CONVERT_NON_MP4
IF %Extension_Type% EQU ebm GOTO CONVERT_NON_MP4
IF %Extension_Type% EQU mov GOTO CONVERT_NON_MP4
IF %Extension_Type% EQU mp4 GOTO CHECK_SUBTITLE_FILE
IF %Extension_Type% EQU srt GOTO BLOCKING_FILE
IF %Extension_Type% EQU txt GOTO BLOCKING_FILE

::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: CONVERT NON-MP4 MOVIES HERE TO MP4 (LET'S GET TO BUSINESS)
:CONVERT_NON_MP4

(dir /b *.mp4 > "%Temporary_Folder%\temp.var") > nul 2>nul
set /p Global_Variable_Char_1=<"%Temporary_Folder%\temp.var"
IF "%File_Name%.mp4" EQU "%Global_Variable_Char_1%" GOTO CHECK_SUBTITLE_FILE

set /A CONVERTED_MOVIE_STATUS=1
set /A Global_Variable_Int_1=1

%Blink_Folder%\blink1-tool -q --id all --white --led 1 && %Blink_Folder%\blink1-tool -q --id all --rgb 255,0,0 --led 2

IF %Extension_Type% EQU mkv echo MKV File Found: %Original_Filename%! Converting...
IF %Extension_Type% EQU avi echo AVI File Found: %Original_Filename%! Converting...
IF %Extension_Type% EQU .ts echo TS File Found: %Original_Filename%! Converting...
IF %Extension_Type% EQU peg echo MPEG File Found: %Original_Filename%! Converting...
IF %Extension_Type% EQU ebm echo WEBM File Found: %Original_Filename%! Converting...
IF %Extension_Type% EQU mov echo MOV File Found: %Original_Filename%! Converting...

echo -  - Format Shifting to MP4. If you want to stop, please press CTRL+C in 3...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%Speech_Voice%'); $speak.Rate=%Speech_Voice_Speed%; $speak.Speak('Format Shifting to MP4. If you want to stop, please press control c in 3');"
echo -  - 2
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%Speech_Voice%'); $speak.Rate=%Speech_Voice_Speed%; $speak.Speak('2');"
echo -  - 1
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%Speech_Voice%'); $speak.Rate=%Speech_Voice_Speed%; $speak.Speak('1');"
echo -  - Converting...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%Speech_Voice%'); $speak.Rate=%Speech_Voice_Speed%; $speak.Speak('Converting');"

color C7
%FFmpeg_Folder%\ffmpeg -i "%Original_Filename%" -acodec copy -vcodec copy "%File_Name%.mp4"
%FFmpeg_Folder%\ffplay -loglevel quiet -autoexit -nodisp "%Sound_Folder%\converted.wav"
cls
echo            e   e                         ,e,            e88'Y88                                              d8                  
echo           d8b d8b     e88 88e  Y8b Y888P  "   ,e e,    d888  'Y  e88 88e  888 8e  Y8b Y888P  ,e e,  888,8,  d88    ,e e,  888,8, 
echo          e Y8b Y8b   d888 888b  Y8b Y8P  888 d88 88b  C8888     d888 888b 888 88b  Y8b Y8P  d88 88b 888 "  d88888 d88 88b 888 "  
echo         d8b Y8b Y8b  Y888 888P   Y8b "   888 888   ,   Y888  ,d Y888 888P 888 888   Y8b "   888   , 888     888   888   , 888    
echo        d888b Y8b Y8b  "88 88"     Y8P    888  "YeeP"    "88,d88  "88 88"  888 888    Y8P     "YeeP" 888     888    "YeeP" 888    
echo  ------------------------------------------------------------------------------------------------------------------------------------
::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: GET SUBTITLES/RIP FROM MOVIE (GOTTA HAVE THE ACCESSIBILITY OPTIONS FOR THE DISABLED...)
:CHECK_SUBTITLE_FILE
IF %Global_Variable_Int_1% EQU 1 echo Converted MP4 File Found: %File_Name%.mp4
IF %Global_Variable_Int_1% NEQ 1 echo MP4 File Found: %File_Name%.mp4

echo -  - Finding SRT/No-SRT File based on Movie Name: %File_Name%.srt or %File_Name%.txt

:SUBTITLE_RIP_LANDING_POINT

set No_Subtitle_File=null
set Subtitle_File=null

(dir /b *.txt > "%Temporary_Folder%\temp.var") > nul 2>nul
set /p No_Subtitle_File=<"%Temporary_Folder%\temp.var"
(dir /b *.srt > "%Temporary_Folder%\temp.var") > nul 2>nul
set /p Subtitle_File=<"%Temporary_Folder%\temp.var"

set /A SUB_OR_NOSUB_CHECK_VALUE=0

IF %Debug_Mode% EQU 1 echo [DEBUG] Subtitle File Name: %Subtitle_File%
IF %Debug_Mode% EQU 1 echo [DEBUG] No Subtitle File Name: %No_Subtitle_File%

IF "%Subtitle_File%" EQU "%File_Name%.srt" set /A SUB_OR_NOSUB_CHECK_VALUE=2
IF "%Subtitle_File%" EQU "%File_Name%.srt" GOTO CHECK_SUBTITLE_SIZE

IF "%No_Subtitle_File%" NEQ "%File_Name%.txt" echo -  - No Subtitle or No-SRT Confirmation File Not Found! Skipping this file...
IF "%No_Subtitle_File%" NEQ "%File_Name%.txt" GOTO BLOCKING_FILE

set /A SUB_OR_NOSUB_CHECK_VALUE=1
IF %Global_Variable_Int_2% EQU 0 echo -  - No-SRT Confirmation File Found! Attempting to Rip Subtitle from the Movie...
IF %Global_Variable_Int_2% EQU 1 echo -  - Attempt to Rip Failed! Proceeding...
IF %Global_Variable_Int_2% EQU 1 GOTO SKIP_RIP_SUBTITLE

%FFmpeg_Folder%\ffmpeg -i "%Original_Filename%" -map 0:s:0? "%File_Name%.srt" 1>nul 2>nul

set /A Global_Variable_Int_2=1

GOTO SUBTITLE_RIP_LANDING_POINT

:SKIP_RIP_SUBTITLE
GOTO CHECK_RESOLUTION_BITRATE


::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: CHECKING SUBTITLE FILE SIZE IF THERE IS ONE (ARE YOU SURE THIS IS THE RIGHT ONE?)
:CHECK_SUBTITLE_SIZE
for %%I in ("%File_Name%.srt") do @set /A Global_Variable_Int_1=%%~zI

IF %Debug_Mode% EQU 1 echo [DEBUG] Subtitle File Size: %Global_Variable_Int_1% Bytes

IF %Global_Variable_Int_1% LSS 10 echo -  - Subtitle File Error! Cancelling Progress...
IF %Global_Variable_Int_1% LSS 10 GOTO BLOCKING_FILE

IF %Global_Variable_Int_2% EQU 1 echo -  - Subtitle File Ripped Successfully! Evaluating Bitrate and Resolution...
IF %Global_Variable_Int_2% EQU 0 echo -  - Subtitle File Passed! Evaluating Bitrate and Resolution...

::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: OPTIMIZING VIDEO FOR STREAMING, 1080P AND 2600KHZ MAX (COME BACK LATER IF YOU'RE TOO BIG)
:CHECK_RESOLUTION_BITRATE

%FFmpeg_Folder%\ffprobe.exe -v error -select_streams v:0 -show_entries stream=width -of csv=s=x:p=0 "%Original_Filename%" > "%Temporary_Folder%\temp.var"
set /p Global_Variable_Int_1=<"%Temporary_Folder%\temp.var"

if %Global_Variable_Int_1% == 1920 (set Global_Variable_Int_2=1080)
if %Global_Variable_Int_1% LSS 1920 (set Global_Variable_Int_2=720)
if %Global_Variable_Int_1% GTR 1920 (GOTO SEND_TO_ADOBE)

%FFmpeg_Folder%\ffprobe.exe -v error -show_entries stream=bit_rate -select_streams v "%File_Name%.mp4" > "temp.var"
for /f "skip=1" %%i in (temp.var) do (set Global_Variable_Int_3=%%i & goto FORCE_END_BITRATE_LOOP)

:FORCE_END_BITRATE_LOOP
ERASE /F /Q temp.var
set /a Global_Variable_Int_3=%Global_Variable_Int_3:~9%/1000
IF %Debug_Mode% EQU 1 echo [DEBUG] Bitrate: echo %Global_Variable_Int_3% kbps

set /a Global_Variable_Int_4=2600

if %Global_Variable_Int_3% GTR %Global_Variable_Int_4% (GOTO SEND_TO_ADOBE)
echo -  - Bitrate/Resolution Pass... Frame Height: %Global_Variable_Int_1%. Resolution: %Global_Variable_Int_2%p. Bitrate: %Global_Variable_Int_3%/%Global_Variable_Int_4%. Processing Movie...
GOTO PROCESS_MP4


::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: SEND TO ADOBE FOR FURTHER SIZE REDUCTION, BOTH RESOLUTION AND/OR BITRATE (THAT ONE TIME WHEN TOO BIG IS A CONS, AND NO SHE DIDN'T SAY THE SAME...)
:SEND_TO_ADOBE
echo -  - Bitrate/Resolution Fail... Frame Height: %Global_Variable_Int_1%. Resolution: %Global_Variable_Int_2%p. Bitrate: %Global_Variable_Int_3%/%Global_Variable_Int_4%. Sending Movie for Conversion...
%FFmpeg_Folder%\ffplay -loglevel quiet -autoexit -nodisp "%Sound_Folder%\warning.wav" | %Blink_Folder%\blink1-tool -q --id all --rgb 255,0,255 --led 1 && %Blink_Folder%\blink1-tool -q --id all --rgb 0,255,255 --led 2

echo -  - Moving MP4 File to Adobe Watch Folder...
move %File_Name%.mp4 %Adobe_Watch_Folder%\%File_Name%.mp4
echo -  - Moving MP4 File to Adobe Watch Folder... Success!

call %Adobe_ME_App%

IF %CONVERTED_MOVIE_STATUS% EQU 1 echo -  - Moving Original Non-MP4 File to Archive Folder...
IF %CONVERTED_MOVIE_STATUS% EQU 1 move "%Original_Filename%" "%Archive_Folder%\%Original_Filename%"
IF %CONVERTED_MOVIE_STATUS% EQU 1 echo -  - Moving Original Non-MP4 File to Archive Folder... Success!

::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: NOTIFY BLOCKING SRT AND TXT FILE THAT DISABLE OTHER VIDEO FROM BEING PROCESSED (EITHER YOU'RE DUMB, OR LATE, IN WHICH YOU'RE DUMB ANYWAYS...)
:BLOCKING_FILE
%FFmpeg_Folder%\ffplay -loglevel quiet -autoexit -nodisp "%Sound_Folder%\warning.wav" | %Blink_Folder%\blink1-tool -q --id all --rgb 255,255,0 --flash 3
echo -  - SRT/No-SRT Confirmation File is Blocking the Pipeline. Add Related Video or Remove SRT/No-SRT Confirmation File to Proceed. Ignore if Adobe Media Encoder is Processing...

GOTO START_PROGRAM

::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: ADDING SUBTITLE INTO MOVIE, SENDING MOVIE TO NAS, BACK-UP OLD FILES (WE'RE REACHING THE END NOW...)
:PROCESS_MP4

IF %SUB_OR_NOSUB_CHECK_VALUE% EQU 2 GOTO PROCESS_MP4_WITH_SUBTITLE
IF %SUB_OR_NOSUB_CHECK_VALUE% EQU 1 GOTO PROCESS_MP4_WITH_NO_SUBTITLE

:PROCESS_MP4_WITH_SUBTITLE

%Blink_Folder%\blink1-tool -q --id all --rgb 255,0,0 --led 1 && %Blink_Folder%\blink1-tool -q --id all --rgb 255,125,0 --led 2
echo -  - Adding subtitle stream into the movie. If you want to stop, please press CTRL+C in 3...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%Speech_Voice%'); $speak.Rate=%Speech_Voice_Speed%; $speak.Speak('Adding subtitle stream into the movie. If you want to stop, please press control c in 3');"
echo -  - 2
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%Speech_Voice%'); $speak.Rate=%Speech_Voice_Speed%; $speak.Speak('2');"
echo -  - 1
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%Speech_Voice%'); $speak.Rate=%Speech_Voice_Speed%; $speak.Speak('1');"
echo -  - Processing...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%Speech_Voice%'); $speak.Rate=%Speech_Voice_Speed%; $speak.Speak('Processing');"
color B0

%FFmpeg_Folder%\ffmpeg -i "%File_Name%.mp4" -c:v copy -c:a copy -sn "output-nosub.mp4"
%FFmpeg_Folder%\ffmpeg -i "%File_Name%.srt" -c:v copy -c:a copy "subtitle.srt"

move "%File_Name%.mp4" "backup.mp4"
move "%File_Name%.srt" "backup.srt"

move "output-nosub.mp4" "%File_Name%.mp4"
move "subtitle.srt" "%File_Name%.srt"

ERASE /F /Q "backup.mp4" 1>nul 2>nul
ERASE /F /Q "backup.srt" 1>nul 2>nul

%FFmpeg_Folder%\ffmpeg -i "%File_Name%.mp4" -i "%File_Name%.srt" -c copy -c:s mov_text -metadata:s:s:0 language=eng "%Converted_Folder%\%File_Name% [%Global_Variable_Int_2%p].mp4"
%FFmpeg_Folder%\ffplay -loglevel quiet -autoexit -nodisp "%Sound_Folder%\converted.wav" | %Blink_Folder%\blink1-tool -q --id all --rgb 255,125,0 --led 1 | %Blink_Folder%\blink1-tool -q --id all --rgb 255,255,0 --led 2

cls
echo            e   e                         ,e,            e88'Y88                                              d8                  
echo           d8b d8b     e88 88e  Y8b Y888P  "   ,e e,    d888  'Y  e88 88e  888 8e  Y8b Y888P  ,e e,  888,8,  d88    ,e e,  888,8, 
echo          e Y8b Y8b   d888 888b  Y8b Y8P  888 d88 88b  C8888     d888 888b 888 88b  Y8b Y8P  d88 88b 888 "  d88888 d88 88b 888 "  
echo         d8b Y8b Y8b  Y888 888P   Y8b "   888 888   ,   Y888  ,d Y888 888P 888 888   Y8b "   888   , 888     888   888   , 888    
echo        d888b Y8b Y8b  "88 88"     Y8P    888  "YeeP"    "88,d88  "88 88"  888 888    Y8P     "YeeP" 888     888    "YeeP" 888    
echo  ------------------------------------------------------------------------------------------------------------------------------------
IF %CONVERTED_MOVIE_STATUS% EQU 1 echo -  - Moving Original Non-MP4 File to Archive Folder...
IF %CONVERTED_MOVIE_STATUS% EQU 1 move "%Original_Filename%" "%Archive_Folder%\%Original_Filename%"
IF %CONVERTED_MOVIE_STATUS% EQU 1 echo -  - Moving Original Non-MP4 File to Archive Folder... Success!

IF %CONVERTED_MOVIE_STATUS% EQU 1 echo -  - Moving Converted MP4 File to Archive Folder...
IF %CONVERTED_MOVIE_STATUS% NEQ 1 echo -  - Moving Original MP4 File to Archive Folder...
move "%File_Name%.mp4" "%Archive_Folder%\%File_Name%.mp4"
IF %CONVERTED_MOVIE_STATUS% EQU 1 echo -  - Moving Converted MP4 File to Archive Folder...Success!
IF %CONVERTED_MOVIE_STATUS% NEQ 1 echo -  - Moving Original MP4 File to Archive Folder...Success!

ERASE /F /Q "%File_Name%.txt" 1>nul 2>nul

echo -  - Moving SRT File to Archive Folder...!
move "%File_Name%.srt" "%Archive_Folder%\%File_Name%.srt%"
echo -  - Moving SRT File to Archive Folder...Success!

GOTO SEND_TO_NAS

:PROCESS_MP4_WITH_NO_SUBTITLE

echo -  - No Subtitle Detected. Moving Files Around...
%Blink_Folder%\blink1-tool -q --id all --rgb 255,0,0 --led 1 && %Blink_Folder%\blink1-tool -q --id all --rgb 255,125,0 --led 2
copy "%File_Name%.mp4" "%Converted_Folder%\%File_Name% [%Global_Variable_Int_2%p].mp4"
%Blink_Folder%\blink1-tool -q --id all --rgb 255,125,0 --led 1 && %Blink_Folder%\blink1-tool -q --id all --rgb 255,255,0 --led 2

IF %CONVERTED_MOVIE_STATUS% EQU 1 echo -  - Moving Original Non-MP4 File to Archive Folder...
IF %CONVERTED_MOVIE_STATUS% EQU 1 move "%Original_Filename%" "%Archive_Folder%\%Original_Filename%"
IF %CONVERTED_MOVIE_STATUS% EQU 1 echo -  - Moving Original File to Archive Folder... Success!

IF %CONVERTED_MOVIE_STATUS% EQU 1 echo -  - Moving Converted MP4 File to Archive Folder...
IF %CONVERTED_MOVIE_STATUS% NEQ 1 echo -  - Moving Original MP4 File to Archive Folder...
move "%File_Name%.mp4" "%Archive_Folder%\%File_Name%.mp4"
IF %CONVERTED_MOVIE_STATUS% EQU 1 echo -  - Moving Converted MP4 File to Archive Folder...Success!
IF %CONVERTED_MOVIE_STATUS% NEQ 1 echo -  - Moving Original MP4 File to Archive Folder...Success!

ERASE /F /Q "%File_Name%.txt"
echo -  - Erasing No-SRT Confirmation File...Success!
%FFmpeg_Folder%\ffplay -loglevel quiet -autoexit -nodisp "%Sound_Folder%\converted.wav" | %Blink_Folder%\blink1-tool -q --id all --rgb 255,0,0 --led 1 | %Blink_Folder%\blink1-tool -q --id all --rgb 255,125,0 --led 2



::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: ADDING SUBTITLE INTO MOVIE, SENDING MOVIE TO NAS, BACK-UP OLD FILES (WE'RE REACHING THE END NOW...)
:SEND_TO_NAS
%Blink_Folder%\blink1-tool -q --id all --rgb 255,255,0 --led 1 && %Blink_Folder%\blink1-tool -q --id all --rgb 0,255,0 --led 2
echo -  - Uploading Movie to NAS Folder...
copy "%Converted_Folder%\%File_Name% [%Global_Variable_Int_2%p].mp4" "\\%NAS_Folder%"
echo -  - Uploading Movie to NAS Folder...Success!

%FFmpeg_Folder%\ffplay -loglevel quiet -autoexit -nodisp "%Sound_Folder%\completed.wav" | %Blink_Folder%\blink1-tool -q --id all --rgb 0,255,0 --flash 3 | color A0

::END OF LINE
GOTO START_PROGRAM
echo #####################################################################################################################################
::$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$