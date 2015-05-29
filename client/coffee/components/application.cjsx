# @cjsx React.DOM
'use strict'

_ = require 'lodash'
RD3 = require 'react-d3'

Fluxxor = require 'Fluxxor'
FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

ListItem = require './lists/list_item'

module.exports = React.createClass
  mixins: [FluxMixin, StoreWatchMixin('ThoughtStore')]

  getInitialState: ->
    newThought: ''

  # "read data from the stores at the top-level component and
  # pass the data through props as necessary."
  getStateFromFlux: ->
    thoughts: @getFlux().store('ThoughtStore').getState().thoughts
    results: @getFlux().store('ThoughtStore').getState().results
    loading: @getFlux().store('ThoughtStore').getState().loading

  handleInputChange: (e) ->
    @setState newThought: e.target.value

  handleThoughtRemove: (id) ->
    @getFlux().actions.removeThought id

  onSubmitForm: (e) ->
    e.preventDefault()

    if !@state.loading and @state.newThought? and @state.newThought.trim()
      @getFlux().actions.addThought @state.newThought
      @setState newThought: ''

  getButtonClass: ->
    if @state.loading then 'loading' else ''

  render: ->
    <div className="list-wrapper">
      {
        if Object.keys(@state.thoughts).length
          <ul>
            {
              for key, thought of @state.thoughts
                <ListItem id={thought.id} text={thought.text} handleRemove={@handleThoughtRemove} />
            }
          </ul>
        else
          <p>Nothing here</p>
      }
      <form onSubmit={@onSubmitForm}>
        <input type="text" size="30" placeholder="New..."
          value={@state.newThought}
          onChange={@handleInputChange} />
        <input type="submit" value="Load" className={@getButtonClass()}/>
      </form>
    </div>
