import 'package:animator/animator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/bloc/get_movie_detail_bloc.dart';
import 'package:movieapp/config/config_bloc.dart';
import 'package:movieapp/models/movie_detail.dart';
import 'package:movieapp/models/movie_detail_response.dart';

class MovieInfo extends StatefulWidget {
  final int id;

  MovieInfo(this.id);

  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {

  @override
  void initState() {
    // TODO: implement initState
      super.initState();
      movieDetailBloc..getMovieDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailResponse>(
      stream: movieDetailBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieDetailResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildMovieInfoWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            )
          ],
        ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error"),
          ],
        ));
  }

  Widget _buildMovieInfoWidget(MovieDetailResponse data) {
    MovieDetail movie = data.movieDetail;
    if (movie == null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Row(

                        children: <Widget>[
                          Text(movie.releaseDate),
                          SizedBox(width: 20,),
                          movie.adult==false?Text('PG-13') : Text('PG-18'),
                          SizedBox(width: 20,),
                          Text(movie.runtime.toString() + ' mins')
                        ],
                      ),
                      SizedBox(height: 8,),
                      Container(
                        height: 38.0,
                        child: ListView.builder(
                            itemCount: movie.genres.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return GenreTabs(movie: movie, index: index,);
                            }),
                      ),
                      SizedBox(height: 20,),
                      Text('Plot Summary',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),),
                      SizedBox(height: 15,),
                      Text(movie.overview),
                      SizedBox(height: 20,),

                    ],

                  ),

                ),
              ],
            ),
          );



    }
  }
}

class GenreTabs extends StatelessWidget {
  final int index;
  final MovieDetail movie;

  GenreTabs({ this.movie, this.index});

  @override
  Widget build(BuildContext context) {
    return Animator(
      tween:Tween<Offset>(
          begin: Offset(0.7, 0),
          end: Offset(0.0, 0)
      ),
        duration: Duration(milliseconds: 1000),
      curve: Curves.decelerate,
      builder: (context,anim, child)=> FractionalTranslation(
        translation: anim.value,
        child: Container(
          margin: EdgeInsets.only(right: 8),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
              color:  ConfigBloc().isDarkModeOn
                  ? Colors.deepOrange
                  : Colors.white54,
              border: Border.all(
                color: ConfigBloc().isDarkModeOn
                    ? Colors.white
                    : Colors.deepOrange,
              )
            ),
          child: Center(child: Text(movie.genres[index].name,
          style: TextStyle(
            fontWeight: FontWeight.w500
          ),)),
        ),
      ),
    );
  }
}
