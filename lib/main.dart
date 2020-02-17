import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:youtubebloc/screens/api.dart';
import 'package:youtubebloc/screens/home.dart';

import 'blocs/favorite_bloc.dart';
import 'blocs/videos_bloc.dart';

void main() {

  Api api = Api();
  api.search("search");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc())
      ],
      child: MaterialApp(
        title: "FlutterTube",
        home: Home()
      )
    );
  }
}