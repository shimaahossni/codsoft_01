// feature/upload/upload_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/core/functions/newNavigation.dart';
import 'package:todo/core/services/app_local_storage.dart';
import '../../core/functions/show_error.dart';
import '../../core/utils/color.dart';
import '../../core/utils/text_style.dart';
import '../../core/widgets/custom_button.dart';
import '../home/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  String name = '';

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ThemeMode.light == ThemeMode.light
            ? AppColor.whiteColor
            : AppColor.blackColor,
        appBar: AppBar(
          backgroundColor: ThemeMode.light == ThemeMode.light
              ? AppColor.whiteColor
              : AppColor.blackColor,
          actions: [
            TextButton(
                onPressed: () {
                  if (path == null && name.isEmpty) {
                    ShowErrorDialog(
                      context,
                      "Please upload image and enter your name",
                    );
                  } else if (path == null && name.isNotEmpty) {
                    ShowErrorDialog(context, "Please upload image");
                  } else if (path != null && name.isEmpty) {
                    ShowErrorDialog(context, "Please enter your name");
                  } else {
                    AppLocalStorage.cachedData(AppLocalStorage.nameKey, name);
                    AppLocalStorage.cachedData(AppLocalStorage.imageKey, path);
                    AppLocalStorage.cachedData(AppLocalStorage.isUpload, true);
                    pushWithReplacement(context, HomeScreen());
                  }
                },
                child: Text(
                  "Done",
                  style: gettitleTextStyle(
                      fontsize: 18, color: AppColor.purpleColor),
                )),
            SizedBox(
              width: mediaquery.width * .02,
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: mediaquery.width * .18,
                //child: Image.asset("assets/images/image.png"),
                backgroundImage: path != null
                    ? FileImage(File(path!))
                    : const AssetImage(
                        "assets/images/person.png",
                      ),
              ),
              SizedBox(
                height: mediaquery.height * .03,
              ),
              SizedBox(
                width: mediaquery.width * .8,
                 child: CustomButton(
                    text: "Upload from Camera",
                    onPressed: () async {
                      await uploadImage(
                        isCamera: true,
                      );
                    }),
              ),
              SizedBox(
                height: mediaquery.height * .015,
              ),
              SizedBox(
                width: mediaquery.width * .8,
                child: CustomButton(
                    text: "Upload from Gallery",
                    onPressed: () async {
                      await uploadImage(
                        isCamera: false,
                      );
                    }),
              ),
              SizedBox(
                height: mediaquery.height * .015,
              ),
              Divider(
                color: AppColor.purpleColor,
                indent: mediaquery.width * .08,
                endIndent: mediaquery.width * .08,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mediaquery.width * .07,
                      vertical: mediaquery.height * .02),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: "Enter your name",
                        labelStyle:
                            gettitleTextStyle(fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.purpleColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: AppColor.purpleColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: AppColor.purpleColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        errorStyle: TextStyle(
                          fontSize: mediaquery.height * 0.017,
                        )),
                  )),
            ],
          ),
        ));
  }

  uploadImage({required bool isCamera}) async {
    await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery)
        .then((value) {
      if (value != null) {
        setState(() {
          path = value.path;
        });
      }
    });
  }
}
