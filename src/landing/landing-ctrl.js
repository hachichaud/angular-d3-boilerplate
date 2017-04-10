// To use this, comment the .coffee version and uncomment this one

angular.module('%module%.landing')
.controller('LandingCtrl', function($scope, $http) {
  var LandingCtrl = this;
  LandingCtrl.users = [];
  LandingCtrl.test = "abc";
  LandingCtrl.availableRoles = ['USER', 'EDITOR', 'ADMIN'];
  LandingCtrl.toggleRole = toggleRole;

  $http.get('data/users.csv')
  .then(function(res) {
    LandingCtrl.users = Papa.parse(res.data, {
      header: true,
      delimiter: ',',
      dynamicTyping: true,
      skipEmptyLines: true
    }).data;

    LandingCtrl.users = LandingCtrl.users.map(function(user) {
        user.initials = toInitial(user.firstname) + toInitial(user.lastname);

        user.roleList = user.roles.split(";");
        user.checkRole = LandingCtrl.availableRoles.map(function(item){
           return {roleName : item, checked : user.roles.includes(item)};
        });
        return user;
      })
  });

  function toggleRole(role) {
    console.log(role);
    role.checked = !role.checked;
  }

  function toInitial(firstName){
    var initials = "";
    var tmpArr = firstName.split("-");
    tmpArr.map(function(item) {
      initials += item[0];
    });
    return initials;
  }
});
