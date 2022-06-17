import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/pokemonmodels.dart';

class DetailScreen extends StatefulWidget {
  static const String routName = 'detail';
  const DetailScreen({Key? key}) : super(key: key);
  @override
  State<DetailScreen> createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final PokemonElement pokemonInfo =
        ModalRoute.of(context)!.settings.arguments as PokemonElement;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorPok(pokemonInfo.type![0]),
      ),
      backgroundColor: colorPok(pokemonInfo.type![0]),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${pokemonInfo.name}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "# ${pokemonInfo.numm}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
          Positioned(
              top: 40,
              left: 22,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${pokemonInfo.type}",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                ),
              )),
          Positioned(
            top: height * 0.03,
            right: -30,
            child: Image.asset(
              'assets/images/logo/pokeball.png',
              height: 200,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height * 0.6,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: const Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17),
                            ),
                          ),
                          Text(
                            "${pokemonInfo.name}",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: const Text(
                              'Height',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17),
                            ),
                          ),
                          Text(
                            "${pokemonInfo.height}",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: const Text(
                              'Weight',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17),
                            ),
                          ),
                          Text(
                            "${pokemonInfo.weight}",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: const Text(
                              'Spawn Time',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17),
                            ),
                          ),
                          Text(
                            "${pokemonInfo.spawnTime}",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: const Text(
                              'Weakness',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17),
                            ),
                          ),
                          Text(
                            "${pokemonInfo.weaknesses}",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: const Text(
                              'Pre Evolution',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17),
                            ),
                          ),
                          if (pokemonInfo.prevEvolution!.isEmpty) ...[
                            const Text(
                              "Just Hatched",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                          ] else ...[
                            SizedBox(
                              height: 20,
                              width: width * 0.55,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: pokemonInfo.prevEvolution?.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "${pokemonInfo.prevEvolution?[index].name}",
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: const Text(
                              'Next Evolution',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 17),
                            ),
                          ),
                          Container(
                              child: pokemonInfo.prevEvolution!.isEmpty
                                  ? SizedBox(
                                      height: 20,
                                      width: width * 0.55,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            pokemonInfo.nextEvolution?.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                              "${pokemonInfo.nextEvolution?[index].name}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const Text(
                                      "Maxed Out",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 55,
            left: (width / 2) - 100,
            child: Hero(
              tag: pokemonInfo.id.toString(),
              child: CachedNetworkImage(
                height: 200,
                width: 200,
                imageUrl: pokemonInfo.img.toString(),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  Color colorPok(String tipo) {
    return tipo == "Grass"
        ? Colors.greenAccent
        : tipo == "Fire"
            ? Colors.redAccent
            : tipo == "Water"
                ? Colors.blue
                : tipo == "Poison"
                    ? Colors.deepPurpleAccent
                    : tipo == "Electric"
                        ? Colors.amber
                        : tipo == "Rock"
                            ? Colors.grey
                            : tipo == "Ground"
                                ? Colors.brown
                                : tipo == "Psychic"
                                    ? Colors.indigo
                                    : tipo == "Fighting"
                                        ? Colors.orange
                                        : tipo == "Bug"
                                            ? Colors.lightGreenAccent
                                            : tipo == "Ghost"
                                                ? Colors.deepPurple
                                                : tipo[0] == "Normal"
                                                    ? Colors.black26
                                                    : Colors.pink;
  }
}
