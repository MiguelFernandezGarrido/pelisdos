import 'package:flutter/material.dart';
import 'package:peliculas/pages/actor_detail_page.dart';
import 'package:peliculas/shared_prefs/user_prefs.dart';
import 'package:provider/provider.dart';

import 'pages/pages.dart';
import 'providers/movies_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = UserPrefs();
  await UserPrefs.init();
  // await prefs.initPrefs();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false)
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Pelis',
        initialRoute: '/',
        routes: {
          '/': (_) => const HomeScreen(),
          HomeScreen.routeName: (_) => const HomeScreen(),
          'detail': (_) => const DetailScreen(),
          'actor_detail': (_) => const ActorDetailScreen(),
        },
        theme: ThemeData.light()
            .copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo)));
  }
}
