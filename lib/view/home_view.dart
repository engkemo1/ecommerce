import 'dart:math';

import 'package:ecommerce/core/viewmodel/profile_viewmodel.dart';
import 'package:ecommerce/view/Add%20product.dart';
import 'package:ecommerce/view/AddCategories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Service/theme_services.dart';
import '../core/viewmodel/checkout_viewmodel.dart';
import '../core/viewmodel/home_viewmodel.dart';
import 'category_products_view.dart';
import 'product_detail_view.dart';
import 'search_view.dart';
import 'widgets/custom_text.dart';
import '../../constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutViewModel());

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //Background of Drawer
            Container(
              decoration: BoxDecoration(color: d),
            ),
            //Navigation Menu
            SafeArea(
              child: Container(
                width: 200.0,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DrawerHeader(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage:
                                AssetImage("assets/images/profile_pic.png"),
                          ),
                          Text(
                            "kamal magdy",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Get.put(ProfileViewModel()).currentUser?.email ==
                                  "kemoeng40@gmail.com"
                              ? ListTile(
                                  leading: Icon(
                                    Icons.category,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Add Category",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  onTap: () {
                                    Get.to(() => AddCategory(),
                                        transition: Transition.downToUp,
                                        duration: Duration(milliseconds: 500));
                                  },
                                )
                              : Container(),
                          Get.put(ProfileViewModel()).currentUser?.email ==
                                  "kemoeng40@gmail.com"
                              ? ListTile(
                                  leading: Icon(
                                    Icons.add_circle,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Add Product",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  onTap: () {
                                    Get.to(() => AddProduct(),
                                        transition: Transition.downToUp,
                                        duration: Duration(milliseconds: 500));
                                  },
                                )
                              : Container(),
                          ListTile(
                            leading: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.black,
                            ),
                            title: Text(
                              "Cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.brightness_4,
                              color: Colors.black,
                            ),
                            title: Text(
                              "Theme",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            onTap: () {
                              ThemeServices().switchTheme();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main Screen
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: Duration(milliseconds: 500),
              builder: (_, double val, __) {
                return (
                    //Transform Widget
                    Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..setEntry(0, 3, 200 * val)
                          ..rotateY((pi / 6) * val),
                        child: Scaffold(
                          backgroundColor: CupertinoColors.white,
                          body: GetBuilder<HomeViewModel>(
                            init: Get.find<HomeViewModel>(),
                            builder: (controller) => controller.loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20)),
                                              color: d),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 10,),

                                              Text(
                                                "What do you want to \n buyToday",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              SizedBox(width: 30,),
                                              Image.asset(
                                                "assets/sale.png",
                                                width: 100,
                                                height: 100,
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 30, right: 30, top: 30),
                                          height: 49.h,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(45.r),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              prefixIcon: Icon(
                                                Icons.search,
                                                color: Colors.black,
                                              ),
                                            ),
                                            onFieldSubmitted: (value) {
                                              Get.to(SearchView(value));
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 44.h,
                                        ),
                                        CustomText(
                                          text: 'Categories',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          height: 19.h,
                                        ),
                                        ListViewCategories(),
                                        SizedBox(
                                          height: 50.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: 'Best Selling',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(CategoryProductsView(
                                                  categoryName: 'Best Selling',
                                                  products: controller.products,
                                                ));
                                              },
                                              child: CustomText(
                                                text: 'See all',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        ListViewProducts(),
                                      ],
                                    ),
                                  ),
                          ),
                        )));
              },
            ),
            GestureDetector(
              onHorizontalDragUpdate: (e) {
                if (e.delta.dx > 0) {
                  setState(() {
                    value = 1;
                  });
                } else
                  setState(() {
                    value = 0;
                  });
              },
            ),
            // Gesture Detector to Open the Drawer.
          ],
        ),
      ),
    );
  }
}

class ListViewCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 150.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(CategoryProductsView(
                  categoryName: controller.categories[index].name,
                  products: controller.products
                      .where((product) =>
                          product.category ==
                          controller.categories[index].name.toLowerCase())
                      .toList(),
                ));
              },
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(offset: Offset(1, 3), blurRadius: 3)
                          ]),
                      height: 80.h,
                      width: 80.w,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(controller.categories[index].image),
                      )),
                  CustomText(
                    text: controller.categories[index].name,
                    fontSize: 15,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 20.w,
            );
          },
        ),
      ),
    );
  }
}

class ListViewProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 320.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(
                  ProductDetailView(controller.products[index]),
                );
              },
              child: Container(
                width: 164.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: Colors.white,
                      ),
                      height: 240.h,
                      width: 164.w,
                      child: Image.network(
                        controller.products[index].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    CustomText(
                      text: controller.products[index].name,
                      fontSize: 16,
                    ),
                    CustomText(
                      text: controller.products[index].description,
                      fontSize: 12,
                      color: Colors.grey,
                      maxLines: 1,
                    ),
                    CustomText(
                      text: '\$${controller.products[index].price}',
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 15.w,
            );
          },
        ),
      ),
    );
  }
}
