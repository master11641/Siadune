class Image {
  final String url;
  Image({this.url});
  factory Image.fromJSON(Map<String, dynamic> parsedJson) {
    return Image(url: parsedJson['Url']);
  }
}
