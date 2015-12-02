angular.module '%module%.landing'
.controller 'LandingCtrl',
($scope, $http) ->
  $scope.someText = "Hello you !"

  $http.get 'data/0_32205_0.csv'
  .then (res) ->
    $scope.data = Papa.parse(
      res.data
    ,
      header: true
      delimiter: ','
      dynamicTyping: true
      skipEmptyLines: true
    ).data
    console.log $scope.data

  $scope.highlight = 0

.directive 'master', ->
  restrict: 'E'
  scope:
    data: '='
    selectedValue: '='
  templateUrl: 'landing/views/master.html'
  link: ($scope, $element, $attr) ->
    draw = (data) ->
      return unless data
      margin =
        top: 20
        right: 20
        bottom: 30
        left: 50
      width = 960 - (margin.left) - (margin.right)
      height = 500 - (margin.top) - (margin.bottom)
      x = d3.time.scale().range([
        0
        width
      ])
      y = d3.scale.linear().range([
        height
        0
      ])
      xAxis = d3.svg.axis().scale(x).orient('bottom')
      yAxis = d3.svg.axis().scale(y).orient('left')

      line = d3.svg.line().x((d) ->
        x d.date
      ).y((d) ->
        y d.value
      )

      svg = d3.select('#master-chart').append('svg')
        .attr('width', width + margin.left + margin.right)
        .attr('height', height + margin.top + margin.bottom)
        .append('g')
        .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')

      x.domain d3.extent(data, (d) ->
        d.date
      )
      y.domain d3.extent(data, (d) ->
        d.value
      )
      svg.append('g')
      .attr('class', 'x axis')
      .attr('transform', 'translate(0,' + height + ')')
      .call xAxis

      svg.append('g').attr('class', 'y axis')
      .call(yAxis)
      .append('text')
      .attr('transform', 'rotate(-90)')
      .attr('y', 6).attr('dy', '.71em').style('text-anchor', 'end').text 'Value (Chaussette)'
      svg.append('path').datum(data).attr('class', 'line').attr 'd', line

      svg.selectAll('.dot').data(data).enter().append('circle').attr('class', 'dot')
      .attr('r', 3.5)
      .attr('cx', (d) -> x d.date)
      .attr('cy', (d) -> y d.value).style('fill', (d) -> 'red')
      .on('click', (d) ->
        $scope.selectedValue = d.value
        $scope.$apply()
      )


    $scope.$watch 'data', (newValue, oldValue, scope) ->
      return unless newValue
      newValue.forEach (d) ->
        d.date = parseDate(d.date)
      draw(newValue)

    parseDate = (date) ->
      +date.split(" ")[1]
