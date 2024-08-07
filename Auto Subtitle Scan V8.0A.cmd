@echo off

:: WorkingDir can be anywhere.
set WorkingDir=E:\Movies Space\Output

:: WatchFolderDir is the directory where the mp4 will be moved in case it doesn't fit the resolution and bitrate.
set WatchFolderDir=E:\Movies Space\

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
set DoneDir=F:\Movie Converter Files\Done Convert

:: NASDir can be anywhere, the final directory to host these video files.
set NASDir=192.168.100.132\SeL\Movies\Unprocessed Movies

echo Variables:
echo %WorkingDir%
echo %WatchFolderDir%
echo %FFmpegDir%
echo %BlinkDir%
echo %TempDir%
echo %ArchiveDir%
echo %FSArchiveDir%
echo %DoneDir%
echo %NASDir%
echo.
echo Complete Dirs:
echo %WorkingDir%
echo %WatchFolderDir%
echo %FFmpegDir%
echo %BlinkDir%
echo %TempDir%
echo %WorkingDir%\%ArchiveDir%
echo %WorkingDir%\%FSArchiveDir%
echo %WorkingDir%\%DoneDir%
echo %NASDir%

timeout /t 2

cls

E:
cd %WorkingDir%
mode con: cols=135 lines=14
%BlinkDir%\blink1-tool -q --id all --on

set version=V8 Alpha

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

set /A red=0
set /A green=0
set /A blue=0
set /A step=0
title Movie Converter - By: Selvandiran Marimuthu [%version%]. Scanning Video Files...
color B

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

dir /b *.mkv > "%TempDir%\name.var"
set /p mkvfile=<"%TempDir%\name.var"

dir /b *.avi > "%TempDir%\name.var"
set /p avifile=<"%TempDir%\name.var"

dir /b *.ts > "%TempDir%\name.var"
set /p tsfile=<"%TempDir%\name.var"

dir /b *.mpeg > "%TempDir%\name.var"
set /p mpegfile=<"%TempDir%\name.var"

dir /b *.webm > "%TempDir%\name.var"
set /p webmfile=<"%TempDir%\name.var"

dir /b *.mov > "%TempDir%\name.var"
set /p movfile=<"%TempDir%\name.var"

color 4

if "%mkvfile%" NEQ "z.mkv" (GOTO FS1)
if "%avifile%" NEQ "z.avi" (GOTO FS2)
if "%tsfile%" NEQ "z.ts" (GOTO FS3)
if "%mpegfile%" NEQ "z.mpeg" (GOTO FS4)
if "%webmfile%" NEQ "z.webm" (GOTO FS5)
if "%movfile%" NEQ "z.mov" (GOTO FS6)
GOTO START

:FS1
mode con: cols=135 lines=64
%BlinkDir%\blink1-tool -q --id all --white --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 2
title MKV Video Found: %mkvfile%! Converting...
echo %mkvfile% Detected. Format Shifting to MP4!
echo Press Ctrl+C to Terminate...
timeout /t 5
%FFmpegDir%\ffmpeg -i "%mkvfile%" -acodec copy -vcodec copy "%mkvfile:~0,-4%.mp4"
move "%mkvfile%" "%FSArchiveDir%\%mkvfile%"
GOTO DISPLAY

:FS2
mode con: cols=135 lines=64
%BlinkDir%\blink1-tool -q --id all --white --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 2
title AVI Video Found: %avifile%! Converting...
echo %avifile% Detected. Format Shifting to MP4!
echo Press Ctrl+C to Terminate...
timeout /t 5
%FFmpegDir%\ffmpeg -i "%avifile%" -acodec copy -vcodec copy "%avifile:~0,-4%.mp4"
move "%avifile%" "%FSArchiveDir%\%avifile%"
GOTO DISPLAY

:FS3
mode con: cols=135 lines=64
%BlinkDir%\blink1-tool -q --id all --white --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 2
title TS Video Found: %tsfile%! Converting...
echo %tsfile% Detected. Format Shifting to MP4!
echo Press Ctrl+C to Terminate...
timeout /t 5
%FFmpegDir%\ffmpeg -i "%tsfile%" -acodec copy -vcodec copy "%tsfile:~0,-3%.mp4"
move "%tsfile%" "%FSArchiveDir%\%tsfile%"
GOTO DISPLAY

:FS4
mode con: cols=135 lines=64
%BlinkDir%\blink1-tool -q --id all --white --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 2
title MPEG Video Found: %mpegfile%! Converting...
echo %mpegfile% Detected. Format Shifting to MP4!
echo Press Ctrl+C to Terminate...
timeout /t 5
%FFmpegDir%\ffmpeg -i "%mpegfile%" -acodec copy -vcodec copy "%mpegfile:~0,-5%.mp4"
move "%mpegfile%" "%FSArchiveDir%\%mpegfile%"
GOTO DISPLAY

:FS5
mode con: cols=135 lines=64
%BlinkDir%\blink1-tool -q --id all --white --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 2
title WEBM Video Found: %webmfile%! Converting...
echo %webmfile% Detected. Format Shifting to MP4!
echo Press Ctrl+C to Terminate...
timeout /t 5
%FFmpegDir%\ffmpeg -i "%webmfile%" -acodec copy -vcodec copy "%webmfile:~0,-5%.mp4"
move "%webmfile%" "%FSArchiveDir%\%webmfile%"
GOTO DISPLAY

:FS6
mode con: cols=135 lines=64
%BlinkDir%\blink1-tool -q --id all --white --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,0,0 --led 2
title MOV Video Found: %movfile%! Converting...
echo %movfile% Detected. Format Shifting to MP4!
echo Press Ctrl+C to Terminate...
timeout /t 5
%FFmpegDir%\ffmpeg -i "%movfile%" -acodec copy -vcodec copy "%movfile:~0,-4%.mp4"
move "%movfile%" "%FSArchiveDir%\%movfile%"
GOTO DISPLAY

:START

dir /b *.mp4 > "%TempDir%\name.var"
set /p filename=<"%TempDir%\name.var"
color 3

if "%filename%" == "z.mp4" (GOTO A) else (GOTO B)

:A
echo - # No File Found
GOTO :C

:B
echo - # Filename: %filename%

:C
if "%filename%" == "z.mp4" (GOTO end)

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
%BlinkDir%\blink1-tool -q --id all --rgb 255,255,0 --flash 3
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
echo Press Ctrl+C to Terminate...
timeout /t 5
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
GOTO NAS_COPY


:DONESRT
title SUCCESS! %movie_name% Subtitle Soft-Code and [%resolution%p] Tag Update (Auto)...
color 2
%BlinkDir%\blink1-tool -q --id all --rgb 255,125,0 --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 255,255,0 --led 2
echo ############################################################ CONVERTED! ############################################################
move convert.mp4 "%ArchiveDir%\%filename%"
move convert.srt "%ArchiveDir%\%srtfilename%"

:NAS_COPY
color 6
%BlinkDir%\blink1-tool -q --id all --rgb 255,255,0 --led 1 && %BlinkDir%\blink1-tool -q --id all --rgb 0,255,0 --led 2
echo ######################################################### UPLOADING TO NAS #########################################################
copy "%DoneDir%\%filename:~0,-4% [%resolution%p].mp4" "\\%NASDir%"
color D
echo ############################################################ COMPLETED! ############################################################
%BlinkDir%\blink1-tool -q --id all --rgb 0,255,0 --flash 3
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