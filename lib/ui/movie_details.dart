import 'package:bastien/models/ItemModel.dart';
import 'package:bastien/models/movie_data.dart';
import 'package:bastien/models/movie_trailer.dart';
import 'package:bastien/services/web_service.dart';
import 'package:bastien/services/api.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsWidget extends StatelessWidget {
  final MovieData movieData;
  final int index;

  MovieDetailsWidget(this.movieData, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                 expandedHeight: 300.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: "poster$index",
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500${movieData.posterPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(margin: EdgeInsets.only(top: 5.0)),
                    Text(
                      movieData.title,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 1.0, right: 1.0),
                        ),
                        Text(
                          movieData.voteAverage,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        Text(
                          movieData.releaseDate,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    Text(movieData.overview),
                    Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    Text(
                      "Bande annonce",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    StreamBuilder<MovieTrailer>(
                      stream: Webservice()
                          .load(Api.fetchMovieTrailer(movieData.id))
                          .asStream(),
                      builder:
                          (context, AsyncSnapshot<MovieTrailer> itemSnapShot) {
                        if (itemSnapShot.hasData) {
                          if (itemSnapShot.data.results.length > 0)
                            return trailerLayout(itemSnapShot.data);
                          else
                            return noTrailer(itemSnapShot.data);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                      /* );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }*/
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noTrailer(MovieTrailer data) {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }


  Widget trailerLayout(MovieTrailer data) {
    if (data.results.length > 1) {
      return Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          PlayerWidget(data:data, index: 0,),
          PlayerWidget(data:data, index:1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          PlayerWidget(data:data, index: 0,),
        ],
      );
    }
  }





}

class PlayerWidget extends StatelessWidget {
  final MovieTrailer data;
  final int index;
   PlayerWidget({@required this.data, @required this.index,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(

        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            height: 200.0,
            color: Colors.grey,
            //child: Center(child: Icon(Icons.play_circle_filled)),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: data.results[index].key, //Add videoID.
                flags: YoutubePlayerFlags(
                  hideControls: false,
                  controlsVisibleAtStart: true,
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.indigo,
            ),
          ),
          Text(
            data.results[index].name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
