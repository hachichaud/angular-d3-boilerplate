# To use this, comment the .js version and uncomment this one

# angular.module '%module%.landing'
# .controller 'LandingCtrl',
# ($scope, $http) ->
#   $scope.someText = "Test"
#
#   $scope.users = []
#
#   $scope.availableRoles = ['USER', 'EDITOR', 'ADMIN']
#
#   $http.get 'data/users.csv'
#   .then (res) ->
#     $scope.users = Papa.parse(
#       res.data
#     ,
#       header: true
#       delimiter: ','
#       dynamicTyping: true
#       skipEmptyLines: true
#     ).data
