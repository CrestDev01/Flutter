class APIRequestData {
  static APIRequestData? _instance;

  APIRequestData._internal() {
    _instance = this;
  }

  factory APIRequestData() => _instance ?? APIRequestData._internal();

  static APIRequestData get shared => APIRequestData();
}

extension CommonRequestDataExt on APIRequestData {
  //Pagination params
  Map<String, dynamic> paginationReqData({required int page, int? count}) {
    count = 10;
    Map<String, dynamic> data = {
      'page': page,
      if (count != null) 'limit': count,
    };

    return data;
  }
}

//Common
extension RequestDataExt on APIRequestData {
  //Fetch combine requests params
  Map<String, dynamic> fetchRequestsData({
    required int page,
    required int? count,
    required String? type,
    required String? sessionId,
    String? requestType,
  }) {
    Map<String, dynamic> data = {
      'type': type,
      'session_uuid': sessionId,
      if (requestType != null) 'request_type': requestType,
    };

    data.addAll(paginationReqData(page: page, count: count));

    return data;
  }
}

//DJ - Requests
extension DjRequestsAPIParamsExt on APIRequestData {
  //Change request status params
  Map<String, dynamic> changeRequestStatusData({
    required String? uuid,
    required String? type,
    required String? requestType,
    required String? declineReason,
    required String? declineSummary,
  }) {
    return {
      'request_uuid': uuid,
      'type': type,
      'req_type': requestType,
      'decline_reason': declineReason,
      'decline_comment': declineSummary,
    };
  }
}

//DJ - Sessions
extension DjSessionsAPIExt on APIRequestData {
  //Create session params
  Map<String, dynamic> createSessionData({
    required String? barName,
  }) {
    return {
      'bar_name': barName,
    };
  }

  //Change receive shoutout request
  Map<String, dynamic> receiveShoutoutRequestStatusData({
    required bool shoutoutEnable,
  }) {
    return {
      'shoutout_req_enable': shoutoutEnable,
    };
  }

  //Change receive video request
  Map<String, dynamic> receiveVideoRequestStatusData({
    required bool videoEnable,
  }) {
    return {
      'video_req_enable': videoEnable,
    };
  }
}

//Listener - Requests
extension ListenerRequestsAPIParamsExt on APIRequestData {
  //Delete request params
  Map<String, dynamic> deleteRequestData({
    required String? uuid,
    required String? requestType,
  }) {
    return {
      'uuid': uuid,
      'req_type': requestType,
    };
  }
}

//Listener - Shoutout
extension ListenerShoutoutAPIParamsExt on APIRequestData {
  //Create/Edit shoutout params
  Map<String, dynamic> createEditShoutoutData({
    required String? shoutoutUuid,
    required String title,
    required String description,
    required String djUuid,
    required String shoutoutTypeId,
    required String? tipAmount,
  }) {
    return {
      'shoutout_uuid': shoutoutUuid,
      'shoutout_title': title,
      'shoutout_description': description,
      'shoutout_type_id': shoutoutTypeId,
      'dj_uuid': djUuid,
      'tip_amount': tipAmount,
    };
  }

  //Fetch shoutouts params
  Map<String, dynamic> fetchShoutoutsData({
    required int page,
    required int? count,
    required String djUuid,
    required String? type,
  }) {
    Map<String, dynamic> data = {
      'uuid_dj': djUuid,
      'type': type,
    };

    data.addAll(paginationReqData(page: page, count: count));

    return data;
  }
}

//Listener - Feedback
extension ListenerFeedbackAPIParamsExt on APIRequestData {
  //Add feedback params
  Map<String, dynamic> addFeedbackData({
    required String? feedbackUuid,
    required String djUuid,
    required double rating,
    required String feedbackText,
    required String requestUuid,
    required String title,
    required String requestType,
  }) {
    return {
      'uuid': feedbackUuid,
      'dj_uuid': djUuid,
      'star_count': rating,
      'feedback_text': feedbackText,
      'request_uuid': requestUuid,
      'title': title,
      'type': requestType,
    };
  }
}

//Listener - DJs
extension ListenerDjAPIParamsExt on APIRequestData {
  //Fetch shoutouts params
  Map<String, dynamic> fetchDJsData({
    required int page,
    required int? count,
    required int? isActive,
    required String? searchText,
  }) {
    Map<String, dynamic> data = {
      if (isActive != null) 'is_active': isActive,
      if (searchText != null) 'search': searchText,
    };

    data.addAll(paginationReqData(page: page, count: count));

    return data;
  }
}

//Listener - Wallet
extension ListenerWalletAPIParamsExt on APIRequestData {
  //Add fund params
  Map<String, dynamic> addFundData({
    required String? amount,
  }) {
    return {
      'amount': amount,
    };
  }
}

//Payout
extension PayoutAPIParamsExt on APIRequestData {
  //Retrive stripe user params
  Map<String, dynamic> retriveStripeUserData({
    required String? accountId,
  }) {
    return {
      'account_id': accountId,
    };
  }

  //Transfer fund params
  Map<String, dynamic> transferFundData({
    required String accountId,
    required String amount,
  }) {
    return {
      'account_id': accountId,
      'amount': amount,
    };
  }
}
