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
Hubot is an open source chat robot for your organization. It runs on Node.js and is easy to program with simple scripts written in CoffeeScript. Service Manager ChatOps allows your Hubot instance to connect and interact with your Slack team.

The SM Hubot package contains Hubot scripts that are required by Slack. After the installation of these scripts, you can configure one or more Service Manager (SM) servers and specify a RESTFul web service account for the SM bot (chat robot) to access Service Manager. People who are invited to your Slack team can then send commands to the SM bot to perform operations in Service Manager in an automated way.
Complete the following tasks to install and set up Hubot.

### Task 1 Install Hubot and configure SM server connection infomation
1. open configure.json file in a editor
2. in the "sm" section,specify a RESTful Web Service integration account for the SM bot(chat bot) to access your Service Manager system, and specify the host name and port for SM server.
   The following is an example
```js
{
  "config" : {
    "sm" : {
      "servers" : {
        "default" : "hpe",
        "hpe" : {
          "account" : "System.Admin",
          "endpoint" : "16.187.231.2:13080"
        },
        "advantageinc-demo" : {
          "endpoint" : "xxx.xx.xxx.xxx:13080",
          "account" : "System.Admin"
        }
      }
    }
  }
}
```
In this example, the default SM server is named hpe,the RESTFul web service configuration account is System.Admin, and the host and port are 16.187.231.2 and 13080.
3. Continue to run the following command to install Coffee-Script
```
npm install -g coffee-script
```

### Task 2 Create a private Slack App
  You need to create a private Slack app to obtain a clientId and clientSecret, which are required to enable the SM bot to access your Slack team.
1. Visit this URL: [https://api.slack.com/slack-apps](https://api.slack.com/slack-apps)
2. Go to the **Create an app section**, and then click **Create your Slack app**.


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
