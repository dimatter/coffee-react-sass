express = require 'express'
router = express.Router()

router.route('/:user_id?')
  .all (req, res, next) ->
    console.log "Incoming #{req.method} request"
    id = req.params.user_id
    unless id?
      res.sendFile 'index.html', { root: "./public" }
    else
      next()
  .get (req, res, next) ->
    res.json { userId: req.params.user_id }

module.exports = router

