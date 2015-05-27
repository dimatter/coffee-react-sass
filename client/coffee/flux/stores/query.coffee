{
  ADD_QUERY
  REMOVE_QUERY
} = require '../constants'

# Why this here and not in ape? same with $ and _
Fluxxor = require 'Fluxxor'

module.exports = Fluxxor.createStore
  initialize: ->
    @queryId = 0
    @queries = {}

    @bindActions(
      ADD_QUERY, @onAddQuery
      REMOVE_QUERY, @onRemoveQuery
    )

  onAddQuery: (payload) ->
    id = @._nextQueryId()
    query =
      id: id
      text: payload.text

    @queries[id] = query
    @emit 'change'

  onRemoveQuery: (payload) ->
    delete @queries[payload.id]
    @emit 'change'

  getState: ->
    queries: @queries

  _nextQueryId: ->
    ++@.queryId