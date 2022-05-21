// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mapix/models/residence.dart';
import 'package:mapix/theme/color.dart';
import 'package:mapix/widgets/favorite_box.dart';
import 'custom_image.dart';

class FeatureItem extends StatelessWidget {
  FeatureItem(
      {Key? key,
      required this.data,
      this.width = 280,
      this.height = 300,
      this.onTap,
      this.onTapFavorite})
      : super(key: key);
  final Residence data;
  final double width;
  final double height;
  final GestureTapCallback? onTapFavorite;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 5, top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(
              data.images![0],
              width: double.infinity,
              height: 190,
              radius: 15,
            ),
            Container(
              width: width - 20,
              padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.nom!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // data["type"],
                            "category",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: labelColor, fontSize: 13),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          RichText(
                            text: TextSpan(
                              text: data.prix!.toString() + " FCFA",
                              style: TextStyle(
                                color: primary,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: " / jours",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // FavoriteBox(
                      //   size: 16,
                      //   onTap: onTapFavorite,
                      //   isFavorited: data["is_favorited"],
                      // )
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
