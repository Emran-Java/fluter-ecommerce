import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:footware_client/app_data/app_constant.dart';
import 'package:footware_client/controller/login_controller.dart';
import 'package:footware_client/widgets/otp_text_field.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          //width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //top title text
              const Text(
                AppConstant.titleCreateYourAccount,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              const SizedBox(height: 20),

              //input field for name
              TextField(
                controller: ctrl.registerNameCtrl,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.account_box_outlined),
                  labelText: AppConstant.yourName,
                  hintText: AppConstant.enterYourName,
                ),
              ),
              const SizedBox(height: 20),

              //input mobile number
              TextField(
                controller: ctrl.registerMobileNumberCtrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.phone_android),
                  labelText: AppConstant.labelMobileNumber,
                  hintText: AppConstant.labelEnterYourMobileNumber,
                ),
              ),
              const SizedBox(height: 30),

              OtpTextField(otpController: ctrl.otpController, isVisible: ctrl.isOtpFieldShow,
                onCompleteOtp: (otp) {
                  ctrl.enteredOtp = int.tryParse(otp ?? '0000') ?? 0;
                },
              ),
              const SizedBox(height: 30),

              //send otp button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white),
                onPressed: () {
                  if(ctrl.isOtpFieldShow){
                    ctrl.addUser();
                  }else{
                    ctrl.sendOtp();
                  }
                },
                child: Text(ctrl.isOtpFieldShow ? AppConstant.register :AppConstant.sendOtp),
              ),
              const SizedBox(height: 0),

              //login text button
              TextButton(
                onPressed: () {
                  ctrl.openLoginPage();
                },
                child: const Text(AppConstant.login),
              ),
            ],
          ),
        ),
      );
    });
  }
}
