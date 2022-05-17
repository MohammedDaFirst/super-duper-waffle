import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/fatButton.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = '/';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    controller =
        new AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = ColorTween(
      begin: Colors.white60,
      end: Colors.white,
    ).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black54,
                    fontFamily: 'Bobbers',
                  ),
                  child: AnimatedTextKit(animatedTexts: [
                    TypewriterAnimatedText('Flash Chat'),
                  ]),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            FatButton(
                text: 'Log In',
                color: Colors.lightBlueAccent,
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            FatButton(
                text: 'Register',
                color: Colors.blueAccent,
                onTap: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
