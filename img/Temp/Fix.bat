@ECHO OFF&PUSHD %~DP0 &TITLE BY��Brywmzl
mode con cols=36 lines=23
color 02
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo ��ʹ���Ҽ�����Ա������У�&&PAUSE >NUL&&EXIT)
Rd "%WinDir%\System32\test_permissions" 2>NUL
SetLocal EnableDelayedExpansion
::��ʼ������
:Menu
Cls
@ echo.
@ echo.
@ echo.          
@ echo.        1.�������� (XP/W7)
@ echo.
@ echo.        2.��̫�� (W8/W10)
@ echo.
@ echo.        3.�ֶ���������������
@ echo.
@ echo.        4.���� DHCP ����
@ echo.
@ echo.        5.���� DHCP ����
@ echo.
@ echo.        6.���� DNS
@ echo.
@ echo.        7.���� LSP
@ echo.
@ echo.        8.���ͼ�껺��
@ echo.
@ echo.
set /p xj= �������ֻس���
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
@ echo.��ǰ��������%VAR%  
@ echo.             
@ echo.
@ echo.        1.�ָ�IP
@ echo.
@ echo.        2.����IP
@ echo.
@ echo.        3.����
@ echo.
@ echo.
set /p xj= �������ֻس���
if /i "%xj%"=="1" Goto r_ip
if /i "%xj%"=="2" Goto s_ip
if /i "%xj%"=="3" Goto Menu
goto Menu_SetIP

:s_rpsq_1
set VAR=��������
goto Menu_SetIP

:s_rpsq_2
set VAR=��̫��
goto Menu_SetIP

:s_rpsq_3
set /p VAR=���������������ƣ�
goto Menu_SetIP

:odh_o
@ echo. �������� DHCP ����...
net start DHCP
@ echo. DHCP ������
ping -n 2 10>nul
goto Menu

:odh_c
@ echo. ���ڽ��� DHCP ����...
net stop DHCP
@ echo. DHCP �ѽ���
ping -n 2 10>nul
goto Menu

:s_ip
set /p ipsz= ����(0-100)��
if /i "%ipsz%"=="" Goto Menu_SetIP
@ echo. ����������...
netsh int ip set addr name="%VAR%" static %ipsz% 255.255.255.0 58.199.17.1 1
netsh int ip set dns name="%VAR%" static 0.0.0.0 primary
::netsh int ip add dns name="%VAR%" 0.0.0.0
goto m_s_ip

:r_ip
Echo ���ڻָ���...
netsh int ip set addr name="%VAR%" source = dhcp
netsh int ip set dns name="%VAR%" source = dhcp
goto m_r_ip

:r_dns
Echo DNS ��������...
ipconfig /flushdns
goto m_r_dns

:r_lsp
Echo LSP ��������...
netsh winsock reset
goto m_r_lsp

:d_icon
Echo �������ͼ�껺��...
taskkill /f /im explorer.exe
attrib -h -i %userprofile%\AppData\Local\IconCache.db
del %userprofile%\AppData\Local\IconCache.db /a
start explorer
goto m_d_icon

:m_s_ip
@ ECHO.
ECHO �������������..
ping -n 2 10>nul
goto Menu_SetIP

:m_r_ip
@ ECHO.
ECHO �������ָ����..
ping -n 2 10>nul
goto Menu_SetIP

:m_r_dns
@ ECHO.
ECHO ������DNS �����ã�
ping -n 2 10>nul
goto Menu

:m_r_lsp
@ ECHO.
ECHO ������LSP �����ã�
ping -n 2 10>nul
goto Menu

:m_d_icon
@ ECHO.
ECHO ������IconCache.db ��ɾ����
ping -n 2 10>nul
goto Menu