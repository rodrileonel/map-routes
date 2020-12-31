import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:googlemaps/helpers/navigate_fadein.dart';
import 'package:googlemaps/pages/map_page.dart';
import 'package:googlemaps/pages/permission_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {

  static final routeName = 'Loading';

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver{

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
    if (state == AppLifecycleState.resumed)
      await checkGpsAndLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGpsAndLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return Center( child: Text(snapshot.data));
          }
          else
            return Center( child: CircularProgressIndicator(strokeWidth:3));
        },
      )
    );
  }

  Future checkGpsAndLocation(BuildContext context) async {

    //permiso gps
    final permGps = await Permission.location.isGranted;
    //gps activo
    final gpsActive = await Geolocator.isLocationServiceEnabled();
    
    if(permGps && gpsActive){
      Navigator.pushReplacement(context,navigateFadeIn(context, MapPage()));
      return 'Entrando al mapa';
    }
    else if (!permGps){
      Navigator.pushReplacement(context,navigateFadeIn(context, PermissionPage()));
      return 'Es necesario el permiso de gps';
    }
    else if (!gpsActive)
      return 'El gps esta inactivo';
  }
}