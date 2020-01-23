class ReserveSpot {
  String userid;
  String garage_id;
  String place_number;

  ReserveSpot({
    this.garage_id,
    this.userid,
    this.place_number,
  });

  factory ReserveSpot.fromJson(Map<String, dynamic> json) => ReserveSpot(
        userid: json["userid"],
        garage_id: json["garage_id"],
        place_number: json['"place_number'],
      );

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userid"] = userid;
    map["garage_id"] = garage_id;
    map["place_number"] = place_number;
    return map;
  }

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "garage_id": garage_id,
        "place_number": place_number,
      };
}
