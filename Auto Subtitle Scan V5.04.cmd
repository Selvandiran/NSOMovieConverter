@echo off
mode con: cols=122 lines=30

:LOOP
echo %date%, %time% - Scanning for New Video File...
title Movie Converter - By: Selvandiran Marimuthu [V5.4]. Scanning Video Files...
color B

ping 127.0.0.1 -n 5 -l 0 | find "Reply" > nul

dir /b *.mkv > name.var
set /p mkvfile=<name.var

dir /b *.avi > name.var
set /p avifile=<name.var

dir /b *.ts > name.var
set /p tsfile=<name.var

dir /b *.mpeg > name.var
set /p mpegfile=<name.var

dir /b *.webm > name.var
set /p webmfile=<name.var

dir /b *.mov > name.var
set /p movfile=<name.var

color 4

if "%mkvfile%" NEQ "z.mkv" (GOTO FS1)
if "%avifile%" NEQ "z.avi" (GOTO FS2)
if "%tsfile%" NEQ "z.ts" (GOTO FS3)
if "%mpegfile%" NEQ "z.mpeg" (GOTO FS4)
if "%webmfile%" NEQ "z.webm" (GOTO FS5)
if "%movfile%" NEQ "z.mov" (GOTO FS6)
GOTO START

:FS1
title MKV Video Found: %mkvfile%! Converting...
echo %mkvfile% Detected. Format Shifting to MP4!
C:\ffmpeg\bin\ffmpeg -i "%mkvfile%" -acodec copy -vcodec copy "%mkvfile:~0,-4%.mp4"
move "%mkvfile%" "E:\Movies\Output\Archive (Format-Shift)\%mkvfile%"
GOTO START

:FS2
title AVI Video Found: %avifile%! Converting...
echo %avifile% Detected. Format Shifting to MP4!
C:\ffmpeg\bin\ffmpeg -i "%avifile%" -acodec copy -vcodec copy "%avifile:~0,-4%.mp4"
move "%avifile%" "E:\Movies\Output\Archive (Format-Shift)\%avifile%"
GOTO START

:FS3
title TS Video Found: %tsfile%! Converting...
echo %tsfile% Detected. Format Shifting to MP4!
C:\ffmpeg\bin\ffmpeg -i "%tsfile%" -acodec copy -vcodec copy "%tsfile:~0,-3%.mp4"
move "%tsfile%" "E:\Movies\Output\Archive (Format-Shift)\%tsfile%"
GOTO START

:FS4
title MPEG Video Found: %mpegfile%! Converting...
echo %mpegfile% Detected. Format Shifting to MP4!
C:\ffmpeg\bin\ffmpeg -i "%mpegfile%" -acodec copy -vcodec copy "%mpegfile:~0,-5%.mp4"
move "%mpegfile%" "E:\Movies\Output\Archive (Format-Shift)\%mpegfile%"
GOTO START

:FS5
title WEBM Video Found: %webmfile%! Converting...
echo %webmfile% Detected. Format Shifting to MP4!
C:\ffmpeg\bin\ffmpeg -i "%webmfile%" -acodec copy -vcodec copy "%webmfile:~0,-5%.mp4"
move "%webmfile%" "E:\Movies\Output\Archive (Format-Shift)\%webmfile%"
GOTO START

:FS6
title MOV Video Found: %movfile%! Converting...
echo %movfile% Detected. Format Shifting to MP4!
C:\ffmpeg\bin\ffmpeg -i "%movfile%" -acodec copy -vcodec copy "%movfile:~0,-4%.mp4"
move "%movfile%" "E:\Movies\Output\Archive (Format-Shift)\%movfile%"
GOTO START

:START

dir /b *.mp4 > name.var
set /p filename=<name.var
color 3

if "%filename%" == "z.mp4" (GOTO A) else (GOTO B)

:A
echo - # No File Found
GOTO :C

:B
echo - # Filename: %filename%

:C
if "%filename%" == "z.mp4" (GOTO LOOP)

title MP4 Found: %filename%! Evaluating Resolution...

C:\FFmpeg\bin\ffprobe.exe -v error -select_streams v:0 -show_entries stream=width -of csv=s=x:p=0 "%filename%" > res.var

set /p res=<res.var

if %res% == 1920 (set resolution=1080)
if %res% LSS 1920 (set resolution=720)
if %res% GTR 1920 (GOTO BITRATE_ERROR)

echo -  - Resolution: %resolution%p

title MP4 Found: %filename%! Evaluating Bitrate...

C:\FFmpeg\bin\ffprobe.exe -v error -show_entries stream=bit_rate -select_streams v "%filename%" > bitrate.var

for /f "skip=1" %%i in (bitrate.var) do (set LINE=%%i & goto bitrate_ingested)
:bitrate_ingested

set /a %LINE%/1000
set /a max_bitrate = 2600

if %bit_rate% GTR %max_bitrate% (GOTO BITRATE_ERROR) else (GOTO BITRATE_OK)

:BITRATE_ERROR
echo -  - Bitrate/Resolution Fail... %bit_rate%/%max_bitrate%. Resolution: %resolution%p
move "%filename%" "E:\Movies\%filename%"

GOTO LOOP

:BITRATE_OK
echo -  - Bitrate Pass... %bit_rate%/%max_bitrate%

title Bitrate Passed: %filename%! Finding Subtitle File...

(dir /b *.srt > subsrt.var) > nul 2>nul
(dir /b *.txt > nonsrt.var) > nul 2>nul
set /p srtfilename=<subsrt.var
set /p nosrtfilename=<nonsrt.var

title Finding SRT File [%filename%]
echo -  - Finding SRT File based on Movie Name: "%filename:~0,-4%".srt
ping 127.0.0.1 -n 2 -l 0 | find "Reply" > nul

if "%filename:~0,-4%" == "%srtfilename:~0,-4%" (GOTO SRT)
if "%filename:~0,-4%" == "%nosrtfilename:~0,-4%" (GOTO NOSRT) else (GOTO SRT_PRE_LOOP)

:SRT_PRE_LOOP
echo -  - SRT or No-SRT File Not Found! Skipping this video until confirmation...
GOTO LOOP

:SRT
set srt_val=1
GOTO UNLOCK

:NOSRT
set srt_val=0
GOTO UNLOCK

:UNLOCK
ping 127.0.0.1 -n 2 -l 0 | find "Reply" > nul
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
ping 127.0.0.1 -n 2 -l 0 | find "Reply" > nul
echo:
color 4
if %srt_val% == 0 (GOTO TAG_UPDATE)
echo ################################################ PREPARING FOR CONVERSION ################################################
ping 127.0.0.1 -n 3 -l 0 | find "Reply" > nul
move "%filename%" convert.mp4
move "%srtfilename%" convert.srt
echo -  - Renamed for Subtitle Soft-Code and Tag Update, Proceeding in 5 Seconds...
ping 127.0.0.1 -n 6 -l 0 | find "Reply" > nul
title %movie_name% Subtitle Soft-Code and [%resolution%p] Tag Update (Auto)...
C:\ffmpeg\bin\ffmpeg -i convert.mp4 -i convert.srt -c copy -c:s mov_text -metadata:s:s:0 language=eng "E:\Movies\Output\Done\%filename:~0,-4% [%resolution%p].mp4"
GOTO DONESRT

:TAG_UPDATE
move "%filename%" "Done\%filename:~0,-4% [%resolution%p].mp4"
del /F /Q "%filename:~0,-4%.txt"

title SUCCESS! %movie_name% [%resolution%p] Tag Update (Auto)...
color 2
echo ####################################################### CONVERTED! #######################################################
GOTO NAS_COPY


:DONESRT
title SUCCESS! %movie_name% Subtitle Soft-Code and [%resolution%p] Tag Update (Auto)...
color 2
echo ####################################################### CONVERTED! #######################################################
move convert.mp4 "ZArchive\%filename%"
move convert.srt "ZArchive\%srtfilename%"

:NAS_COPY
color 6
echo #################################################### UPLOADING TO NAS ####################################################
copy "Done\%filename:~0,-4% [%resolution%p].mp4" "\\192.168.100.132\SeL\Movies\Unprocessed"
color D
echo ########################################### FILE ARCHIVED, WAITING 15 SECONDS! ###########################################
ping 127.0.0.1 -n 15 -l 0 | find "Reply" > nul
cls
GOTO LOOP

