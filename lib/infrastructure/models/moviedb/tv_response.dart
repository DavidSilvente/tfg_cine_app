import 'dart:convert';

import 'package:cine_tfg_app/infrastructure/models/moviedb/moviedb_tv.dart';

class TvMovieDbResponse {
    final int page;
    final List<TvMovieDB> results;
    final int totalPages;
    final int totalResults;

    TvMovieDbResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory TvMovieDbResponse.fromRawJson(String str) => TvMovieDbResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TvMovieDbResponse.fromJson(Map<String, dynamic> json) => TvMovieDbResponse(
        page: json["page"],
        results: List<TvMovieDB>.from(json["results"].map((x) => TvMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}
