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

###### Note: for Windows NodeJS environment setup, you can follow up [instructions guide](https://github.com/Microsoft/nodejs-guidelines/blob/master/windows-environment.md#compiling-native-addon-modules) from Microsoft 
######

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
3. Follow the instructions in the Slack documentation to create an app.    
4. Make a note of the client_id and client_secret issued when you created the app. You will need them in the next task.  

### Task 3 Authorize the SM bot with your Slack team   
1. run `npm install` in the command shell  
2. Start the Slack App authorization process by running the following command:  
```
coffee install-slackapp.coffee [client_id] [client_secret] smbot
```
Replace [client_id] and [client_secret] with the values you obtained in task 2.   
You should see the following message on the console:  
```
Start installing Slack APP....  
info: ** Using simple storage. Saving data to ./db_slackbutton_bot/  
info: ** Setting up custom handlers for processing Slack messages   
info: ** Configuring app as a Slack App!   
info: ** Starting webserver on port 4000   
info: ** Serving login URL: http://MY_HOST:4000/login   
info: ** Serving oauth return endpoint: http://MY_HOST:4000/oauth
```  
3. Visit the following URL from your browser: [http://localhost:4000](http://localhost:4000)  
4. Click **Add to Slack**
5. Confirm that you are adding the SM bot to the right team, and then click Authorize.  
  Once the authorization process is successfully complete, your browser returns a "Success!" message, and the command line console returns the following  messages: 
```  
Slack App is successfully installed   
Get your tokens in data/smbot.json file  
```    

6. open data/smbot.json file in the text editor to get indidual slack token.
  the content of this file should look like the following:
```  

{"id":"smbot","apiToken":"xoxp-43844883909-43836899238-45600533889-63f799bda4","botToken":"xoxb-45587005878-aFuCQKKLkuxw4KOoMvS4Rfa3"}
```     

7.update the startsmbot.bat or startsmbot.sh.
  used startsmbot.bat as exmaple
```
set HTTP_PROXY=<your proxy>  
set HTTPS_PROXY=<your proxy>  
set CONFIG_FILE=./config.json   
set SLACK_APP_TOKEN=<your api token from smbot.json>   
set HUBOT_SLACK_TOKEN=<your bot token from smbot.json>
set sm_servers_<your SM server name from config.json>_password=<your sm password>  
```  

8. run `npm install`  
9. start `startsmbot.bat` or `startsmbot.sh`  




