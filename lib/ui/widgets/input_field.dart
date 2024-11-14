import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/ui/theme.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  final String title, hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? white : Colors.black)),
        Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                autofocus: false,
                cursorColor:
                    Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                readOnly: widget != null ? true : false,
                style: TextStyle(
                  fontSize: 15,
                  color: Get.isDarkMode ? white : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                      fontSize: 15,
                      color: Get.isDarkMode ? white : Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: context.theme.dialogBackgroundColor,
                      width: 0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: context.theme.dialogBackgroundColor,
                      width: 0,
                    ),
                  ),
                ),
              ),
            ),
            widget ?? Container(),
          ]),
        ),
      ]),
    );
  }
}
