#  Installation SM ChatOps

## Required components

Installation of SM ChatOps modules is fairly easy. You can find the Administration and User Guide on [HPE Live Network](https://hpln.hpe.com/product/chatops/content)


## Create a slack team  
Before you begin, create a slack team. 
1.Go to www.slack.com.
2.Click Create a new team to create your slack team with your business email address.

Example:
https://smie.slack.com


## Install required third-party software  
- NodeJS  
- Git   
- Chrome (IE 11 )
- Python 2.7 
- VS C++ Builder 

**Note: for Windows NodeJS environment setup, you can follow up [instructions guide](https://github.com/Microsoft/nodejs-guidelines/blob/master/windows-environment.md#compiling-native-addon-modules) from Microsoft
**

## Install and configure Hubot  


## Set up a demo Hubot App

You will need a Hubot App to run SM Hubot Scripts. You can quickly set up a fresh one from scratch or choose to reuse this project.

Here are steps to reuse this project

1. Check out the project
  ```
  git clone git@github.hpe.com:IncubationLab/sm-chatops-test.git
  ```
1. Check out `hubot-sm` project
  ```
  git clone git@github.hpe.com:ChatOps/hubot-integrations.git
  ```
1. Open `startfrom-sample.sh` and modify the line `npm install ../hubot-integrations` with your own location.
  ```
  #!/bin/sh
  npm install ../hubot-integration-discover-16/hubot-sm/ --save

  CONFIG_FILE=./config.json SLACK_APP_TOKEN=[your slack app token] HUBOT_SLACK_TOKEN=[your slack bot token] HUBOT_LOG_LEVEL=debug SLACK_LOG_LEVEL=debug sm_servers_test_password=[your sm integration account password] npm start
  ```

You can also use `boot.coffee` to automate bot installation, see [here](install-with-slackbutton.md)

You can refer `config.json` for how to configure SM ChatOps.

Once you finish that, run command `./startfrom-sample.sh`.
