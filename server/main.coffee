express = require 'express'
app = express()
users = require './routes/users'

app.set 'title', 'Skeleton'

app.use '/users', users

# Boot server up
server = app.listen 3000, ->
  host = server.address().address
  port = server.address().port
  name = app.get 'title'

  console.log "#{name} server listening at http://#{host}:#{port}"
