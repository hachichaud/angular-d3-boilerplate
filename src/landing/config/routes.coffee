angular.module '%module%.landing'
.config ($stateProvider) ->
  $stateProvider
  .state 'landing',
    url: '/'
    templateUrl: 'landing/views/view.html'
    controller: 'LandingCtrl'
  .state 'landing.simple-bar-chart',
    url: 'simple-bar-chart'
    templateUrl: 'landing/views/simple-bar-chart.html'
