import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieDetail {
  final String title;
  final String rating;
  final String description;
  final String posters;
  final List actors;

  const MovieDetail(
      {required this.title,
      required this.rating,
      required this.description,
      required this.posters,
      required this.actors});

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    List<String> actorList = [];

    for (int i = 0; i < json['actor'].length; i++) {
      actorList.add(json['actor'][i]['name']);
    }

    return MovieDetail(
      title: json['name'] ?? '',
      description: json['description'] ?? '',
      rating: json['aggregateRating']['ratingValue'].toString(),
      posters: json['image'] ?? '',
      actors: actorList,
    );
  }

  static Future<MovieDetail> fetchMovie(String id) async {
    String apiURL = 'https://search.imdbot.workers.dev/?tt=$id';

    var apiResult = await http.get(Uri.parse(apiURL));

    return MovieDetail.fromJson(jsonDecode(apiResult.body)['short']);
  }
}
