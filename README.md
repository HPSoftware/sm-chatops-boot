# Introduction
This is a test project for SM Hubot Chatops https://github.com/HPSoftware/hubot-sm

## Set up

Create a Hubot app project
```
yo hubot
```

Check out `hubot-integrations` project and install hubot-sm manually
```
npm install /path/to/hubut-sm --save
```

Patch `hubot-slack` dependency, update `package.json`

```json
{
  "hubot-slack": "git+https://github.com/keke/hubot-slack.git"
}
```

Reinstall all `node_packages`
```
rm -rf node_packages
npm install
```

## Run
### Without a SlackApp
Modify env in `starthubot.sh` and run it
```
./starthubot.sh
```

### With a Slack app
Run `stackfrombokit.sh`
```
port=PORT clientId=<clientId> name=<name of the integration> cs=<clientSecret> coffee boot.coffee -n
```
Where `clientId` and `clientSecret` are from your Slack App page.
