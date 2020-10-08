import '../models/image.dart';

class Adver {
  final int id;
  final String title;
  final String description;
  final String addDate;
  final List<Image> imagees;
  Adver({this.id, this.title, this.description, this.addDate, this.imagees});
  factory Adver.fromJSON(Map<String, dynamic> parsedJson) {
    return Adver(
        id: parsedJson['Id'],
        title: parsedJson['Title'],
        description: parsedJson['Description'],
        addDate: parsedJson['AddDate'],
        imagees: (parsedJson['Images'] as List)
            .map((x) => Image.fromJSON(x))
            .toList());
  }
}
