import 'package:dio/dio.dart';
import 'package:google_maps/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchApi {
  SearchApi._internal();
  static SearchApi get instance => SearchApi._internal();

  final Dio _dio = Dio();

  Future<List<Place>> searchPlace(String query, LatLng at) async {
    final response = await this._dio.get(
        'https://places.ls.hereapi.com/places/v1/autosuggest',
        queryParameters: {
          "q": query,
          "apiKey": "ywy_99ZCC0TbZvZuokGEuW3s6TOfXHn_gFy-qGbXZ6c",
          "at": "${at.latitude},${at.longitude}",
        });

    final List<Place> places = (response.data['results'] as List)
        .where((element) => element['position'] != null)
        .map((item) => Place.fromJson(item))
        .toList();
    print(response.data['results']);
    return places;
  }
}
