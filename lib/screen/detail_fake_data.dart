import 'package:flutter/material.dart';

class GetDetail extends StatelessWidget {
  final String name;
  final String email;
  final String image;

  GetDetail({this.name, this.email, this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('User Detail'),
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: getClipper(),
            child: Container(
              color: Colors.redAccent.withOpacity(0.8),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 140),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    //backgroundColor: Colors.redAccent,
                    backgroundImage: NetworkImage(image),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    email,
                    style: TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          color: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {},
                          child: Text('Edit Name'),
                        ),
                        FlatButton(
                          color: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {},
                          child: Text('Logout'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class getClipper extends CustomClipper<Path> {
  @override
  // ignore: missing_return
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 2.45);
    path.lineTo(size.width + 125, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
