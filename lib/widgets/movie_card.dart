import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/config/config_bloc.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/views/movie_detail_page.dart';
import 'dart:math' as math;

class MovieCard extends StatelessWidget {
  final Movie movies;
  final double offset;

  MovieCard({this.movies, this.offset});

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-50 * gauss * offset.sign, 0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailPage(movies)));
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  color: ConfigBloc().isDarkModeOn ? Colors.black : Colors.grey,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/original/" + movies.poster_path,
                      height: 280,
                      width: 400,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(movies.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25.0,
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
                    fontSize: 18,
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
