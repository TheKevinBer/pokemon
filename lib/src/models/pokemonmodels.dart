import 'dart:convert';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  Pokemon({
    this.pokemon,
  });

  List<PokemonElement>? pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        pokemon: List<PokemonElement>.from(
            json["pokemon"].map((x) => PokemonElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pokemon": List<dynamic>.from(pokemon!.map((x) => x.toJson())),
      };
}

class PokemonElement {
  PokemonElement({
    this.id,
    this.numm,
    this.name,
    this.img,
    this.type,
    this.height,
    this.weight,
    this.candy,
    this.candyCount,
    this.egg,
    this.spawnChance,
    this.avgSpawns,
    this.spawnTime,
    this.multipliers,
    this.weaknesses,
    this.nextEvolution,
    this.prevEvolution,
  });

  int? id;
  String? numm;
  String? name;
  String? img;
  List<String>? type;
  String? height;
  String? weight;
  String? candy;
  int? candyCount;
  String? egg;
  double? spawnChance;
  num? avgSpawns;
  String? spawnTime;
  List<double>? multipliers;
  List<String>? weaknesses;
  List<NextEvolution>? nextEvolution;
  List<PrevEvolution>? prevEvolution;

  factory PokemonElement.fromJson(Map<String, dynamic> json) => PokemonElement(
        id: json["id"],
        numm: json["num"],
        name: json["name"],
        img: json["img"],
        type: json["type"] == null
            ? []
            : List<String>.from(json["type"]!.map((x) => x)),
        height: json["height"],
        weight: json["weight"],
        candy: json["candy"],
        candyCount: json["candy_count"],
        egg: json["egg"],
        spawnChance: json["spawn_chance"]?.toDouble(),
        avgSpawns: json["avg_spawns"],
        spawnTime: json["spawn_time"],
        multipliers: json["multipliers"] == null
            ? []
            : List<double>.from(json["multipliers"]?.map((x) => x.toDouble())),
        weaknesses: json["weaknesses"] == null
            ? []
            : List<String>.from(json["weaknesses"]?.map((x) => x)),
        prevEvolution: json["prev_evolution"] == null
            ? []
            : List<PrevEvolution>.from(
                json["prev_evolution"]!.map((x) => PrevEvolution.fromJson(x))),
        nextEvolution: json["next_evolution"] == null
            ? []
            : List<NextEvolution>.from(
                json["next_evolution"]!.map((x) => NextEvolution.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "num": numm,
        "name": name,
        "img": img,
        "type": List<dynamic>.from(type!.map((x) => x)),
        "height": height,
        "weight": weight,
        "candy": candy,
        "candy_count": candyCount,
        "egg": egg,
        "spawn_chance": spawnChance,
        "avg_spawns": avgSpawns,
        "spawn_time": spawnTime,
        "multipliers": List<dynamic>.from(multipliers!.map((x) => x)),
        "weaknesses": List<dynamic>.from(weaknesses!.map((x) => x)),
        "prev_evolution":
            List<dynamic>.from(prevEvolution!.map((x) => x.toJson())),
        "next_evolution":
            List<dynamic>.from(nextEvolution!.map((x) => x.toJson())),
      };
}

class NextEvolution {
  NextEvolution({
    this.numm,
    this.name,
  });

  String? numm;
  String? name;

  factory NextEvolution.fromJson(Map<String, dynamic> json) => NextEvolution(
        numm: json["num"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "num": numm,
        "name": name,
      };
}

class PrevEvolution {
  PrevEvolution({
    this.numm,
    this.name,
  });

  String? numm;
  String? name;

  factory PrevEvolution.fromJson(Map<String, dynamic> json) => PrevEvolution(
        numm: json["num"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "num": numm,
        "name": name,
      };
}
