@ECHO off

CLS
echo.
echo ----- SMG1 Mod ISO Builder (v0.1)
echo ----- Made in Venezuela
echo ----- By Humming Owl
echo.

set wget=tools\wget.exe
set extract=tools\7z.exe

:select_iso

SET /P image=Enter name of disc image (e.g. SMG.iso, SMG.wbfs): 

if not exist ".\%image%" (

echo.
echo Disc image not found.
echo Place SMG1 disc image in the same location the "ISO-Builder.bat" file is.
echo Press any key to try again.
echo.
pause >nul

GOTO :select_iso)

echo.
echo Disc image found.
echo.

echo --- SMG1 Hacks list:
echo.
echo 1. Kaizo Mario Galaxy (Partial)
echo 2. Super Mario Galaxy: Transformationless Challenge
echo 3. Super Mario Galaxy: The Green Stars
echo 4. Super Mario Galaxy: The Kaizo Green Stars (Partial)
echo 5. Super Mario Galaxy: Underwater Edition
echo 6. Super Mario Galaxy: No Gravity Edition
echo 7. Super Mario Galaxy: Cosmic Caos (Partial)
echo.
echo NOTE: Those with the "(Partial)" tag are hacks that I
echo could not include some patches because of limited knowledge
echo and/or some broke the game in the USB Loader.
echo. 

set /P apply_mod=Select Mod number to apply to ISO/WBFS image: 

if %apply_mod%==1 (mods\KMG1\builder.bat)

if %apply_mod%==2 (mods\SMG1TC\builder.bat)

if %apply_mod%==3 (mods\SMG1TGS\builder.bat)  

if %apply_mod%==4 (mods\SMG1TKGS\builder.bat) 

if %apply_mod%==5 (mods\SMG1UE\builder.bat)

if %apply_mod%==6 (mods\SMG1NGE\builder.bat)  

if %apply_mod%==7 (mods\SMG1CC\builder.bat)

exit