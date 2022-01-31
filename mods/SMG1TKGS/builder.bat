@ECHO off

CLS
echo.
echo ----- SMG1: TKGS Mod ISO Builder (Partial)
echo ----- Super Mario Galaxy: The Kaizo Green Stars (v1.6.1)
echo.

set /P question1=Download Hack files (approx. size 3.7mb)? (y/n): 
echo.

if %question1%==y GOTO :down_hack

if %question1%==n GOTO :question2

:question2

set /P question2=Already downloaded compressed hack file in "mods/SMG1TKGS" folder? (y/n): 
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

%wget% -t inf "https://archive.org/download/SMG_1-2_Rom_Hacks/SMGTKGS 1.6.1.7z" -P mods/SMG1TKGS >nul

echo.

:confirm_file

if exist ".\mods\SMG1TKGS\SMGTKGS 1.6.1.7z" GOTO :extract_file

echo Rom Hack file not found.
echo Press any key to close program.
echo.

pause > nul

exit

:extract_file

echo Rom Hack file found.

echo Extracting file contents...

%extract% x "mods\SMG1TKGS\SMGTKGS 1.6.1.7z" -o.\mods\SMG1TKGS\ >nul

ren ".\mods\SMG1TKGS\SMGTKGS 1.6.1" "SMG1TKGS_files"

echo.

:build_iso

echo Building modded disc image...
echo This will take a while.
echo.

echo Extracting image contents...

wit EXTRACT ".\%image%" ".\temp" >nul

echo Copying and replacing mod files...

xcopy ".\mods\SMG1TKGS\SMG1TKGS_files\SMGTKGS\SMGTKGS\*" ".\temp\files\" /E /Y >nul

echo Assembling game image...

wit COPY ".\temp" ".\SMG1TKGS.wbfs" >nul

echo Removing temp folders...

rmdir /s /q ".\temp"

rmdir /s /q ".\mods\SMG1TKGS\SMG1TKGS_files"

echo Editing game IDs...

wit EDIT --id "SMGTKG" ".\SMG1TKGS.wbfs" >nul

wit EDIT --tt-id "1TKG" ".\SMG1TKGS.wbfs" >nul

wit EDIT --name "Super Mario Galaxy: The Kaizo Green Stars" ".\SMG1TKGS.wbfs" >nul

if exist ".\SMG1TKGS.wbfs" GOTO :print-info
if not exist ".\SMG1TKGS.wbfs" GOTO :print-error

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
echo Game ID: "SMGTKG"
echo TMD ID: "1TKG"
echo Game name: "Super Mario Galaxy: The Kaizo Green Stars"
echo.
echo NOTE: I didn't include the hex patches in the game 
echo image due to my limited knowledge and because it breaks 
echo the game when grabbing the first star. Maybe you 
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