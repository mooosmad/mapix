// ignore_for_file: prefer_const_constructors

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:get/get.dart';
import 'package:mapix/models/residence.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';

class MyDetails extends StatefulWidget {
  final Residence? residence;
  const MyDetails({Key? key, required this.residence}) : super(key: key);

  @override
  _MyDetailsState createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  AnimationController? controller;
  Animation<Offset>? position;
  final now = DateTime.now();
  var select = DateTime.now();

  void _next() {
    setState(() {
      if (currentIndex < widget.residence!.images!.length - 1) {
        currentIndex++;
      } else {
        currentIndex = currentIndex;
      }
    });
  }

  void _preve() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onHorizontalDragEnd: (DragEndDetails details) {
                    if (details.velocity.pixelsPerSecond.dx > 0) {
                      _preve();
                    } else if (details.velocity.pixelsPerSecond.dx < 0) {
                      _next();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              widget.residence!.images![currentIndex]),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.grey[700]!.withOpacity(.9),
                            Colors.grey.withOpacity(.0),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 90,
                            margin: EdgeInsets.only(bottom: 60),
                            child: Row(
                              children: _buildIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // open san noto sans jp
                Expanded(
                  child: Transform.translate(
                    offset: const Offset(0, -40),
                    child: Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 30, right: 30, left: 30),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.residence!.nom!,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                widget.residence!.description!,
                                style: TextStyle(
                                  color: Colors.yellow[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.yellow[700],
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.yellow[700],
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.yellow[700],
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.yellow[700],
                                  ),
                                  Icon(
                                    Icons.star_half,
                                    size: 18,
                                    color: Colors.yellow[700],
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "(4.2/70 reviews)",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(),
                          Text(widget.residence!.description!),
                          Divider(),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  Stack(
                                    // overflow: Overflow.visible,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10),
                                          ),
                                        ),
                                        height: 400,
                                        child: Column(
                                          children: [
                                            DatePicker(
                                              DateTime.now(),
                                              initialSelectedDate:
                                                  DateTime.now(),
                                              selectionColor: Colors.black,
                                              selectedTextColor: Colors.white,
                                              onDateChange: (date) {
                                                // New date selected
                                                setState(() {
                                                  select = date;
                                                });
                                              },
                                            ),
                                            FloatingActionButton(
                                              onPressed: () {
                                                DateTime today = DateTime.now();
                                                print(today);
                                                print(
                                                  today.add(
                                                    Duration(days: 1),
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: -15,
                                        right: 10,
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            child: Icon(
                                              Icons.close,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.yellow[700],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    "RESERVER",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 15,
            left: 9,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: Container(
        height: 4,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isActive ? Colors.grey[800] : Colors.white),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.residence!.images!.length; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
