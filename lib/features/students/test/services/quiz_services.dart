// // ✅ 1. Import required packages
// import 'dart:convert';
// import 'package:club_app/comman/widgets/show_snack_bar.dart';
// import 'package:club_app/constant/global_variable.dart';
// import 'package:club_app/constant/http_error_handling.dart';
// import 'package:club_app/models/quiz_attempts.dart';
// import 'package:club_app/models/quiz_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../models/resutlModel.dart';
// import '../../../providers/user_provider.dart';
// import '../screens/resuiltScreen.dart';
//
// class QuizServices {
//   final String baseUrl = '$uri/api/fetch-question';
//
//   // fetch questions
//   Future<List<QuizModel>> fetchQuizzes(BuildContext context) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('x-auth-token');
//
//       if (token == null || token.isEmpty) {
//         throw Exception("No token found. Please login again.");
//       }
//
//       final response = await http.get(
//         Uri.parse(baseUrl),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': token,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         List<dynamic> jsonData = jsonDecode(response.body);
//         // 🔄 Convert JSON to List<Quiz> using your model
//         List<QuizModel> quizzes =
//             jsonData.map((quizJson) => QuizModel.fromJson(quizJson)).toList();
//         return quizzes; // ✅ Return the list of quizzes
//       } else {
//         throw Exception(
//           'Failed to load quizzes (status ${response.statusCode})',
//         );
//       }
//     } catch (e) {
//       // ❌ Handle any errors in network or parsing
//       throw Exception('Error fetching quizzes: $e');
//     }
//   }
//
//   Future<void> saveAttempt(
//     BuildContext context,
//     String quizId,
//     int score,
//     String category,
//     int totalQue,
//     bool attempted,
//   ) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     print('userId : ---------------------${userProvider.user.id}');
//     try {
//       QuizAttempt attempt = QuizAttempt(
//         id: '',
//         userId: userProvider.user.id,
//         quizId: quizId,
//         category: category,
//         score: score,
//         attempted: attempted,
//       );
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('x-auth-token');
//
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/save-attempts'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': token!,
//         },
//         body: jsonEncode(attempt.toJson()),
//       );
//
//       httpErrorHandling(
//         context: context,
//         res: res,
//         onSuccess: () {
//           // showSnackBar(text: 'Save attempts', context: context);
//           // Navigator.pushReplacement(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder:
//           //         (context) =>
//           //             ResuiltScreen(score: score, totalQuestion: totalQue),
//           //   ),
//           // );
//         },
//       );
//     } catch (e) {
//       throw Exception('Fail to save: $e');
//     }
//   }
//
//   // check attempted
//   Future<bool> checkAttempt({required String quizId}) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('x-auth-token');
//
//     final url = Uri.parse(
//       '$uri/api/check-attempts/$quizId',
//     ); // URL to check if quiz is attempted
//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': token!,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print(data);
//         if (data['attempted']) {
//           return true;
//         } else {
//           return false;
//         }
//       } else {
//         throw Exception('Failed to check attempt: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle any exceptions or errors
//       throw Exception('Error checking attempt: $e');
//     }
//   }
//
//   // save results
//
//   Future<void> saveResult({
//     required BuildContext context,
//     required String quizId,
//     required int score,
//     required int totalQue,
//     required String category,
//   }) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     print('userName ---------------------------------${userProvider.user.name}');
//     print(userProvider.user.id);
//     try {
//       ResultModel resultModel = ResultModel(
//         category: category,
//         quizId: quizId,
//         userResult: UserResult(
//           userId: userProvider.user.id,
//           userName: userProvider.user.name,
//           score: score,
//           totalQuestions: totalQue,
//         ),
//       );
//
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('x-auth-token');
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/save-results'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': token!,
//         },
//         body: jsonEncode(resultModel.toJson()),
//       );
//
//       httpErrorHandling(
//         context: context,
//         res: res,
//         onSuccess: () {
//           // showSnackBar(text: "Result store success", context: context);
//         },
//       );
//     } catch (e) {
//       print(e.toString());
//       showSnackBar(text: e.toString(), context: context);
//     }
//   }
//
//
//   // get score
//
//   Future<int?> getScore({required String quizId}) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('x-auth-token');
//
//     final url = Uri.parse(
//       '$uri/api/get-score/$quizId',
//     ); // URL to check if quiz is attempted
//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           'x-auth-token': token!,
//         },
//       );
//
//       print("Status Code: ${response.statusCode}");
//       print("Response Body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         print(data['score']['score'] as int);
//         return data['score']['score'] as int;  // Return the score value
//       }
//       // If response is 204 No Content, return null (no score)
//       else if (response.statusCode == 204) {
//         return null; // No score found, return null
//       } else {
//         // Handle other status codes (errors)
//         throw Exception('Failed to load score');
//       }
//
//     } catch (e) {
//       // Handle any exceptions or errors
//       throw Exception('Error checking attempt: $e');
//     }
//   }
//
// }
