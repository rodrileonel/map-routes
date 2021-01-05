part of 'widgets.dart';


class BtnLocation extends StatelessWidget {

  final MapBloc mapBloc;
  final LocationBloc locationBloc;

  const BtnLocation({this.mapBloc, this.locationBloc});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom:10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          color: Colors.black,
          icon: Icon(Icons.my_location), 
          onPressed: () { 
            final destino = this.locationBloc.state.location;
            this.mapBloc.moveCamera(destino);
          },
        ),
      )
    );
  }
}