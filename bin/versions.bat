@echo off
rem /**
rem  * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
rem  *
rem  * Author: ThinkGem@163.com
rem  */
echo.
echo [��Ϣ] ������Ŀ�汾�š�
echo.
rem pause
echo.

cd %~dp0

set /p new=�������°汾�ţ�
echo.

pause
echo.
cd ..

rem ����pom�汾��
call mvn versions:set -DnewVersion=%new%

rem �滻 config.properties �еİ汾��
echo.
set f=%cd%\src\main\resources\config.properties
echo [INFO] Update %f%
set s1=version=
set s2=version=V%new%
for /f "delims=:" %%a in ('findstr /in "%s1%" "%f%"') do set n=%%a
(for /f "tokens=1* delims=:" %%a in ('findstr /n ".*" "%f%"') do (
  if %%a equ %n% ( echo.%s2%) else ( echo.%%b)
))>newfile
echo.
move newfile "%f%" >nul
echo.

cd bin
pause