set CONFIG_FILE=./config.json
set SLACK_APP_TOKEN=
set HUBOT_SLACK_TOKEN=
REM set HTTP_PROXY=
REM set HTTPS_PROXY=

REM Please change hubot port if default port 8080 is occupied
REM set PORT=

if NOT EXIST node_modules (
    npm install
    npm start
)else (
    npm start
)
