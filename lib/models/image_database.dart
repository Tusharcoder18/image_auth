class ImageDatabase {
  List<String?> _randomImages = [];
  List<String?> _queryImages = [];

  void setRandomImages(List<String?> randomImages) {
    _randomImages = randomImages;
  }

  void setQueryImages(List<String?> queryImages) {
    _queryImages = queryImages;
  }

  List<String?> getRandomImages() {
    return _randomImages;
  }

  List<String?> getQueryImages() {
    return _queryImages;
  }
}
