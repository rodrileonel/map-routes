part of 'widgets.dart';


class BtnRoute extends StatelessWidget {

  final MapBloc mapBloc;

  const BtnRoute({this.mapBloc});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom:10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 30,
        child: IconButton(
          color: Colors.black,
          icon: Icon(Icons.linear_scale), 
          onPressed: () { 
            this.mapBloc.add(OnShowRoute());
          },
        ),
      )
    );
  }
}