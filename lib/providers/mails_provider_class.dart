// import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_response.dart';
// import 'package:consulting_app_pailmail/repositories/mails_reprository.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../models/mails/mail.dart';
//
// class MailProvider extends ChangeNotifier {
//   late MailsRepository _mailsRepository;
//   late ApiResponse<List<Mail>> _mailsList;
//   late ApiResponse<Mail> _singleMail;
//   late ApiResponse<bool> _del;
//
//   ///to view a list of all mails
//   MailProvider() {
//     _mailsRepository = MailsRepository();
//     _fetchAllMails();
//     createEmail(
//       status_id: '4',
//       decision: "not yet",
//       sender_id: '81',
//       activities: [],
//       tags: [1],
//       subject: 'test create email',
//       description: "I hate my self",
//       archive_number: '/2000',
//       archive_date: DateTime.now().toString(),
//     );
//   }
//
//   ApiResponse<List<Mail>> get mails => _mailsList;
//   ApiResponse<Mail> get createdMail => _singleMail;
//   ApiResponse<bool> get deleted => _del;
//   Future<void> _fetchAllMails() async {
//     _mailsList = ApiResponse.loading("loading");
//     notifyListeners();
//     try {
//       final response = await _mailsRepository.fetchAllMails();
//       _mailsList = ApiResponse.completed(response);
//       notifyListeners();
//     } catch (e) {
//       _mailsList = ApiResponse.error(e.toString());
//       notifyListeners();
//     }
//   }
//
//   Future<void> fetchSingleMail(String id) async {
//     _mailsList = ApiResponse.loading("loading");
//     notifyListeners();
//     try {
//       final response = await _mailsRepository.fetchSingleMail(
//           id: id); //add id here as string
//       _mailsList = ApiResponse.completed(response);
//       notifyListeners();
//     } catch (e) {
//       _mailsList = ApiResponse.error(e.toString());
//       notifyListeners();
//     }
//   }
//
//   Future<void> createEmail(
//       {required String subject,
//       String? description,
//       required String sender_id,
//       required String archive_number,
//       required String archive_date,
//       String? decision,
//       required String status_id,
//       String? final_decision,
//       List<int>? tags,
//       List<Map<String, dynamic>>? activities}) async {
//     _mailsList = ApiResponse.loading("loading");
//     notifyListeners();
//     try {
//       final response = await _mailsRepository.createMail(
//           subject: subject,
//           decision: decision,
//           final_decision: final_decision,
//           description: description,
//           tags: tags,
//           sender_id: sender_id,
//           archive_number: archive_number,
//           archive_date: archive_date,
//           status_id: status_id);
//       _mailsList = ApiResponse.completed(response);
//       print("ooooooooo");
//       notifyListeners();
//     } catch (e) {
//       _mailsList = ApiResponse.error(e.toString());
//       notifyListeners();
//     }
//   }
//
//   Future<void> updateEmail(
//       {required String id,
//       String? decision,
//       required int status_id,
//       String? final_decision,
//       List<int>? tags,
//       List<int>? idAttachmentsForDelete,
//       List<int>? pathAttachmentsForDelete,
//       List<Map<String, dynamic>>? activities}) async {
//     _singleMail = ApiResponse.loading("loading");
//     try {
//       final response = await _mailsRepository.updateMail(
//           id: id,
//           status_id: status_id,
//           final_decision: final_decision,
//           decision: decision,
//           tags: tags,
//           idAttachmentsForDelete: idAttachmentsForDelete,
//           pathAttachmentsForDelete: pathAttachmentsForDelete);
//       _singleMail = ApiResponse.completed(response);
//       notifyListeners();
//     } catch (e) {
//       _singleMail = ApiResponse.error(e.toString());
//       notifyListeners();
//     }
//   }
//
//   Future<void> deleteEmail({required String id}) async {
//     _del = ApiResponse.loading("loading");
//     try {
//       final response = await _mailsRepository.deleteMail(id: id);
//       _del = ApiResponse.completed(response);
//       notifyListeners();
//     } catch (e) {
//       _del = ApiResponse.error(e.toString());
//       notifyListeners();
//     }
//   }
// }
