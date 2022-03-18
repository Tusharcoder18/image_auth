class ImageDatabase {
  List<String?> _randomImages = [];
  List<String?> _queryImages = [];
  List<List<String?>> _roundsImages = [];

  void setRandomImages(List<String?> randomImages) {
    _randomImages = randomImages;
  }

  void setQueryImages(List<String?> queryImages) {
    _queryImages = queryImages;
  }

  void setRoundsImages(List<List<String?>> roundsImages) {
    _roundsImages = roundsImages;
  }

  List<String?> getRandomImages() {
    return _randomImages;
  }

  List<String?> getQueryImages() {
    return _queryImages;
  }

  List<List<String?>> getRoundsImages() {
    return _roundsImages;
  }
}
