import 'package:flutter/material.dart';

class Text_field extends StatelessWidget {
  Text_field({Key? key,
    required this.text_field
  }) : super(key: key);

  Widget text_field;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.width * .15,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
              Radius.circular(20)),
          border: Border.all(color: Colors.grey)),
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: text_field
      ),
    );
  }
}
