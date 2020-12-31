import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlemaps/bloc/location/location_bloc.dart';
import 'package:googlemaps/bloc/map/map_bloc.dart';
import 'package:googlemaps/pages/loading_page.dart';
import 'package:googlemaps/pages/map_page.dart';
import 'package:googlemaps/pages/permission_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocationBloc(),),
        BlocProvider(create: (_) => MapBloc(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: LoadingPage.routeName,
        routes: {
          MapPage.routeName: (_) => MapPage(),
          LoadingPage.routeName: (_) => LoadingPage(),
          PermissionPage.routeName: (_) => PermissionPage(),
        },
      ),
    );
  }
}
