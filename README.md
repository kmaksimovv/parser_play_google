## Google Play Parser
Ruby Script parser Google Play and get information about application

## For a start 
1. Clone repo `git clone https://github.com/kmaksimovv/parser_play_google.git`.
2. `bundle install`.

## Settings database if required
1. Open file `.env` and settings for connection for base.
2. Run command `dotenv` for export ENV Environment Variables.
3. Run script `ruby database_setup.rb`.
  This script created database, table and columns.

## Get information about application
1. Run script `ruby main.rb 'href to application'`.
  
  $ For example, `ruby main.rb https://play.google.com/store/apps/details?id=com.idamob.tinkoff.android`

## Get history ratings for app
1. Run script, `ruby app_history_ratings.rb 'name app' 'count last ratings'`
  
  $ For example, ruby app_history_ratings.rb tinkoff 10

## Contributing
Bug reports and pull requests are welcome on GitHub at `https://github.com/kmaksimovv/parser_play_google`.

## Api
1. Run server.rb

  $ For example, run command

  `curl -i -X GET -H "Content-Type: application/json"  http://localhost:4567/api/v1/apps`

          Response to json:
          
          [
            {
              "id": 1,
              "name": "tinkoff",
              "category": "Finance",
              "dowload_count": "388982",
              "author": "https://www.tinkoff.ru",
              "author_email": "support@tinkoff.ru",
              "created_at": "2019-07-09 22:02:21 +0400"
            }
          ]

