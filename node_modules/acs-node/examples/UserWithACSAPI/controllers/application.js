function index(req, res) {
	res.render('index', {user: req.session.user});
}

function login(req, res) {
	res.render('login');
}

function update(req, res) {
	res.render('update');
}

function signup(req, res) {
	res.render('signup');
}
