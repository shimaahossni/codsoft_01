// ../../git_app/taskati-with-hive_third-task/lib/feature/profile/profile_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/core/services/app_local_storage.dart';
import 'package:todo/core/utils/color.dart';
import 'package:todo/core/utils/text_style.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/textfieldflorm_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileUploadState();
}

class _ProfileUploadState extends State<ProfileScreen> {
  String? path;
  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    var nameController = TextEditingController(
        text: AppLocalStorage.getCachedData(AppLocalStorage.nameKey));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
      ),
      backgroundColor: AppColor.whiteColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      context: context,
                      builder: (builder) {
                        return Padding(
                          padding: EdgeInsets.all(mediaquery.width * .05),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: mediaquery.width,
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
                                width: mediaquery.width,
                                child: CustomButton(
                                    text: "Upload from Gallery",
                                    onPressed: () async {
                                      await uploadImage(
                                        isCamera: false,
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: mediaquery.width * .18,
                      backgroundImage: FileImage(File(
                          AppLocalStorage.getCachedData(
                                  AppLocalStorage.imageKey) ??
                              "")),
                    ),
                    Positioned(
                      child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.whiteColor,
                          ),
                          child: Icon(Icons.camera_alt)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mediaquery.height * .02,
              ),
              Divider(
                color: AppColor.purpleColor,
                indent: mediaquery.width * .08,
                endIndent: mediaquery.width * .08,
              ),
              SizedBox(
                height: mediaquery.height * .05,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      context: context,
                      builder: (builder) {
                        return Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: mediaquery.height * .03,
                              start: mediaquery.width * .05,
                              end: mediaquery.width * .05,
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //////////////////////////////////////////////////////name textformfield
                              TextfieldflormWidget(
                                controller: nameController,
                                isobsecure: false,
                                onTap: () {},
                              ),
                              SizedBox(
                                height: mediaquery.height * .015,
                              ),
                              ///////////////////////////////////////////////////////button update name
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: mediaquery.height * .03),
                                child: SizedBox(
                                  width: mediaquery.width,
                                  child: CustomButton(
                                      text: "update name",
                                      onPressed: () {
                                        AppLocalStorage.cachedData(
                                            AppLocalStorage.nameKey,
                                            nameController.text);
                                        Navigator.pop(context);
                                        setState(() {});
                                      }),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: mediaquery.width * .08),
                  child: Row(
                    children: [
                      Text(
                        AppLocalStorage.getCachedData(AppLocalStorage.nameKey),
                        style: gettitleTextStyle(
                          fontsize: mediaquery.width * .05,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.edit),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  uploadImage({required bool isCamera}) async {
    await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery)
        .then((value) {
      if (value != null) {
        AppLocalStorage.cachedData(AppLocalStorage.imageKey, value.path);
        setState(() {});
        Navigator.of(context).pop();
      }
    });
  }
}
