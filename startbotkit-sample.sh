#!/bin/sh

npm install ../[folder to hubot-sm]/ --save

CONFIG_FILE=./config.json HUBOT_LOG_LEVEL=debug SLACK_LOG_LEVEL=debug sm_servers_demo_password=[password] npm start
