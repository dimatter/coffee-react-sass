module.exports = React.createClass
  displayName: 'ListItem'

  propTypes:
    id:   React.PropTypes.number.isRequired
    text: React.PropTypes.string.isRequired
    handleRemove: React.PropTypes.func

  remove: ->
    @props.handleRemove?(@props.id)

  render: ->
    <li className="list-item">
      {@props.text}
      <button type="button" onClick={@remove}></button>
    </li>