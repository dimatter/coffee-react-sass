# @cjsx React.DOM
'use strict'

d3 = require 'd3'
{ dataset } = require '../../utils/data'

module.exports = React.createClass

  displayName: 'DonutChart'

  propTypes:
    data:   React.PropTypes.object.isRequired
    height: React.PropTypes.number
    width:  React.PropTypes.number

  getDefaultProps: ->
    data:   dataset
    height: 2200
    width:  1000

  getInitialState: ->
    root: null

  create: ->
    el = @refs.donut.getDOMNode()

    # New cluster graph
    cluster = d3.layout.cluster().size([@props.height, @props.width])

    # Diangonal projection to make the graph vertical
    diagonal = d3.svg.diagonal().projection (d) -> [d.x, d.y]

    root = d3.select(el).append('svg')
      .attr('class','nodes')
      .attr('width', @props.width)
      .attr('height', @props.height)

      .call(d3.behavior.zoom().scaleExtent([1, 10]).on('zoom', @update))
      .append('g')
      .attr('transform', 'translate(0, 0)')

    nodes = cluster.nodes(@props.data)

    link = root.selectAll('path.link')
      .data(cluster.links(nodes))
      .enter().append('path')
      .attr('class','link')
      .attr('d', diagonal)

    node = root.selectAll('g.node')
      .data(nodes)
      .enter().append('g')
      .attr('class', 'node')
      .attr('transform', (d) -> "translate(#{d.x},#{d.y})")

    node.append('circle')
      .attr('r', 10.5)

    node.append('text')
      .attr('text-anchor', 'middle')
      .text((d) -> d.name)

    @setState root: root

    @update()

  draw: ->
    console.log 'draw'

  update: ->
    console.log 'Update'
    el = @refs.donut.getDOMNode()

    if d3.event?
      d3.event.sourceEvent.stopPropagation()
      switch d3.event.type
        when 'zoom'
          @state.root.attr('transform', "translate(#{d3.event.translate})scale(#{d3.event.scale})")

    g = d3.select(el).selectAll('.nodes')

    node = g.selectAll('.node')
      .data(@props.data)

    # Enter
    node.enter().append('circle')
      .attr('r', 10.5)
      .text((d) -> d.name)

    # Enter & Update
    # TODO update text

    # Exit
    node.exit().remove()


  destroy: ->
    console.log 'destroy'

  componentDidMount: ->
    @create()

  componentWillRecieveProps: ->
    @update()

  componentDidUpdate: ->
    @update()

  componentWillUnmount: ->
    @destroy()


  render: ->
    <div className="donut-chart" ref="donut"></div>
