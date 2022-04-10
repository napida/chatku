import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoggingIn = false;

  _login() async{
    setState(() {
      isLoggingIn = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
      Navigator.pushNamed(context, '/friend');
    } on FirebaseAuthException catch(e){
      var message = '';
      switch (e.code) {
        case 'invalid-email':
          message = 'Invalid Email';
          break;
        case 'user-disabled':
          message = 'The user you tried to log into is disable';
          break;
        case 'user-not-found':
          message = 'The user you tried to log into was not found';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
      }
      if (_emailController.text =='' && _passwordController.text ==''){
        message = 'please enter email and password';
      }
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('Log in failed'),
          content: Text(message),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text('OK')),
          ],
        );
      });
    } finally {
      setState(() {
        isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('ChatKu', style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            )),
            const SizedBox(height: 5),
            Text('Log In', style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            )),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress, // the keyboard will has .com, @ for easily typing
              ),
            ),

            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,  //hiding the password
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top:28, left: 50.0, right: 50.0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(onPressed: (){
                  _login();
                }, child: Text('Log in', style: TextStyle(fontSize: 20))),
              ),
            ),
            if (isLoggingIn) ...[
              const SizedBox(height: 16),
              Center(child: CircularProgressIndicator()),
            ]
          ],
        ),
      ),
    );
  }
}
