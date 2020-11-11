import 'package:equatable/equatable.dart';
import 'package:google_maps/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

class HomeState extends Equatable {
  final LatLng myLocation;
  final bool loading;
  final bool gpsEnable;

  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;

  final Map<String, Place> history;

  final Place arrival;

  HomeState(
      {this.myLocation,
      this.loading = true,
      this.markers,
      this.gpsEnable,
      this.polylines,
      this.history,
      this.arrival});

  static HomeState get initialState => new HomeState(
      myLocation: null,
      loading: true,
      markers: Map(),
      gpsEnable: Platform.isIOS,
      polylines: Map(),
      history: Map());

  HomeState copyWith(
      {LatLng myLocation,
      bool loading,
      Map<MarkerId, Marker> markers,
      bool gpsEnable,
      Map<PolylineId, Polyline> polylines,
      Map<String, Place> history,
      Place arrival}) {
    return HomeState(
        myLocation: myLocation ?? this.myLocation,
        loading: loading ?? this.loading,
        markers: markers ?? this.markers,
        gpsEnable: gpsEnable ?? this.gpsEnable,
        polylines: polylines ?? this.polylines,
        history: history ?? this.history,
        arrival: arrival ?? this.arrival);
  }

  @override
  List<Object> get props =>
      [myLocation, loading, markers, gpsEnable, polylines, history, arrival];
}
