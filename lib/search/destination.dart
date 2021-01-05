import 'package:flutter/material.dart';
import 'package:googlemaps/models/search_result.dart';

class SearchDestination extends SearchDelegate<SearchResult>{

  @override
  final String searchFieldLabel = 'Buscar';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query ='',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios), 
      onPressed: () => this.close(context, SearchResult(cancel: true)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children:[
        ListTile(
          leading:Icon(Icons.location_on),
          title:Text('Colocar dirección manualmente'),
          onTap: (){
            this.close(context, SearchResult(cancel: false, manual: true));
          },
        )
      ]
    );
  }
}