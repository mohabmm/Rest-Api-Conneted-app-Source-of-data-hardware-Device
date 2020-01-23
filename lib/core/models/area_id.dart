class AreaIdModel {
  String id;

  AreaIdModel({
    this.id,
  });

  factory AreaIdModel.fromJson(Map<String, dynamic> json) => AreaIdModel(
        id: json["area_id"],
      );

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["area_id"] = id;
    return map;
  }

  Map<String, dynamic> toJson() => {
        "area_id": id,
      };
}
