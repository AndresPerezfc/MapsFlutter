import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps/blocs/pages/home/bloc.dart';
import 'package:google_maps/utils/extras.dart';
import 'package:google_maps/utils/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart';
import 'home_events.dart';
import 'home_state.dart';
import 'dart:io' show Platform;

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  Geolocator _geolocator = Geolocator();
  final LocationPermissions _locationPermissions = LocationPermissions();
  final Completer<GoogleMapController> _completer = Completer();
  final LocationOptions _locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  StreamSubscription<Position> _subscription;
  StreamSubscription<ServiceStatus> _subscriptionGpsStatus;

  Future<GoogleMapController> get _mapController async {
    return await _completer.future;
  }

  HomeBloc(HomeState initialState) : super(initialState) {
    this._init();
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
    _subscriptionGpsStatus?.cancel();
    super.close();
  }

  _init() async {
    _subscription = _geolocator
        .getPositionStream(_locationOptions)
        .listen((Position position) {
      if (position != null) {
        add(OnMyLocationUpdate(LatLng(position.latitude, position.longitude)));
      }
    });

    if (Platform.isAndroid) {
      //final bool enabled = await _geolocator.isLocationServiceEnabled();

      _subscriptionGpsStatus =
          _locationPermissions.serviceStatus.listen((status) {
        add(onGpsEnable(status == ServiceStatus.enabled));
      });
    }
  }

  void setMapController(GoogleMapController controller) {
    if (!_completer.isCompleted) {
      _completer.complete(controller);
      controller.setMapStyle(jsonEncode(mapaStyle));
    }
  }

  HomeState get initialState => HomeState.initialState;

  @override
  Stream<HomeState> mapEventToState(HomeEvents event) async* {
    if (event is OnMyLocationUpdate) {
      yield this.state.copyWith(loading: false, myLocation: event.location);
    } else if (event is onGpsEnable) {
      yield this.state.copyWith(gpsEnable: event.enabled);
    } else if (event is OnMapTap) {
      yield* this._mapOnMapTap(event);
    }
  }

  Stream<HomeState> _mapOnMapTap(OnMapTap event) async* {
    final markerId = MarkerId(this.state.markers.length.toString());
    final info = InfoWindow(
      title: "Hola Marcador ${markerId.value}",
      snippet: "La dirección es buena",
    );

    final Uint8List bytes =
        await loadAsset('assets/car-pin.png', width: 50, height: 95);

    //final Uint8List bytes = await loadimageFromNetwork(
    //  'https://cdn.iconscout.com/icon/free/png-256/google-470-675827.png',
    //width: 50,
    //height: 95);
    final customIcon = BitmapDescriptor.fromBytes(bytes);

    final marker = Marker(
        markerId: markerId,
        position: event.location,
        icon: customIcon,
        onTap: () {
          print("## MARCADOR  ${markerId.value} ##");
        },
        draggable: true,
        onDragEnd: (newPosition) {
          print(
              "## MARCADOR Nueva Posicion  ${markerId.value} ##  $newPosition");
        },
        infoWindow: info);

    final markers = Map<MarkerId, Marker>.from(this.state.markers);
    markers[markerId] = marker;
    yield this.state.copyWith(markers: markers);
  }
}
