{
  ADD_QUERY
  ADD_QUERY_SUCCESS
  ADD_QUERY_FAIL
  REMOVE_QUERY
} = require "../constants"

comm = require './../../comm'

module.exports =
  addQuery: (text) ->
    @dispatch ADD_QUERY, text: text

    comm.get 'http://www.comicvine.com/api/search/?api_key=4f9f897e7a16eb1551afafde0d1687bc50f2b46e&query=lex-luthor&format=json', {},
      (res) =>
        @dispatch ADD_QUERY_SUCCESS, res
      (res) =>
        @dispatch ADD_QUERY_FAIL, res

  removeQuery: (id) ->
    @dispatch REMOVE_QUERY, id: id