import 'package:bastien/models/movie_data.dart';
import 'package:bastien/providers/movie_data_provider.dart';
import 'package:bastien/providers/theme_provider.dart';
import 'movie_search_delegate.dart';
import 'package:bastien/utils/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_data_widget.dart';
import 'movie_details.dart';
import 'movie_parameter_widgets.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController;
  bool _isShowed;
  int pageNumber;
  String message = "";
  ScrollStatus scrollStatus = ScrollStatus.None;

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController();
    _isShowed = true;
    pageNumber = 1;
    handleScroll();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDataProvider>(
      builder: (BuildContext context, movieDataProvider, Widget child) {
        return Scaffold(
          appBar: buildAppBar(widget.title),
          body: Center(
            child: StreamBuilder<List<MovieData>>(
                initialData: [],
                stream:
                    movieDataProvider.fetchMoviesDataWithRuntime().asStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<MovieData>> snapshot) {
                  if (!snapshot.hasData || snapshot.data.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }

                  return Stack(children: [
                    NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollStartNotification) {
                          _onStartScroll(scrollNotification.metrics);
                        } else if (scrollNotification
                            is ScrollUpdateNotification) {
                          _onUpdateScroll(scrollNotification.metrics);
                        } else if (scrollNotification
                            is ScrollEndNotification) {
                          _onEndScroll(scrollNotification.metrics);
                        }
                        return true;
                      },
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
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
                              onTap: () =>
                                  openMovieDetails(snapshot.data[index], index),
                            );
                          }),
                    ),
                    scrollStatus == ScrollStatus.None &&
                            snapshot.connectionState == ConnectionState.waiting
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                          )
                        : Center(),
                  ]);
                }),
          ),
          floatingActionButton: Visibility(
            visible: _isShowed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Visibility(
                  visible:
                      movieDataProvider.actualPagNumber == 1 ? false : true,
                  child: FloatingActionButton(
                    onPressed: () {
                      movieDataProvider.down();
                      scrollStatus = ScrollStatus.None;
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  onPressed: () {
                    movieDataProvider.up();
                    scrollStatus = ScrollStatus.None;
                  },
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar(String text) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return AppBar(
      title: Text(
        text,
        style: TextStyle(
          fontFamily: 'Charmonman',
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
      ),
      elevation: 0,
      actions: [
        Switch(
            value: themeChange.darkTheme,
            onChanged: (bool value) {
              themeChange.darkTheme = value;
            }),
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: MovieSearchDelegate(),
                );
              },
              child: Icon(
                Icons.search,
                size: 26.0,
              ),
            )),
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MovieParametersWidget(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Icon(Icons.settings),
            )),
      ],
    );
  }

  openMovieDetails(MovieData movieData, int index) {
    final detailsPage = MovieDetailsWidget(movieData, index);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return detailsPage;
      }),
    );
  }

  void hideFloatingButton() {
    setState(() {
      _isShowed = false;
    });
  }

  void showFloatingButton() {
    setState(() {
      _isShowed = true;
    });
  }

  void handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideFloatingButton();
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloatingButton();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(() {});
  }

  _onStartScroll(ScrollMetrics metrics) {
    scrollStatus = ScrollStatus.Start;
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    scrollStatus = ScrollStatus.Update;
  }

  _onEndScroll(ScrollMetrics metrics) {
    scrollStatus = ScrollStatus.End;
  }
}
