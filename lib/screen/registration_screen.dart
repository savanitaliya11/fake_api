import 'dart:convert';

import 'package:fake_api/screen/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class Registartion extends StatefulWidget {
  @override
  _RegistartionState createState() => _RegistartionState();
}

class _RegistartionState extends State<Registartion>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AnimationController animationController;
  Animation animation, delayedanimation;
  bool isProgress = false;

  Future<Map> isDataIn(String email, String password) async {
    Map data = {"email": email, "password": password};
    http.Response response =
        await http.post('https://reqres.in/api/register', body: data);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return {
        "message": "Registration Succesfully",
        "token": data['token'],
        'isRegistration': true
      };
    } else {
      var data = jsonDecode(response.body);
      return {"message": data['error'], "token": " ", 'isRegistration': false};
    }
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(curve: Curves.bounceOut, parent: animationController));
    delayedanimation = Tween(begin: 0.8, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    animationController.forward();
    return AnimatedBuilder(
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text('Registration Page'),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height / 6,
                        child: Transform(
                          transform: Matrix4.translationValues(
                              animation.value * size.width, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Registration',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                'Page',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 55,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                        height: size.height / 3,
                        width: size.width,
                        child: Transform(
                          transform: Matrix4.translationValues(
                              delayedanimation.value * size.width, 0, 0),
                          child: Column(
                            children: [
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: "Username",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: size.width,
                                child: Builder(
                                  builder: (BuildContext context) =>
                                      RaisedButton(
                                    color: Colors.redAccent.shade200,
                                    elevation: 10,
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    onPressed: () async {
                                      setState(() {
                                        isProgress = true;
                                      });
                                      Map result = await isDataIn(
                                          emailController.text,
                                          passwordController.text);
                                      if (!result['isRegistration']) {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Registration Failed')))
                                            .closed
                                            .then((value) {
                                          setState(() {
                                            isProgress = false;
                                          });
                                        });
                                      } else {
                                        setState(() {
                                          isProgress = false;
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'Registration',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: size.width,
                                child: RaisedButton(
                                  color: Colors.redAccent.shade200,
                                  elevation: 10,
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              isProgress
                  ? Container(
                      color: Colors.black.withOpacity(0.54),
                      child: Center(
                        child: CupertinoActivityIndicator(
                          radius: 20,
                        ),
                      ),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    )
                  : SizedBox()
            ],
          ),
        );
      },
      animation: animation,
    );
  }
}
