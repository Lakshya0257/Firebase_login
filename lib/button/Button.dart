import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({Key? key,
    required this.on_pressed,
    required this.text,
    this.height,
    this.width
  }) : super(key: key);
  VoidCallback on_pressed;
  String text;
  double? width;
  double? height;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: on_pressed,
      child: Container(
          width: MediaQuery.of(context)
              .size
              .width *
              .6,
          height: MediaQuery.of(context)
              .size
              .width *
              .15,
          decoration: BoxDecoration(
              borderRadius:
              const BorderRadius.all(
                  Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.yellow,
                    Colors.orangeAccent.shade200
                  ])),
          child: Center(
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ))),
    );
  }
}
