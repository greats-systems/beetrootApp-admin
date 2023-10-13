@REM flutter build web
Xcopy C:\src\flutter-projects\core_erp_project\main_ui\Flatten\build\web\  C:\src\flutter-projects\core_erp_project\main_ui\Flatten\web_build\ /E 
A
cd C:\src\flutter-projects\core_erp_project\main_ui\Flatten\web_build\
git add . 
git commit -m "initial"
git push 