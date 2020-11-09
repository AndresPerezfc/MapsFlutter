import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

class HomeState extends Equatable {
  final LatLng myLocation;
  final bool loading;
  final bool gpsEnable;

  final Map<MarkerId, Marker> markers;

  HomeState(
      {this.myLocation, this.loading = true, this.markers, this.gpsEnable});

  static HomeState get initialState => new HomeState(
      myLocation: null,
      loading: true,
      markers: Map(),
      gpsEnable: Platform.isIOS);

  HomeState copyWith(
      {LatLng myLocation,
      bool loading,
      Map<MarkerId, Marker> markers,
      bool gpsEnable}) {
    return HomeState(
        myLocation: myLocation ?? this.myLocation,
        loading: loading ?? this.loading,
        markers: markers ?? this.markers,
        gpsEnable: gpsEnable ?? this.gpsEnable);
  }

  @override
  List<Object> get props => [myLocation, loading, markers, gpsEnable];
}
