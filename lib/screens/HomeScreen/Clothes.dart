class Clothes {
  int count;
  String type;
  Clothes({required this.count, required this.type});
  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'type': type,
    };
  }
}

class LaundryData {
  String regNo;
  String roomNo;
  String status;
  List<Clothes> clothesList;

  LaundryData({
    required this.regNo,
    required this.roomNo,
    required this.status,
    required this.clothesList,
  });

  Map<String, dynamic> toJson() {
    return {
      'reg_no': regNo,
      'room_no': roomNo,
      'status': status,
      'clothes': Map.fromIterable(clothesList, key: (clothes) => clothes.type, value: (clothes) => clothes.count),
    };
  }
}
