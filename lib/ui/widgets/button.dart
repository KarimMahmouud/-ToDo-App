import 'package:flutter/material.dart';
import '../theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.lable,
    required this.onTap,
  }) : super(key: key);

  final String lable;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 58, 56, 174),
            ),
            width: 100,
            height: 45,
            child: Text(lable,
                style: const TextStyle(color: white),
                textAlign: TextAlign.center)),
      ),
    );
  }
}
