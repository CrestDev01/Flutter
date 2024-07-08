class SuccessModel {
  bool? status;
  String? message;
  String? type;

  SuccessModel({
    this.status,
    this.message,
    this.type,
  });

  SuccessModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    type = json is Map
        ? (json).containsKey('type')
            ? json['type']
            : ''
        : '';
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['type'] = type;

    return map;
  }
}
