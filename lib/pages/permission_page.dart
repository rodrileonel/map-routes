import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlemaps/pages/loading_page.dart';
import 'package:googlemaps/pages/map_page.dart';
import 'package:permission_handler/permission_handler.dart';


class PermissionPage extends StatefulWidget {

  static final routeName = 'Permission';

  @override
  _PermissionPageState createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print(state);
    if(state == AppLifecycleState.resumed)
      if(await Permission.location.isGranted)
        Navigator.pushReplacementNamed(context, LoadingPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es necesario el gps para usar esta app'),
            MaterialButton(
              child: Text('Solicitar acceso', style: TextStyle(color: Colors.white),),
              color: Colors.orange,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () async {
                accessGPS(await Permission.location.request());
              }
            )
          ],
        ),
      ),
    );
  }

  void accessGPS(PermissionStatus permissionStatus) {
    switch (permissionStatus) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, MapPage.routeName);
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
}