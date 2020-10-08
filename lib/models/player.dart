import 'dart:convert';

class Players {
  List<Player> players;
  Players({this.players});
  factory Players.fromJson(List<dynamic> parsedJson) {
    List<Player> players = List<Player>();
    players = parsedJson.map((i) => Player.fromJson(i)).toList();
    return Players(
      players: players,
    );
  }
  String toJson() {
    String json =
        jsonEncode(players.map((i) => i.toJson()).toList()).toString();
    return json;
  }
}

class Player {
  final String name;
  final String imagePath;
  final int totalGames;
  final int points;
  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "imagePath": this.imagePath,
      "totalGames": this.totalGames,
      "points": this.points
    };
  }

  Player({this.name, this.imagePath, this.totalGames, this.points});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      imagePath: json['imagePath'],
      totalGames: json['totalGames'],
      points: json['points'],
    );
  }
}
