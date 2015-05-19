express     = require 'express'
bodyParser  = require 'body-parser'
app         = express()
users       = require './routes/users'

app.set 'title', 'Skeleton'

app.use express.static('public')
app.use express.static('images')
app.use express.static('fonts')

app.use '/users', users

app.get '/', (req, res) ->
  res.sendFile 'index.html', { root: './public' }

# Boot server up
server = app.listen 3000, ->
  host = server.address().address
  port = server.address().port
  name = app.get 'title'

  console.log "#{name} server listening at http://#{host}:#{port}"
