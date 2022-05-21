// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class DialogGestion {
  dialogpicture(BuildContext context, void Function()? firstfunction,
      void Function()? secondfunction) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Veuillez choisir svp",
                ),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: firstfunction,
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Icon(Icons.camera),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: secondfunction,
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Center(child: Icon(Icons.image)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
