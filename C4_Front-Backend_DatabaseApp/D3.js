import * as d3 from 'd3';

function drawNetwork(data) {
  const svg = d3.select('svg');
  const width = +svg.attr('width');
  const height = +svg.attr('height');

  const simulation = d3.forceSimulation(data.nodes)
    .force('link', d3.forceLink(data.links).id(d => d.id))
    .force('charge', d3.forceManyBody())
    .force('center', d3.forceCenter(width / 2, height / 2));

  const link = svg.append('g')
    .selectAll('line')
    .data(data.links)
    .enter().append('line')
    .attr('stroke-width', d => Math.sqrt(d.value));

  const node = svg.append('g')
    .selectAll('circle')
    .data(data.nodes)
    .enter().append('circle')
    .attr('r', 5)
    .call(d3.drag()
      .on('start', dragstarted)
      .on('drag', dragged)
      .on('end', dragended));

  node.append('title')
    .text(d => d.id);

  simulation.on('tick', () => {
    link
      .attr('x1', d => d.source.x)
      .attr('y1', d => d.source.y)
      .attr('x2', d => d.target.x)
      .attr('y2', d => d.target.y);

    node
      .attr('cx', d => d.x)
      .attr('cy', d => d.y);
  });

  function dragstarted(event, d) {
    if (!event.active) simulation.alphaTarget(0.3).restart();
    d.fx = d.x;
    d.fy = d.y;
  }

  function dragged(event, d) {
    d.fx = event.x;
    d.fy = event.y;
  }

  function dragended(event, d) {
    if (!event.active) simulation.alphaTarget(0);
    d.fx = null;
    d.fy = null;
  }
}
