@ECHO off

CLS
echo.
echo ----- KMG Mod ISO Builder (Partial)
echo ----- Kaizo Mario Galaxy (v1.2)
echo.

set /P question1=Download Hack files (approx. size 4.1mb)? (y/n): 
echo.

if %question1%==y GOTO :down_hack

if %question1%==n GOTO :question2

:question2

set /P question2=Already downloaded compressed hack file in "mods/KMG1" folder? (y/n): 
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

%wget% -t inf "https://archive.org/download/SMG_1-2_Rom_Hacks/Kaizo Mario Galaxy V1.2.zip" -P mods/KMG1 >nul

echo.

:confirm_file

if exist ".\mods\KMG1\Kaizo Mario Galaxy V1.2.zip" GOTO :extract_file

echo Rom Hack file not found.
echo Press any key to close program.
echo.

pause > nul

exit

:extract_file

echo Rom Hack file found.

echo Extracting file contents...

%extract% x "mods\KMG1\Kaizo Mario Galaxy V1.2.zip" -o.\mods\KMG1\ >nul

ren ".\mods\KMG1\Kaizo Mario Galaxy V1.2" "KMG1_files"

echo.

:build_iso

echo Building modded disc image...
echo This will take a while.
echo.

echo Extracting image contents...

wit EXTRACT ".\%image%" ".\temp" >nul

echo Copying and replacing mod files...

xcopy ".\mods\KMG1\KMG1_files\KMG\*" ".\temp\files\" /E /Y >nul

echo Applying hexadecimal patches (if available for your image region)...

if exist ".\temp\files\UeEnglish" (

echo Applying UE_PAL hex patch...

wit dolpatch ".\temp\sys\main.dol" xml=".\mods\KMG1\KMG1_files\EU (PAL)\riivolution\SMG1.xml" >nul

GOTO :final_steps)

if exist ".\temp\files\UsEnglish" (

echo Applying US_NTSC hex patch...

wit dolpatch ".\temp\sys\main.dol" xml=".\mods\KMG1\KMG1_files\US (NTSC)\riivolution\SMG1.xml" >nul

GOTO :final_steps)

if not exist ".\temp\files\UeEnglish" GOTO :no_ue_patch

:no_ue_patch

if not exist ".\temp\files\UsEnglish" GOTO :no_hex_patch

:no_hex_patch

echo.
echo No Hex patch available for your region...
echo Hex patches were only available for US_NTSC and EU_PAL.
echo.

:final_steps

xcopy ".\mods\KMG1\KMG1_files\US (NTSC)\UsEnglish" ".\temp\files\UsEnglish" /E /Y /I >nul

xcopy ".\mods\KMG1\KMG1_files\EU (PAL)\EuEnglish" ".\temp\files\EuEnglish" /E /Y /I >nul

echo Assembling game image...

wit COPY ".\temp" ".\KMG1.wbfs" >nul

echo Removing temp folders...

rmdir /s /q ".\temp"

rmdir /s /q ".\mods\KMG1\KMG1_files"

echo Editing game IDs...

wit EDIT --id "SMGKMG" ".\KMG1.wbfs" >nul

wit EDIT --tt-id "KMG1" ".\KMG1.wbfs" >nul

wit EDIT --name "Kaizo Mario Galaxy" ".\KMG1.wbfs" >nul

if exist ".\KMG1.wbfs" GOTO :print-info
if not exist ".\KMG1.wbfs" GOTO :print-error

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
echo Game ID: "SMGKMG"
echo TMD ID: "KMG1"
echo Game name: "Kaizo Mario Galaxy"
echo.
echo NOTE: I could not include a patch in the game 
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