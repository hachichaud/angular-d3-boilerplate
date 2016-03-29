angular.module '%module%.test'
.config ($stateProvider) ->
  $stateProvider
  .state 'landing.test',
    url: 'test'
    templateUrl: 'test/views/test.html'
    controller: 'TestCtrl'
  # .state 'landing.simple-bar-chart',
  #   url: 'simple-bar-chart'
  #   template: '<simple-bar-chart chart-data="data"></simple-bar-chart>'
