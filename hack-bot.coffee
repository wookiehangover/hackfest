sys = require 'sys'
Campfire = require('./node-campfire/lib/campfire').Campfire
Sandbox = require 'sandbox'

sandbox = new Sandbox()

instance = new Campfire({
  ssl: true
  token: 'fc3438c24c8302f9c6550b75bfb60ec4eadb870a'
  account: 'quickleft'
})

logger = ( d ) ->
  console.log "quack sent: #{d.message.created_at}"

instance.room 401915, ( room ) ->
  room.join ->
    room.listen ( msg ) ->

      if msg.body is 'quack'
        room.speak 'quack!', logger

      if /w(h)?at/i.test( msg.body )
        room.speak 'yr not david mark', logger

      if /advice/i.test( msg.body )
        room.speak 'talk to Paul on quora http://www.quora.com/Dating-Relationships-on-Quora', logger

      #if /ha/i.test( msg.body ) and /hat-bot/.test( msg.body ) is false and /hai/.test( msg.body ) is false
        #room.speak 'shut up, hat-bot', logger

      if /hi|yo|hello/.test( msg.body )
        room.speak 'o hai', logger

      if /wookie/.test( msg.body )
        room.speak 'is prettymuch the best', logger

      if /^eval (.+)/.test( msg.body )
        sandbox.run /^eval (.+)/.exec(msg.body)[1], ( output ) ->
          output = output.result.replace( /\n/g, ' ' )
          room.speak output, logger

      return
