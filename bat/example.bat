@ECHO OFF
 
:: Initialize variables

SET state="success"

:: Do your stuff

IF ERRORLEVEL 1 SET state="failure"
IF ERRORLEVEL 1 GOTO End
 
:: Done
ENDLOCAL

:: Print Output as JSON to be used on next task in Workflow 
:End
ECHO {"state":%state%, "data":["%~1", "%~2", "%~3"]}
