part of 'widgets.dart';

class Pin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if(state.pin)
          return _BuildPin();
        else
          return Container();
      },
    );
  }
}

class _BuildPin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: 10,
          child: FadeInLeft(
            duration: Duration(milliseconds: 200),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon( Icons.arrow_back, color: Colors.black ), 
                onPressed: () {
                  BlocProvider.of<SearchBloc>(context).add(OnDesactivate());
                }
              ),
            ),
          )
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -20),
            child: BounceInDown(
              child: Icon(
                Icons.location_on,
                color: Colors.black,
                size: 50,
              ),
            )
          ),
        ),
        Positioned(
          width: width,
          right: 25,
          bottom: 20,
          child: FadeIn(
            child:Center(
              child: MaterialButton(
                minWidth: width-140,
                child: Text('Confirmar destino',style:TextStyle(color: Colors.white)),
                color: Colors.black,
                shape: StadiumBorder(),
                onPressed: (){
                  showAlert(context, 'Espere..', 'Calculando ruta');
                  calculateWay(context);
                  Navigator.of(context).pop();
                },
              ),
            )
          ),
        )
      ],
    );
  }

  void calculateWay(BuildContext context) async {
    final trafficService = TrafficService();
    final start = BlocProvider.of<LocationBloc>(context).state.location;
    final end = BlocProvider.of<MapBloc>(context).state.central;

    final route = await trafficService.getCoords(start, end);

    final geometry = route.routes[0].geometry;
    final duration = route.routes[0].duration;
    final distance = route.routes[0].distance;

    // Decodificar los puntos de mapbox (geometry)
    final points = Pline.Polyline.Decode(encodedString: geometry, precision: 6).decodedCoords;
    //final List<LatLng> puntos = points.map((point) => LatLng(point[0],point[1])).toList();

    List<LatLng> puntos = List();

    for (var i = 0; i < points.length-1; i++) {
      final routePoint = await trafficService.getCoords(LatLng(points[i][0],points[i][1]), LatLng(points[i+1][0],points[i+1][1]));
      final geometryPoint = routePoint.routes[0].geometry;
      final pointsPoint = Pline.Polyline.Decode(encodedString: geometryPoint, precision: 6).decodedCoords;
      pointsPoint.forEach((point) {
        puntos.add(LatLng(point[0],point[1]));
      });
    }

    BlocProvider.of<MapBloc>(context).add(OnCreateRoute(puntos,duration,distance));

    BlocProvider.of<SearchBloc>(context).add(OnDesactivate());
    
  } 
}
