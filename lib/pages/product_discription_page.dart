import 'package:flutter/material.dart';
import 'package:footware_client/app_data/app_constant.dart';
import 'package:footware_client/controller/purchase_controller.dart';
import 'package:footware_client/model/product/product.dart';
import 'package:footware_client/model/user/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductDescriptionPage extends StatelessWidget {
  const ProductDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Product product = Get.arguments[AppConstant.intentKeyProductData];

    return GetBuilder<PurchaseController>(builder: (ctrl) {
      return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstant.titleProductDetails),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //top product image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.image ?? AppConstant.defaultValProductImageUrl,
                fit: BoxFit.contain,
                width: double.infinity,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //product name
            Text(
              product.name ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),

            //product Description
            Text(
              product.description ?? '',
              style: const TextStyle(
                  fontSize: 12, height: 1.5),
            ),
            const SizedBox(
              height: 15,
            ),

            //product price
            Text(
              '${AppConstant.symbolTextTaka}: ${product.price ?? '0.0'}',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(
              height: 20,
            ),

            TextField(
              controller: ctrl.orderAddressCtrl,
              decoration: InputDecoration(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: AppConstant.labelEnterBillAddress,
              ),
              maxLines: 4,
            ),
            const SizedBox(
              height: 20,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    backgroundColor: Colors.blue),
                onPressed: () {
                  GetStorage sharePrf = GetStorage();
                  Map<String,dynamic>? user = sharePrf.read(AppConstant.prefKeyLoginUserData);
                  User loginUser=User();
                  if(user!=null){
                    loginUser = User.fromJson(user);
                  }
                  //store order data to firebase db

                  ctrl.addOrder(context, user: loginUser, selectedProduct: product);

                },
                child: const Text(
                  AppConstant.buttonBuyNow,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            //
          ],
        ),
      ),
      );
    });
  }
}
