// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import "package:flutter/material.dart";
import 'package:mapix/backend/firestoredatabase.dart';
import 'package:mapix/screens/ChooseeImage.dart';
import 'package:mapix/screens/dialog.dart';
import 'package:image_picker/image_picker.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  PageController controller = PageController();
  File? file1;
  File? file2;
  File? file3;
  File? file4;
  TextEditingController? nomcontroller = TextEditingController();
  TextEditingController? descriptioncontroller = TextEditingController();
  TextEditingController? latcontroller = TextEditingController();
  TextEditingController? longcontroller = TextEditingController();
  TextEditingController? prixContoller = TextEditingController();

  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          Container(
            child: Form(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                          top: 20, right: 10, left: 10, bottom: 10),
                      children: [
                        Text(
                          "Publiez votre residence gratuitement en quelques minutes",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(width: 30),
                          ],
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: nomcontroller,
                          decoration: InputDecoration(hintText: "nom"),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: descriptioncontroller,
                          decoration: InputDecoration(hintText: "description"),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: latcontroller,
                          decoration: InputDecoration(hintText: "Latitude"),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: longcontroller,
                          decoration: InputDecoration(hintText: "Longitude"),
                        ),
                        Row(
                          children: [
                            Container(
                              child: Center(
                                child: Text(
                                  "Prix : ",
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                child: TextFormField(
                                  controller: prixContoller,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Veuillez ajouter au moins une photo",
                  ),
                  Text(
                    "choissisez des photos explicites qui vous decrive",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      photoWidget1(),
                      SizedBox(width: 10),
                      photoWidget2(),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      photoWidget3(),
                      SizedBox(width: 10),
                      photoWidget4(),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (file1 == null &&
                          file2 == null &&
                          file3 == null &&
                          file4 == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Veuillez choisir au moins une image"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else {
                        setState(() {
                          load = true;
                        });

                        List<File> mesimages = [];
                        if (file1 != null) {
                          mesimages.add(file1!);
                        }
                        if (file2 != null) {
                          mesimages.add(file2!);
                        }
                        if (file3 != null) {
                          mesimages.add(file3!);
                        }
                        if (file4 != null) {
                          mesimages.add(file4!);
                        }

                        var urls = await ChooseImage.uploadFiles(mesimages);
                        print(urls);
                        FirestorDataBase().createResidence(
                          nomcontroller!.text,
                          descriptioncontroller!.text,
                          double.parse(latcontroller!.text),
                          double.parse(longcontroller!.text),
                          urls,
                          int.parse(prixContoller!.text),
                        );
                        setState(() {
                          load = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Posts effectué avec succes"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                    child: Text("Publier"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  photoWidget1() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            DialogGestion().dialogpicture(
              context,
              () async {
                File? res = await ChooseImage().getImage(ImageSource.camera);
                if (res != null) {
                  file1 = res;
                  Navigator.pop(context);
                }
                setState(() {});
              },
              () async {
                File? res = await ChooseImage().getImage(ImageSource.gallery);
                if (res != null) {
                  file1 = res;
                  Navigator.pop(context);
                }
                setState(() {});
              },
            );
          },
          child: Container(
            height: 110,
            width: 90,
            child: file1 == null
                ? Center(
                    child: Icon(
                      Icons.add,
                      size: 20,
                    ),
                  )
                : SizedBox(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              image: file1 != null
                  ? DecorationImage(
                      image: FileImage(file1!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
        ),
        if (file1 != null)
          Positioned(
            top: -5,
            right: -5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  file1 = null;
                });
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.clear,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          )
      ],
    );
  }

  photoWidget2() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            DialogGestion().dialogpicture(
              context,
              () async {
                File? res = await ChooseImage().getImage(ImageSource.camera);
                if (res != null) {
                  file2 = res;
                  Navigator.pop(context);
                }
                setState(() {});
              },
              () async {
                File? res = await ChooseImage().getImage(ImageSource.gallery);
                if (res != null) {
                  file2 = res;
                  Navigator.pop(context);
                }
                setState(() {});
              },
            );
          },
          child: Container(
            height: 110,
            width: 90,
            child: file2 == null
                ? Center(
                    child: Icon(
                      Icons.add,
                      size: 20,
                    ),
                  )
                : SizedBox(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                image: file2 != null
                    ? DecorationImage(
                        image: FileImage(file2!),
                        fit: BoxFit.cover,
                      )
                    : null),
          ),
        ),
        if (file2 != null)
          Positioned(
            top: -5,
            right: -5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  file2 = null;
                });
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.clear,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          )
      ],
    );
  }

  photoWidget3() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            DialogGestion().dialogpicture(
              context,
              () async {
                File? res = await ChooseImage().getImage(ImageSource.camera);
                if (res != null) {
                  file3 = res;
                  Navigator.pop(context);
                }
                setState(() {});
              },
              () async {
                File? res = await ChooseImage().getImage(ImageSource.gallery);
                if (res != null) {
                  file3 = res;
                  Navigator.pop(context);
                }
                setState(() {});
              },
            );
          },
          child: Container(
            height: 110,
            width: 90,
            child: file3 == null
                ? Center(
                    child: Icon(
                      Icons.add,
                      size: 20,
                    ),
                  )
                : SizedBox(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                image: file3 != null
                    ? DecorationImage(
                        image: FileImage(file3!),
                        fit: BoxFit.cover,
                      )
                    : null),
          ),
        ),
        if (file3 != null)
          Positioned(
            top: -5,
            right: -5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  file3 = null;
                });
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.clear,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          )
      ],
    );
  }

  photoWidget4() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            DialogGestion().dialogpicture(
              context,
              () async {
                File? res = await ChooseImage().getImage(ImageSource.camera);
                if (res != null) {
                  file4 = res;
                  Navigator.pop(context);
                }
                setState(() {});
              },
              () async {
                File? res = await ChooseImage().getImage(ImageSource.gallery);
                if (res != null) {
                  file4 = res;
                  Navigator.pop(context);
                }
                setState(() {});
              },
            );
          },
          child: Container(
            height: 110,
            width: 90,
            child: file4 == null
                ? Center(
                    child: Icon(
                      Icons.add,
                      size: 20,
                    ),
                  )
                : SizedBox(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                image: file4 != null
                    ? DecorationImage(
                        image: FileImage(file4!),
                        fit: BoxFit.cover,
                      )
                    : null),
          ),
        ),
        if (file4 != null)
          Positioned(
            top: -5,
            right: -5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  file4 = null;
                });
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.clear,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          )
      ],
    );
  }
}
