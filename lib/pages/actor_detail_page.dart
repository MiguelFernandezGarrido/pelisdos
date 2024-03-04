import 'package:flutter/material.dart';
import 'package:peliculas/models/cast.dart';

class ActorDetailScreen extends StatelessWidget {
  const ActorDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Cast cast = ModalRoute.of(context)!.settings.arguments as Cast;
    return Scaffold(
        body: CustomScrollView(slivers: [
      _CustomAppBar(cast: cast),
      SliverList(
          delegate: SliverChildListDelegate([
        const SizedBox(height: 10),
        Container(
          width: 200,
          height: 350,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image.network(cast.profileImg),
        ),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                '${cast.name} ${cast.gender == 1 ? 'Mujer' : 'Hombre'}',
              ),
            )),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(child: Text("Personaje: ${cast.character ?? ''}")),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(child: Text("Trabajo: ${cast.job ?? 'Desconocido'}")),
        )
      ]))
    ]));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Cast cast;

  const _CustomAppBar({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: Colors.indigo,
        expandedHeight: 200,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: EdgeInsets.zero,
          title: Container(
            alignment: Alignment.bottomCenter,
            color: Colors.black12,
            width: double.infinity,
            child: Text(cast.name, style: const TextStyle(fontSize: 16)),
          ),
          background: FadeInImage(
              placeholder: const AssetImage('assets/images/loading.gif'),
              image: NetworkImage(cast.profileImg),
              fit: BoxFit.cover),
        ));
  }
}
