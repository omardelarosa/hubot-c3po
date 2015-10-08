_ = require 'lodash'
NO_TOPIC = 'none';

module.exports = (robot) ->

  robot.hear /topic set (.*)/, (msg) ->
    t = msg.match[1]
    if (t)
      robot.brain.set 'currentTopic', t
      listString = robot.brain.get 'topicList'
      if listString
        list = _.without((listString.split ','), NO_TOPIC)
        list.push t.replace ',',''
        robot.brain.set 'topicList', _.uniq(list).join(',')
      else
        robot.brain.set 'topicList', NO_TOPIC

      msg.send "Topic has been set to '" +msg.match[1] + "'"

  robot.hear /topic (list|ls)/, (msg) ->
    msg.send robot.brain.get('topicList')

  robot.hear /topic current/, (msg) ->
    msg.send "The current topic is '" + robot.brain.get('currentTopic') + "'"

  robot.hear /topic reset/, (msg) ->
    robot.brain.set('topicList', NO_TOPIC)
    msg.send "Consider it all forgotten."

  robot.hear /topic help/, (msg) ->
    s = "@bot [set|list|reset|current] TOPIC"
    msg.send s
