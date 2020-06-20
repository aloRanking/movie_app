import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:movieapp/bloc/get_cast_bloc.dart';
import 'package:movieapp/models/cast.dart';
import 'package:movieapp/models/cast_response.dart';

class MovieCast extends StatefulWidget {
  final int id;

  MovieCast(this.id);
  @override
  _MovieCastState createState() => _MovieCastState();
}

class _MovieCastState extends State<MovieCast> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieCastsBloc..getMovieCasts(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CastResponse>(
      stream: movieCastsBloc.subject.stream,
      builder: (context, AsyncSnapshot<CastResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildMovieCastWidget(snapshot.data);
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

  Widget _buildMovieCastWidget(CastResponse data) {
    List<Cast> cast = data.casts;
    if (cast.length == 0) {
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Cast and Crew',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),),
                    SizedBox(height: 15,),
                    Container(
                      height: 155,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cast.length,
                          itemBuilder: (context, index){
                            return CastAvatar(cast: cast[index]);
                          }),
                    )
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

class CastAvatar extends StatelessWidget {
  final Cast cast;


  CastAvatar({this.cast});

  @override
  Widget build(BuildContext context) {
    return Animator(
      tween: Tween<Offset>(
        begin: Offset(60, 0),
        end: Offset(0, 0)
      ),
        duration: Duration(milliseconds: 1000),
      builder: (context,anim,child)=> Transform.translate(
        offset: anim.value,
        child: Container(
          margin: EdgeInsets.only(right: 15),
          child: Column(

            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage("https://image.tmdb.org/t/p/original/" + cast.img) ,
              ),
              SizedBox(height: 8,),
              Text(cast.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 5,),
              Text(cast.character,
                style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                ),)
            ],
          ),
        ),
      ),
    );
  }
}
