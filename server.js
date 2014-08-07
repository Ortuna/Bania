
var express  = require('express'),
    app      = express(),
    fs       = require('fs'),
    Calendar = require('./lib/calendar')

 
var calendar = Calendar();    
filePath = calendar.generate({});



/*app.get('/', function(req, res){*/
  //res.send('Hello World');
//});


//var server = app.listen(3000, function() {
  //console.log('Listening on port %d', server.address().port);
/*});*/
