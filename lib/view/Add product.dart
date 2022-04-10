import 'dart:io';

import 'package:ecommerce/core/viewmodel/home_viewmodel.dart';
import 'package:ecommerce/core/viewmodel/selectImage_viewmodel.dart';
import 'package:ecommerce/view/widgets/custom_text.dart';
import 'package:ecommerce/view/widgets/custom_textFormField.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../constants.dart';

class AddProduct extends StatelessWidget {
  File? imageFile;
  String? picUrl;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var controller = Get.put(SelectImageViewModel());
    return Scaffold(
        body: SafeArea(
            child: GetBuilder<HomeViewModel>(
      builder: (c) => ListView(
        children: [
          Container(
            height: 100,
            child: Row(
              children: [
                SizedBox(width: 10,),
                IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){},),
                Text(
                  "Add New Product",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: p),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: CustomTextFormField(
                        title: "Name",
                        hintText: "product name",
                        validatorFn: (value) {
                          if (value!.isEmpty) return 'Please enter valid name.';
                        },
                        onSavedFn: (val) {
                          c.name = val;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: CustomTextFormField(
                        title: "Description",
                        hintText: "Description",
                        validatorFn: (value) {
                          if (value!.isEmpty)
                            return 'Please enter valid description.';
                        },
                        onSavedFn: (val) {
                          c.description = val;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: CustomTextFormField(
                        title: "Size",
                        hintText: "Size",
                        validatorFn: (value) {
                          if (value!.isEmpty) return 'Please enter valid size.';
                        },
                        onSavedFn: (val) {
                          c.size = val;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: CustomTextFormField(
                        title: "Price",
                        hintText: "Enter Price",
                        validatorFn: (value) {
                          if (value!.isEmpty)
                            return 'Please enter valid price.';
                        },
                        onSavedFn: (val) {
                          c.price = val;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: CustomTextFormField(
                        title: "Category",
                        hintText: "Enter Category",
                        validatorFn: (value) {
                          if (value!.isEmpty)
                            return 'Please enter valid Category.';
                        },
                        onSavedFn: (val) {
                          c.category = val;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: CustomTextFormField(
                        title: "ProductId",
                        hintText: "Enter ProductId",
                        validatorFn: (value) {
                          if (value!.isEmpty)
                            return 'Please enter valid ProductId.';
                        },
                        onSavedFn: (val) {
                          c.productId = val;
                        }),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          title: CustomText(
                            text: 'Choose option',
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Divider(
                                height: 1,
                              ),
                              ListTile(
                                onTap: () async {
                                  try {
                                    final _pickedFile =
                                        await ImagePicker().pickImage(
                                      source: ImageSource.camera,
                                      maxHeight: 400,
                                      maxWidth: 400,
                                    );
                                    imageFile = File(_pickedFile!.path);
                                    Get.back();
                                  } catch (error) {
                                    Get.back();
                                  }
                                },
                                title: CustomText(
                                  text: 'Camera',
                                ),
                                leading: Icon(
                                  Icons.camera,
                                  color: Colors.blue,
                                ),
                              ),
                              Divider(
                                height: 1,
                              ),
                              ListTile(
                                onTap: () async {
                                  try {
                                    final _pickedFile =
                                        await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                      maxHeight: 400,
                                      maxWidth: 400,
                                    );
                                    imageFile = File(_pickedFile!.path);

                                    Get.back();
                                  } catch (error) {
                                    Get.back();
                                  }
                                  String _fileName = basename(imageFile!.path);

                                  c.image = _fileName;
                                },
                                title: CustomText(
                                  text: 'Gallery',
                                ),
                                leading: Icon(
                                  Icons.account_box,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Text('Select Image'),
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                String _fileName = basename(imageFile!.path);
                Reference _firebaseStorageRef = FirebaseStorage.instance
                    .ref()
                    .child('profilePics/$_fileName');
                UploadTask _uploadTask =
                    _firebaseStorageRef.putFile(imageFile!);
                picUrl = await (await _uploadTask).ref.getDownloadURL();
                c.image = picUrl;

                Get.find<HomeViewModel>().addProductToFireStore();
              }
            },
            child: Text("ok"),
          )
        ],
      ),
    )));
  }
}
