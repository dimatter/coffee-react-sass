# @cjsx React.DOM
'use strict'

_ = require 'lodash'
RD3 = require 'react-d3'

Fluxxor = require 'Fluxxor'
FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

ListItem = require './lists/list_item'

module.exports = React.createClass
  mixins: [FluxMixin, StoreWatchMixin('QueryStore')]

  getInitialState: ->
    newQuery: ''

  # "read data from the stores at the top-level component and
  # pass the data through props as necessary."
  getStateFromFlux: ->
    results: @getFlux().store('QueryStore').getState().results
    queries: @getFlux().store('QueryStore').getState().queries
    loading: @getFlux().store('QueryStore').getState().loading

  handleQueryChange: (e) ->
    @setState newQuery: e.target.value

  handleQueryRemove: (id) ->
    @getFlux().actions.removeQuery id

  onSubmitForm: (e) ->
    e.preventDefault()

    if !@state.loading and @state.newQuery? and @state.newQuery.trim()
      @getFlux().actions.addQuery @state.newQuery
      @setState newQuery: ''

  getButtonClass: ->
    if @state.loading then 'loading' else ''

  render: ->
    <div className="list-wrapper">
      {
        if Object.keys(@state.queries).length
          <ul>
            {
              for key, query of @state.queries
                <ListItem id={query.id} text={query.text} handleRemove={@handleQueryRemove} />
            }
          </ul>
        else
          <p>Nothing here</p>
      }
      <form onSubmit={@onSubmitForm}>
        <input type="text" size="30" placeholder="New..."
          value={@state.newQuery}
          onChange={@handleQueryChange} />
        <input type="submit" value="Load" className={@getButtonClass()}/>
      </form>
    </div>
