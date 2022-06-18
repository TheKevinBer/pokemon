import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

import '../providers/db_provider.dart';
import '../providers/info_provider.dart';

class EquipoPages extends StatefulWidget {
  static const String routName = 'equipos';
  const EquipoPages({Key? key}) : super(key: key);

  @override
  State<EquipoPages> createState() => _EquipoPagesState();
}

class _EquipoPagesState extends State<EquipoPages> {
  final _saved = [];
  final List<Widget> equipo = [];
  final teamname = TextEditingController();
  //final _pokemon = InfoPorvider();
  @override
  Widget build(BuildContext context) {
    //DBProvider.db.insert(1,'Equipo 1',1,2,3,4,5,6);

    return Scaffold(
        appBar: AppBar(
          title: const Text('select your team'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.list),
                onPressed: () => Navigator.pushNamed(context, 'equipoview')),
          ],
        ),
        body: _cargaPokemon(context));
  }

  Widget _cargaPokemon(BuildContext context) {
    final pokemon = InfoPorvider();
    final size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height,
        width: double.infinity,
        child: FutureBuilder(
          future: pokemon.cargarPokemon(),
          builder: (BuildContext context,
              AsyncSnapshot<List<PokemonElement>> snapshot) {
            if (snapshot.hasData) {
              final infoc = snapshot.data;
              //_pref.nummsg = infoc.length;
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, childAspectRatio: 1.4),
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
        ));
  }

  Widget _pokedexVista(PokemonElement pokedex, int index) {
    final alreadySaved = _saved.contains('${pokedex.id}');

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
                  top: 0,
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
                  child: Icon(
                    alreadySaved ? Icons.favorite : Icons.favorite_border,
                    color: alreadySaved ? Colors.red : null,
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 15,
                  child: Text(
                    "${pokedex.name}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
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
          ),
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove('${pokedex.id}');
              // ignore: list_remove_unrelated_type
              equipo.removeWhere(
                  (item) => item.key == Key(pokedex.id.toString()));
            } else if (_saved.length < 6) {
              _saved.add('${pokedex.id}');
              equipo.add(equipoPokemon(pokedex));
              if (_saved.length == 6) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 0.0,
                    child: StackedCardCarousel(
                      items: equipo,
                    ),
                  ),
                );
              }
            }
          });
        },
      ),
    );
  }

  Widget equipoPokemon(PokemonElement pokedex) {
    return Card(
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      key: Key(pokedex.id.toString()),
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
                                                    ? Colors.lightGreenAccent
                                                    : pokedex.type?[0] ==
                                                            "Ghost"
                                                        ? Colors.deepPurple
                                                        : pokedex.type?[0] ==
                                                                "Normal"
                                                            ? Colors.black26
                                                            : Colors.pink,
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 250,
              child: CachedNetworkImage(
                  imageUrl: pokedex.img.toString(),
                  height: 100,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      )),
            ),
            Text(
              "${pokedex.name}",
              style: Theme.of(context).textTheme.headline5,
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.INFO,
                    body: Column(
                      children: [
                        TextField(
                          controller: teamname,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "NAME OF THE TEAM",
                            hintStyle: TextStyle(
                                fontFamily: "Montserrat", color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 16.0),
                          ),
                        ),
                        ElevatedButton(
                          child: const Text('Save'),
                          onPressed: () {
                            DBProvider.db.insert(teamname.text, _saved);
                            //_saved.clear();
                            DBProvider.db.scans;
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                    title: 'Agree',
                    desc: 'Confirm Agree',
                  ).show();
                },
                icon: const Icon(Icons.save))
          ],
        ),
      ),
    );
  }
}
