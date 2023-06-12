@echo off
REM exclamation mark used for delayed expansion marker 
SETLOCAL enabledelayedexpansion

REM time directly from the system as variable
set m_time=%time%
REM change any leading space (time less than 10am ) to a zero, trim down to seconds precision, remove colon separators [in 3 steps for clarity]
SET l_timepad=%m_time: =0%
SET l_timetrunc=%l_timepad:~0,8%
SET l_timestrip=%l_timetrunc::=%

SET OTFdir=.\EXTRACT_otfs
SET TTFdir=.\EXTRACT_ttfs
SET NEXUSdir=.\EXTRACT_Nexus

if NOT EXIST "%NEXUSdir%\" (  md "%NEXUSdir%" )

REM break down date to day month year directly from system as variable
for /f "tokens=1,2,3 delims=/ " %%a in ("%date%") do set day=%%a&set month=%%b&&set year=%%c

SET m_datestring=%year%%month%%day%

SET m_datetime=%m_datestring%_%l_timestrip%

(
echo.    ^<set name="Import %m_datetime%"^>

FOR %%F IN ( "%OTFdir%\*.otf" "%TTFdir%\*.ttf" ) DO ( 

REM nx gives filename and extension only
SET FRED=      ^<font^>C:\WINDOWS\Fonts\%%~nxF^</font^>

REM SET FRED= "      <font>C:\WINDOWS\Fonts\%%F</font>"

ECHO. !FRED!
) 
echo.    ^</set^>
) > "%NEXUSdir%\NexusFont_%m_datetime%.txt"