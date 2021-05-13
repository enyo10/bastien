import 'package:bastien/providers/movie_data_provider.dart';
import 'package:bastien/providers/movie_parameter_provider.dart';
import 'package:bastien/providers/theme_provider.dart';
import 'package:bastien/ui/home.dart';
import 'package:bastien/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();


  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();

  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeChangeProvider),
        ChangeNotifierProvider<MovieParametersProvider>(
            create: (_) => MovieParametersProvider()),

        ChangeNotifierProxyProvider<MovieParametersProvider, MovieDataProvider>(
          create: (BuildContext context) =>
              MovieDataProvider(Provider.of<MovieParametersProvider>(context, listen: false)),

          update: (BuildContext context,
                  MovieParametersProvider movieParametersProvider,
                  MovieDataProvider job) =>
              MovieDataProvider(movieParametersProvider),
        ),
      ],
      child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              //theme: ThemeData.dark(),
              //theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              theme: themeChangeProvider.darkTheme?darkTheme:lightTheme,
              title: 'Liste des films',
              home: MyHomePage(title: 'Liste des films'),
            );
          },
      )
    );
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }
}
