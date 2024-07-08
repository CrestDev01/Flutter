class ErrorModel {
  bool? status;
  String? message;
  bool? showMessage;
  String? type;

  ErrorModel({
    this.status,
    required this.message,
    this.type,
  });

  ErrorModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    type = json is Map
        ? (json).containsKey('type')
            ? json['type']
            : ''
        : '';
    showMessage = json['status'] != 403;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['type'] = type;
    map['showMessage'] = status != 403;
    return map;
  }
}
