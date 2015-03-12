# @cjsx React.DOM

LeftNav = React.createClass
  displayName: 'LeftNav'

  componentWillMount: ->
    console.log "componentWillMount"

  componentDidMount: ->
    console.log "componentDidMount"

  componentWillReceiveProps: ->
    console.log "componentWillReceiveProps"

  shouldComponentUpdate: ->
    console.log "shouldComponentUpdate"

  componentWillUpdate: ->
    console.log "componentWillUpdate"

  componentDidUpdate: ->
    console.log "componentDidUpdate"

  componentWillUnmount: ->
    console.log "componentWillUnmount"

  render: ->
    <nav id="left-nav">
      <a><i className="fa fa-github"></i></a>
    </nav>

module.exports = LeftNav
