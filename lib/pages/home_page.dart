import 'package:flutter/material.dart';
import 'package:peliculas/pages/favourites_page.dart';
import 'package:peliculas/pages/last_searches_page.dart';
import 'package:peliculas/widgets/card_swiper.dart';
import 'package:peliculas/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';
import '../search/search_delegate.dart';
import '../shared_prefs/user_prefs.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex =
      UserPrefs.lastPageG == null ? 0 : int.parse(UserPrefs.lastPageG!);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      UserPrefs.lastPage = index.toString();
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    List<Widget> widgetOptions = <Widget>[
      home(moviesProvider),
      const Favourites(),
      const LastSearches()
    ];
    return Scaffold(
      appBar: AppBar(
          title: const Text('Peliculas en cines',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon(Icons.search_off_outlined),
            )
          ]),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            label: 'Menú Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Últimas Búsquedas'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  SingleChildScrollView home(MoviesProvider moviesProvider) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // En cines
          CardSwiper(
            movies: moviesProvider.enCines,
          ),

          // Populares
          MovieSlider(
            title: 'Populares',
            movies: moviesProvider.populares,
            nextPage: () => moviesProvider.getPopulares(),
            numSlider: '1',
          ),
          // Populares
          MovieSlider(
            title: 'Top Rated',
            movies: moviesProvider.topRated,
            nextPage: () => moviesProvider.getTopRated(),
            numSlider: '2',
          ),
          MovieSlider(
            title: 'Upcoming',
            movies: moviesProvider.upcoming,
            nextPage: () => moviesProvider.getUpcoming(),
            numSlider: '3',
          ),
        ],
      ),
    );
  }
}
