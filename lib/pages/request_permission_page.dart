import 'package:flutter/material.dart';
import 'package:google_maps/pages/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionPage extends StatefulWidget {
  static const routeName = 'requestPermission';
  @override
  _RequestPermissionPageState createState() => _RequestPermissionPageState();
}

class _RequestPermissionPageState extends State<RequestPermissionPage>
    with WidgetsBindingObserver {
  bool _fromSettings = false;
  //saber si tiene los permisos desde el codigo dart
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState:::::::::: $state");
    if (state == AppLifecycleState.resumed && _fromSettings) {
      this._check();
    }
  }

  _check() async {
    print("AppLifecycleState:::::::::: Checking");
    final bool hasAccess = await Permission.locationWhenInUse.isGranted;
    if (hasAccess) {
      this._goToHome();
    }
  }

  _goToHome() {
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  //solicita el acceso a la ubicación
  Future<void> _request() async {
    final PermissionStatus status =
        await Permission.locationWhenInUse.request();

    print("status $status");

    switch (status) {
      case PermissionStatus.undetermined:
        break;
      case PermissionStatus.granted:
        this._goToHome();
        break;
      case PermissionStatus.denied:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.permanentlyDenied:
        await openAppSettings();
        _fromSettings = true;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Permiso requerido"),
            Text("Necesitamos el permiso para mostrarte tu ubicación"),
            FlatButton(
                onPressed: this._request,
                color: Colors.blue,
                child: Text(
                  "Permitir",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
