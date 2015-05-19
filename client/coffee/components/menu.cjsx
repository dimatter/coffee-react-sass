# @cjsx React.DOM

Menu = React.createClass
  displayName: 'Menu'

  propsTypes:
    options: React.PropTypes.string

  render: ->
    <nav>
      <li><a>{@props.options}</a></li>
    </nav>

module.exports = Menu
