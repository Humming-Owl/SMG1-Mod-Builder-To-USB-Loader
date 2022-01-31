@ECHO off

CLS
echo.
echo ----- SMG1: TC Mod ISO Builder
echo ----- Super Mario Galaxy: Transformationless Challenge (v1.0.1)
echo.

set /P question1=Download Hack files (approx. size 0.9mb)? (y/n): 
echo.

if %question1%==y GOTO :down_hack

if %question1%==n GOTO :question2

:question2

set /P question2=Already downloaded compressed hack file in "mods/SMG1TC" folder? (y/n): 
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

%wget% -t inf "https://archive.org/download/SMG_1-2_Rom_Hacks/super_mario_galaxy_transformationle.zip" -P mods/SMG1TC >nul

echo.

:confirm_file

if exist ".\mods\SMG1TC\super_mario_galaxy_transformationle.zip" GOTO :extract_file

echo Rom Hack file not found.
echo Press any key to close program.
echo.

pause > nul

exit

:extract_file

echo Rom Hack file found.

echo Extracting file contents...

%extract% x "mods\SMG1TC\super_mario_galaxy_transformationle.zip" -o.\mods\SMG1TC\ >nul

ren ".\mods\SMG1TC\Super Mario Galaxy Transformationless Challenge - v1.0" "SMG1TC_files"

echo.

:build_iso

echo Building modded disc image...
echo This will take a while.
echo.

echo Extracting image contents...

wit EXTRACT ".\%image%" ".\temp" >nul

echo Copying and replacing mod files...

xcopy ".\mods\SMG1TC\SMG1TC_files\SMG1TC\*" ".\temp\files\" /E /Y >nul

echo Assembling game image...

wit COPY ".\temp" ".\SMG1TC.wbfs" >nul

echo Removing temp folders...

rmdir /s /q ".\temp"

rmdir /s /q ".\mods\SMG1TC\SMG1TC_files"

echo Editing game IDs...

wit EDIT --id "SMG1TC" ".\SMG1TC.wbfs" >nul

wit EDIT --tt-id "G1TC" ".\SMG1TC.wbfs" >nul

wit EDIT --name "Super Mario Galaxy: Transformationless Challenge" ".\SMG1TC.wbfs" >nul

if exist ".\SMG1TC.wbfs" GOTO :print-info
if not exist ".\SMG1TC.wbfs" GOTO :print-error

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
echo Game ID: "SMG1TC"
echo TMD ID: "G1TC"
echo Game name: "Super Mario Galaxy: Transformationless Challenge"
echo.
echo If you want to contribute (New Hack/Improve Tool) 
echo go to my GitHub repository and open an Issue.
echo Have fun!
echo.
echo Press any key to exit.
echo.

pause >nul