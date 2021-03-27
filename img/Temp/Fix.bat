@ECHO OFF&PUSHD %~DP0 &TITLE BY：Brywmzl
mode con cols=36 lines=23
color 02
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行！&&PAUSE >NUL&&EXIT)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
::初始化结束
:Menu
Cls
@ echo.
@ echo.
@ echo.          
@ echo.        1.本地连接 (XP/W7)
@ echo.
@ echo.        2.以太网 (W8/W10)
@ echo.
@ echo.        3.手动输入配适器名称
@ echo.
@ echo.        4.启用 DHCP 服务
@ echo.
@ echo.        5.禁用 DHCP 服务
@ echo.
@ echo.        6.重置 DNS
@ echo.
@ echo.        7.重置 LSP
@ echo.
@ echo.        8.清除图标缓存
@ echo.
@ echo.
set /p xj= 输入数字回车：
if /i "%xj%"=="1" Goto s_rpsq_1
if /i "%xj%"=="2" Goto s_rpsq_2
if /i "%xj%"=="3" Goto s_rpsq_3
if /i "%xj%"=="4" Goto odh_o
if /i "%xj%"=="5" Goto odh_c
if /i "%xj%"=="6" Goto r_dns
if /i "%xj%"=="7" Goto r_lsp
if /i "%xj%"=="8" Goto d_icon
goto Menu

:Menu_SetIP
Cls
@ echo.当前配适器：%VAR%  
@ echo.             
@ echo.
@ echo.        1.恢复IP
@ echo.
@ echo.        2.设置IP
@ echo.
@ echo.        3.返回
@ echo.
@ echo.
set /p xj= 输入数字回车：
if /i "%xj%"=="1" Goto r_ip
if /i "%xj%"=="2" Goto s_ip
if /i "%xj%"=="3" Goto Menu
goto Menu_SetIP

:s_rpsq_1
set VAR=本地连接
goto Menu_SetIP

:s_rpsq_2
set VAR=以太网
goto Menu_SetIP

:s_rpsq_3
set /p VAR=请输入配适器名称：
goto Menu_SetIP

:odh_o
@ echo. 正在启用 DHCP 服务...
net start DHCP
@ echo. DHCP 已启用
ping -n 2 10>nul
goto Menu

:odh_c
@ echo. 正在禁用 DHCP 服务...
net stop DHCP
@ echo. DHCP 已禁用
ping -n 2 10>nul
goto Menu

:s_ip
set /p ipsz= 输入(0-100)：
if /i "%ipsz%"=="" Goto Menu_SetIP
@ echo. 正在设置中...
netsh int ip set addr name="%VAR%" static %ipsz% 255.255.255.0 58.199.17.1 1
netsh int ip set dns name="%VAR%" static 0.0.0.0 primary
::netsh int ip add dns name="%VAR%" 0.0.0.0
goto m_s_ip

:r_ip
Echo 正在恢复中...
netsh int ip set addr name="%VAR%" source = dhcp
netsh int ip set dns name="%VAR%" source = dhcp
goto m_r_ip

:r_dns
Echo DNS 正重置中...
ipconfig /flushdns
goto m_r_dns

:r_lsp
Echo LSP 正重置中...
netsh winsock reset
goto m_r_lsp

:d_icon
Echo 正在清除图标缓存...
taskkill /f /im explorer.exe
attrib -h -i %userprofile%\AppData\Local\IconCache.db
del %userprofile%\AppData\Local\IconCache.db /a
start explorer
goto m_d_icon

:m_s_ip
@ ECHO.
ECHO 　　　设置完成..
ping -n 2 10>nul
goto Menu_SetIP

:m_r_ip
@ ECHO.
ECHO 　　　恢复完成..
ping -n 2 10>nul
goto Menu_SetIP

:m_r_dns
@ ECHO.
ECHO 　　　DNS 已重置！
ping -n 2 10>nul
goto Menu

:m_r_lsp
@ ECHO.
ECHO 　　　LSP 已重置！
ping -n 2 10>nul
goto Menu

:m_d_icon
@ ECHO.
ECHO 　　　IconCache.db 已删除！
ping -n 2 10>nul
goto Menu