// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mapix/backend/firestoredatabase.dart';
import 'package:mapix/models/residence.dart';
import 'package:mapix/screens/detailsPage.dart';
import 'package:mapix/screens/detailsmy.dart';
import 'package:mapix/theme/color.dart';
import 'package:mapix/utils/data.dart';
import 'package:mapix/widgets/feature_item.dart';
import 'package:mapix/widgets/notification_box.dart';
import 'package:mapix/widgets/recommend_item.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Location location = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {});
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: getAppBar(),
          ),
          getProcheResidence(),
          getAllResidence(),
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

  getProcheResidence() {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                child: Text(
                  "reserver votre résidence dès maintenant",
                  style: TextStyle(
                    color: labelColor,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Text(
                  "Proche de vous",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
              ),
              getProche(),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommandé",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: textColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getProche() {
    return _locationData != null
        ? StreamBuilder(
            stream: FirestorDataBase(
                    latclient: _locationData!.latitude,
                    longclient: _locationData!.longitude)
                .getProcheResidence,
            builder: (context, AsyncSnapshot<List<Residence?>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  final res = snapshot.data;

                  return res!.isEmpty
                      ? Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(1, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Aucune residence à moins de 5km de chez vous",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              Lottie.asset(
                                "assets/lotties/61372-404-error-not-found.json",
                              ),
                            ],
                          ),
                        )
                      : CarouselSlider(
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            height: 300,
                            enlargeCenterPage: true,
                            disableCenter: true,
                            viewportFraction: .75,
                          ),
                          items: List.generate(
                            res.length,
                            (index) => FeatureItem(
                              data: res[index]!,
                              onTapFavorite: () {
                                setState(() {});
                              },
                              onTap: () {
                                Get.to(
                                  MyDetails(
                                    residence: res[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                } else {
                  return Text("No data");
                }
              }
            })
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  getAllResidence() {
    return StreamBuilder(
      stream: FirestorDataBase(latclient: 0, longclient: 0).getAllResidence,
      builder: ((context, AsyncSnapshot<List<Residence?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            final res = snapshot.data;
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: RecommendItem(
                      data: res![i]!,
                      onTap: () {
                        Get.to(MyDetails(
                          residence: res[i],
                        ));
                      },
                    ),
                  );
                },
                childCount: res!.length,
              ),
            );
          } else {
            return SliverToBoxAdapter(child: Text("No data"));
          }
        }
      }),
    );
  }
}
