# @cjsx React.DOM
'use strict'

_ = require 'lodash'
RD3 = require 'react-d3'

Fluxxor = require 'Fluxxor'
FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

# NOTE: why does comm need to be explicilty required here, but not APE?
comm = require './../comm'
{ API_KEY } = require './../config'

module.exports = React.createClass
  mixins: [FluxMixin, StoreWatchMixin('QueryStore')]

  getInitialState: ->
    newQuery: ''

  getStateFromFlux: ->
    queries: @getFlux().store('QueryStore').getState().queries

  handleQueryChange: (e) ->
    @setState query: e.target.value

  handleQueryRemove: (e) ->
    @getFlux().actions.removeQuery e.target.dataset.id

  onSubmitForm: (e) ->
    e.preventDefault()
    extras =
      dataType: "jsonp",
      cache: false,
      crossDomain: true,
      processData: true

    comm.get "http://www.comicvine.com/api/search/?api_key=4f9f897e7a16eb1551afafde0d1687bc50f2b46e&query=lex-luthor&format=json", {},
      (res) =>
        console.warn "TODO handle success", res
      (res) =>
        console.warn "TODO handle error", res
      , extras

    if @state.newQuery? and @state.newQuery.trim()
      @getFlux().actions.addTodo @state.newQuery
      @setState query: ''

  render: ->
    <div className="list-wrapper">
      <ul>
        {
          if Object.keys(@state.queries).length
            for key, query of @state.queries
              <li key={key}>{query.text}<span data-id={query.id} onClick={@handleQueryRemove}>X</span></li>
          else
            <li>Nothing here</li>
        }
      </ul>
      <form onSubmit={@onSubmitForm}>
        <input type="text" size="30" placeholder="New..."
          value={@state.newQuery}
          onChange={@handleQueryChange} />
        <input type="submit" value="Load" />
      </form>
    </div>
