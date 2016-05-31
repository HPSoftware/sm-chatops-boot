Botkit = require 'botkit'
QS = require 'querystring'
Store = require 'jfs'
dataStore = new Store('data', {saveId: 'id'})
# console.log process.argv
clientId= process.argv[2]
cs= process.argv[3]
name = process.argv[4]
# console.log clientId, cs, name
if not name
  console.log "Please specify a name"
  return
_ = require('underscore')

dataStore.get name, (err, data)->
  if not err
    console.log("Using following data to start your Hubot");
    console.log(data)
  else
    console.log('Start installing Slack APP....');
    # console.log(Botkit);
    try
      controller = Botkit.slackbot({
        json_file_store: './db_slackbutton_bot/',
      }).configureSlackApp(
        {
          clientId: clientId,
          clientSecret: cs,
          scopes: ['bot','channels:write', 'channels:history', 'groups:write', 'groups:history'],
        }
      )
    catch e
      console.log "Unable to start Installation App, make sure you have clientId and cs in environment"
      return
    # port = process.env.port;
    port = 4000
    controller.setupWebserver port, (err, webserver)->
      welcome_page = """
      <!DOCTYPE>
      <html>
        <head>
          <style>
            #center {
              position: absolute;
              height: 140px;
              width: 140px;
              margin: -80px 0 0 -70px;
              top: 50%;
              left: 50%;
            }
            #center h1{
              font-size: 15px;
              text-align: center;
            }
          </style>
        </head>
        <body>
          <div id="center">
            <h1>Add SM bot to your Slack Team</h1>
            <a href='#{controller.getAuthorizeURL()}&redirect_uri=http://localhost:#{port}/oauth'>
              <img alt='Add HPE Bot to Slack' height='40' width='139' src='https://platform.slack-edge.com/img/add_to_slack.png' srcset='https://platform.slack-edge.com/img/add_to_slack.png 1x, https://platform.slack-edge.com/img/add_to_slack@2x.png 2x' />
            </a>
          </div>
        </body>
      </html>
      """
      webserver.get '/', (req, res)->
        res.send(welcome_page);


      webserver.get '/config', (req, res)->
        page = "<!DOCTYPE><html><body><h1>Configurate Hubot here</h1></body></html>"
        res.send(page);


      controller.createOauthEndpoints webserver,(err,req,res) ->
        if err
          res.status(500).send('ERROR: ' + err);
        else
          res.send('Success!');

    handleEvent = (bot, user)->
      # console.log(bot);
      # console.log(user);
      # console.log(bot.config.incoming_webhook.token, bot.config.token);
      # console.log(bot.config.incoming_webhook.url)
      dataStore.save name,{
        id: name,
        apiToken: user.access_token,
        botToken: bot.config.bot.token
        # url: bot.config.incoming_webhook.url
      }, ()->
        # runHubot(user.access_token ,bot.config.bot.token)
        console.log "Slack App is successfully installed"
        console.log "Get your tokens in data/#{name}.json file"
        return

    controller.on 'update_user', handleEvent
    controller.on 'create_user', handleEvent
