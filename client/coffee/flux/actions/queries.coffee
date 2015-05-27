{
  ADD_QUERY
  REMOVE_QUERY
} = require '../constants'

module.exports =
  addQuery: (text) ->
    @dispatch ADD_QUERY, text: text

  removeQuery: (id) ->
    @dispatch REMOVE_QUERY, id: id