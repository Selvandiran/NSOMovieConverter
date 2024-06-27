@echo off

:: Set Program Version
set version=V8 Final
:: Changelog:
:: - Removed Dependencies (Major Program Update) - V8 Beta
:: - Added Changelog & Future Update in batch file. - V8 Beta
:: - Add Chimes/Sounds/Voices. - V8 Final
:: - Add Support to Change Voices. - V8 Final

:: Future Updates:
:: - Add Support for Filename Checker for Watch Folders (Compliance)
:: - Add Support for Auto-Tags for Watch Folders (Filename Checker)
:: - Add Support for Autostart for Adobe Media Encoder

:: Available Voices: Microsoft David Desktop, Microsoft Hazel Desktop, Microsoft Zira Desktop, Microsoft Richard Desktop
set voice=Microsoft Richard Desktop

:: WorkingDir can be anywhere.
set WorkingDir=E:\Movies\Output

:: WatchFolderDir is the directory where the mp4 will be moved in case it doesn't fit the resolution and bitrate.
set WatchFolderDir=E:\Movies\

::FFmpegDir is the directory which ffmpeg.exe and ffprobe.exe is in.
set FFmpegDir=C:\FFmpeg\bin

:: BlinkDir is the directory which blink1-tool.exe is in.
set BlinkDir=C:\blink1-tool-v2.3.0

:: TempDir can be anywhere. Preferably not on SSD.
set TempDir=F:\Movie Converter Files\Temp Files

:: ArchiveDir can be anywhere, used for originals of converted soft-sub movies.
set ArchiveDir=F:\Movie Converter Files\Movie Archive

:: FSArchiveDir can be anywhere, used for originals of converted non-mp4s.
set FSArchiveDir=F:\Movie Converter Files\Format-Shift Archive

:: DoneDir can be anywhere, used for converted movies before uploading to NAS (redundancy).
set DoneDir=F:\Movie Converter Files\Converted Files

:: NASDir can be anywhere, the final directory to host these video files.
set NASDir=192.168.100.132\SeL\Movies\Unprocessed Movies

:: AlertDir can be anywhere, used to store audio files for alerts.
set AlertDir=F:\Movie Converter Files\Alerts
set AlertMode=1
:: AlertMode 1 for Normal Sound, 0 for Silent.

echo.
echo Complete Dirs:
echo %WorkingDir%
echo %WatchFolderDir%
echo %FFmpegDir%
echo %BlinkDir%
echo %TempDir%
echo %WorkingDir%
echo %WorkingDir%
echo %WorkingDir%
echo %NASDir%
echo %AlertDir%
echo %AlertMode%

::timeout /t 5

cls

E:
cd %WorkingDir%
mode con: cols=135 lines=14
%BlinkDir%\blink1-tool -q --id all --on
title Movie Converter - By: Selvandiran Marimuthu [%version%]. Scanning Video Files...
color B

echo.
echo  ####################################################################################################################################
echo. 
echo            e   e                         ,e,            e88'Y88                                              d8                  
echo           d8b d8b     e88 88e  Y8b Y888P  "   ,e e,    d888  'Y  e88 88e  888 8e  Y8b Y888P  ,e e,  888,8,  d88    ,e e,  888,8, 
echo          e Y8b Y8b   d888 888b  Y8b Y8P  888 d88 88b  C8888     d888 888b 888 88b  Y8b Y8P  d88 88b 888 "  d88888 d88 88b 888 "  
echo         d8b Y8b Y8b  Y888 888P   Y8b "   888 888   ,   Y888  ,d Y888 888P 888 888   Y8b "   888   , 888     888   888   , 888    
echo        d888b Y8b Y8b  "88 88"     Y8P    888  "YeeP"    "88,d88  "88 88"  888 888    Y8P     "YeeP" 888     888    "YeeP" 888    
echo.
echo        Made By: Selvandiran Marimuthu                                                                             Version: %version%
echo.
echo  ########################################################### INITIALIZING ###########################################################

%FFmpegDir%\ffplay -loglevel quiet -autoexit -nodisp "%AlertDir%\startup_sound.wav" | %BlinkDir%\blink1-tool -q --id all -t 30 --random=550
%BlinkDir%\blink1-tool -q --id all --on

set /A red=255
set /A green=0
set /A blue=0
set /A step=7

:LOOP
:step0

::echo Red:%red% Green:%green% Blue:%blue% Step:%step%

If NOT %step%==0 GOTO step1
set /A red=%red%+15
If %red%==255 (set /A step=1)
GOTO end

:step1
If NOT %step%==1 GOTO step2
set /A green=%green%+15
If %green%==255 (set /A step=2)
GOTO end

:step2
If NOT %step%==2 GOTO step3
set /A red=%red%-15
If %red%==0 (set /A step=3)
GOTO end

:step3
If NOT %step%==3 GOTO step4
set /A blue=%blue%+15
If %blue%==255 (set /A step=4)
GOTO end

:step4
If NOT %step%==4 GOTO step5
set /A green=%green%-15
If %green%==0 (set /A step=5)
GOTO end

:step5
If NOT %step%==5 GOTO step6
set /A red=%red%+15
If %red%==255 (set /A step=6)
GOTO end

:step6
If NOT %step%==6 GOTO step7
set /A blue=%blue%-15
If %blue%==0 (set /A step=7)
GOTO end

:step7
If NOT %step%==7 GOTO step1
set /A step=1

cls
echo. 
echo            e   e                         ,e,            e88'Y88                                              d8                  
echo           d8b d8b     e88 88e  Y8b Y888P  "   ,e e,    d888  'Y  e88 88e  888 8e  Y8b Y888P  ,e e,  888,8,  d88    ,e e,  888,8, 
echo          e Y8b Y8b   d888 888b  Y8b Y8P  888 d88 88b  C8888     d888 888b 888 88b  Y8b Y8P  d88 88b 888 "  d88888 d88 88b 888 "  
echo         d8b Y8b Y8b  Y888 888P   Y8b "   888 888   ,   Y888  ,d Y888 888P 888 888   Y8b "   888   , 888     888   888   , 888    
echo        d888b Y8b Y8b  "88 88"     Y8P    888  "YeeP"    "88,d88  "88 88"  888 888    Y8P     "YeeP" 888     888    "YeeP" 888    
echo.
echo        By: Selvandiran Marimuthu                                                                                  Version: %version%
echo  ------------------------------------------------------------------------------------------------------------------------------------

echo %date%, %time% - Scanning for New Video File...
title Movie Converter - By: Selvandiran Marimuthu [%version%]. Scanning Video Files...
color B

set mkvfile=null
dir /b *.mkv > "%TempDir%\name.var" 2>nul
set /p mkvfile=<"%TempDir%\name.var"

set avifile=null
dir /b *.avi > "%TempDir%\name.var" 2>nul
set /p avifile=<"%TempDir%\name.var"

set tsfile=null
dir /b *.ts > "%TempDir%\name.var" 2>nul
set /p tsfile=<"%TempDir%\name.var"

set mpegfile=null
dir /b *.mpeg > "%TempDir%\name.var" 2>nul
set /p mpegfile=<"%TempDir%\name.var"

set webmfile=null
dir /b *.webm > "%TempDir%\name.var" 2>nul
set /p webmfile=<"%TempDir%\name.var"

set movfile=null
dir /b *.mov > "%TempDir%\name.var" 2>nul
set /p movfile=<"%TempDir%\name.var"

color 4

if "%mkvfile%" NEQ "null" (GOTO FS1)
if "%avifile%" NEQ "null" (GOTO FS2)
if "%tsfile%" NEQ "null" (GOTO FS3)
if "%mpegfile%" NEQ "null" (GOTO FS4)
if "%webmfile%" NEQ "null" (GOTO FS5)
if "%movfile%" NEQ "null" (GOTO FS6)
GOTO START

:FS1
mode con: cols=135 lines=64
%BlinkDir%\blink1-tool -q --id all --white --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 2
title MKV Video Found: %mkvfile%! Converting...
echo Format Shifting to MP4. If you want to stop, please press CTRL+C in 3...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Format Shifting to MP4. If you want to stop, please press control c in 3');"
echo 2
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('2');"
echo 1
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('1');"
echo Converting...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Converting');"
%FFmpegDir%\ffmpeg -i "%mkvfile%" -acodec copy -vcodec copy "%mkvfile:~0,-4%.mp4"
%FFmpegDir%\ffplay -loglevel quiet -autoexit -nodisp "%AlertDir%\converted.wav"
move "%mkvfile%" "%FSArchiveDir%\%mkvfile%"
GOTO DISPLAY

:FS2
mode con: cols=135 lines=64
%BlinkDir%\blink1-tool -q --id all --white --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 2
title AVI Video Found: %avifile%! Converting...
echo Format Shifting to MP4. If you want to stop, please press CTRL+C in 3...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Format Shifting to MP4. If you want to stop, please press control c in 3');"
echo 2
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('2');"
echo 1
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('1');"
echo Converting...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Converting');"
%FFmpegDir%\ffmpeg -i "%avifile%" -acodec copy -vcodec copy "%avifile:~0,-4%.mp4"
%FFmpegDir%\ffplay -loglevel quiet -autoexit -nodisp "%AlertDir%\converted.wav"
move "%avifile%" "%FSArchiveDir%\%avifile%"
GOTO DISPLAY

:FS3
mode con: cols=135 lines=64
%BlinkDir%\blink1-tool -q --id all --white --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 2
title TS Video Found: %tsfile%! Converting...
echo Format Shifting to MP4. If you want to stop, please press CTRL+C in 3...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Format Shifting to MP4. If you want to stop, please press control c in 3');"
echo 2
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('2');"
echo 1
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('1');"
echo Converting...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Converting');"
%FFmpegDir%\ffmpeg -i "%tsfile%" -acodec copy -vcodec copy "%tsfile:~0,-3%.mp4"
%FFmpegDir%\ffplay -loglevel quiet -autoexit -nodisp "%AlertDir%\converted.wav"
move "%tsfile%" "%FSArchiveDir%\%tsfile%"
GOTO DISPLAY

:FS4
mode con: cols=135 lines=64
%BlinkDir%\blink1-tool -q --id all --white --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 2
title MPEG Video Found: %mpegfile%! Converting...
echo Format Shifting to MP4. If you want to stop, please press CTRL+C in 3...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Format Shifting to MP4. If you want to stop, please press control c in 3');"
echo 2
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('2');"
echo 1
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('1');"
echo Converting...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Converting');"
%FFmpegDir%\ffmpeg -i "%mpegfile%" -acodec copy -vcodec copy "%mpegfile:~0,-5%.mp4"
%FFmpegDir%\ffplay -loglevel quiet -autoexit -nodisp "%AlertDir%\converted.wav"
move "%mpegfile%" "%FSArchiveDir%\%mpegfile%"
GOTO DISPLAY

:FS5
mode con: cols=135 lines=64
%BlinkDir%\blink1-tool -q --id all --white --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 2
title WEBM Video Found: %webmfile%! Converting...
echo Format Shifting to MP4. If you want to stop, please press CTRL+C in 3...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Format Shifting to MP4. If you want to stop, please press control c in 3');"
echo 2
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('2');"
echo 1
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('1');"
echo Converting...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Converting');"
%FFmpegDir%\ffmpeg -i "%webmfile%" -acodec copy -vcodec copy "%webmfile:~0,-5%.mp4"
%FFmpegDir%\ffplay -loglevel quiet -autoexit -nodisp "%AlertDir%\converted.wav"
move "%webmfile%" "%FSArchiveDir%\%webmfile%"
GOTO DISPLAY

:FS6
mode con: cols=135 lines=64
%BlinkDir%\blink1-tool -q --id all --white --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 2
title MOV Video Found: %movfile%! Converting...
echo Format Shifting to MP4. If you want to stop, please press CTRL+C in 3...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Format Shifting to MP4. If you want to stop, please press control c in 3');"
echo 2
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('2');"
echo 1
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('1');"
echo Converting...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Converting');"
%FFmpegDir%\ffmpeg -i "%movfile%" -acodec copy -vcodec copy "%movfile:~0,-4%.mp4"
%FFmpegDir%\ffplay -loglevel quiet -autoexit -nodisp "%AlertDir%\converted.wav"
move "%movfile%" "%FSArchiveDir%\%movfile%"
GOTO DISPLAY

:START

set filename=null
dir /b *.mp4 > "%TempDir%\name.var" 2>nul
set /p filename=<"%TempDir%\name.var"
color 3

if "%filename%" == "null" (GOTO A) else (GOTO B)

:A
echo - # No File Found
GOTO :C

:B
echo - # Filename: %filename%
%FFmpegDir%\ffplay -loglevel panic -autoexit -nodisp "%AlertDir%\file_found.wav" > nul 2>nul


:C
if "%filename%" == "null" (GOTO end)

title MP4 Found: %filename%! Evaluating Resolution...

%FFmpegDir%\ffprobe.exe -v error -select_streams v:0 -show_entries stream=width -of csv=s=x:p=0 "%filename%" > "%TempDir%\res.var"

set /p res=<"%TempDir%\res.var"

if %res% == 1920 (set resolution=1080)
if %res% LSS 1920 (set resolution=720)
if %res% GTR 1920 (GOTO BITRATE_ERROR)

title MP4 Found: %filename%! Evaluating Bitrate...

%FFmpegDir%\ffprobe.exe -v error -show_entries stream=bit_rate -select_streams v "%filename%" > "%TempDir%\bitrate.var"

F:
cd %TempDir%

for /f "skip=1" %%i in (bitrate.var) do (set LINE=%%i & goto bitrate_ingested)
:bitrate_ingested

E:
cd %WorkingDir%

set /a %LINE%/1000
set /a max_bitrate = 2600

if %bit_rate% GTR %max_bitrate% (GOTO BITRATE_ERROR) else (GOTO BITRATE_OK)

:BITRATE_ERROR
echo -  - Bitrate/Resolution Fail... %bit_rate%/%max_bitrate%. Resolution: %resolution%p (%resolution%p)
move "%filename%" "%WatchFolderDir%\%filename%"

GOTO LOOP

:BITRATE_OK
echo -  - Bitrate Pass... %bit_rate%/%max_bitrate% (%resolution%p)

title Bitrate Passed: %filename%! Finding Subtitle File...

(dir /b *.srt > "%TempDir%\subsrt.var") > nul 2>nul
(dir /b *.txt > "%TempDir%\nonsrt.var") > nul 2>nul
set /p srtfilename=<"%TempDir%\subsrt.var"
set /p nosrtfilename=<"%TempDir%\nonsrt.var"

title Finding SRT File [%filename%]
echo -  - Finding SRT File based on Movie Name: "%filename:~0,-4%".srt

if "%filename:~0,-4%" == "%srtfilename:~0,-4%" (GOTO SRT)
if "%filename:~0,-4%" == "%nosrtfilename:~0,-4%" (GOTO NOSRT) else (GOTO SRT_PRE_LOOP)

:SRT_PRE_LOOP
echo -  - SRT or No-SRT File Not Found! Skipping this video until confirmation...
%FFmpegDir%\ffplay -loglevel quiet -autoexit -nodisp "%AlertDir%\sub_warning.wav" | %BlinkDir%\blink1-tool -q --id all --rgb 255,255,0 --flash 3
GOTO LOOP

:SRT
set srt_val=1
GOTO UNLOCK

:NOSRT
set srt_val=0
GOTO UNLOCK

:UNLOCK
if %srt_val% == 0 (GOTO D) else (GOTO E)
:D
echo -  - No-SRT File Found. Proceeding...
GOTO F

:E
echo -  - Found SRT: %srtfilename%

:F
if %srt_val% == 0 (GOTO G) else (GOTO H)

:G
title No-SRT File Found. Proceeding...
GOTO I

:H
title Found SRT: %srtfilename%

:I
2>nul (
  >>"%filename%" (call )
) && GOTO NEXT || GOTO UNLOCK

:NEXT
echo -  - Verified MP4 is not locked by other process: %filename%
if %srt_val% == 0 (GOTO NONE)
2>nul (
  >>"%srtfilename%" (call )
) && GOTO NONE || GOTO UNLOCK

:NONE
if %srt_val% == 0 (GOTO J) else (GOTO K)

:J
echo -  - Verified No-SRT Condition...
GOTO L

:K
echo -  - Verified SRT is not locked by other process: %srtfilename%

:L
echo:
color 4
if %srt_val% == 0 (GOTO TAG_UPDATE)
echo ##################################################### PREPARING FOR CONVERSION #####################################################
%BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,125,0 --led 2
echo Adding subtitle stream into the movie. If you want to stop, please press CTRL+C in 3...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Adding subtitle stream into the movie. If you want to stop, please press control c in 3');"
echo 2
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('2');"
echo 1
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('1');"
echo Converting...
PowerShell -Command "Add-Type -AssemblyName System.Speech; $speak=New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.SelectVoice('%voice%'); $speak.Rate=2; $speak.Speak('Converting');"
move "%filename%" convert.mp4
move "%srtfilename%" convert.srt
echo -  - Renamed for Subtitle Soft-Code and Tag Update, Proceeding in 5 Seconds...
timeout /t 5
title %movie_name% Subtitle Soft-Code and [%resolution%p] Tag Update (Auto)...
%FFmpegDir%\ffmpeg -i convert.mp4 -i convert.srt -c copy -c:s mov_text -metadata:s:s:0 language=eng "%DoneDir%\%filename:~0,-4% [%resolution%p].mp4"
GOTO DONESRT

:TAG_UPDATE
%BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,125,0 --led 2
move "%filename%" "%DoneDir%\%filename:~0,-4% [%resolution%p].mp4"
del /F /Q "%filename:~0,-4%.txt"
title SUCCESS! %movie_name% [%resolution%p] Tag Update (Auto)...
color 2
echo ############################################################ CONVERTED! ############################################################
%FFmpegDir%\ffplay -loglevel quiet -autoexit -nodisp "%AlertDir%\converted.wav"
GOTO NAS_COPY


:DONESRT
title SUCCESS! %movie_name% Subtitle Soft-Code and [%resolution%p] Tag Update (Auto)...
color 2
%BlinkDir%\blink1-tool -q --id all --rgb 255,125,0 --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,255,0 --led 2
echo ############################################################ CONVERTED! ############################################################
%FFmpegDir%\ffplay -loglevel quiet -autoexit -nodisp "%AlertDir%\converted.wav"
move convert.mp4 "%ArchiveDir%\%filename%"
move convert.srt "%ArchiveDir%\%srtfilename%"

:NAS_COPY
color 6
%BlinkDir%\blink1-tool -q --id all --rgb 255,255,0 --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 0,255,0 --led 2
echo ######################################################### UPLOADING TO NAS #########################################################
copy "%DoneDir%\%filename:~0,-4% [%resolution%p].mp4" "\\%NASDir%"
color D
echo ############################################################ COMPLETED! ############################################################
%FFmpegDir%\ffplay -loglevel quiet -autoexit -nodisp "%AlertDir%\completed.wav" | %BlinkDir%\blink1-tool -q --id all --rgb 0,255,0 --flash 3
set srt_val=2
set srtfilename=null
set nosrtfilename=null

:DISPLAY
mode con: cols=135 lines=14
echo. 
echo            e   e                         ,e,            e88'Y88                                              d8                  
echo           d8b d8b     e88 88e  Y8b Y888P  "   ,e e,    d888  'Y  e88 88e  888 8e  Y8b Y888P  ,e e,  888,8,  d88    ,e e,  888,8, 
echo          e Y8b Y8b   d888 888b  Y8b Y8P  888 d88 88b  C8888     d888 888b 888 88b  Y8b Y8P  d88 88b 888 "  d88888 d88 88b 888 "  
echo         d8b Y8b Y8b  Y888 888P   Y8b "   888 888   ,   Y888  ,d Y888 888P 888 888   Y8b "   888   , 888     888   888   , 888    
echo        d888b Y8b Y8b  "88 88"     Y8P    888  "YeeP"    "88,d88  "88 88"  888 888    Y8P     "YeeP" 888     888    "YeeP" 888    
echo.
echo        By: Selvandiran Marimuthu                                                                                  Version: %version%
echo  ------------------------------------------------------------------------------------------------------------------------------------

echo %date%, %time% - Scanning for New Video File...
title Movie Converter - By: Selvandiran Marimuthu [%version%]. Scanning Video Files...
color B
GOTO LOOP

:end
%BlinkDir%\blink1-tool -q --id all --rgb %red%,%green%,%blue%
GOTO step0