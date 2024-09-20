import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'viewer_home_screen.dart';
import 'admin_home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _showPassword = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();

        if (userDoc.exists) {
          if (userDoc['role'] == 'admin') {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomeScreen(user: userCredential.user!)));
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewerHomeScreen(user: userCredential.user!)));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User login is successfully')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
        backgroundColor: Colors.amber,
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),


                  labelText: 'Email',
                  hintText: "Please enter email"
                  ),
                onChanged: (val) => email = val,
                validator: (val) => val!.contains('@') ? null : 'Invalid email',
              ),
              SizedBox(height: 20,),

              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)),
                  labelText: 'Password',
                  hintText: 'Enter password',
                  suffixIcon: IconButton(
                    icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _showPassword = !_showPassword),
                  ),
                ),
                obscureText: !_showPassword,
                onChanged: (val) => password = val,
            
                validator: (val) => val!.length >= 8 && val.contains(RegExp(r'[A-Z]')) && val.contains(RegExp(r'[!@#\$&*~]'))
                    ? null
                    : 'Password must be 8 characters,',
              ),
              SizedBox(height: 40),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple,
                ),
               // width: MediaQuery.of(context).size.width,
                //color: Colors.purple,
                child: TextButton(
                  onPressed: _login, 
                  child: Text('Login',style: TextStyle(fontSize: 15,color: Colors.white),),
                  ),
              ),
            
              // TextButton(
              //   onPressed: () {
              //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
              //   },
              //   child: Text('Don\'t have an account? Sign Up'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
