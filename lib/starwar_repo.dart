  
import 'package:dio/dio.dart';

class People {
  final String name;
  final String url;
  People(this.name, this.url);

  factory People.fromJson(dynamic data) {
    return People(data['name'], data['url']);
  }
}

class StarwarsRepo {
  Future<List<People>> fetchPeople({int page = 1}) async {
    var response = await Dio().get('https://swapi.dev/api/people/?page=$page');
    List<dynamic> results = response.data['results'];
    return results.map((it) => People.fromJson(it)).toList();
  }
}