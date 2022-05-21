// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapix/models/residence.dart';
import 'package:mapix/theme/color.dart';
import 'package:mapix/widgets/notification_box.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailPage extends StatefulWidget {
  final Residence? residence;
  const DetailPage({Key? key, required this.residence}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appBarColor,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
            ),
            pinned: true,
            snap: true,
            floating: true,
            title: getAppBar(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 0, right: 10, left: 10),
              child: Column(
                children: [
                  elementinAppBar(),
                  SizedBox(height: 30),
                  Divider(),
                  Text(
                    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search ",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getAppBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.place_outlined,
                    color: labelColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Abidjan",
                    style: TextStyle(
                      color: darker,
                      fontSize: 13,
                    ),
                  ),
                ],
              )
            ],
          ),
          Spacer(),
          NotificationBox(
            notifiedNumber: 0,
            onTap: () {},
          )
        ],
      ),
    );
  }

  elementinAppBar() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .62,
          // margin: EdgeInsets.only(top: 0, right: 10, left: 10),
          child: PageView(
            children: [
              for (var i = 0; i < widget.residence!.images!.length; i++)
                Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white54,
                    image: DecorationImage(
                      image: NetworkImage(widget.residence!.images![i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          bottom: 30,
          left: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Petite description",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.residence!.nom!.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 5,
          right: 20,
          child: Container(
            width: 50,
            height: 50,
            child: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
