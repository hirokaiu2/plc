
const http = require('http');
const fs = require('fs');
//const qs = require('querystring');

const hostname = '127.0.0.1';
//const port = 3000;
const port = process.env.port || 3000;

const server = http.createServer((req, res) => {
  var filePath = '.' + req.url;
  if (filePath == './') {
    filePath = './index.html';
  }

  if (req.method == 'GET') {
    fs.readFile(filePath, function (err, content) {
      if (err) {
        console.log("\n"+err);
      } else {
        res.statusCode = 200;
        res.setHeader('Content-Type', 'text/html');
        res.end(content), 'utf-8';
      }
    });
  } else if (req.method == 'POST') {
    var body = '';
    req.on('data', chunk => {
      body += chunk.toString();
      //console.log('server data');
      fs.writeFile('./core/plc.wd', body, function(err) {
        if (err) {
          console.log(err);
        }
        console.log('WaveDrom JSON file created.');
      });
    });
    req.on('end', () => {
      //var postData = qs.parse(body);
      //console.log('server on');
      //body += '_from_server';
      
      /* Run model checking */
      var process = require('child_process');
      process.exec('python ./core/plc.py', function(err, stdout, stderr) {
        if (err) {
          console.log("\n"+stderr);
        } else {
          console.log(stdout);
        }
      });

      //res.end(body);

      /* Send result of model checking back to client */
      fs.readFile('./core/plc.ce', function (err, content) {
        if (err) {
          console.log("\n"+err);
        } else {
          res.statusCode = 200;
          res.setHeader('Content-Type', 'text/plain');
          res.end(content), 'utf-8';
        }
      });
    });
  }
});

/*
var express = require('express');
var app = express.createServer();
app.use(express.static(__dirname + '/public'));

app.post('/genmodel', function(req, res) {
	console.log('body: ' + JSON.stringify(req.body));
	res.send(req.body);
});
*/

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});


