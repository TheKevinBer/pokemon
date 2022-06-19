import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../providers/db_provider.dart';
import '../providers/info_provider.dart';

class EquipoView extends StatefulWidget {
  static const String routName = 'equipoview';
  const EquipoView({Key? key}) : super(key: key);
  @override
  State<EquipoView> createState() => _EquipoViewState();
}

class _EquipoViewState extends State<EquipoView> {
  final _pokemon = InfoPorvider();
  final db = DBProvider.db;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    final snacdb = DBProvider.db.scans;
    return Scaffold(
        appBar: AppBar(
          title: const Text('This is your new team'),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/logo/pokeball.png'),
                  fit: BoxFit.cover)),
          child: ListView.builder(
              itemCount: snacdb.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: Text(
                            'Team: ${snacdb[i]['nombre']}',
                            style: const TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    FutureBuilder(
                      future: _pokemon.cargarequipoPokemon(snacdb[i]),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PokemonElement>> snapshot) {
                        if (snapshot.hasData) {
                          final infoc = snapshot.data;
                          return Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              height: 200.0,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: infoc!.length,
                                  itemBuilder: (context, i) {
                                    return sqlequipo(infoc[i]);
                                  }));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                );
              }),
        ));
  }

  Widget sqlequipo(PokemonElement pokedex) {
    return Container(
      height: 100,
      width: 160.0,
      decoration: BoxDecoration(
          color: pokedex.type?[0] == "Grass"
              ? Colors.greenAccent
              : pokedex.type?[0] == "Fire"
                  ? Colors.redAccent
                  : pokedex.type?[0] == "Water"
                      ? Colors.blue
                      : pokedex.type?[0] == "Poison"
                          ? Colors.deepPurpleAccent
                          : pokedex.type?[0] == "Electric"
                              ? Colors.amber
                              : pokedex.type?[0] == "Rock"
                                  ? Colors.grey
                                  : pokedex.type?[0] == "Ground"
                                      ? Colors.brown
                                      : pokedex.type?[0] == "Psychic"
                                          ? Colors.indigo
                                          : pokedex.type?[0] == "Fighting"
                                              ? Colors.orange
                                              : pokedex.type?[0] == "Bug"
                                                  ? Colors.lightGreenAccent
                                                  : pokedex.type?[0] == "Ghost"
                                                      ? Colors.deepPurple
                                                      : pokedex.type?[0] ==
                                                              "Normal"
                                                          ? Colors.black26
                                                          : Colors.pink,
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: Stack(
        children: [
          Positioned(
            bottom: 90,
            right: 0,
            child: Image.asset(
              'assets/images/logo/pokeball.png',
              height: 100,
              fit: BoxFit.fitHeight,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Hero(
              tag: pokedex,
              child: CachedNetworkImage(
                  imageUrl: pokedex.img.toString(),
                  height: 100,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.black.withOpacity(0.5)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 5, bottom: 5),
                child: Text(
                  pokedex.type
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", ""),
                  style: const TextStyle(color: Colors.white, shadows: [
                    BoxShadow(
                        color: Colors.blueGrey,
                        offset: Offset(0, 0),
                        spreadRadius: 1.0,
                        blurRadius: 15)
                  ]),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "${pokedex.name}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                        color: Colors.blueGrey,
                        offset: Offset(0, 0),
                        spreadRadius: 1.0,
                        blurRadius: 15)
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
