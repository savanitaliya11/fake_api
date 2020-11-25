import 'dart:convert';

import 'package:fake_api/model/fake_api.dart';
import 'package:fake_api/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_fake_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

SharedPreferences sharedPreferences;

class _HomePageState extends State<HomePage> {
  Future<FakeApi> getData() async {
    http.Response response =
        await http.get('https://reqres.in/api/users?page=2');
    if (response.statusCode == 200) {
      return FakeApi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<FakeApi> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var _user = snapshot.data.data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GetDetail(
                                  name: _user.firstName,
                                  image: _user.avatar,
                                  email: _user.email,
                                )));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_user.avatar),
                      backgroundColor: Colors.red,
                    ),
                    title: Text('${_user.firstName} ${_user.lastName}'),
                    subtitle: Text(_user.email),
                  ),
                );
              },
              itemCount: snapshot.data.data.length,
            );
          } else {
            return Container(
                color: Colors.black.withOpacity(0.54),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(child: CircularProgressIndicator()));
          }
        },
        future: getData(),
      ),
    );
  }
}
