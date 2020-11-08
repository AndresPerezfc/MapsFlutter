import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps/utils/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _completer = Completer();

  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(11.2202012, -74.1827116), zoom: 15);

  @override
  void initState() {
    super.initState();
    this._init();
  }

  Future<GoogleMapController> get _mapController async {
    return await _completer.future;
  }

  _init() async {
    (await _mapController).setMapStyle(jsonEncode(mapaStyle));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          zoomControlsEnabled: false,
          compassEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
        ),
      ),
    );
  }
}
