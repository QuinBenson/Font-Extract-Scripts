rem @echo off

REM v1.1 added basic otfs & ttfs directory functionality    20220104
REM v1.2 changed target directories to EXTRACT_ prefixes    20220111
REM v1.2 added EXTRACT_ variable names                      
REM v1.2 added MOVE zip to EXTRACT_zips                     

SETLOCAL enabledelayedexpansion
SET OTFdir=.\EXTRACT_otfs
SET TTFdir=.\EXTRACT_ttfs
SET ZIPdir=.\EXTRACT_zips
SET CWD=%CD%

if NOT EXIST "%OTFdir%\" ( md "%OTFdir%" )
if NOT EXIST "%TTFdir%\" ( md "%TTFdir%" ) 
if NOT EXIST "%ZIPdir%\" ( md "%ZIPdir%" )

REM find zip files in current directory  
REM dir /B  Uses bare format (no heading information or summary).
FOR /F "usebackq tokens=*" %%F IN (`dir /b *.zip`) DO (

    SET Filename=%%F
    SET dirname=%%~nF

    REM unzip filename into directory named as the zipfile with no extension 
    REM (that's why the variable name 'dirname' not 'basename' is used)
    REM x flag extracts WITH any path specified in the archive
    REM e flag would extract all files into a single directory specified by -o flag
    REM NB NO SPACE between -o flag and dirname
   "F:\Program Files\7-Zip\7z.exe" x "%%F" -o"!dirname!"

REM Change to extract directory because there seems to be a problem passing variables into a `` execution string 

cd !dirname!

REM search extract directory for font files and copy them to the relevant holding directory, 
REM excluding ._ prefix (Mac) files [v - invert, i - case insensitive, r - interpret pattern as regex]
REM NB CARET ESCAPE BEFORE PIPE - required to prevent shell interpreting early

REM command line version dir *.ttf *.otf /b/s | findstr /i /v /r  /c:"\._"
FOR /F "usebackq tokens=*" %%X IN (` dir *.ttf *.otf /b/s ^| findstr /i /r /v /c:"\._" `) DO ( if "%%~xX" == ".otf" ( xcopy "%%X" "%CWD%\EXTRACT_otfs" ) else ( xcopy "%%X" "%CWD%\EXTRACT_ttfs" ) )

REM Return to original directory
cd %CWD%
MOVE %%F %ZIPdir%
)