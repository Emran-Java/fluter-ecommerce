import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footware_client/app_data/app_constant.dart';
import 'package:footware_client/model/order/product_order.dart';
import 'package:footware_client/model/product/product.dart';
import 'package:footware_client/model/user/user.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  late CollectionReference orderCollection;

  TextEditingController orderAddressCtrl = TextEditingController();

  @override
  void onInit() {
    orderCollection = fireStore.collection(AppConstant.fireTableOrder);
    super.onInit();
  }


  addOrder(BuildContext context, {User? user, Product? selectedProduct}) {
    try {
      DateTime now = DateTime.now();
      String insertDateTime = '${now.hour}:${now.minute}:${now.second}_${now.day}-${now.month}-${now.year}';
      insertDateTime = '${now.year}-${now.month}-${now.day}_${now.hour}:${now.minute}:${now.second}';

      print(insertDateTime);

      DocumentReference docFef = orderCollection.doc();
      ProductOrder productOrder = ProductOrder(
        id: docFef.id,
        address: orderAddressCtrl.text,
        customer: user?.name ?? '',
        dateTime:insertDateTime,
        item: selectedProduct?.name ?? '',
        price: selectedProduct?.price ?? '0.0',
        phone: user?.mobileNumber ?? '',
        transactionId: '${user?.id}#${selectedProduct?.id}',
        userId: user?.id,
        productId: selectedProduct?.id,
      );

      final productOrderJson = productOrder.toJson();
      docFef.set(productOrderJson);
      Get.snackbar('Success', 'Order success', colorText: Colors.green);
      Navigator.pop(context);

    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }
}