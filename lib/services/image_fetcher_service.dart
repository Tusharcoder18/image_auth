import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_auth/Keys/pexels_api_key.dart';
import 'package:image_auth/models/image_database.dart';
import 'package:provider/provider.dart';
import 'package:unsplash_client/unsplash_client.dart';

/*
ImageFetcherService provides services to fetch images randomly or based on
a particular search term.
Note: There are two functions available, one makes use of the Pexels API and
the other uses the unsplash_client plugin which internally uses the Unsplash
API.
*/

class ImageFetcherService {
  final _client = UnsplashClient(
    settings: ClientSettings(
        credentials: AppCredentials(
      accessKey: unsplashAccessKey!,
      secretKey: unsplashSecretKey!,
    )),
  );

  void dispose() {
    _client.close();
  }

  // Required for use with fetchRandomImages (Pexels API)
  // final Random _rnd = Random();
  // final List<String?> queries = [
  //   "nature",
  //   "animals",
  //   "hotel",
  //   "internet",
  //   "tea",
  //   "television",
  //   "forest",
  //   "town",
  //   "energy",
  //   "bird",
  //   "village",
  //   "youth",
  //   "night",
  //   "funeral",
  //   "data",
  //   "food",
  //   "newspaper"
  // ];

  /* 
  This function uses the Pexels API to fetch random images
  Note: No random endpoint available, manually written logic to select random
  images.
  */
  // Future<void> fetchRandomImages(BuildContext context) async {
  //   try {
  //     List<String?> imageUrls = [];
  //     for (var i = 0; i < 9; i++) {
  //       String? query = queries[_rnd.nextInt(queries.length)];
  //       String? url =
  //           "https://api.pexels.com/v1/search?query=$query&orientation=square&size=small&per_page=10";
  //       Uri? uri = Uri.parse(url);
  //       http.Response response =
  //           await http.get(uri, headers: {"Authorization": apiKey!});
  //       if (response.statusCode == 200) {
  //         dynamic parsed = jsonDecode(response.body);
  //         List<dynamic> photos = (parsed['photos'] as List);
  //         String? imageUrl = photos[_rnd.nextInt(10)]['src']['small'];
  //         debugPrint(imageUrl);
  //         imageUrls.add(imageUrl);
  //       } else {
  //         throw Exception(["${response.statusCode}"]);
  //       }
  //     }
  //     context.read<RandomImages>().setRandomImages(imageUrls);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  /*
  This function uses the unsplash_client plugin which internally uses the
  Unsplash API to fetch random images. Random endpoint available in this
  function.
  */
  Future<void> fetchRandomImages(BuildContext context) async {
    try {
      List<String?> imageUrls = [];
      final photos = await _client.photos
          .random(count: 9, orientation: PhotoOrientation.squarish)
          .goAndGet();
      for (Photo photo in photos) {
        var url = photo.urls.thumb.toString();
        debugPrint(url);
        imageUrls.add(url);
      }
      context.read<ImageDatabase>().setRandomImages(imageUrls);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /*
  This function uses the unsplash_client plugin which internally uses the
  Unsplash API to fetch images based on the search query provided. Provide the
  search term as 'query'.
  */
  Future<void> fetchImagesByQuery(BuildContext context, String? query) async {
    try {
      List<String?> imageUrls = [];
      var res = await _client.search
          .photos(query!, perPage: 9, orientation: PhotoOrientation.squarish)
          .goAndGet();
      final photos = res.results;
      for (Photo photo in photos) {
        var url = photo.urls.thumb.toString();
        debugPrint(url);
        imageUrls.add(url);
      }
      context.read<ImageDatabase>().setQueryImages(imageUrls);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
