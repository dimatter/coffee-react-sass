# Why do i need this in here and in application component?
Fluxxor = require 'Fluxxor'

Application = require './components/application'

# Constants
constants =
  ADD_TODO: "ADD_TODO"
  REMOVE_TODO: "REMOVE_TODO"

# Stores
TodoStore = Fluxxor.createStore
  initialize: ->
    @todoId = 0
    @todos = {}

    @bindActions(
      constants.ADD_TODO, @onAddTodo
      constants.REMOVE_TODO, @onRemoveTodo
    )

  onAddTodo: (payload) ->
    id = @._nextTodoId()
    todo =
      id: id
      text: payload.text
      complete: false

    @todos[id] = todo
    @emit "change"

  onRemoveTodo: (payload) ->
    delete @todos[payload.id]
    @emit "change"

  getState: ->
    todos: @todos

  _nextTodoId: ->
    ++@.todoId

# Actions
actions =
  addTodo: (text) ->
    @dispatch constants.ADD_TODO, text: text

  removeTodo: (id) ->
    @dispatch constants.REMOVE_TODO, id: id

# Instantiate stores
stores =
  TodoStore: new TodoStore()

# Instantiate Fluxxor
flux = new Fluxxor.Flux(stores, actions)

# # Get verbose
flux.on "dispatch", (type, payload) ->
  if console && console.log
    console.log "[DISPATCH]", type, payload

React.render <Application flux={flux} />, document.getElementById('app')