import 'package:flutter/material.dart';
import 'package:flutter_app/utils/shared_preferences.dart';
import 'package:flutter_app/utils/constance.dart';
import 'package:flutter_app/start/login.dart';
import 'package:flutter_app/utils/httpUtils.dart';


void main() {
  HttpUtils.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  bool isLogin = false;

  @override
  void initState() {
    //模拟延时任务
    Future.delayed(Duration(milliseconds: 1000), () {
      return "";
    }).then((a) {
      return SpUtil.getInstance();
    })
        .then((sp) {
      setState(() {
        isLogin = sp.getBool(Contance.loginFlag);
        isLogin ??= false;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
        ),
      );
    } else {
      if (isLogin) {
        return Center(
          child: Text('登录'),
        );
      } else {
        return LoginPage();
      }
    }
  }
}
