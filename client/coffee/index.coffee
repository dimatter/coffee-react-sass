# Why do i need this in here and in application component?
Fluxxor = require 'Fluxxor'

Application = require './components/application'

stores = require './flux/stores'
actions = require './flux/actions'
flux = new Fluxxor.Flux(stores, actions)

# # Get verbose
flux.on "dispatch", (type, payload) ->
  if console && console.log
    console.log "[DISPATCH]", type, payload

React.render <Application flux={flux} />, document.getElementById('app')