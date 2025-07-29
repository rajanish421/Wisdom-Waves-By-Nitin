// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shimmer/shimmer.dart';
//
// class QuestionsScreen extends StatefulWidget {
//   String category;
//   String level;
//   QuestionsScreen({required this.category,required this.level});
//   @override
//   State<QuestionsScreen> createState() => _QuestionsScreenState();
// }
//
// class _QuestionsScreenState extends State<QuestionsScreen> {
//   bool isNetOn = true;
//   List<String> OList = [];
//   int? totalQuestion;
//   int score = 0;
//   String? question;
//   String? currectAnswer;
//   List<quizModal> list = [];
//   List<String> options = [];
//   int currentQuestion = 0;
//   int selectedOption = -1;
//   bool isLoading = false;
// // @override
// // void initState() {
// //   // TODO: implement initState
// //   super.initState();
// //   isLoading = true;
// //   getData();
// //   print(widget.category);
// //   checkInt();
// // }
// // void checkInt()async {
// //   bool check = await ApiService().isConnectedToInternet();
// //   setState(() {
// //     isNetOn = check;
// //     print(isNetOn);
// //   });
// // }
// //
// // Future<void> getData()async{
// //   list = await ApiService().fetchQuestion(widget.category, widget.level);
// //   setState(() {
// //     isLoading = false;
// //   });
// // }
// // String decodeHtml(String question){
// //   return html_parser.parse(question).documentElement?.text ?? question;
// // }
//
//   @override
//   Widget build(BuildContext context) {
//     if(!isNetOn){
//       return Scaffold(body: Center(child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("No Internet Connection".toString(),style: Theme.of(context).textTheme.displayMedium,),
//           SizedBox(height: 10,),
//           IconButton(onPressed: (){
//             // Provider.of<HomePageProvider>(context,listen: false).defalutLevel();
//             // Navigator.pushAndRemoveUntil(
//             //   context,
//             //   MaterialPageRoute(builder: (context) => HomePageScreen(),),
//             //       (route) => false,
//             // );
//           },
//               icon: Icon(Icons.refresh,size: 60,)),
//         ],
//       )));
//     }
//     if(isLoading){
//       return Scaffold(
//         body:Shimmer.fromColors(
//           child: Container(
//             alignment: Alignment.center,
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Spacer(flex: 5,),
//                 Stack(
//                   alignment: Alignment.center,
//                   children:[
//                     Container(
//                       width: 80,
//                       height: 80,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 15,
//                         backgroundColor: Colors.blue,
//                         strokeCap: StrokeCap.round,
//                       ),
//                     ),
//                   ] ,
//                 ),
//                 Spacer(flex: 1,),
//                 Card(
//                   child: Container(
//                     width: MediaQuery.of(context).size.width*0.93,
//                     height: MediaQuery.of(context).size.height*0.66,
//                     child:Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16,),
//                 SizedBox(
//                   height: 40,
//                   width: 200,
//                   child: ElevatedButton(
//                     onPressed: (){},
//                     child: Text("Next"),
//                   ),
//                 ),
//                 Spacer(flex: 3,),
//               ],
//             ),
//           ),
//           baseColor: Colors.grey.withOpacity(0.5),
//           highlightColor: Colors.white,
//         ),
//       );
//     }else if(list.isEmpty){
//       return Scaffold(body: Center(child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("Something Happen Wrong!",style: Theme.of(context).textTheme.displayMedium,),
//           SizedBox(height: 10,),
//           IconButton(onPressed: (){
//             showDialog(context: context, builder: (context) {
//               return AlertDialog.adaptive(
//                 alignment: Alignment.center,
//                 actionsAlignment:MainAxisAlignment.center ,
//                 contentTextStyle: Theme.of(context).textTheme.displayMedium,
//                 content: Text("Try without selecting level"),
//                 actions: [
//                   TextButton(
//                     onPressed: (){
//                       // Provider.of<HomePageProvider>(context,listen: false).defalutLevel();
//                       // Navigator.pushAndRemoveUntil(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => HomePageScreen(),),
//                       //       (route) => false,
//                       // );
//                     },
//                     child: Text('Ok'),
//                   ),
//                 ],
//               );
//             },);
//           },
//               icon: Icon(Icons.refresh,size: 60,)),
//         ],
//       )));
//     }
// //
// //     final data = list[currentQuestion];
// //     totalQuestion = list.length;
// //     print("Before Converting Question ---->>>>>> ${data.question}");
// //     question = decodeHtml(data.question.toString());
// //     print(question);
// //     currectAnswer = data.correctAnswer;
// //     options = List<String>.from(data.incorrectAnswers!.map((e) => decodeHtml(e.toString()),));
// //     options.add(decodeHtml(data.correctAnswer!));
// //     options.shuffle();
// //     selectedOption = -1;
// //     return Scaffold(
// //       backgroundColor: Color.fromRGBO(240, 240, 240, 1),
// //       appBar: AppBar(
// //         automaticallyImplyLeading: false,
// //         backgroundColor: Color.fromRGBO(240, 240, 240, 1),
// //         actions: [
// //           PopupMenuButton<String>(
// //             itemBuilder:(context) => <PopupMenuEntry<String>>[
// //               PopupMenuItem(
// //                 child: Text("Home"),
// //                 onTap: (){
// //                   Navigator.pushReplacement(context , MaterialPageRoute(builder: (context) => HomePageScreen(),));
// //                 },
// //               ),
// //               PopupMenuItem(
// //                 child: Text("Show Resuilt"),
// //                 onTap: (){
// //                   Navigator.pushReplacement(context , MaterialPageRoute(builder: (context) => ResuiltScreen(score: score,totalQuestion: totalQuestion!,),));
// //                 },
// //               ),
// //               PopupMenuItem(
// //                 child: Text("Exit"),
// //                 onTap: (){
// //                   SystemNavigator.pop();
// //                 },
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //       body: SafeArea(
// //         child:Consumer<OptionProvider>(
// //           builder: (context, value, child) {
// //             return Container(
// //               alignment: Alignment.center,
// //               width: MediaQuery.of(context).size.width,
// //               height: MediaQuery.of(context).size.height,
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Spacer(flex: 1,),
// //                   Stack(
// //                     alignment: Alignment.center,
// //                     children:[
// //                       Container(
// //                         width: 80,
// //                         height: 80,
// //                         child: CircularProgressIndicator(
// //                           value: currentQuestion/totalQuestion!,
// //                           color: Colors.red,
// //                           strokeWidth: 15,
// //                           backgroundColor: Colors.blue,
// //                           strokeCap: StrokeCap.round,
// //                         ),
// //                       ),
// //                       Text("$currentQuestion/$totalQuestion",
// //                         style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily:GoogleFonts.robotoMono().fontFamily ),),
// //                     ] ,
// //                   ),
// //                   Spacer(flex: 1,),
// //                   Card(
// //                     elevation: 5,
// //                     child: Container(
// //                       width: MediaQuery.of(context).size.width*0.93,
// //                       height: MediaQuery.of(context).size.height*0.66,
// //                       child:Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           // SizedBox(height: 30,),
// //                           Spacer(flex: 2,),
// //                           Padding(
// //                             padding: const EdgeInsets.only(left: 10,right: 10),
// //                             child:Text(question.toString(),style: TextStyle(fontSize: 25 ,fontFamily: GoogleFonts.roboto().fontFamily ,fontWeight: FontWeight.bold,),),
// //                           ),
// //                           Spacer(flex: 1,),
// //                           Container(
// //                             width: MediaQuery.of(context).size.width*0.93,
// //                             height: MediaQuery.of(context).size.height*0.35,
// //                             child:  ListView.builder(
// //                               itemCount: options.length,
// //                               // physics: NeverScrollableScrollPhysics(),
// //                               itemBuilder: (context, index) {
// //                                 return Padding(
// //                                   padding: const EdgeInsets.symmetric(horizontal:10,vertical: 11),
// //                                   child: GestureDetector(
// //                                     onTap: (){
// //                                       Provider.of<OptionProvider>(context ,listen: false).changeValue(index);
// //                                     },
// //                                     child: Container(
// //                                       width: MediaQuery.of(context).size.width*0.85,
// //                                       height: 50,
// //                                       alignment: Alignment.centerLeft,
// //                                       child: Padding(
// //                                         padding: const EdgeInsets.symmetric(horizontal: 12),
// //                                         child: Text(options[index],style: Theme.of(context).textTheme.displayMedium,),
// //                                       ),
// //                                       decoration: BoxDecoration(
// //                                           color:value.indexValue == index ?Colors.blue.withOpacity(1): Colors.white,
// //                                           borderRadius: BorderRadius.circular(12),
// //                                           boxShadow: [
// //                                             BoxShadow(
// //                                                 spreadRadius:2,
// //                                                 blurRadius: 7,
// //                                                 color:value.indexValue == index ?Colors.transparent: Colors.grey
// //                                             )
// //                                           ]
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 );
// //                               },
// //                             ),
// //                           ),
// //                           Spacer(flex: 2,),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(height: 16,),
// //                   SizedBox(
// //                     height: 40,
// //                     width: 200,
// //                     child: ElevatedButton(
// //                       onPressed: (){
// //                         if(value.indexValue == -1){
// //                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please select an option")));
// //                         }else if(currentQuestion < totalQuestion! - 1){
// //                           if(options[value.indexValue] == currectAnswer){
// //                             score+=1;
// //                           }
// //                           setState(() {
// //                             currentQuestion++;
// //                             Provider.of<OptionProvider>(context , listen: false).defaultValue();
// //                           });
// //                           print(score);
// //                         }else{
// //                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResuiltScreen(score: score, totalQuestion: totalQuestion!,),));
// //                         }
// //                       },
// //                       child: currentQuestion == 19?
// //                       Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white,fontFamily:GoogleFonts.poppins().fontFamily),)
// //                           :Text("Next",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white,fontFamily:GoogleFonts.poppins().fontFamily),),
// //                       style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colors.blue
// //                       ),
// //                     ),
// //                   ),
// //                   Spacer(flex: 4,),
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// // }
