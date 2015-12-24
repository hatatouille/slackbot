https = require('https') random = require('hubot').Response::random 
BASE_URL = 'https://slack.com/api/chat.postMessage?token=xoxp-2600144217-2600144219-17328413682-8ab73f836b' #replace your Slack API key!

members = [  #replace and add your team members!
	'hiroki',
	'bbb',
	'ccc',
	'ddd'
]

module.exports = (robot) ->
	robot.router.post '/hubot/gitlab', (req, res) ->
		channel = "wordpress"　# replace team name!
		json = req.body
		if not json
			res.end ""
			return

		gitlab_event = "#{json.object_kind}" || 'push'

		if gitlab_event is "merge_request" and json.object_attributes.state is "opened"
			merge_request json, channel
				
		if gitlab_event is "push" and json.object_attributes.state is "opened"
			push json, channel

		res.end()

	push = (json, channel) ->
		title = "#{json.object_attributes.title}"
		description = "#{json.object_attributes.description}"
		iid = "#{json.object_attributes.iid}"
		update_time = "#{json.object_attributes.updated_at}"
		namespace = "#{json.object_attributes.source.namespace}".toLowerCase()
		name = "#{json.object_attributes.source.name}".toLowerCase()
		url = "http://133.242.237.95/#{namespace}/#{name}/merge_requests/#{iid}"  # replace your GitLab URL!
		assignee = random members
		message = """
		          Merge Request was created at #{update_time}.
		          #{title}
		          #{description}
		          #{url}
		          @#{assignee}: Pushしやした。
		          """
		url = BASE_URL + 'channel=' + channel + '&text=' + encodeURIComponent(message) + '&link_names=1'
		console.log(url)

		robot.http(url).get() (err, res, body) ->
			console.log body
			return

	merge_request = (json, channel) ->
		title = "#{json.object_attributes.title}"
		description = "#{json.object_attributes.description}"
		iid = "#{json.object_attributes.iid}"
		update_time = "#{json.object_attributes.updated_at}"
		namespace = "#{json.object_attributes.source.namespace}".toLowerCase()
		name = "#{json.object_attributes.source.name}".toLowerCase()
		url = "http://133.242.237.95/#{namespace}/#{name}/merge_requests/#{iid}"  # replace your GitLab URL!
		assignee = random members
		message = """
		          Merge Request was created at #{update_time}.
		          #{title}
		          #{description}
		          #{url}
		          @#{assignee}: レビューお願いしやす。
		          """
		url = BASE_URL + 'channel=' + channel + '&text=' + encodeURIComponent(message) + '&link_names=1'
		console.log(url)

		robot.http(url).get() (err, res, body) ->
			console.log body
			return
