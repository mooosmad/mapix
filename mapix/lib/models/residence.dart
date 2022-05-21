class Residence {
  String? uid;
  String? nom;
  String? description;
  double? lat;
  double? long;
  int? prix;
  List<dynamic>? images;
  Residence(
      {this.images,
      this.lat,
      this.long,
      this.nom,
      this.prix,
      this.uid,
      this.description});
}
