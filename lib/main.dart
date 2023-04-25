import 'package:facebook_auth/view-model/login-view-model.dart';
import 'package:facebook_auth/view/fbuser-info-screen.dart';
import 'package:facebook_auth/view/listing-screen.dart';
import 'package:flutter/material.dart';
import 'package:facebook_auth/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = false;
  late String id;
  late String token;

  isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  id = prefs.getString('id') ?? '';
  token = prefs.getString('token') ?? '';

  final FBprefs = await SharedPreferences.getInstance();
  bool isFBLoggedIn = false;
  late String FBname;
  late String FBemail;
  late String FBurl;

  isFBLoggedIn = FBprefs.getBool('isFBLoggedIn') ?? false;
  FBname = FBprefs.getString('FBname') ?? '';
  FBemail = FBprefs.getString('FBemail') ?? '';
  FBurl = FBprefs.getString('FBurl') ?? '';

  LoginViewModel loginViewModel = LoginViewModel();

  runApp(
    MyApp(
      isLoggedIn: isLoggedIn,
      id: id,
      token: token,
      loginViewModel: loginViewModel,
      isFBLoggedIn: isFBLoggedIn,
      FBname: FBname,
      FBemail: FBemail,
      FBurl: FBurl,
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  final String id;
  final String token;
  final LoginViewModel loginViewModel;
  final bool isFBLoggedIn;
  final String FBname;
  final String FBemail;
  final String FBurl;

  const MyApp(
      {Key? key,
      required this.isLoggedIn,
      required this.loginViewModel,
      required this.id,
      required this.token,
      required this.isFBLoggedIn,
      required this.FBname,
      required this.FBemail,
      required this.FBurl})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isLoggedIn;
  late String id;
  late String token;
  late LoginViewModel loginViewModel;
  late bool isFBLoggedIn;
  late String FBname;
  late String FBemail;
  late String FBurl;

  @override
  void initState() {
    super.initState();
    isLoggedIn = widget.isLoggedIn;
    id = widget.id;
    token = widget.token;
    loginViewModel = widget.loginViewModel;
    isFBLoggedIn = widget.isFBLoggedIn;
    FBname = widget.FBname;
    FBemail = widget.FBemail;
    FBurl = widget.FBurl;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      home: isLoggedIn
          ? ListPage(id: id, token: token)
          : isFBLoggedIn
              ? FBUserInfo(email: FBemail, name: FBname, url: FBurl)
              : LoginPage(),
      routes: {
        '/home': (context) => ListPage(id: id, token: token),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
