
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:footware_client/app_data/app_constant.dart';
import 'package:footware_client/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold (
       body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //welcome text view
            const Text(
              AppConstant.titleWelcomeBack,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple
              ),
            ),
            const SizedBox(height: 20),

            //input mobile number
            TextField(
              controller: ctrl.loginMobileNumberCtrl,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                prefixIcon: const Icon(Icons.phone_android),
                labelText: AppConstant.labelMobileNumber,
                hintText: AppConstant.labelEnterYourMobileNumber,
              ),
            ),
            const SizedBox(height: 20),

            //login button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white),
              onPressed: () {
                ctrl.loginWithMobileNumber();
              },
              child: const Text(AppConstant.login),
            ),
            const SizedBox(height: 20),

            //reg text button
            TextButton(
              onPressed: () {
                ctrl.openRegistrationPage();
              },
              child: const Text(AppConstant.registrationNewAccount),
            ),

          ],
        ),
      ),
      );
    });
  }
}
