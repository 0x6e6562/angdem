ApplicationController = function($cookies, $route) {
	
	var scope = this;

	scope.username = function() {
		return $cookies.username;
	};
	
	scope.authenticated = function() {
		return ($cookies.username && $cookies.username != '') ? true : false;
	};
	
	scope.logout = function() {
		delete $cookies.username;
	};
	
	$route.when('/login',    {template: 'static/login.html',    controller: LoginController});
	$route.when('/signup',   {template: 'static/signup.html',   controller: SignupController});
	$route.when('/activate', {template: 'static/activate.html', controller: ActivationController});
	$route.when('/',  		   {template: 'static/home.html',     controller: HomeController});
	
	$route.otherwise({redirectTo: '/'});
	
	$route.parent(this);

}
ApplicationController.$inject = ['$cookies', '$route'];