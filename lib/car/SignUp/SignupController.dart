import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SignIn/SignInController.dart';
import '../Token/AccessToken.dart';

class SignUpController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  AcessToken acessTokenclass = Get.put(AcessToken());
  SignInController sic = Get.put(SignInController());

  var name;
  var id;
  RxBool isHidepass = true.obs;
  var isHideconpass = true.obs;

  var accessToken;

  var Value = false.obs;
  handleRadioValueChanged(val) {
    Value.value = val;
    print(Value.value);
  }

  void checkIsAgree() {
    if (Value.value == false) {
      Get.defaultDialog(
          buttonColor: Colors.black,
          title: "",
          middleText: "Please agree with our terms and condition",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else {
      getAcessToken();

      Value.value = false;
    }
  }

  void SignUp(String accessToken) async {
    SharedPreferences signupshared = await SharedPreferences.getInstance();
    String _username = username.text.toString();
    String _email = email.text.toString();
    String _password = password.text.toString();
    String _conpassword = confirmpassword.text.toString();

    try {
      //getAcessToken();
      //print(accessToken);
      var response = await http.post(
          Uri.parse(
              "https://vekaautomobile.technopreneurssoftware.com/wp-json/wp/v2/users"),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
          body: {
            "username": _username,
            "email": _email,
            "password": _password
          });
      print("method called");
      if (response.statusCode == 201) {
        // SignUpWithFirebase();
        clearFileds();

        //  name = data["username"].toString();
        signupshared.setString("username", _username);
        signupshared.setString("email", _email);

        Get.snackbar("", "User Created Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.grey,
            colorText: Colors.black); //print(_email);
      } else {
        Map<String, dynamic> error = jsonDecode(response.body);
        String errorCode = error["code"];
        if (errorCode == "existing_user_login") {
          Get.snackbar("Error", "Sorry, that username already exists!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        } else if (errorCode == "existing_user_email") {
          Get.snackbar("Error", "Sorry, that email address is already used!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        } else if (errorCode == "jwt_auth_invalid_token") {
          print("invalid token");
        }
      }
    } catch (e) {
      print(e.toString() + "errorr");
      Get.snackbar("", "SomeThing went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black); //print(_email);
    }
  }

  Future getAcessToken() async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://vekaautomobile.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {
            "username": acessTokenclass.AutoMobileusername,
            "password": acessTokenclass.AutoMobilepassword
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        accessToken = data["data"]['token'];
        print(accessToken);
        SignUp(accessToken);
      }
    } catch (e) {
      print("access token" + e.toString());
    }
  }

  void clearFileds() {
    username.clear();
    email.clear();
    password.clear();
    confirmpassword.clear();
  }

  /*SignUpWithFirebase()async{
    String _email = email.text.toString();
    String _password = password.text.toString();

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      if(credential != null){
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        id = credential.user!.uid;
        users.doc(id).set({
          "name":name
        });

        clearFileds();
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("","SomeThing went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black);
    } catch (e) {
      print(e);
    }*/

}
