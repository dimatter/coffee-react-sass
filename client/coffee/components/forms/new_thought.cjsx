
module.exports = React.createClass
  mixins: [FluxMixin, StoreWatchMixin('ThoughtStore')]

  propTypes:
    onSubmit: React.PropTypes.func.isRequired

  render: ->
    <form className="new-thought-form" onSubmit={@onSubmitForm}>
      <input type="text" size="30" placeholder="New Thought..."
        value={@state.newThought}
        onChange={@handleInputChange} />
      <input type="submit" value="Load" className={@getButtonClass()}/>
    </form>