SignupController = function($location) {
	
	var scope = this;
	
  scope.form = {
		username: '',
	  password: '',
	  email: ''
  };

	scope.signup = function() {
		var id = scope.form.username;
		$location.path('/activate');		
	};
	
	scope.identifierExists = function(identifier, yes, no) {
    var resource = '/signup/exists/' + identifier;
 
    // $xhr('GET', resource, function(code, response) {
    //       (response == 'true') ? yes() : no()
    //     });
		(identifier == 'foo') ? yes() : no();
  };
  
  scope.checkUsername = function() {
    var widget = scope.signupForm;
    this.identifierExists(this.form.username,
      function() {
        if (!widget.$error.username_exists) {
          widget.$emit('$invalid', 'username_exists');
        }
      },
      function() {
        widget.$emit('$valid', 'username_exists');
      }
    );
  };
  
  scope.checkEmail = function() {
    var widget = scope.signupForm;  
    this.identifierExists(this.form.email,
      function() {
        if (!widget.$error.email_exists && !widget.email.$invalid) {
          widget.$emit('$invalid', 'email_exists');
        }
      },
      function() {
        widget.$emit('$valid', 'email_exists');
      }
    );
  };

}
SignupController.$inject = ['$location'];