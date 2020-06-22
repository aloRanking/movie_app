
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/utils/data_connection_checker.dart';
import 'package:movieapp/utils/movieapp.dart';
import 'package:movieapp/views/movie_home.dart';
import 'package:provider/provider.dart';
import 'index.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  ConfigBloc configBloc;

  @override
  void initState() {
    super.initState();
    setupApp();
  }

  setupApp() {
    configBloc = ConfigBloc();
    configBloc.isDarkModeOn =
        MovieApp.prefs.getBool(MovieApp.darkModePref) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (context) => configBloc,
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Movie App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              //* Custom Google Font
              //fontFamily: Devfest.google_sans_family,
              primarySwatch: Colors.red,
              primaryColor: configBloc.isDarkModeOn ? Colors.black : Colors.white,
              disabledColor: Colors.grey,
              cardColor: configBloc.isDarkModeOn ? Colors.black : Colors.white,
              canvasColor:
              configBloc.isDarkModeOn ? Colors.black : Colors.grey[50],
              brightness:
              configBloc.isDarkModeOn ? Brightness.dark : Brightness.light,
              buttonTheme: Theme.of(context).buttonTheme.copyWith(
                  colorScheme: configBloc.isDarkModeOn
                      ? ColorScheme.dark()
                      : ColorScheme.light()),
              appBarTheme: AppBarTheme(
                elevation: 0.0,
              ),
            ),
            home: StreamProvider<DataConnectionStatus>(
               create: (context) {
            return DataConnectivityService()
                .connectivityStreamController
                .stream;
          },
          child: MovieHome()),
          );
        },
      ),
    );
  }
}
