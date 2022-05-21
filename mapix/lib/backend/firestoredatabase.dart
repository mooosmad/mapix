import "dart:math" as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mapix/models/residence.dart';

class FirestorDataBase {
  double? latclient;
  double? longclient;
  FirestorDataBase({this.latclient, this.longclient});
  int getDistanceinMetre(
      {required double? lat1,
      required double? lon1,
      required double? lat2,
      required double? lon2}) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        math.cos((lat2! - lat1!) * p) / 2 +
        math.cos(lat1 * p) *
            math.cos(lat2 * p) *
            (1 - math.cos((lon2! - lon1!) * p)) /
            2;
    var res = 12742 *
        math.asin(
          math.sqrt(a),
        );

    return (res * 1000).ceil();
  }

  var residenceCollection = FirebaseFirestore.instance.collection("residences");

  createResidence(String nom, String description, double latitude,
      double longitude, List<dynamic> images, int prix) {
    String id = residenceCollection.doc().id;
    residenceCollection.doc(id).set({
      "uid": id,
      "nom": nom,
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
      "images": images,
      "prix": prix,
    });
  }
  // 5.357570166931127, -4.100881617516845

  List<Residence?> residencesfilter(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs
        .map((doc) {
          double latitudeResi = doc.data()["latitude"];
          double longitudeResi = doc.data()["longitude"];
          int distance = getDistanceinMetre(
              lat1: latclient,
              lon1: longclient,
              lat2: latitudeResi,
              lon2: longitudeResi);
          print(distance);

          if (distance <= 5000) {
            return Residence(
              lat: doc.data()["latitude"],
              long: doc.data()["longitude"],
              uid: doc.data()["uid"],
              images: doc.data()["images"],
              nom: doc.data()["nom"],
              prix: doc.data()["prix"],
              description: doc.data()["description"],
            );
          }
        })
        .toList()
        .whereType<Residence>()
        .toList();
  }

  List<Residence?> residences(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return Residence(
        lat: doc.data()["latitude"],
        long: doc.data()["longitude"],
        uid: doc.data()["uid"],
        images: doc.data()["images"],
        nom: doc.data()["nom"],
        prix: doc.data()["prix"],
        description: doc.data()["description"],
      );
    }).toList();
  }

  Stream<List<Residence?>> get getProcheResidence {
    return residenceCollection.snapshots().map(residencesfilter);
  }

  Stream<List<Residence?>> get getAllResidence {
    return residenceCollection.snapshots().map(residences);
  }
}
