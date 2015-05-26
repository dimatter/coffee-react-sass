# @cjsx React.DOM
Fluxxor = require 'Fluxxor'
BarChart = require('react-d3/barchart').BarChart

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

{ API_KEY } = require './../config'

module.exports = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("TodoStore")]

  getInitialState: ->
    nextTodoText: ""
    barData: [
      label: 'A', value: 5
      label: 'B', value: 6
      label: 'F', value: 7
    ]

  getStateFromFlux: ->
    todos: @getFlux().store("TodoStore").getState().todos

  handleTodoTextChange: (e) ->
    @setState newTodoText: e.target.value

  handleTodoRemove: (e) ->
    @getFlux().actions.removeTodo e.target.dataset.id

  onSubmitForm: (e) ->
    e.preventDefault()
    console.log API_KEY

    if @state.newTodoText? and @state.newTodoText.trim()
      @getFlux().actions.addTodo @state.newTodoText
      @setState newTodoText: ''

  render: ->
    <div className="list-wrapper">
      <ul>
        {
          if Object.keys(@state.todos).length
            for key, todo of @state.todos
              <li key={key}>{todo.text}<span data-id={todo.id} onClick={@handleTodoRemove}>X</span></li>
          else
            <li>Nothing here</li>
        }
      </ul>
      <BarChart
        data={@state.barData}
        width={500}
        height={200}
        fill={'#3182bd'}
        title='Bar Chart'
      />
      <form onSubmit={@onSubmitForm}>
        <input type="text" size="30" placeholder="New..."
          value={@state.newTodoText}
          onChange={@handleTodoTextChange} />
        <input type="submit" value="Add todo" />
      </form>
    </div>
