// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mapix/models/residence.dart';
import 'package:mapix/theme/color.dart';
import 'custom_image.dart';

class RecommendItem extends StatelessWidget {
  RecommendItem({Key? key, required this.data, this.onTap}) : super(key: key);
  final Residence data;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 10, left: 10),
        padding: EdgeInsets.all(10),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            CustomImage(
              data.images![0],
              radius: 15,
              height: 80,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.nom!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Category",
                    style: TextStyle(fontSize: 12, color: labelColor),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14,
                        color: yellow,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: Text(
                          "4.5",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                      Text(
                        data.prix!.toString() + " FCFA",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
