import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/bloc/get_top_rated_movies.dart';
import 'package:movieapp/config/config_bloc.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/models/movie_response.dart';

import 'build_error.dart';
import 'build_loading.dart';
import 'movie_card.dart';

class TopRatedCategory extends StatefulWidget {
  @override
  _TopRatedCategoryState createState() => _TopRatedCategoryState();
}

class _TopRatedCategoryState extends State<TopRatedCategory> {

   PageController pageController;
  var currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    topRatedMoviesBloc..getTopRatedMoviesList();
    pageController = PageController();
    pageController.addListener(() {
      setState(() => currentPageValue = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: topRatedMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return BuildErrorWidget(error:snapshot.data.error);
          }
          return _buildTopRatedWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return BuildErrorWidget(error:snapshot.data.error);
        } else {
          return BuildLoadingWidget();
        }
      },
    );
  }



  Widget _buildTopRatedWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Moviess",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
        height: 450,
        child: PageView.builder(
          controller: pageController,
          scrollDirection: Axis.horizontal,
            itemBuilder: (context, position) {
              if (position == currentPageValue.floor()) {
                                
                      //the page we are swiping from
                      return Transform(
                          transform: Matrix4.identity()
                            ..rotateX(( currentPageValue- position)),
                          child: MovieCard(movies: movies[position]));
                    } else if (position == currentPageValue.floor()+1) {
                      
                      //the page we are swiping to

                      return Transform(
                          transform: Matrix4.identity()
                            ..rotateX((currentPageValue - position)),
                      
                          child:MovieCard(movies: movies[position]));
                    } else {
                      return MovieCard(movies: movies[position]);
                    }
             
            }),
      );
    }
  }
}


