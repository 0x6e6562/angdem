ActivationController = function($cookies, userDetailsById) {
	
	var scope = this;
	
	scope.user = userDetailsById($cookies.username);
	
	scope.email = function() {		
		if (scope.user) return scope.user.email;
	};
	
}
ActivationController.$inject = ['$cookies', 'userDetailsById'];
