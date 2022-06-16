import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemonmodels.dart';

class InfoPorvider {
  Future<List<PokemonElement>> cargarPokemon() async {
    const url =
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
    final resp = await http.get(Uri.parse(url));
    final Map<String, dynamic>? decodeData = json.decode(resp.body);
    List<dynamic> data = decodeData!['pokemon'];
    final List<PokemonElement> informac = [];
    for (var inforh in data) {
      final infoTemp = PokemonElement.fromJson(inforh);
      informac.add(infoTemp);
    }
    //print(data);
    return informac;
  }
}
