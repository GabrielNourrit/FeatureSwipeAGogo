import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:FeatureSwipeAGogo/login.dart';
import 'package:FeatureSwipeAGogo/swipe.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App() : super();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes:{
          '/login': (context) => Login(),
          '/swipe': (context) => Swipe()
        },
        theme: ThemeData(
            fontFamily: 'OpenSans',
            primaryColorDark: Color(0xff303030),
            primaryColor: Color(0xffAB9C8B),
            primaryColorLight: Color(0xff707070)
        ),
        home: Login()
    );
  }
}