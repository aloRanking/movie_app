import 'package:flutter/material.dart';

class BuildErrorWidget extends StatelessWidget {
  final String error;

  BuildErrorWidget({this.error}) ;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10,),
        Image.asset('images/no-connection.png'),


        
      ],
    ),);
  }
}