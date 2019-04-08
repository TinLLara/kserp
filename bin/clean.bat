@echo off
rem /**
rem  * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
rem  *
rem  * Author: ThinkGem@163.com
rem  */
echo.
echo [��Ϣ] �������·����
echo.
pause
echo.

cd %~dp0
cd..

call mvn clean

cd bin
pause