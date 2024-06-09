import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footware_client/app_data/app_constant.dart';
import 'package:footware_client/pages/home_page.dart';
import 'package:footware_client/pages/login_page.dart';
import 'package:footware_client/pages/register_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

import '../model/user/user.dart';

class LoginController extends GetxController {
  GetStorage sharePrf = GetStorage();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  late CollectionReference userCollection;
  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerMobileNumberCtrl = TextEditingController();
  TextEditingController loginMobileNumberCtrl = TextEditingController();

  OtpFieldControllerV2 otpController = OtpFieldControllerV2();

  bool isOtpFieldShow = false;
  late int sendOtpValue;
  late int enteredOtp;

  User? loginUser;

  @override
  void onReady(){
    Map<String,dynamic>? user = sharePrf.read(AppConstant.prefKeyLoginUserData);
    if(user!=null){
      loginUser = User.fromJson(user);
      Get.offAll(const HomePage());
    }

    super.onReady();
  }

  @override
  void onInit() {
    userCollection = fireStore.collection(AppConstant.fireTableUsers);

    super.onInit();
  }


  void loginWithMobileNumber() async {
    String mobileNumber = loginMobileNumberCtrl.text;
    if(mobileNumber.isEmpty || mobileNumber.length!=11){
      Get.snackbar('Sorry', 'Wrong mobile number', colorText: Colors.blue);
      return;
    }

    var querySnapshot = await userCollection.where('mobile_number', isEqualTo: mobileNumber).limit(1).get();
    if(querySnapshot.docs.isEmpty){
      Get.snackbar('Sorry', 'Un authorized user', colorText: Colors.blue);
      return;
    }

    var userDoc = querySnapshot.docs.first;
    var userData = userDoc.data() as Map<String,dynamic>;
    if(userData.isNotEmpty){
      Fluttertoast.showToast(
          msg: AppConstant.messageLoginSuccess,
          // toastLength: Toast.LENGTH_SHORT,
          // gravity: ToastGravity.CENTER,
          // timeInSecForIosWeb: 1,
          // backgroundColor: Colors.grey,
          // textColor: Colors.black87,
          // fontSize: 16.0
      );

      //store user data in local memory
      sharePrf.write(AppConstant.prefKeyLoginUserData, userData);
      loginMobileNumberCtrl.clear();
      Get.to(const HomePage());
    }
  }

  void addUser() {
    try {
      if (!isUserInfoValid()) {
        return;
      }

      if (enteredOtp == sendOtpValue) {
        DocumentReference docFef = userCollection.doc();

        User user = User(
          id: docFef.id,
          name: registerNameCtrl.text,
          mobileNumber: registerMobileNumberCtrl.text,
        );

        final userJson = user.toJson();
        docFef.set(userJson);

        Get.snackbar('Success', 'User added successfully', colorText: Colors.green);

        clearAllFields();
        
        openLoginPage();
      } else {
        Get.snackbar('Sorry', 'Wrong OTP', colorText: Colors.blue);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  void sendOtp() {
    try {
      if (!isUserInfoValid()) {
        return;
      }

      final random = Random();
      int otp = 1000 + random.nextInt(9000);
      sendOtpValue = otp;
      print(otp);

      //Get.snackbar('Success', 'OTP send success', colorText: Colors.green);
      Get.snackbar('OTP', 'enter $otp OTP in box', colorText: Colors.blue);
      isOtpFieldShow = true;

    } on Exception catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally {
      update();
    }
  }

  bool isUserInfoValid() {
    if (registerNameCtrl.text.isEmpty ||
        registerMobileNumberCtrl.text.isEmpty) {
      Get.snackbar('Sorry', "Please enter value", colorText: Colors.blue);
      return false;
    } else {
      return true;
    }
  }

  void clearAllFields(){
    registerNameCtrl.clear();
    registerMobileNumberCtrl.clear();
    otpController.clear();
  }

  void openLoginPage() {
    Get.to(const LoginPage());
  }

  void openRegistrationPage() {
    Get.to(const RegisterPage());
  }

}
