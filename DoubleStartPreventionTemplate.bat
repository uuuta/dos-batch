@ECHO OFF
REM バッチ自身のカレントディレクトリに移動（カレントにログを出すため）
REM 別のバッチから起動される場合、これをやらないと起動元のバッチにログができる
REM /DはCDのオプション、%~DP0は%0がバッチの暗黙の引数（パスが入る）
CD /D %~DP0

SET CMD_NAME=BAT0001 1 （＃）
SET LOG_PATH=batch.log
SET CMD_RESULT=0

REM ---------------------------------------------------------------------------
REM 前処理
REM ---------------------------------------------------------------------------
REM 開始
ECHO %DATE%　%TIME%　%CMD_NAME%　バッチ開始 >>%LOG_PATH%
REM 多重起動チェック スペースを考慮してFINDSTRに/C:""を付与
@TASKLIST /v | FINDSTR /C:"%CMD_NAME%"
IF %ERRORLEVEL%==0 GOTO EXCEPTION_ALREADY_RUN

REM 自己起動後名称変更（多重起動防止の為）
TITLE %CMD_NAME%

REM ---------------------------------------------------------------------------
REM 本処理
REM ---------------------------------------------------------------------------

ECHO %CMD_NAME%
TIMEOUT 15


REM ---------------------------------------------------------------------------
REM 後処理
REM ---------------------------------------------------------------------------
GOTO END

REM 多重起動エラー
:EXCEPTION_ALREADY_RUN
ECHO %DATE%　%TIME%　%CMD_NAME%　既に起動されています。 >>%LOG_PATH%
GOTO END

REM 終了
:END
ECHO %DATE%　%TIME%　%CMD_NAME%　バッチ終了 >>%LOG_PATH%
Exit(%CMD_RESULT%)
