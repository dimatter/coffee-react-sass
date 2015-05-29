{
  ADD_THOUGHT
  ADD_THOUGHT_SUCCESS
  ADD_THOUGHT_FAIL
  REMOVE_THOUGHT
} = require "../constants"

# TODO: these paths are ugly... any better way?
comm  = require './../../comm'
{ BASE_URL } = require './../../config'

module.exports =
  addThought: (text) ->
    @dispatch ADD_THOUGHT, text: text
    console.log "add thought", text
    # comm.get "#{BASE_URL}/#{text}", {},
    #   (res) =>
    #     @dispatch ADD_THOUGHT_SUCCESS, res
    #   (res) =>
    #     @dispatch ADD_THOUGHT_FAIL, res

  removeThought: (id) ->
    @dispatch REMOVE_THOUGHT, id: id
    console.log "Remove thought"