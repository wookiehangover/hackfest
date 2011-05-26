var Campfire, Sandbox, instance, logger, sandbox, sys;
sys = require('sys');
Campfire = require('./node-campfire/lib/campfire').Campfire;
Sandbox = require('sandbox');
sandbox = new Sandbox();
instance = new Campfire({
  ssl: true,
  token: 'fc3438c24c8302f9c6550b75bfb60ec4eadb870a',
  account: 'quickleft'
});
logger = function(d) {
  return console.log("quack sent: " + d.message.created_at);
};
instance.room(401915, function(room) {
  return room.join(function() {
    return room.listen(function(msg) {
      if (msg.body === 'quack') {
        room.speak('quack!', logger);
      }
      if (/w(h)?at/i.test(msg.body)) {
        room.speak('yr not david mark', logger);
      }
      if (/advice/i.test(msg.body)) {
        room.speak('talk to Paul on quora http://www.quora.com/Dating-Relationships-on-Quora', logger);
      }
      if (/hi|yo|hello/.test(msg.body)) {
        room.speak('o hai', logger);
      }
      if (/wookie/.test(msg.body)) {
        room.speak('is prettymuch the best', logger);
      }
      if (/^eval (.+)/.test(msg.body)) {
        sandbox.run(/^eval (.+)/.exec(msg.body)[1], function(output) {
          output = output.result.replace(/\n/g, ' ');
          return room.speak(output, logger);
        });
      }
    });
  });
});