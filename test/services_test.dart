import 'package:flutter_test/flutter_test.dart';
import 'package:image_auth/services/image_fetcher_service.dart';

void main() {
  test("should fetch random image urls", () async {
    final _imageFetcher = ImageFetcherService();

    // await _imageFetcher.fetchRandomImages();
    // final _imageUrls = _imageFetcher.imageUrls;
    // expect(_imageUrls.length, 9);
  });
}
