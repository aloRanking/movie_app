import 'package:animator/animator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/bloc/get_movie_detail_bloc.dart';
import 'package:movieapp/config/config_bloc.dart';
import 'package:movieapp/config/config_event.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/models/movie_detail.dart';
import 'package:movieapp/models/movie_detail_response.dart';
import 'package:movieapp/widgets/movie_cast.dart';
import 'package:movieapp/widgets/movie_info.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // movieDetailBloc..getMovieDetail(widget.movieId);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }




  Widget getWidget(Movie movie) {
    if (movie != null) {
      return _buildNowPlayingWidget(movie);
    } else if (movie == null) {
      return _buildErrorWidget("Movie not available");
    } else {
      return _buildLoadingWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(child: getWidget(widget.movie)),
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

  Widget _buildNowPlayingWidget(Movie data) {
    Movie movie = data;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
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
      return SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: screenHeight * 0.40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/original/" +
                                    movie.backdrop_path,
                            ),
                        fit: BoxFit.cover)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.deepOrange,
                        ),
                        child: Icon(
                          EvaIcons.plus,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: MovieInfo(movie.id),
                ),
                MovieCast(movie.id),
              ],
            ),
            Positioned(
              top: screenHeight * 0.27,
              child: Animator(
                duration: Duration(seconds: 2),
                builder:(context,anim, child)=> Transform.scale(
                  //origin: Offset(screenWidth, 0),
                  scale: anim.value,
                  child: Container(
                    margin: EdgeInsets.only(left: 30),
                    height: 80,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(10, 15),
                            color: ConfigBloc().isDarkModeOn
                                ? Colors.transparent
                                : Colors.blueGrey,
                            blurRadius: 15,
                          )
                        ],
                        color: ConfigBloc().isDarkModeOn
                            ? Colors.deepOrange
                            : Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Icon(
                                  EvaIcons.star,
                                  color: Colors.yellow,
                                  size: 35,
                                ),
                                Text(movie.vote_average.toString() + '/10')
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Icon(
                                  EvaIcons.starOutline,
                                  size: 35,
                                ),
                                Text('Rate this')
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 25,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      width: 50,
                      child: IconButton(
                        icon: Icon(
                          ConfigBloc().isDarkModeOn
                              ? FontAwesomeIcons.lightbulb
                              : FontAwesomeIcons.solidLightbulb,
                          size: 18,
                        ),
                        onPressed: () {
                          ConfigBloc()
                              .add(DarkModeEvent(!ConfigBloc().isDarkModeOn));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 1.2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

