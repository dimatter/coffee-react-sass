{
  ADD_THOUGHT
  ADD_THOUGHT_SUCCESS
  ADD_THOUGHT_FAIL
  REMOVE_THOUGHT
} = require '../constants'

# Why this here and not in ape? same with $ and _
Fluxxor = require 'Fluxxor'

module.exports = Fluxxor.createStore
  initialize: ->
    @thoughtId = 0
    @results = []
    @thoughts = {}
    @loading = false

    @bindActions(
      ADD_THOUGHT, @onAddThought
      ADD_THOUGHT_SUCCESS, @onAddThoughtSuccess
      ADD_THOUGHT_FAIL, @onAddThoughtFail
      REMOVE_THOUGHT, @onRmoveThought
    )

  onAddThought: (payload) ->
    @loading = true

    id = @._nextThoughtId()
    thought =
      id: id
      text: payload.text

    @thoughts[id] = thought
    @emit 'change'

  onAddThoughtSuccess: (payload) ->
    @results = payload
    @loading = false
    @emit 'change'

  onAddThoughtFail: (payload) ->
    @loading = false
    @emit 'change'

  onRmoveThought: (payload) ->
    delete @thoughts[payload.id]
    @emit 'change'

  getState: ->
    thoughts: @thoughts
    results: @results
    loading: @loading

  _nextThoughtId: ->
    ++@.thoughtId