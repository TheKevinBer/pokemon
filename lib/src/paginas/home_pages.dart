import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke/src/providers/db_provider.dart';

import '../providers/info_provider.dart';
import '../sharepreference/pref_user.dart';

class HomePage extends StatefulWidget {
  static const String routName = 'home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pokemon = InfoPorvider();
  final pref = PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DBProvider.db.scans;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //return final headlines = Provider.of<NewsService>(context).headlines;
    DBProvider.db.database;
    DBProvider.db.getTodosLosScans();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
      ),
      body: SizedBox(
        height: height / 1.2,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          clipBehavior: Clip.antiAlias,
          semanticContainer: true,
          //clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),

          elevation: 6,
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
              width: width / 1.2,
              top: 45,
              left: 5,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 20,
                      ),
                      onPressed: () {
                        pref.disconnect();
                        Navigator.pushReplacementNamed(context, 'login');
                      }),
                  IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'equipoview',
                            arguments: DBProvider.db.scans);
                      }),
                ],
              ),
            ),
            Positioned(
              top: -30,
              right: -50,
              child: Image.asset(
                'assets/images/logo/pokeball.png',
                width: 200,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
                top: 100,
                left: 20,
                child: Text(
                  'Pokedex',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                )),
            Positioned(
              top: 0,
              child: SizedBox(
                height: 150,
                width: width,
              ),
            ),
            _cargaPokemon(context)
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'equipos');
        },
        child: const Icon(Icons.format_align_justify),
      ),
    );
  }

  Widget _cargaPokemon(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: 150,
      bottom: 0,
      width: size.width,
      child: SizedBox(
          height: size.height / 1.6,
          width: double.infinity,
          child: FutureBuilder(
            future: _pokemon.cargarPokemon(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PokemonElement>> snapshot) {
              if (snapshot.hasData) {
                final infoc = snapshot.data;
                return Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1.4),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: infoc!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _pokedexVista(infoc[index], index);
                          }),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }

  Widget _pokedexVista(PokemonElement pokedex, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: InkWell(
        child: SafeArea(
          child: Container(
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
                                                        ? Colors
                                                            .lightGreenAccent
                                                        : pokedex.type?[0] ==
                                                                "Ghost"
                                                            ? Colors.deepPurple
                                                            : pokedex.type?[
                                                                        0] ==
                                                                    "Normal"
                                                                ? Colors.black26
                                                                : Colors.pink,
                borderRadius: const BorderRadius.all(Radius.circular(25))),
            child: Stack(
              children: [
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: Image.asset(
                    'assets/images/logo/pokeball.png',
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Hero(
                    tag: index,
                    child: CachedNetworkImage(
                        imageUrl: pokedex.img.toString(),
                        height: 100,
                        fit: BoxFit.fitHeight,
                        placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            )),
                  ),
                ),
                Positioned(
                  top: 55,
                  left: 15,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
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
                Positioned(
                  top: 30,
                  left: 15,
                  child: Text(
                    "${pokedex.name}",
                    style: const TextStyle(
                      fontFamily: "Open Sans",
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'detail', arguments: pokedex);
        },
      ),
    );
  }
}
