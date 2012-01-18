var angdemModule = angular.module('angdem', []);

angdemModule.factory('userDetailsById', function() {
  return function(id) {
		return {username:'foo',email:'foo@bar.com'};
	};
});
