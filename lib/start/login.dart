import 'package:flutter/material.dart';
import 'package:flutter_app/sourcedata/start.dart';


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }

}

class LoginState extends State<LoginPage> {
  bool isEnable = true;
  String phone;
  var code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 15),
            child: Image.asset('assets/images/my_set_logo.png'),
          ),
          Text('一米阅读老师'),
          Row(
            children: <Widget>[
              Text('+86',),
              Expanded(
                  child: TextField(
                    decoration: InputDecoration(
//                      labelText: 'Hello',
                      hintText: '请输入手机号码',
//                      helperText: '我是helptext',
                    ),
                    onChanged: (String s) {
                      phone = s;
                    },

                    onSubmitted: (String s) {

                    },
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                  )
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '输入验证码',
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                ),
              ),

              Listener(
                child: Container(
                  padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                  decoration: BoxDecoration(color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text('获取验证码', style: TextStyle(
                      color: isEnable ? Colors.white : Colors.grey),),
                ),

                onPointerUp: (pointerUpEvent) {
                  setState(() {
                    isEnable = false;
                  });
                  StartDataSource.getCode({"mobile": phone})
                      .then((onValue) {
                    print(onValue.toString()+"----------------");
                  }, onError: () {

                  });
                },
              ),
            ],
          ),

          Listener(
            child: Container(
              padding: EdgeInsets.fromLTRB(50, 8, 50, 8),
              decoration: BoxDecoration(color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                  '登录', style: TextStyle(color: Colors.white, fontSize: 18)),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            onPointerDown: (PointerDownEvent event) {
              login();
            },
          ),

        ],
      ),
    );
  }

  void login() {
    var map = {"mobile": phone,};
    StartDataSource.loginByAuthCode(map);
  }

}