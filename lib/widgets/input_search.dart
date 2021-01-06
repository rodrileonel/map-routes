part of 'widgets.dart';

class InputSearch extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if(!state.pin)
          return _buildSearch(context);
        else
          return Container();
      },
    );
  }

  Widget _buildSearch(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: GestureDetector(
        onTap: () async {
          final result = await showSearch(context: context, delegate: SearchDestination());
          this.searchPlace(context,result);
        },
        child: FadeInDown(
          duration: Duration(milliseconds:300),
          child: Container(
            child: Align(
              child: Text('¿A donde quieres ir?',style: TextStyle(color: Colors.black45),), 
              alignment: Alignment.centerLeft,
            ),
            width: width,
            height: 40,
            margin: EdgeInsets.only(left:20,right:20,top:10),
            padding: EdgeInsets.symmetric(horizontal:20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow( color: Colors.blueGrey[100], blurRadius: 5, offset: Offset(0,3))
              ]
            ),
          ),
        ),
      ),
    );
  }

  void searchPlace(BuildContext context, SearchResult place){
    if(place.cancel) return;

    if(place.manual){
      BlocProvider.of<SearchBloc>(context).add(OnActivate());
    }
  }
}