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
    loading: @getFlux().store('QueryStore').getState().loading

  handleQueryChange: (e) ->
    @setState newQuery: e.target.value

  handleQueryRemove: (e) ->
    @getFlux().actions.removeQuery e.target.dataset.id

  onSubmitForm: (e) ->
    e.preventDefault()

    if !@state.loading and @state.newQuery? and @state.newQuery.trim()
      @getFlux().actions.addQuery @state.newQuery
      @setState newQuery: ''

  getButtonClass: ->
    if @state.loading then 'loading' else ''

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
        <input type="submit" value="Load" className={@getButtonClass()}/>
      </form>
    </div>
