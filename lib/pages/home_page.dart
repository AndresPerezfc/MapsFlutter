import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/utils/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../blocs/pages/home/bloc.dart';

class HomePage extends StatefulWidget {
  static const routeName = "HomePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = HomeBloc(HomeState.initialState);

  @override
  void initState() {
    super.initState();

    print("Holas");
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        body: SafeArea(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (_, state) {
                  if (!state.gpsEnable) {
                    return Center(
                        child: Text(
                      "Para utilizar la app activa el GPS :)",
                      textAlign: TextAlign.center,
                    ));
                  }

                  if (state.loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  final CameraPosition initialPosition =
                      CameraPosition(target: state.myLocation, zoom: 17);

                  return Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: initialPosition,
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        onTap: (LatLng position) {
                          print(":):) $position");
                          this._bloc.add(OnMapTap(position));
                        },
                        markers: state.markers.values.toSet(),
                        polylines: state.polylines.values.toSet(),
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          this._bloc.setMapController(controller);
                        },
                      ),
                      Positioned(
                          bottom: 15,
                          right: 15,
                          child: FloatingActionButton(
                            onPressed: () {
                              _bloc.goToMyPosition();
                            },
                            child: Icon(Icons.gps_fixed),
                          ))
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
