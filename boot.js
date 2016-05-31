var Botkit = require('Botkit');
var QS = require('querystring');
var Store = require('jfs');
var dataStore = new Store('data', {saveId: 'id'});
var name = process.env.name;

var runHubot = function(apiToken, botToken){
  var _ = require('underscore'); // for some utility goodness
  var spawn = require('child_process').spawn;
  var runHubot = spawn('./startfrombotkit.sh', [], {
    env:_.extend(process.env, { SLACK_APP_TOKEN:apiToken, HUBOT_SLACK_TOKEN:botToken})
  });
  runHubot.stdout.on('data', function(data){
    console.log(data.toString());
  });
  runHubot.stderr.on('data', function(data){
    console.log(data.toString());
  });
};

dataStore.get(name, function(err, data){
  // console.log(data);
  if(! err){
    console.log(data);
    runHubot(data.apiToken, data.botToken);
  }else{
    console.log(Botkit);

    var controller = Botkit.slackbot({
      json_file_store: './db_slackbutton_bot/',
    }).configureSlackApp(
      {
        // clientId: '24135013921.30570766214',
        clientId: process.env.clientId,
        clientSecret: process.env.cs,
        scopes: ['bot','channels:write', 'channels:history', 'incoming-webhook', 'chat:write:user', 'emoji:read', 'groups:write', 'groups:history', 'pins:read'],
      }
    );;
    port = process.env.port;
    controller.setupWebserver(port, function(err, webserver){
      // controller.createHomepageEndpoint(webserver);
      // ruri = QS.escape('http://localhost:4000/login');
      // authUrl = QS.escape(controller.getAuthorizeURL));
      webserver.get('/', function(req, res){
        var page = "<!DOCTYPE><html><body><a href='"+controller.getAuthorizeURL()+"&client_id="+process.env.clientId+"&redirect_uri=http://localhost:"+port+"/oauth'><img alt='Add HPE Bot to Slack' height='40' width='139' src='https://platform.slack-edge.com/img/add_to_slack.png' srcset='https://platform.slack-edge.com/img/add_to_slack.png 1x, https://platform.slack-edge.com/img/add_to_slack@2x.png 2x' /></a></body></html>"
        res.send(page);
      });

      webserver.get('/config', function(req, res){
        var page = "<!DOCTYPE><html><body><h1>Configurate Hubot here</h1></body></html>"
        res.send(page);
      });

      controller.createOauthEndpoints(webserver,function(err,req,res) {
        if (err) {
          res.status(500).send('ERROR: ' + err);
        } else {
          // console.log(req);
          res.send('Success!');
        }
      });
    });

    controller.on('create_bot',function(bot,config) {
      console.log(bot);
      console.log(bot.config.incoming_webhook.token, bot.config.token);
      console.log(bot.config.incoming_webhook.url)
      dataStore.save(name,{
        id: name,
        apiToken: bot.config.incoming_webhook.token,
        botToken: bot.config.token,
        url: bot.config.incoming_webhook.url
      }, function(){
        runHubot(bot.config.incoming_webhook.token,bot.config.token);
      });
    });
  }
});
