import 'package:bastien/models/movie_genre.dart';
import 'package:bastien/models/sort_options.dart';
import 'package:bastien/providers/movie_parameter_provider.dart';
import 'package:bastien/utils/constants.dart';
import 'package:bastien/utils/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieParametersWidget extends StatefulWidget {
  @override
  _MovieParametersWidgetState createState() => _MovieParametersWidgetState();
}

class _MovieParametersWidgetState extends State<MovieParametersWidget> {
  MovieCategory _movieCategory = MovieCategory.movie;
  MovieSubCategory _movieSubCategory = MovieSubCategory.popular;

  RangeValues _rangeValues = RangeValues(2018, 2020);
  List<MovieGenre> _genres = MovieGenresList.fromJSON(movie_list).genres;
  List<SortOption> _options = SortOptionList.fromJSON(sort_by).options;
  SortOption _option;

  bool isCheck = true;
  bool isPopular = false;
  bool _isFilmSelected = true;
  bool _sortByRuntime = false;

  @override
  void initState() {
    super.initState();
  }

  _getMovieCategoryValue() {
    if (_movieCategory == MovieCategory.discover)
      return "discover";
    else
      return "movie";
  }

  @override
  Widget build(BuildContext context) {
    final parameterProvider = Provider.of<MovieParametersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Center(child: Text('Parametres')),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Center(
        child: ListView(
          // shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 10.0),
          children: [
            Card(
              elevation: 4,
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Film'),
                      leading: Radio<MovieCategory>(
                        value: MovieCategory.movie,
                        groupValue: _movieCategory,
                        onChanged: (value) {
                          setState(() {
                            _movieCategory = value;
                            print("${_movieCategory.index}");
                            _isFilmSelected = true;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Découvrir'),
                      leading: Radio<MovieCategory>(
                        value: MovieCategory.discover,
                        groupValue: _movieCategory,
                        onChanged: (value) {
                          setState(() {
                            _movieCategory = value;
                            print("${_movieCategory.index}");
                            _isFilmSelected = false;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isFilmSelected,
              child: Card(
                elevation: 4,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(" Populaires"),
                      leading: Radio<MovieSubCategory>(
                        value: MovieSubCategory.popular,
                        groupValue: _movieSubCategory,
                        onChanged: (value) {
                          setState(() {
                            _movieSubCategory = value;
                            print("${_movieSubCategory.index}");
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text("Mieux notés"),
                      leading: Radio<MovieSubCategory>(
                        value: MovieSubCategory.top_rated,
                        groupValue: _movieSubCategory,
                        onChanged: (value) {
                          setState(() {
                            _movieSubCategory = value;
                            print("${_movieSubCategory.index}");
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text("A venir"),
                      leading: Radio<MovieSubCategory>(
                        value: MovieSubCategory.upcoming,
                        groupValue: _movieSubCategory,
                        onChanged: (value) {
                          setState(() {
                            _movieSubCategory = value;
                            print("${_movieSubCategory.index}");
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Année de sortie entre : ',
                      style: TextStyle(
                          //decoration: TextDecoration.overline,
                          fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                    child: SliderTheme(
                      // Customization of the SliderTheme
                      // based on individual definitions
                      // (see rangeSliders in _RangeSliderSampleState)
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFFFF0000),
                        showValueIndicator: ShowValueIndicator.always,
                      ),
                      child: RangeSlider(
                        min: 2000,
                        max: 2030,
                        divisions: 30,
                        values: _rangeValues,
                        labels: RangeLabels(
                            _rangeValues.start.round().toString(),
                            _rangeValues.end.round().toString()),
                        onChanged: (rangeValues) {
                          setState(() {
                            _rangeValues = rangeValues;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Genre:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 24.0),
                    new DropdownButton<MovieGenre>(
                        value: parameterProvider.movieGenre,
                        items: _genres.map((MovieGenre movieGenre) {
                          return DropdownMenuItem<MovieGenre>(
                            value: movieGenre,
                            child: new Text(movieGenre.text),
                          );
                        }).toList(),
                        onChanged: (MovieGenre newMovieGenre) {
                          parameterProvider.setMovieGenre(newMovieGenre);
                          print("${parameterProvider.movieGenre.text}");
                        }),
                  ],
                ),
              ),
            ),
            // Durée
            Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text("Durée"),
                          leading: Checkbox(
                              value: isPopular,
                              onChanged: (bool value) {
                                setState(() {
                                  isPopular = value;
                                });
                              }),
                        ),
                      ),
                      /*  Expanded(
                        child: ListTile(
                          title: Text("Vote"),
                          leading: Checkbox(
                              value: isPopular,
                              onChanged: (bool value) {
                                setState(() {
                                  isPopular = value;
                                });
                              }),
                        ),
                      )*/
                    ],
                  ),
                  /*Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text("Popularité"),
                          leading: Checkbox(
                              value: isPopular,
                              onChanged: (bool value) {
                                setState(() {
                                  isPopular = value;
                                });
                              }),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text("data"),
                          leading: Checkbox(
                              value: isPopular,
                              onChanged: (bool value) {
                                setState(() {
                                  isPopular = value;
                                });
                              }),
                        ),
                      )
                    ],
                  )*/
                ],
              ),
            ),
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Option de tri :',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 24.0,
                      height: 8,
                    ),
                    DropdownButton<SortOption>(
                      value: _option,
                      items: _options.map((SortOption sortOption) {
                        return DropdownMenuItem<SortOption>(
                          value: sortOption,
                          child: Text(sortOption.name),
                        );
                      }).toList(),
                      onChanged: (SortOption value) {
                        setState(() {
                          _option = value;
                        });
                        print("$_option}");
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Release dates range selector
            Container(
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  /* Container(
                    constraints: BoxConstraints(
                      minWidth: 40.0,
                      maxWidth: 40.0,
                    ),
                    child: Text('${_minReleaseDate.toStringAsFixed(0)}'),
                  ),*/
                  /*  Expanded(
                    child: SliderTheme(
                      // Customization of the SliderTheme
                      // based on individual definitions
                      // (see rangeSliders in _RangeSliderSampleState)
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFFFF0000),
                        showValueIndicator: ShowValueIndicator.always,
                      ),
                      child: RangeSlider(
                        min: _minReleaseDate,
                        max: 2030,
                        // lowerValue: _minReleaseDate,
                        // upperValue: _maxReleaseDate,
                        divisions: 30,
                        values: _rangeValues,
                        labels: RangeLabels(
                          _rangeValues.start.round().toString(),
                          _rangeValues.end.round().toString()
                        ),
                        //   showValueIndicator: true,
                        //  valueIndicatorMaxDecimals: 0,
                        onChanged: (rangeValues) {
                          setState(() {
                            _rangeValues = rangeValues;
                          });
                        },
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60),
              child: Center(
                child: Text(" Developed by @Enyo "),
              ),
            )
            //  Divider(), // Genre Selector
          ],
        ),
      ),

      // Filters acceptance

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          // close the screen
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
