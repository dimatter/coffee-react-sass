# @cjsx React.DOM
Menu = require './menu'

App = React.createClass
  displayName: 'App'

  render: ->
    <div>
      <h1>Hello, World!</h1>
      <Menu />
    </div>

module.exports = App

