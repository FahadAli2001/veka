import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../home/homeScreen.dart';

class meetingSuccessScreen extends StatefulWidget {
  meetingSuccessScreen({Key? key}) : super(key: key);

  @override
  State<meetingSuccessScreen> createState() => _meetingSuccessScreenState();
}

class _meetingSuccessScreenState extends State<meetingSuccessScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4), () => Get.offAll(const homeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.red,
            ),
            Text("Your meeting is successfully sheduled")
          ],
        ),
      ),
    );
  }
}
