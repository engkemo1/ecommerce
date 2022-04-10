import 'dart:io';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/view/widgets/custom_text.dart';
import 'package:ecommerce/view/widgets/custom_textFormField.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../constants.dart';
import '../core/viewmodel/home_viewmodel.dart';
import '../core/viewmodel/selectImage_viewmodel.dart';

class AddCategory extends StatelessWidget {
  File? imageFile;
  String? picUrl;

  @override
  Widget build(BuildContext context) {
    final _formKey2 = GlobalKey<FormState>();
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
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Add New Category",
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
          SizedBox(
            height: 150.h,
          ),
          Form(
              key: _formKey2,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: CustomTextFormField(
                        title: "Name",
                        hintText: "Category name",
                        validatorFn: (value) {
                          if (value!.isEmpty) return 'Please enter valid name.';
                        },
                        onSavedFn: (val) {
                          c.nameG = val;
                        }),
                  ),

                  RaisedButton(
                    color: d,
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

          Padding(padding: EdgeInsets.only(left: 80,right: 80),child:   RaisedButton(
            onPressed: () async {
              if (_formKey2.currentState!.validate()) {
                _formKey2.currentState!.save();
                String _fileName = basename(imageFile!.path);
                Reference _firebaseStorageRef = FirebaseStorage.instance
                    .ref()
                    .child('profilePics/$_fileName');
                UploadTask _uploadTask =
                _firebaseStorageRef.putFile(imageFile!);
                picUrl = await (await _uploadTask).ref.getDownloadURL();
                c.image = picUrl;

                Get.find<HomeViewModel>().addCategoryToFireStore();
              }
            },
            child: Text("Add"),color: d,
          ),)

        ],
      ),
    )));
  }
}
