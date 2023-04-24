import 'package:flutter/material.dart';
import 'package:facebook_auth/view-model/login-view-model.dart';
import 'package:facebook_auth/view-model/FBloginout-vew-model.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  late LoginViewModel _loginViewModel;
  late FBLoginViewModel _fbloginViewModel;

  @override
  void initState() {
    _loginViewModel = LoginViewModel();
    _fbloginViewModel = FBLoginViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Auth',
                style: GoogleFonts.pacifico(
                  textStyle: const TextStyle(fontSize: 80),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _loginViewModel.login(_email, _password, context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text('Login'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text('- Or Login with -'),
              const SizedBox(height: 10),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    _fbloginViewModel.login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.facebook),
                      Text('Login with Facebook'),
                      Opacity(
                        opacity: 0.0,
                        child: Icon(Icons.facebook),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
