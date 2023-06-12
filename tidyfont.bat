rem @echo off
SETLOCAL enabledelayedexpansion

SET OTFdir=.\EXTRACT_otfs
SET TTFdir=.\EXTRACT_ttfs
SET ZIPdir=.\EXTRACT_zips

IF EXIST "%ZIPdir%\" (

FOR /F "usebackq tokens=*" %%F IN (` dir "%ZIPdir%\*.zip" /b/s `) DO ( 

    SET Filename=%%F
	SET dirname=%%~nF

    Move !dirname! "..\Extracts"
)
)

MOVE "%OTFdir%\*.otf" "..\Font Files"
MOVE "%TTFdir%\*.ttf" "..\Font Files"
MOVE "%ZIPdir%\*.zip" "..\Zip Archive"

