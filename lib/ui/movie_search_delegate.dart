import 'package:bastien/models/movie_data.dart';
import 'package:bastien/providers/movie_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_data_widget.dart';
import 'movie_details.dart';

class MovieSearchDelegate extends SearchDelegate<MovieData> {

  MovieSearchDelegate();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than one letter.",
            ),
          )
        ],
      );
    }

    var provider = Provider.of<MovieDataProvider>(context);

    return Container(
      child:
        //Build the results based on the searchResults stream in the searchBloc
        StreamBuilder(
          stream: provider.searchMovie(query).asStream(),
          builder: (context, AsyncSnapshot<List<MovieData>> snapshot) {
            if (!snapshot.hasData) {
              return

                  Center(child: CircularProgressIndicator());


            } else if (snapshot.data.length == 0) {
              return Column(
                children: <Widget>[
                  Text(
                    "No Results Found.",
                  ),
                ],
              );
            } else {
              var results = snapshot.data;
              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  //var movieData = results[index];
                  return InkResponse(
                    enableFeedback: true,
                    child: FilmListItem(
                      thumbnail: Hero(
                        tag: "poster$index",
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w185${snapshot.data[index].posterPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      overview: snapshot.data[index].overview,
                      title: snapshot.data[index].title,
                      runtime:
                      snapshot.data[index].runtime.toString(),
                    ),
                    onTap: () =>  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return MovieDetailsWidget(snapshot.data[index], index);
                      }),
                    )

                  );
                },
              );
            }
          },
        ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

}
