import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/config/config_bloc.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/views/movie_detail_page.dart';
import 'dart:math' as math;

class SimilarMoviesCard extends StatelessWidget {
  final Movie movies;


  SimilarMoviesCard({this.movies});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailPage(movies)));
      },
      child: Container(
        width: 200,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                /*decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  color: ConfigBloc().isDarkModeOn ? Colors.black : Colors.grey,
                ),*/
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/original/" + movies.poster_path,

                      fit: BoxFit.cover,
                    )),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Text(movies.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                  )),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  EvaIcons.star,
                  color: Colors.yellow,
                ),
                Text(
                  movies.vote_average.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),

                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
