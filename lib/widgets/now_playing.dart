import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/bloc/get_nowplaying_bloc.dart';
import 'package:movieapp/config/config_bloc.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/models/movie_response.dart';
import 'package:movieapp/views/movie_detail_page.dart';

import 'build_error.dart';
import 'build_loading.dart';
import 'movie_card.dart';

class NowPlayCategory extends StatefulWidget {
  @override
  _NowPlayCategoryState createState() => _NowPlayCategoryState();
}

class _NowPlayCategoryState extends State<NowPlayCategory> {
  PageController pageController = PageController();
  double pageOffset = 0;
   var currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    nowPlayingBloc..getNowPlayingList();
   // pageController = PageController(viewportFraction: 0.8);
    
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
      stream: nowPlayingBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return BuildErrorWidget(error:snapshot.data.error);
          }
          return _buildNowPlayingWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return BuildErrorWidget(error:snapshot.data.error);
        } else {
          return BuildLoadingWidget();
        }
      },
    );
  }

 


  Widget _buildNowPlayingWidget(MovieResponse data) {
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
        height:MediaQuery.of(context).size.height * 0.70,
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
