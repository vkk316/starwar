import 'package:dio/dio.dart';

class People {
  final String name;
  final String url;
  final int height;
  final int mass;
  final String birthYear;
  final String gender;
  final List films;
  People(this.name, this.url, this.height, this.mass,
      this.birthYear, this.gender, this.films);

  factory People.fromJson(dynamic data) {
    return People(
        data['name'],
        data['url'],
        int.parse(data['height']),
        int.parse(data['mass']),
        data['birth_year'],
        data['gender'],
        data['films']);
  }
}

class Film {
  final String title;
  final int episodeID;

  Film(this.title, this.episodeID);

  factory Film.fromJson(dynamic data) {
    return Film(data['title'], data['episode_id']);
  }
}

class Vehicle {
  final String name;
  final String model;
  final String manufacturer;

  Vehicle(this.name, this.model, this.manufacturer);

  factory Vehicle.fromJson(dynamic data) {
    return Vehicle(data['name'], data['model'], data['manufacturer']);
  }
}

class StarwarsRepo {
  Future<List<People>> fetchPeople({int page = 1}) async {
    var response = await Dio().get('https://swapi.dev/api/people/?page=$page');
    List<dynamic> results = response.data['results'];
    return results.map((it) => People.fromJson(it)).toList();
  }

  Future<List<Vehicle>> fetchVehical({int id = 1}) async {
    var response = await Dio().get('https://swapi.dev/api/vehicles/$id');
    List<dynamic> results = response.data;
    return results.map((e) => Vehicle.fromJson(e)).toList();
  }

  Future<List<Film>> fetchFilm({int id = 1}) async {
    var response = await Dio().get('https://swapi.dev/api/films/$id');
    List<dynamic> results = response.data;
    return results.map((e) => Film.fromJson(e)).toList();
  }
}
