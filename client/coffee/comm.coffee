_ = require 'lodash'
$ = require 'jquery'

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
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      success: [success, @onSuccess]
      error: [error, @onError]

    extra =
      dataType: 'jsonp',
      cache: false,
      crossDomain: true,
      processData: true

    # Tack on the extra options, if any
    _.extend setup, extra

    # Make the ajax call
    $.ajax setup

  @onSuccess: (res, status) ->
    console.debug "[Communicator] Successfully got: ", res

  @onError: (res, status) ->
    console.debug "[Communicator] Error: ", res
