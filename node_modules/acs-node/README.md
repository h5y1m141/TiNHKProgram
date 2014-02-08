acs-node: The sdk of acs for Node.js
==================

ACS SDK for Node.js

You can install it using npm.
    [sudo] npm install acs-node
    
Usage
-----

Example 1, do ACS user login:

~~~
var ACS = require('acs-node');
ACS.initACS('<App Key>');
function login(req, res) {
	var data = {
		login: req.body.username,
		password: req.body.password
	};
	ACS.Users.login(data, function(data){
		if(data.success) {
			console.log("Successful to login.");
            console.log("UserInfo: " + JSON.stringify(data.users[0], null, 2))
		} else {
            console.log("Error to login: " + data.message);
        }
	}, req, res);
}
~~~

Example 2, a generic method show how to operate an ACS user:

~~~
var ACS = require('acs-node');
var sdk = ACS.initACS('<App Key>');
function login(req, res) {
	var data = {
		login: req.body.username,
		password: req.body.password
	};
    sdk.rest('users/login.json', 'POST', data, function(data){
        if(data && data.meta) {
            if(data.meta.status == 'ok') {
                console.log("Successful to login.");
                console.log("UserInfo: " + JSON.stringify(data.response.users[0], null, 2))
            } else {
                console.log("Error to login: " + data.meta.message);
            }
        } else {
            console.log("Error to login, try again later.");
        }
    }, req, res);
}
~~~

More examples, please look up in the folder examples with the command 'acs run'.


Legal
------
This code is proprietary and confidential. 
Copyright (c) 2012 by Appcelerator, Inc.
