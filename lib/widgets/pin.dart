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
                  //todo confirm destine
                },
              ),
            )
          ),
        )
      ],
    );
  }
}
