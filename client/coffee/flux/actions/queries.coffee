{
  ADD_QUERY
  ADD_QUERY_SUCCESS
  ADD_QUERY_FAIL
  REMOVE_QUERY
} = require "../constants"

# TODO: these paths are ugly... any better way?
comm  = require './../../comm'
{ BASE_URL } = require './../../config'

module.exports =
  addQuery: (query) ->
    @dispatch ADD_QUERY, query: query

    comm.get "#{BASE_URL}/#{query}", {},
      (res) =>
        @dispatch ADD_QUERY_SUCCESS, res
      (res) =>
        @dispatch ADD_QUERY_FAIL, res

  removeQuery: (id) ->
    @dispatch REMOVE_QUERY, id: id