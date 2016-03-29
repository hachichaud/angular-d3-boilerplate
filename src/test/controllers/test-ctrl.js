angular.module('%module%.landing')
.controller('TestCtrl', function($scope, $http) {

  $scope.pageTitle = "Test page";

  $scope.users = [];
  return $http.get('data/users.csv').then(function(res) {
    return $scope.users = Papa.parse(res.data, {
      header: true,
      delimiter: ',',
      dynamicTyping: true,
      skipEmptyLines: true
    }).data;
  });

});
