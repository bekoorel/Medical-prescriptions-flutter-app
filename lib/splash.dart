import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: AssetImage("assets/splash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(100, 300, 0, 0),
            child: Text(
              "BEKOOREL . CLINIC",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            )),
        Container(
            margin: EdgeInsets.fromLTRB(100, 355, 0, 0),
            child: Text(
              "        الحل الامثل لاداره مركزك الطبي",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 30,
              ),
            )),
        Container(
            margin: EdgeInsets.fromLTRB(470, 500, 0, 0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/sersh", (route) => false);
                },
                child: Text("Sign In"))),
      ],
    ));
  }
}
