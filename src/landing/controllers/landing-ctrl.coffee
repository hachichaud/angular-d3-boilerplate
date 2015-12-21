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

  $http.get 'data/0_32205_1.csv'
  .then (res) ->
    $scope.slaveData = Papa.parse(
      res.data
    ,
      header: true
      delimiter: ','
      dynamicTyping: true
      skipEmptyLines: true
    ).data
    console.log $scope.slaveData

  $scope.highlight = 1

.directive 'slave', ->
  restrict: 'E'
  scope:
    data: '='
    selectedValue: '='
  templateUrl: 'landing/views/slave.html'
  link: ($scope, $element, $attr) ->
    console.log 'youhou'
    svg = undefined
    margin =
      top: 20
      right: 20
      bottom: 30
      left: 40
    width = 700 - (margin.left) - (margin.right)
    height = 300 - (margin.top) - (margin.bottom)
    xSpace = 70
    y = d3.scale.linear().range([
      height
      0
    ])
    draw = (data) ->
      return unless data

      yAxis = d3.svg.axis().scale(y).orient('left')
      svg = d3.select('#slave-chart')
      .append('svg')
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom)
      .append('g')
      .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')

      y.domain [
        0
        d3.max(data, (d) ->
          d.value
        )
      ]

      svg.append('g').attr('class', 'y axis').call(yAxis).append('text')
      .attr('transform', 'rotate(-90)').attr('y', 6).attr('dy', '.71em')
      .style('text-anchor', 'end').text 'Value'
      svg.selectAll('.bar')
      .data(data.filter((d) ->
        d.date == $scope.selectedValue
      )).enter()
      .append('g').attr('class', 'g-group')
      .append('rect')
      .attr('class', 'bar')
      .attr('x', (d, i) ->
        xSpace * i
      ).attr('width', xSpace)
      .attr('y', (d) ->
        y d.value
      ).attr 'height', (d) ->
        height - y(d.value)

      svg.selectAll('.g-group')
      .append('text')
      .attr('x', (d, i) ->
        xSpace * i
      )
      .text((d) -> d.label)


      return

    update = ->
      return unless $scope.data
      console.table $scope.data.filter((d) ->
        d.date == $scope.selectedValue
      )
      bars = svg.selectAll '.bar'
      .data $scope.data.filter((d) ->
        d.date == $scope.selectedValue
      )

      bars.enter()

      bars
        .transition()
        .duration(500)
        .attr 'y', (d) ->
          y d.value
        .attr 'height', (d) ->
          height - y(d.value)

      sorted = $scope.data.filter((d) ->
          d.date == $scope.selectedValue
        ).sort( (a, b) ->
          a.value < b.value
        )

      bars = svg.selectAll '.bar'
        .data sorted
      bars.enter()
      bars.transition()
        .duration(500)
        .delay(500)
        .attr('x', (d, i) ->
          console.log 'yolo', d, i
          xSpace * i
        ).attr('width', (d, i) -> xSpace / (i+1))

      svg.selectAll('.g-group')
        .attr('x', (d, i) ->
          console.log d.label, xSpace*i
          xSpace * i
        )

      bars
        .exit()
        .remove()


    $scope.$watch 'data', (newValue) ->
      return unless newValue
      newValue.forEach (d) ->
        d.date = parseDate(d.date)
      draw(newValue)

    $scope.$watch 'selectedValue', (newValue, oldValue) ->
      return unless newValue
      return if newValue is oldValue
      update()

    parseDate = (date) ->
      +date.split(" ")[1]

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
      width = 700 - (margin.left) - (margin.right)
      height = 250 - (margin.top) - (margin.bottom)
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
      .attr('r', 15)
      .attr('cx', (d) -> x d.date)
      .attr('cy', (d) -> y d.value).style('fill', (d) -> 'red')
      .on('click', (d) ->
        $scope.selectedValue = d.date
        $scope.$apply()
      )

    $scope.$watch 'data', (newValue, oldValue, scope) ->
      return unless newValue
      newValue.forEach (d) ->
        d.date = parseDate(d.date)
      draw(newValue)

    parseDate = (date) ->
      +date.split(" ")[1]
