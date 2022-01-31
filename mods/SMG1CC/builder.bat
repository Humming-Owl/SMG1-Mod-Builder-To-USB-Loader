@ECHO off

CLS
echo.
echo ----- SMG1: CC Mod ISO Builder (Partial)
echo ----- Super Mario Galaxy: Cosmic Caos (v1.3.5)
echo.

set /P question1=Download Hack files (approx. size 104mb)? (y/n): 
echo.

if %question1%==y GOTO :down_hack

if %question1%==n GOTO :question2

:question2

set /P question2=Already downloaded compressed hack file in "mods/SMG1CC" folder? (y/n): 
echo.

if %question2%==y GOTO :confirm_file

if %question2%==n GOTO :exit_1

:exit_1

echo Download Rom Hack files and try again.
echo Terminating program...
echo Press any key to close program.
echo.

pause >nul

exit

:down_hack

echo Downloading Rom Hack files...
echo.

%wget% -t inf "https://archive.org/download/SMG_1-2_Rom_Hacks/Super%20Mario%20Galaxy%20Cosmic%20Chaos%20-%20v1.3.5.zip" -P mods/SMG1CC >nul

echo.

:confirm_file

if exist ".\mods\SMG1CC\Super Mario Galaxy Cosmic Chaos - v1.3.5.zip" GOTO :extract_file

echo Rom Hack file not found.
echo Press any key to close program.
echo.

pause > nul

exit

:extract_file

echo Rom Hack file found.

echo Extracting file contents...

%extract% x "mods\SMG1CC\Super Mario Galaxy Cosmic Chaos - v1.3.5.zip" -o.\mods\SMG1CC\ >nul

ren ".\mods\SMG1CC\Super Mario Galaxy Cosmic Chaos - v1.3" "SMG1CC_files"

echo.

:build_iso

echo Building modded disc image...
echo This will take a while.
echo.

echo Extracting image contents...

wit EXTRACT ".\%image%" ".\temp" >nul

echo Copying and replacing mod files...

xcopy ".\mods\SMG1CC\SMG1CC_files\SMGCC\*" ".\temp\files\" /E /Y >nul

echo Applying hexadecimal patches (if available for your image region)...

echo Applying hex patches...

wit dolpatch ".\temp\sys\main.dol" xml=".\mods\SMG1CC\SMG1CC_files\riivolution\SMGCC Riivolution.xml" >nul

echo Assembling game image...

wit COPY ".\temp" ".\SMG1CC.wbfs" >nul

echo Removing temp folders...

rmdir /s /q ".\temp"

rmdir /s /q ".\mods\SMG1CC\SMG1CC_files"

echo Editing game IDs...

wit EDIT --id "SMG1CC" ".\SMG1CC.wbfs" >nul

wit EDIT --tt-id "G1CC" ".\SMG1CC.wbfs" >nul

wit EDIT --name "Super Mario Galaxy: Cosmic Caos" ".\SMG1CC.wbfs" >nul

if exist ".\SMG1CC.wbfs" GOTO :print-info
if not exist ".\SMG1CC.wbfs" GOTO :print-error

:print-error

echo.
echo Error while modding the image.
echo Please try again.
echo Press any key to continue.
echo.

pause >nul

exit

:print-info

echo.
echo Disc image modded correctly.
echo.
echo Game ID: "SMG1CC"
echo TMD ID: "G1CC"
echo Game name: "Super Mario Galaxy: Cosmic Caos"
echo.
echo NOTE: I could not include some patches in the game 
echo image due to my limited knowledge. Maybe you 
echo won't notice anything wrong with the hack, but 
echo if you do, it may be due to the lack of that patch.
echo.
echo If you want to contribute (New Hack/Improve Tool) 
echo go to my GitHub repository and open an Issue.
echo Have fun!
echo.
echo Press any key to exit.
echo.

pause >nul