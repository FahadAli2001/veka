import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../BUYING/home/homeScreen.dart';
class loginController extends GetxController{

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isHidepass = true.obs;

  var isremember = false.obs;
  void handleRadioValueChanged(val) {
    isremember.value = val;
  }
  var data;
  void SignIn()async{
    String _username = username.text.trim().toString();
    String _password = password.text.trim().toString();

    try {
      var response = await http.post(
          Uri.parse("https://vekarealestate.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {
            "username": _username,
            "password": _password
          }
      );

      if (response.statusCode == 200) {
        data = jsonDecode(response.body.toString());
        if(isremember.value == true){
          SharedPreferences homesignin =await SharedPreferences.getInstance();
          homesignin.setString("email", _username);
          print(homesignin.getString("email"));
          Get.to(homeScreen());
        }
        else{
          Get.to(homeScreen());
        }
      }else if(response.statusCode == 403){
        Map<String, dynamic> error = jsonDecode(response.body);
        String errorCode = error["code"];
        if (errorCode == "invalid_email") {
          Get.snackbar("Error", "The email is incorrect.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        } else if(errorCode == "incorrect_password") {
          Get.snackbar("Error", "Wrong password entered",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        }else if(errorCode == "incorrect_password" && errorCode == "invalid_email"){
          Get.snackbar("Error", "Wrong email and Password",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        }else{
          print(response.statusCode);
         /* Get.snackbar("Error", "Something Went Wrong",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);*/
        }
      }

      /* else if (response.statusCode == 403) {
        Get.snackbar("Error", "Incorrect password, please try again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.grey,
            colorText: Colors.black);
      }*/
    } catch (e) {
      Get.snackbar("Error", "Some error occurred, please try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black);
    }

    /*try{

      var response =await http.post(
          Uri.parse("https://vekarealestate.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {
            "username":_username,
            "password":_password
          }
      );

      if(response.statusCode==200){
       // print("method called");
        data = jsonDecode(response.body.toString());

        Get.to(homeScreen());
      }else if (response.statusCode == 403){
        var error = jsonDecode(response.body.toString());
        if(error['data']['code'] == "invalid_username"){
          Get.snackbar("Error","Incorrect Email",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        }
        print("invalid email");
      }
     /* else if(response.statusCode ==403){
        Get.snackbar("Error","Authentication failed, please login again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.grey,
            colorText: Colors.black);
      }*/


      //print(data["code"]);
    }catch(e){
      //print(e.toString()+"errorrrrrrrrrrrrrrrrrrrrrrrr");
      Get.snackbar(e.toString(),"SomeThing went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black);
    }*/
  }
}