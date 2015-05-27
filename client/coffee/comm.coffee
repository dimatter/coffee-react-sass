_ = require 'lodash'
$ = require 'jquery'

{ API_KEY } = require './config'

module.exports = class
  @get: (url, data = {}, success, error, extra = {}) ->
    @send url, "GET", data, success, error, extra

  @post: (url, data = {}, success, error, extra = {}) ->
    @send url, "POST", data, success, error, extra

  @patch: (url, data = {}, success, error, extra = {}) ->
    @send url, "PATCH", data, success, error, extra

  @delete: (url, data = {}, success, error, extra = {}) ->
    @send url, "DELETE", data, success, error, extra

  # Wrapper around the jquery ajax call
  @send: (url, method = "GET", data = {}, success, error, extra = {}) ->
    setup =
      url: url
      method: method
      data: data
      beforeSend: (xhr) =>
        xhr.setRequestHeader("X-Mashape-Key", API_KEY)
      success: [success, @onSuccess]
      error: [error, @onError]

    # Tack on the extra options, if any
    _.extend setup, extra

    # Make the ajax call
    $.ajax setup

  @onSuccess: (res, status) ->
    console.debug "[Communicator] Successfully got: ", res

  @onError: (res, status) ->
    console.debug "[Communicator] Error: ", res
