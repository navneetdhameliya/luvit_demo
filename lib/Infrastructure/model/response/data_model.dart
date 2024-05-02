import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DetailsDataModel? banana;
  DetailsDataModel? apple;
  DetailsDataModel? peach;
  DetailsDataModel? melon;

  DataModel({
    this.banana,
    this.apple,
    this.peach,
    this.melon,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    banana: json["banana"] == null ? null : DetailsDataModel.fromJson(json["banana"]),
    apple: json["apple"] == null ? null : DetailsDataModel.fromJson(json["apple"]),
    peach: json["peach"] == null ? null : DetailsDataModel.fromJson(json["peach"]),
    melon: json["melon"] == null ? null : DetailsDataModel.fromJson(json["melon"]),
  );

  Map<String, dynamic> toJson() => {
    "banana": banana?.toJson(),
    "apple": apple?.toJson(),
    "peach": peach?.toJson(),
    "melon": melon?.toJson(),
  };
}

class DetailsDataModel {
  List<String>? images;
  String? name;
  String? description;
  int? likeCount;
  String? location;
  int? age;
  List<String>? tags;

  DetailsDataModel({
    this.images,
    this.name,
    this.description,
    this.likeCount,
    this.location,
    this.age,
    this.tags,
  });

  factory DetailsDataModel.fromJson(Map<String, dynamic> json) => DetailsDataModel(
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    name: json["name"],
    description: json["description"],
    likeCount: json["likeCount"],
    location: json["location"],
    age: json["age"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "name": name,
    "description": description,
    "likeCount": likeCount,
    "location": location,
    "age": age,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
  };
}
