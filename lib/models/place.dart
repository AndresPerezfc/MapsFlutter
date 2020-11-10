import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart' show required;

class Place {
  final String title;
  final LatLng position;

  Place({@required this.title, @required this.position});

  static Place fromJson(Map<String, dynamic> json) {
    final coords = List<double>.from(json['position']);

    return Place(
      title: json['title'],
      position: LatLng(coords[0], coords[1]),
    );
  }
}
