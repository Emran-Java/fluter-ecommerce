import 'package:flutter/material.dart';
import 'package:footware_client/app_data/app_constant.dart';
import 'package:footware_client/controller/home_controller.dart';
import 'package:footware_client/pages/login_page.dart';
import 'package:footware_client/pages/product_discription_page.dart';
import 'package:footware_client/widgets/product_item.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/drop_down_btn.dart';
import '../widgets/multi_select_drop_down.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(AppConstant.titleFootWare),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  GetStorage sharePrf = GetStorage();
                  sharePrf.erase();
                  Get.offAll(const LoginPage());
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: Column(
            children: [
              //top horizontal category list
              SizedBox(
                height: 60,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.categoryList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ctrl.productFilterByCategory(
                              ctrl.categoryList[index].name ?? '');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.5),
                          child: Chip(
                              label: Text(ctrl.categoryList[index].name ?? '')),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),

              //for two dropdown button
              Row(
                children: [
                  Flexible(
                      child: MultiSelectDropDown(
                    items: const ['Sketchers', 'Adidas', 'Puma', 'Clarks'],
                    selectedItemText: 'Brands',
                    onSelectionChanged: (selectedItems) {
                      ctrl.productFilterByBrand(selectedItems);
                    },
                  )),
                  Flexible(
                      child: DropDownBtn(
                    items: ['Tk: low to high', 'Tk: high to low'],
                    selectedItemText: 'Short by price',
                    onSelected: (selectedValue) {
                      ctrl.productShortByPrice(isAscending:
                          selectedValue == 'Tk: high to low' ? false : true);
                    },
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              //product
              Expanded(
                child: GridView.builder(
                    itemCount: ctrl.productFilter.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemBuilder: (context, index) {
                      return ProductItem(
                        name: ctrl.productFilter[index].name ?? '',
                        imageUrl:
                        ctrl.productFilter[index].image ?? AppConstant.defaultValProductImageUrl,
                        price: ctrl.productFilter[index].price ?? '',
                        offerTag: '3${(index)} % off',
                        onItemTab: () {

                          Get.to(ProductDescriptionPage(),
                            arguments: {
                              AppConstant.intentKeyProductData:ctrl.productFilter[index]
                            }
                          );

                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDescriptionPage()));
                          */

                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
