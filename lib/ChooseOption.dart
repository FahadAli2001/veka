import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veka/car/welcome/welcomeScreen.dart';
import 'package:veka/house/login/loginScreen.dart';
import 'package:veka/house/BUYING/home/homeScreen.dart';

import 'car/Dashboard/dashboardScreen.dart';

class ChooseOption extends StatefulWidget {
  const ChooseOption({Key? key}) : super(key: key);

  @override
  State<ChooseOption> createState() => _ChooseOptionState();
}

class _ChooseOptionState extends State<ChooseOption> {
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) {
      if (value.getInt("realStateUserId") != null) {
        Get.off(() => const homeScreen());
      } else if (value.getString("userId") != null) {
        Get.off(() => const DashboardScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                (sp.getString("username") != null)
                    ? Get.to(() => const DashboardScreen())
                    : Get.to(const welcomeScreen());
              },
              child: Center(
                child: Container(
                  width: Get.width * 0.5,
                  height: Get.height * 0.2,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      //color: Colors.green,
                      image: const DecorationImage(
                          image: AssetImage("assets/Veka-Green.png"),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: InkWell(
              onTap: () async {
                SharedPreferences homesp =
                    await SharedPreferences.getInstance();
                (homesp.getString("email") != null)
                    ? Get.to(const homeScreen())
                    : Get.to(loginSxreen());
              },
              child: Center(
                child: Container(
                  width: Get.width * 0.5,
                  height: Get.height * 0.2,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      //  color: Colors.red,
                      image: const DecorationImage(
                          image: AssetImage("assets/Veka-Red.png"),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
