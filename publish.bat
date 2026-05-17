@echo off
:: made by Cakeofcraft
:: ported to Windows batch by Claude, so vibe-coded (because i really dont want to use windows, not for ethical reasons)
:: ZERO testing has been done on the windows side, tried running it via wine, but it doesnt work
:: i might actually port it to windows, probably. My next MC related project is on bedrock, so it would be a testing ground

:: basic script that allows packaging the entire pack in one go, ready for release
:: this script is interchangeable with any pack, granted they have to be open source first
:: put the name here

set PACK_NAME=D°Uzi Craft: Dessert Port

:: creates temporary folder, in order to avoid recursive actions that "might" delete the whole project
mkdir tmp

:: copy everything into tmp, excluding the tmp folder itself
robocopy . .\tmp /E /XD tmp .git original /XF publish.bat publish.sh todo.txt README.md .gitignore > nul

echo NOTE: Robocopy is used here instead of xcopy to cleanly skip the tmp folder — no side-effect warnings unlike the shell version.

:: delete all unwanted files and folders from tmp, forcefully
rmdir /s /q .\tmp\tmp 2>nul
rmdir /s /q .\tmp\.git 2>nul
rmdir /s /q .\tmp\original 2>nul
del /f /q .\tmp\todo.txt 2>nul
del /f /q .\tmp\README.md 2>nul
del /f /q .\tmp\publish.sh 2>nul
del /f /q .\tmp\publish.bat 2>nul
del /f /q .\tmp\.gitignore 2>nul

:: rename LICENSE to License.txt (fits better in a resource pack)
if exist .\tmp\LICENSE ren .\tmp\LICENSE License.txt

:: use PowerShell's built-in zip — no extra installs needed
powershell -Command "Compress-Archive -Path '.\tmp\*' -DestinationPath '.\%PACK_NAME%.zip' -Force"

:: clean up — no reason to keep the temp folder around
rmdir /s /q .\tmp

echo Resource pack has been packaged!