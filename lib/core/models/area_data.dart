class AreaData {
  String id;
  String name;
  String area_id;

  AreaData({
    this.name,
    this.id,
    this.area_id
  });

  factory AreaData.fromJson(Map<String, dynamic> json) => AreaData(
        name: json["name"],
        id: json["id"],
    area_id:json["area_id"],
      );

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["id"] = id;
    map["area_id"] = area_id;

    return map;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
    "area_id":area_id,
      };
}
