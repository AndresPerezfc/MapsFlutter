import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

class HomeState extends Equatable {
  final LatLng myLocation;
  final bool loading;
  final bool gpsEnable;

  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;

  HomeState(
      {this.myLocation,
      this.loading = true,
      this.markers,
      this.gpsEnable,
      this.polylines});

  static HomeState get initialState => new HomeState(
      myLocation: null,
      loading: true,
      markers: Map(),
      gpsEnable: Platform.isIOS,
      polylines: Map());

  HomeState copyWith(
      {LatLng myLocation,
      bool loading,
      Map<MarkerId, Marker> markers,
      bool gpsEnable,
      Map<PolylineId, Polyline> polylines}) {
    return HomeState(
        myLocation: myLocation ?? this.myLocation,
        loading: loading ?? this.loading,
        markers: markers ?? this.markers,
        gpsEnable: gpsEnable ?? this.gpsEnable,
        polylines: polylines ?? this.polylines);
  }

  @override
  List<Object> get props =>
      [myLocation, loading, markers, gpsEnable, polylines];
}
