# Angular + d3js Boilerplate
> Starter kit with angular and d3 + gulp build

## Hello !

For this test, please take a look at the mock-ups in the test_maquettes folder.
The target result is in 'test_user.png'.

The goal is to make a user list directive where users can be edited.
When clicking the edit button, a form should open and allow the modification of the username and the user roles.

### Constraints

- When modifying roles/username, we should be able to see the modification in realtime
- The roles should be editable as checkboxes
- In term of design, the minimum is what's on 'test_user.png'

### Additional info

- The user data is requested in landing-ctrl
- There are only three possible roles (cf. $scope.availableRoles in landing controller)

### Feel free to...

- Up angular version
- download other packages
- Use google
- Use js or coffee
- Ask me for help!

### And then?

The result should be pushed to github or bitbucket.


### Build

```bash
# Install npm + bower dependencies and then build
npm install
# Launch the watcher + livereload
npm start
# http://localhost:8000
```
