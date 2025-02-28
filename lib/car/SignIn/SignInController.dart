import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Dashboard/dashboardScreen.dart';

class SignInController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isHidepass = true.obs;

  var userId;
  var name;

  var isRem = false.obs;

  handleRadioValueChanged(val) {
    print(val);
    isRem.value = val;
    print(isRem.value);
  }

  Future SignIn() async {
    SharedPreferences sigin = await SharedPreferences.getInstance();
    String _email = username.text.trim().toString();
    String _password = password.text.trim().toString();

    try {
      var response = await http.post(
          Uri.parse(
              "https://vekaautomobile.technopreneurssoftware.com/wp-json/jwt-auth/v1/token"),
          body: {"username": _email, "password": _password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        name = data["data"]["nicename"];
        userId = data["data"]["id"];
        sigin.setString("name", name);
        sigin.setString("email", data["data"]["email"]);
        sigin.setString("userId", userId.toString());
        log('Welcome, $userId');
        if (isRem.value == true) {
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString("username", _email);
          sp.setString("password", _password);
          Get.off(DashboardScreen());
        } else {
          Get.off(DashboardScreen());
        }
      } else if (response.statusCode == 403) {
        Map<String, dynamic> error = jsonDecode(response.body);
        String errorCode = error["code"];
        if (errorCode == "invalid_email" && response.statusCode == 403) {
          Get.snackbar("Error", "The email is incorrect.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        } else if (errorCode == "incorrect_password") {
          Get.snackbar("Error", "Wrong password entered",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        } else if (errorCode == "incorrect_password" &&
            errorCode == "invalid_email") {
          Get.snackbar("Error", "Wrong Email and Password",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);
        } else {
          print(response.statusCode);
          /*Get.snackbar("Error", "Something Went Wrong",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey,
              colorText: Colors.black);*/
        }
      }
    } catch (e) {
      print(e.toString() + "error");
      Get.snackbar(e.toString(), "SomeThing went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black);
      rethrow;
    }
  }

  void forgetpassword() async {
    try {
      final Uri _url = Uri.parse(
          'https://vekaautomobile.technopreneurssoftware.com/my-account/lost-password');

      if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
        await launchUrl(_url);
        //print('Could not launch $_url');
      }
    } catch (e) {
      print("eroorr" + e.toString());
    }
  }

  /* void SignInWithFirebase()async{
    String _email = username.text.trim().toString();
    String _password = password.text.trim().toString();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password
      );

      userId = FirebaseAuth.instance.currentUser!.uid;
      GetUsername();


    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", "Something Went Wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.black);
    }
  }*/

  /* Map<String, dynamic>? _userData;

  var result;
   final FirebaseAuth _auth = FirebaseAuth.instance;
   signInWithFacebook() async {
     try {
       final LoginResult? loginResult = await FacebookAuth.instance.login();
       if (loginResult != null) {
         final AccessToken? accessToken = loginResult.accessToken;
         if (accessToken != null) {
           final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(accessToken.token);
           result =await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
           return result;
         } else {
           print('Facebook login failed: access token is null');
         }

       } else {
         print('Facebook login failed: login result is null');
       }
     } on FirebaseAuthException catch (e) {
       print(e);
     }*/

  /*if (loginResult != null) {
       try {
         final OAuthCredential facebookAuthCredential =
         FacebookAuthProvider.credential(loginResult.accessToken!.token);
         final UserCredential userCredential =
         await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
         // Authentication successful, do something with userCredential.user
         return userCredential;
       } on FirebaseAuthException catch (e) {
         print(e.toString()+ "firebase error");
         // Handle authentication error, e.g. invalid credential, network error, etc.
       } catch (e) {
         // Handle other errors
         print(e.toString() + "error");
       }
     } else {
       print("other error");
       // Handle case where loginResult is null, e.g. user cancelled the login dialog
     }*/

  /*try {

      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await _auth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      print( "error"+e.message!.toString()); // Displaying the error message
    }*/

}
 /* String userEmail = "";
  Future<UserCredential> LogInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile', 'user_birthday']
    );

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    final userData = await FacebookAuth.instance.getUserData();

  //  userEmail = userData['email'];

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }*/
