part of 'widgets.dart';


class BtnFollow extends StatelessWidget {

  final MapBloc mapBloc;

  const BtnFollow({this.mapBloc});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom:10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              color: Colors.black,
              icon: Icon( state.follow ? Icons.directions_run : Icons.accessibility_new), 
              onPressed: () { 
                this.mapBloc.add(OnFollow());
              },
            ),
          )
        );
      },
    );
  }
}