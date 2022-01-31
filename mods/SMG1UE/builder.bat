@ECHO off

CLS
echo.
echo ----- SMG1: UE Mod ISO Builder
echo ----- Super Mario Galaxy: Underwater Edition
echo.

set /P question1=Download Hack files (approx. size 2.4mb)? (y/n): 
echo.

if %question1%==y GOTO :down_hack

if %question1%==n GOTO :question2

:question2

set /P question2=Already downloaded compressed hack file in "mods/SMG1UE" folder? (y/n): 
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

%wget% -t inf "https://archive.org/download/SMG_1-2_Rom_Hacks/Super Mario Galaxy Underwater Edition.rar" -P mods/SMG1UE >nul

echo.

:confirm_file

if exist ".\mods\SMG1UE\Super Mario Galaxy Underwater Edition.rar" GOTO :extract_file

echo Rom Hack file not found.
echo Press any key to close program.
echo.

pause > nul

exit

:extract_file

echo Rom Hack file found.

echo Extracting file contents...

%extract% x "mods\SMG1UE\Super Mario Galaxy Underwater Edition.rar" -o.\mods\SMG1UE\ >nul

ren ".\mods\SMG1UE\Super Mario Galaxy Underwater Edition" "SMG1UE_files"

echo.

:build_iso

echo Building modded disc image...
echo This will take a while.
echo.

echo Extracting image contents...

wit EXTRACT ".\%image%" ".\temp" >nul

echo Copying and replacing mod files...

xcopy ".\mods\SMG1UE\SMG1UE_files\SMG1 Underwater Challenge\*" ".\temp\files\" /E /Y >nul

echo Assembling game image...

wit COPY ".\temp" ".\SMG1UE.wbfs" >nul

echo Removing temp folders...

rmdir /s /q ".\temp"

rmdir /s /q ".\mods\SMG1UE\SMG1UE_files"

echo Editing game IDs...

wit EDIT --id "SMG1UE" ".\SMG1UE.wbfs" >nul

wit EDIT --tt-id "G1UE" ".\SMG1UE.wbfs" >nul

wit EDIT --name "Super Mario Galaxy: Underwater Edition" ".\SMG1UE.wbfs" >nul

if exist ".\SMG1UE.wbfs" GOTO :print-info
if not exist ".\SMG1UE.wbfs" GOTO :print-error

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
echo Game ID: "SMG1UE"
echo TMD ID: "G1UE"
echo Game name: "Super Mario Galaxy: Underwater Edition"
echo.
echo If you want to contribute (New Hack/Improve Tool) 
echo go to my GitHub repository and open an Issue.
echo Have fun!
echo.
echo Press any key to exit.
echo.

pause >nul