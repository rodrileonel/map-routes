import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/bloc/location/location_bloc.dart';
import 'package:googlemaps/bloc/map/map_bloc.dart';
import 'package:googlemaps/widgets/widgets.dart';

class MapPage extends StatefulWidget {
  static final routeName = 'Map';

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    BlocProvider.of<LocationBloc>(context).startFollowing();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<LocationBloc>(context).cancelFollowing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) => createMap(state)
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnLocation(
            mapBloc: mapBloc, 
            locationBloc: locationBloc,
          )
        ]
      ),
    );
  }

  Widget createMap(LocationState state){
    if(!state.existLocation) return Center(child: Text('Localizando...'));

    //cambiar opciones del linter, para ello ver archivo analysis_options.yaml
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final cameraPosition = CameraPosition(
      target: state.location,
      zoom: 15
    );

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) 
        => mapBloc.initMap(controller),
    );
  }
}