import 'package:flutter/material.dart';
import 'package:movieapp/config/config_page.dart';
import 'package:movieapp/utils/movieapp.dart';
import 'package:movieapp/views/movie_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  MovieApp.prefs = await SharedPreferences.getInstance();


runApp(ConfigPage());

}



