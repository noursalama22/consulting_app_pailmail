import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:consulting_app_pailmail/repositories/sender_repository.dart';
import 'package:flutter/cupertino.dart';

import '../models/senders/senders_1.dart';

class SenderProvider extends ChangeNotifier {
  late SenderRepository _repository;
  late ApiResponse<List<Data>> _senderList;

  ApiResponse<List<Data>> get senderList => _senderList;

  SenderProvider() {
    _repository = SenderRepository();
    getSenderList();
  }

  getSenderList() async {
    _senderList = ApiResponse.loading("Fetching Senders");
    notifyListeners();
    try {
      List<Data>? senders = await _repository.getallSender();
      _senderList = ApiResponse.completed(senders);
      notifyListeners();
    } catch (error) {
      _senderList = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }
}
