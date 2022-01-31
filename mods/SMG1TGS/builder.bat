@ECHO off

CLS
echo.
echo ----- SMG1: TGS Mod ISO Builder
echo ----- Super Mario Galaxy: The Green Stars (v1.1)
echo.

set /P question1=Download Hack files (approx. size 6.5mb)? (y/n): 
echo.

if %question1%==y GOTO :down_hack

if %question1%==n GOTO :question2

:question2

set /P question2=Already downloaded compressed hack file in "mods/SMG1TGS" folder? (y/n): 
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

%wget% -t inf "https://archive.org/download/SMG_1-2_Rom_Hacks/Super Mario Galaxy The Green Stars v1.1.zip" -P mods/SMG1TGS >nul

echo.

:confirm_file

if exist ".\mods\SMG1TGS\Super Mario Galaxy The Green Stars v1.1.zip" GOTO :extract_file

echo Rom Hack file not found.
echo Press any key to close program.
echo.

pause > nul

exit

:extract_file

echo Rom Hack file found.

echo Extracting file contents...

%extract% x "mods\SMG1TGS\Super Mario Galaxy The Green Stars v1.1.zip" -o.\mods\SMG1TGS\ >nul

ren ".\mods\SMG1TGS\Super Mario Galaxy The Green Stars v1.1" "SMG1TGS_files"

echo.

:build_iso

echo Building modded disc image...
echo This will take a while.
echo.

echo Extracting image contents...

wit EXTRACT ".\%image%" ".\temp" >nul

echo Copying and replacing mod files...

xcopy ".\mods\SMG1TGS\SMG1TGS_files\SMGTGS\*" ".\temp\files\" /E /Y >nul

echo Assembling game image...

wit COPY ".\temp" ".\SMG1TGS.wbfs" >nul

echo Removing temp folders...

rmdir /s /q ".\temp"

rmdir /s /q ".\mods\SMG1TGS\SMG1TGS_files"

echo Editing game IDs...

wit EDIT --id "SMGTGS" ".\SMG1TGS.wbfs" >nul

wit EDIT --tt-id "1TGS" ".\SMG1TGS.wbfs" >nul

wit EDIT --name "Super Mario Galaxy: The Green Stars" ".\SMG1TGS.wbfs" >nul

if exist ".\SMG1TGS.wbfs" GOTO :print-info
if not exist ".\SMG1TGS.wbfs" GOTO :print-error

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
echo Game ID: "SMG1TGS"
echo TMD ID: "1TGS"
echo Game name: "Super Mario Galaxy: The Green Stars"
echo.
echo If you want to contribute (New Hack/Improve Tool) 
echo go to my GitHub repository and open an Issue.
echo Have fun!
echo.
echo Press any key to exit.
echo.

pause >nul