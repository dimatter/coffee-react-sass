{
  ADD_QUERY
  ADD_QUERY_SUCCESS
  ADD_QUERY_FAIL
  REMOVE_QUERY
} = require '../constants'

# Why this here and not in ape? same with $ and _
Fluxxor = require 'Fluxxor'

module.exports = Fluxxor.createStore
  initialize: ->
    @queryId = 0
    @queries = {}
    @loading = false

    @bindActions(
      ADD_QUERY, @onAddQuery
      ADD_QUERY_SUCCESS, @onAddQuerySuccess
      ADD_QUERY_FAIL, @onAddQueryFail
      REMOVE_QUERY, @onRemoveQuery
    )

  onAddQuery: (payload) ->
    @loading = true

    id = @._nextQueryId()
    query =
      id: id
      query: payload.query

    @queries[id] = query
    @emit 'change'

  onAddQuerySuccess: (payload) ->
    @loading = false
    @emit 'change'

  onAddQueryFail: (payload) ->
    @loading = false
    @emit 'change'

  onRemoveQuery: (payload) ->
    delete @queries[payload.id]
    @emit 'change'

  getState: ->
    queries: @queries
    loading: @loading

  _nextQueryId: ->
    ++@.queryId