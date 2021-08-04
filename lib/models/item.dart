import 'dart:convert';

List<Item> itemFromJson(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(Item item) => json.encode(item.toJson());

class Item {
  Item({
    this.image,
    this.title,
    this.isFavorite,
    this.isBookmarked,
    this.labelId,
    this.catId,
    this.id,
  });

  String image;
  String title;
  bool isFavorite;
  bool isBookmarked;
  int labelId;
  int catId;
  int id;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        image: json["image"],
        title: json["title"],
        isFavorite: json["isFavorite"],
        isBookmarked: json["isBookmarked"],
        labelId: json["labelId"],
        catId: json["catId"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "isFavorite": isFavorite,
        "isBookmarked": isBookmarked,
        "labelId": labelId,
        "catId": catId,
        "id": id,
      };
}
