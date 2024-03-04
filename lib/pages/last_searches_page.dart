import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class LastSearches extends StatelessWidget {
  static const routeName = 'last-searches';
  const LastSearches({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesProvider provider = Provider.of<MoviesProvider>(context);
    List<String> lastSearches = provider.getLastSearches();
    return Center(
      child: lastSearches.isEmpty
          ? const Text('No hay busquedas recientes')
          : ListView.builder(
              itemCount: lastSearches.length,
              itemBuilder: (_, int index) {
                return ListTile(
                  title: Text(lastSearches[index]),
                  onTap: () {
                    // Navigator.of(context).pop(lastSearches[index]);
                  },
                );
              },
            ),
    );
  }
}
