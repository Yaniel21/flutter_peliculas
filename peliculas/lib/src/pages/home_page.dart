import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';
//import 'dart:html';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();
  //intento por resolver

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Películas en cines'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetas(),
              _footer(context),
            ],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 300.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20.0 ),
          child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)),
        SizedBox(height: 5.0),
        FutureBuilder(
          future: peliculasProvider.getPopulares(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return MovieHorizontal(peliculas: snapshot.data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),

        //Text('Populares', style: Theme.of(context).textTheme.headline6),
      ]),
    );
  }
}
