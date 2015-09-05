# slackbot
git add -A
git commit -m "act also for line feed & carrige return"
git push -u origin master
git push heroku master
heroku ps:scale web=1
vi scripts/trello.coffee
HUBOT_TRELLO_TODO='55e9a07539ce71010d0006c7' HUBOT_TRELLO_KEY='1c1d128356cdd804e005a2226d255a11' HUBOT_TRELLO_TOKEN='30f06e93e0b81d1e4a409b628acad20bef128931fe65a41ef0373e8a460b2310' PATH="./node_modules/hubot/node_modules/.bin:$PATH"  ./bin/hubot -a shell -n uran -r src
