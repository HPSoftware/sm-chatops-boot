#  Installation SM ChatOps

## Required components

Installation of SM ChatOps modules is fairly easy. What you need are following components

1. **SM ChatOps `unload`**: with a simple integration for SM to send messages to ChatOps tools via webbooks.
  * It also includes a few example configurations
  * _At current moment, you can download it from [here](https://github.hpe.com/IncubationLab/sm-chatops-slack/tree/master/smslack)._
  * Only SM **9.41** is tested for now.
  * In the future, this will be released via HPLN.
1. **SM Hubot scripts**: a `npm` package with ChatOps commands, integration and examples.
  * _At current moment, you can download it from [here](https://github.hpe.com/ChatOps/hubot-integrations/tree/master/hubot-sm)._
  * In the future, the `npm` package will be published into public registry and released under open source license.

## Configure SM 9.41

> Before doing that, you need to patch your SM 9.41 with the unload

Customers configure SM ChatOps integration using PD JS Rule by following following steps

1. Add a new RuleSet at selected phase of PD
1. Config the Rule condition
  - Example `( CI Identifier in Primary Affected Service in CurrentRecord = "CI11082")`
1. Add a simple configuration in the script area

```js
var cfg = {
  webhook_url: "", //webhook_url to your slack Team
  room: "", // the name of the room you want this message is sent to
  docengine_url: true,
  message: "Incident ${number} - ${brief.description} is updated." //message format
}

lib.slack.send(record, cfg);
```

More advanced configuration can be found [here](https://github.hpe.com/IncubationLab/sm-chatops-slack/blob/keke-refactor/smslack/doc/config.md).


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
