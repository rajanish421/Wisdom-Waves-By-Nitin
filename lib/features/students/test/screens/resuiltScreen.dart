// import 'package:club_app/features/quiz/screens/QuestionScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:pie_chart/pie_chart.dart';
// class ResuiltScreen extends StatefulWidget {
//   int score;
//   int totalQuestion;
//   ResuiltScreen({required this.totalQuestion,required this.score});
//
//   @override
//   State<ResuiltScreen> createState() => _ResuiltScreenState();
// }
//
// class _ResuiltScreenState extends State<ResuiltScreen> {
//   String name = "";
//   TextEditingController _controller = TextEditingController();
//   String feedback = "";
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // name  = context.read<WelcomeNameProvider>().name;
//     // saveScore();
//   }
//
//   // Future<void> saveScore()async{
//   //   try{
//   //     final feedbackCollection = FirebaseFirestore.instance.collection('users').doc(name);
//   //     final snapshot = await feedbackCollection.get();
//   //
//   //     if(snapshot.data() == null){
//   //       final value = 0;
//   //       print(value<=widget.score);
//   //       feedbackCollection.set({
//   //         'highestScore':value<=widget.score?widget.score:value,
//   //         'username': name,
//   //         'score':FieldValue.arrayUnion([widget.score]),
//   //         'timestamp':FieldValue.serverTimestamp(),
//   //       }, SetOptions(merge: true)
//   //       ).then((value) {
//   //         print("success");
//   //       },);
//   //     }else{
//   //       final value = snapshot.data()!['highestScore'];
//   //       print(value<=widget.score);
//   //       feedbackCollection.set({
//   //         'highestScore':value<=widget.score?widget.score:value,
//   //         'username': name,
//   //         'score':FieldValue.arrayUnion([widget.score]),
//   //         'timestamp':FieldValue.serverTimestamp(),
//   //       }, SetOptions(merge: true)
//   //       ).then((value) {
//   //         print("success");
//   //       },);
//   //     }
//   //
//   //   }catch(e){
//   //     print(e.toString());
//   //   }
//   // }
//
//   // Future<void> saveFeedback(String name,String feedback)async{
//   //   try{
//   //     CollectionReference feedbackCollection = await FirebaseFirestore.instance.collection("Feedback");
//   //     feedbackCollection.add({
//   //       'username': name,
//   //       'feedback': feedback,
//   //       'score':"${widget.score}/${widget.totalQuestion}",
//   //       'timestamp':FieldValue.serverTimestamp(),
//   //     });
//   //   }catch(e){
//   //     print(e.toString());
//   //   }
//   // }
//
//
//   // Future<void> saveHistory(String name , List<String> list)async{
//   //   final pref = await SharedPreferences.getInstance();
//   //     pref.setStringList(name, list).then((value) {
//   //       print(value);
//   //     },);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final wrongAns = widget.totalQuestion - widget.score;
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(240, 240, 240, 1),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   alignment: Alignment.centerRight,
//                   width: double.infinity,
//                   height: 50,
//                   child: PopupMenuButton<String>(itemBuilder: (context) {
//                     return  <PopupMenuEntry<String>>[
//                       PopupMenuItem(child: Text("Score History"),
//                         onTap: (){
//                           // Provider.of<HistoryProvider>(context,listen: false).addScore("${widget.score}/${widget.totalQuestion}");
//                           //
//                           // Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                           //     HistoryScreen(userName: name,),));
//                         },
//                       ),
//                       PopupMenuItem(child: Text("LeaderBoard"),
//                         onTap: (){
//                           // Provider.of<HistoryProvider>(context,listen: false).addScore("${widget.score}/${widget.totalQuestion}");
//
//                           // Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                           //     LeaderboardScreen(),));
//                         },
//                       ),
//                     ];
//                   },),
//                 ),
//                 // SizedBox(height: MediaQuery.of(context).size.height*0.05,),
//                 Container(
//                   width: MediaQuery.of(context).size.width*0.8,
//                   height: MediaQuery.of(context).size.height*0.4,
//                   child: PieChart(
//                     chartLegendSpacing: 15,
//                     dataMap: {
//                       "Correct":double.parse(widget.score.toString()),
//                       "Wrong":double.parse(wrongAns.toString()),
//                     },
//                     chartValuesOptions: ChartValuesOptions(
//                         showChartValuesInPercentage: true,
//                         decimalPlaces: 0,
//                         chartValueStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
//                         chartValueBackgroundColor: Colors.transparent
//                     ),
//                     colorList: [
//                       Color.fromRGBO(76, 175, 80, 1),
//                       Color.fromRGBO(244, 67, 54, 1)
//                     ],
//                     chartType: ChartType.disc,
//                     legendOptions: LegendOptions(
//                         showLegendsInRow: true,
//                         legendPosition: LegendPosition.bottom,
//                         legendTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
//                     ),
//
//                   ),
//                 ),
//                 Text("Congratulations",
//                   style: TextStyle(
//                       color: Color.fromRGBO(33, 33, 33, 1),
//                       fontSize: 50,
//                       fontWeight: FontWeight.bold,
//                       // fontFamily: GoogleFonts.dancingScript().fontFamily
//                       ),
//                 ),
//                 Text(name.trimLeft().toUpperCase(),
//                   style: TextStyle(
//                       color: Color.fromRGBO(33, 33, 33, 1),
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       // fontFamily: GoogleFonts.dancingScript().fontFamily
//                     ),
//                 ),
//                 Text("Your Score is : ${widget.score}/${widget.totalQuestion}",
//                   style: TextStyle(
//                       color: Color.fromRGBO(33, 33, 33, 1),
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                       // fontFamily: GoogleFonts.dancingScript().fontFamily
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height*0.12,),
//                 SizedBox(
//                   height: 50,
//                   width: MediaQuery.of(context).size.width*0.9,
//                   child: ElevatedButton(
//                     onPressed: (){
//                       Navigator.of(context).popUntil((route) => route.isFirst);
//                     },
//                     child: Text("Back To Home",style: Theme.of(context).textTheme.labelSmall,),
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                         backgroundColor: Colors.lightBlueAccent
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 // SizedBox(
//                 //   height: 50,
//                 //   width: MediaQuery.of(context).size.width*0.9,
//                 //   child: Builder(
//                 //       builder: (BuildContext scaffoldContext) {
//                 //         return ElevatedButton(
//                 //           onPressed: (){
//                 //             showModalBottomSheet(
//                 //               context: scaffoldContext,
//                 //               builder:(BuildContext bottomContext) {
//                 //                 return Container(
//                 //                   width: MediaQuery.of(context).size.width,
//                 //                   child: Column(
//                 //                     // crossAxisAlignment: CrossAxisAlignment.stretch,
//                 //                     mainAxisSize:MainAxisSize.min,
//                 //                     children: [
//                 //                       SizedBox(height: 5,),
//                 //                       Text("Give your valuable feedback",
//                 //                         style: TextStyle(
//                 //                             color: Color.fromRGBO(0, 102, 204, 1),
//                 //                             fontSize: 30,
//                 //                             fontWeight: FontWeight.bold,
//                 //                             // fontFamily: GoogleFonts.kalam().fontFamily,
//                 //                         ),
//                 //                       ),
//                 //                       SizedBox(height: 5,),
//                 //                       Padding(
//                 //                         padding: const EdgeInsets.all(8.0),
//                 //                         child: TextField(
//                 //                           controller: _controller,
//                 //                           textInputAction: TextInputAction.done,
//                 //                           decoration: InputDecoration(
//                 //                             labelText: "Enter your feedback",
//                 //                             border: OutlineInputBorder(),
//                 //                           ),
//                 //                           maxLines: 5,
//                 //                         ),
//                 //                       ),
//                 //                       SizedBox(height: 16),
//                 //                       ElevatedButton(
//                 //                         onPressed: (){
//                 //                           if(_controller.text.trim().isEmpty){
//                 //                             showDialog(context: context, builder: (context) {
//                 //                               return AlertDialog.adaptive(
//                 //                                 contentTextStyle: Theme.of(context).textTheme.displayMedium,
//                 //                                 actionsAlignment: MainAxisAlignment.center,
//                 //                                 content: Text("Please write something...!"),
//                 //                                 actions: [
//                 //                                   TextButton(onPressed: (){
//                 //                                     Navigator.popUntil(context, (route) => false,);
//                 //                                   }, child: Text("OK")),
//                 //                                 ],
//                 //                               );
//                 //                             },);
//                 //                             // ScaffoldMessenger.of(scaffoldContext).
//                 //                             // showSnackBar(SnackBar(
//                 //                             //     content: Text("Please write something!")));
//                 //                           }else{
//                 //                             Navigator.pop(bottomContext);
//                 //                             setState(() {
//                 //                               // feedback = _controller.text;
//                 //                               // _controller.clear();
//                 //                               // saveFeedback(name,feedback);
//                 //                               // print(feedback);
//                 //                             });
//                 //                           }
//                 //                         },
//                 //                         child: Text("Submit",style: Theme.of(context).textTheme.labelSmall,),
//                 //                         style: ElevatedButton.styleFrom(
//                 //                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 //                             backgroundColor: Colors.blue
//                 //                         ),
//                 //                       ),
//                 //                       Spacer(flex: 4,),
//                 //                     ],
//                 //                   ),
//                 //                 );
//                 //               },);
//                 //           },
//                 //           child: Text("Feedback",style: Theme.of(context).textTheme.labelSmall,),
//                 //           style: ElevatedButton.styleFrom(
//                 //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 //             backgroundColor: Colors.lightBlueAccent,
//                 //           ),
//                 //         );
//                 //       }
//                 //   ),
//                 // ),
//                 SizedBox(height: MediaQuery.of(context).size.height*0.05,),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }