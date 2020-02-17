import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtubebloc/blocs/favorite_bloc.dart';
import 'package:youtubebloc/blocs/videos_bloc.dart';
import 'package:youtubebloc/delegates/data_search.dart';
import 'package:youtubebloc/models/video.dart';
import 'package:youtubebloc/widgets/video_tile.dart';

import 'favorites.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/logo.png"),

        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              initialData: {},
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              builder: (context, snapshot){
                if(snapshot.hasData) return Text("${snapshot.data.length}");
                else return Container();

              },
            )
          ),
          IconButton(
            icon:Icon(Icons.star),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Favorites()));
            },
          ),
          IconButton(
            icon:Icon(Icons.search),
            onPressed: () async{
              String result = await showSearch(context: context, delegate: DataSearch());
              if(result != null) BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
            },
          )
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        initialData: [],
        builder: (context, snapshot){
          if(snapshot.hasData)
            return ListView.builder(
              itemBuilder: (context, index){
                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  BlocProvider.getBloc<VideosBloc>().inSearch.add(null);
                  return Container(
                    height: 40.0,
                    width: 40.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
                  );
                }else {
                  Container();
                }
                
              },
              itemCount: snapshot.data.length + 1,
            );
          else
            return Container();
        }
      ),
    );
  }
}