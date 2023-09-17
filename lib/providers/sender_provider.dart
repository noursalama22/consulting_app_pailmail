import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_base_helper.dart';
import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:consulting_app_pailmail/repositories/sender_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../models/senders/sender.dart';

class SenderProvider extends ChangeNotifier {
  late SenderRepository _repository;
  late ApiResponse<List<Sender>> _senderList;

  ApiResponse<List<Sender>> get senderList => _senderList;

  SenderProvider() {
    _repository = SenderRepository();
    getSenderList();
  }

  getSenderList() async {
    _senderList = ApiResponse.loading("Fetching Senders");
    notifyListeners();
    try {
      //List<Sender>senders=await _repository.getallSender();
      //_senderList=ApiResponse.completed(senders);
      notifyListeners();
    } catch (error) {
      _senderList = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }
}
