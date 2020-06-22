import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/bloc/get_nowplaying_bloc.dart';
import 'package:movieapp/config/index.dart';
import 'package:movieapp/views/movie_detail_page.dart';
import 'package:movieapp/widgets/internet_not_available.dart';
import 'package:movieapp/widgets/now_playing.dart';
import 'package:movieapp/widgets/popular.dart';
import 'package:movieapp/widgets/top_rated.dart';
import 'package:provider/provider.dart';

enum MovieCategory {
  now_playing,
  popular,
  top_rated,
  latest
}

class MovieHome extends StatefulWidget {
  @override
  _MovieHomeState createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
    backgroundColor: Colors.transparent,
    leading: Icon(
      ConfigBloc().isDarkModeOn ?
      EvaIcons.menu2: EvaIcons.menu2Outline,

    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          ConfigBloc().isDarkModeOn
              ? FontAwesomeIcons.lightbulb
              : FontAwesomeIcons.solidLightbulb,
          size: 18,
        ),
        onPressed: () {
          ConfigBloc().add(DarkModeEvent(!ConfigBloc().isDarkModeOn));
        },
      ),
      IconButton(
          onPressed: () {},
          icon: Icon(
            ConfigBloc().isDarkModeOn ?
            EvaIcons.search : EvaIcons.searchOutline,

          ))
    ],
    elevation: 0.0,
      ),
      body: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MovieCategory selectedCategory = MovieCategory.now_playing;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
        children: <Widget>[        
                
          Container(
            height: 100,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ListTab(
                  tabText: 'Now Playing',
                  textColor: Colors.black,
                  indicatorColor: selectedCategory == MovieCategory.now_playing
                      ? Colors.red
                      : Colors.transparent,
                  onPressed: () {
                    setState(() {
                      selectedCategory = MovieCategory.now_playing;
                    });
                  },
                ),
                ListTab(
                  tabText: 'Popular',
                  textColor: Colors.black,
                  indicatorColor: selectedCategory == MovieCategory.popular
                      ? Colors.red
                      : Colors.transparent,
                  onPressed: () {
                    setState(() {
                      selectedCategory = MovieCategory.popular;
                    });
                  },
                ),
                ListTab(
                  tabText: 'Top Rated',
                  textColor: Colors.black,
                  indicatorColor: selectedCategory == MovieCategory.top_rated
                      ? Colors.red
                      : Colors.transparent,
                  onPressed: () {
                    setState(() {
                      selectedCategory = MovieCategory.top_rated;
                    });
                  },
                ),
                ListTab(
                  tabText: 'Latest',
                  textColor: Colors.black,
                  indicatorColor: selectedCategory == MovieCategory.latest
                      ? Colors.red
                      : Colors.transparent,
                  onPressed: () {
                    setState(() {
                      selectedCategory = MovieCategory.latest;
                    });
                  },
                ),
              ],
            ),
          ),
           Visibility(
                visible: Provider.of<DataConnectionStatus>(context) ==
                    DataConnectionStatus.disconnected,
                child: InternetNotAvailable()),
          getMoviesCategory(selectedCategory),

        ],
      ),
    );


  }
}

Widget getMoviesCategory( MovieCategory selectedCategory){

  switch(selectedCategory) {
    case MovieCategory.now_playing:
    // TODO: Handle this case.
     return NowPlayCategory();
      break;
    case MovieCategory.popular:
    // TODO: Handle this case.
   return PopularCategory();
      break;
    case MovieCategory.top_rated:
    // TODO: Handle this case.
   return TopRatedCategory();
      break;
    case MovieCategory.latest:
    // TODO: Handle this case.
      break;


  }
}

class ListTab extends StatelessWidget {
  final String tabText;
  final Color indicatorColor;
  final Color textColor;
  final Function onPressed;

  ListTab({this.tabText, this.textColor, this.indicatorColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(top:4.0, right: 24.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Text(
                tabText,
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 5,
                width: 40,
                child: Container(
                  color: indicatorColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



