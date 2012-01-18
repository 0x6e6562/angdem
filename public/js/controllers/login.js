LoginController = function($cookies) {
	
	var scope = this;
	
  scope.form = {
   username: '',
	 password: ''
  };

	scope.login = function() {
		var id = scope.form.username;
		if (id == 'foo') {
			$cookies.username = id;
			// Not 100% happy about having to name the form explicitly here
			scope.loginForm.$emit('$valid', 'credentials');
		}
		else {
			// Not 100% happy about having to name the form explicitly here
			scope.loginForm.$emit('$invalid', 'credentials');
		}
		
	};

}
LoginController.$inject = ['$cookies'];