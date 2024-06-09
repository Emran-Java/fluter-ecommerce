import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footware_client/app_data/app_constant.dart';
import 'package:footware_client/model/category/product_category.dart';
import 'package:footware_client/model/product/product.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference productCollection;
  List<Product> products = [];
  List<Product> productFilter = [];

  late CollectionReference categoryCollection;
  List<ProductCategory> categoryList = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection(AppConstant.fireTableProducts);
    categoryCollection = firestore.collection(AppConstant.fireTableCategory);

    await fetchProducts();
    await fetchCategory();

    super.onInit();
  }

  void productShortByPrice({required bool isAscending}){

    List<Product> shortedProduct = List<Product>.from(productFilter);

    shortedProduct.sort((a,b) => isAscending ? double.parse(a.price ?? '0.0').compareTo(double.parse(b.price ?? '0.0')) :  double.parse(b.price ?? '0.0').compareTo(double.parse(a.price ?? '0.0')));
    productFilter = shortedProduct;
    update();
  }


  void productFilterByBrand(List<String?> brandNames){
    print(brandNames);
    productFilter.clear();
    if(brandNames.isEmpty){
      productFilter.assignAll(products);
    }else{
      //List<String?> lowerCaseBrands = brandNames.map((brand) => brand?.toLowerCase()).toList();
      productFilter = products.where((product) => brandNames.contains(product.brand)).toList();
    }
    update();
  }

  void productFilterByCategory(String categoryName){
    productFilter.clear();
    if(categoryName!='All'){
      productFilter = products.where((product) => product.category == categoryName).toList();
    }
    else{
      productFilter.assignAll(products);
    }
    update();
  }

  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();

      final List<ProductCategory> retrievedProducts = categorySnapshot.docs
          .map((doc) => ProductCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      categoryList.clear();
      categoryList.add(ProductCategory(name: 'All', id: '0'));
      categoryList.addAll(retrievedProducts);
     // Get.snackbar("Info", "Total number of data ${categoryList.length}", colorText: Colors.indigoAccent);
    } catch (e) {
      Get.snackbar("Error", e.toString(), colorText: Colors.red);
    }
    finally{
      update();
    }
  }
  
  fetchProducts() async {
    try {
      QuerySnapshot productsSnapshot = await productCollection.get();

      final List<Product> retrievedProducts = productsSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      products.clear();
      products.assignAll(retrievedProducts);
      productFilter.clear();
      productFilter.assignAll(retrievedProducts);

      //Get.snackbar("Info", "Total number of data ${products.length}", colorText: Colors.indigoAccent);
    } catch (e) {
      Get.snackbar("Error", e.toString(), colorText: Colors.red);
    }
    finally{
      update();
    }
  }

}