import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../models/pokemonmodels.dart';

class InfoPorvider {
  Future<List<PokemonElement>> cargarPokemon() async {
    /*\
    var url = Uri.https('raw.githubusercontent.com',
        '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
     */
    const url =
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
    //final resp = await http.get(Uri.parse(url));
    final resp = await Dio().get(url);
    final Map<String, dynamic>? decodeData = json.decode(resp.data);
    List<dynamic> data = decodeData!['pokemon'];
    final List<PokemonElement> informac = [];
    if (resp.statusCode != 200) return [];
    for (var inforh in data) {
      final infoTemp = PokemonElement.fromJson(inforh);
      informac.add(infoTemp);
    }
    return informac;
  }

  Future<List<PokemonElement>> cargarequipoPokemon(int id) async {
    /*\
    var url = Uri.https('raw.githubusercontent.com',
        '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
     */
    const url =
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
    //final resp = await http.get(Uri.parse(url));
    final resp = await Dio().get(url);
    final Map<String, dynamic>? decodeData = json.decode(resp.data);
    List<dynamic> data = decodeData!['pokemon'];
    final List<PokemonElement> informac = [];
    if (resp.statusCode != 200) return [];
    for (var inforh in data) {
      final infoTemp = PokemonElement.fromJson(inforh);
      informac.add(infoTemp);
    }
    return informac;
  }
}
