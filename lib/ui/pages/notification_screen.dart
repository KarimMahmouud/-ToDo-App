// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payLoadb})
      : super(key: key);

  final String payLoadb;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String payLoad = '';

  @override
  void initState() {
    super.initState();
    payLoad = widget.payLoadb;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.dialogBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: context.theme.dialogBackgroundColor,
          title: Text(payLoad.toString().split('|')[0],
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : darkGreyClr)),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
                Text('Hello Karim',
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : darkGreyClr,
                        fontSize: 25,
                        fontWeight: FontWeight.w900)),
                const SizedBox(height: 10),
                Text('you have a new reminder',
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
                        fontSize: 18,
                        fontWeight: FontWeight.w300)),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: primaryClr),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(children: [
                            Icon(Icons.text_format,
                                size: 35, color: Colors.white),
                            SizedBox(width: 20),
                            Text(
                              'Title',
                              style: TextStyle(fontSize: 30, color: white),
                            )
                          ]),
                          const SizedBox(height: 20),
                          Text(payLoad.toString().split('|')[0],
                              style:
                                  const TextStyle(fontSize: 20, color: white)),
                          const SizedBox(height: 20),
                          const Row(children: [
                            Icon(Icons.description,
                                size: 35, color: Colors.white),
                            SizedBox(width: 20),
                            Text(
                              'Description',
                              style: TextStyle(fontSize: 30, color: white),
                            )
                          ]),
                          const SizedBox(height: 20),
                          Text(payLoad.toString().split('|')[1],
                              style:
                                  const TextStyle(fontSize: 20, color: white),
                              textAlign: TextAlign.justify),
                          const SizedBox(height: 20),
                          const Row(children: [
                            Icon(Icons.calendar_today_outlined,
                                size: 35, color: Colors.white),
                            SizedBox(width: 20),
                            Text(
                              'Date',
                              style: TextStyle(fontSize: 30, color: white),
                            )
                          ]),
                          const SizedBox(height: 20),
                          Text(payLoad.toString().split('|')[2],
                              style:
                                  const TextStyle(fontSize: 20, color: white),
                              textAlign: TextAlign.justify),
                          const SizedBox(height: 20),
                        ]),
                  )),
            ),
            const SizedBox(height: 10),
          ],
        )),
      ),
    );
  }
}
