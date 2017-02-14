// To use this, comment the .coffee version and uncomment this one

angular.module('%module%.landing')
.controller('LandingCtrl', function($scope, $http) {

  $scope.users = [];
  $scope.availableRoles = ['USER', 'EDITOR', 'ADMIN'];

  $http.get('data/users.csv')
  .then(function(res) {
    $scope.users = Papa.parse(res.data, {
      header: true,
      delimiter: ',',
      dynamicTyping: true,
      skipEmptyLines: true
    }).data;
  });
});
