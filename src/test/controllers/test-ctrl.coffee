# angular.module '%module%.landing'
# .controller 'TestCtrl',
# ($scope, $http) ->
#   $scope.someText = "Test"
#
#   $scope.users = []
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
