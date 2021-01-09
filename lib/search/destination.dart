import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:googlemaps/models/search_response.dart';
import 'package:googlemaps/models/search_result.dart';
import 'package:googlemaps/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult>{

  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximity;
  final List<SearchResult> historial;

  SearchDestination(this.proximity, this.historial)
    : this.searchFieldLabel = 'Buscar...',
      this._trafficService = TrafficService();

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
    return this._buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(this.query.length == 0)
      return ListView(
        children:[
          ListTile(
            leading:Icon(Icons.location_on),
            title:Text('Colocar dirección manualmente'),
            onTap: (){
              this.close(context, SearchResult(cancel: false, manual: true));
            },
          ),
          ...this.historial.map((e) => ListTile(
            leading:Icon(Icons.history),
            title: Text(e.name),
            subtitle: Text(e.description),
            onTap: (){
              this.close(context, e);
            },
          )).toList()
        ]
      );
    return this._buildSearchResults();
  }

  Widget _buildSearchResults(){
    if(this.query==0)
      return Container();

    this._trafficService.getSugerenciasPorQuery(this.query.trim(), this.proximity);

    return StreamBuilder(
      //future: this._trafficService.gerResults(this.query.trim(), this.proximity),
      stream: this._trafficService.suggestionsStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {

        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        final places = snapshot.data.features;
        if(places.length == 0)
          return ListTile(
            title: Text('No hay resultados'),
          );

        return ListView.separated(
          itemCount: places.length,
          separatorBuilder: (_, i) => Divider(),
          itemBuilder: (_, i) {
            return ListTile(
              leading:Icon(Icons.place),
              title: Text(places[i].textEs),
              subtitle: Text(places[i].placeNameEs),
              onTap: (){
                this.close(context, SearchResult(
                  cancel: false,
                  manual: false,
                  //en mapbox viene primero la longitud y luego la latitud
                  position: LatLng(places[i].center[1], places[i].center[0]),
                  name: places[i].textEs,
                  description: places[i].placeNameEs,
                ));
              },
            );
          },
        );
      },
    );
  }
}