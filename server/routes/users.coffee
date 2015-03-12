express = require 'express'
router = express.Router()

# define the home page route
router.get '/', (req, res) ->
  res.send 'Birds home page'

router.route('/:user_id')
  .all (req, res, next) ->
    console.log "Incoming #{req.method} request"

    next()
  .get (req, res, next) ->
    res.json '{test: "testing"}'

module.exports = router

