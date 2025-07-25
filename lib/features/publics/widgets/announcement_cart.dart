import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';

class AnnouncementCart extends StatelessWidget {
  final String title;
  final String subTitle;
   AnnouncementCart({super.key , required this.subTitle,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(),
      width: MediaQuery.of(context).size.width*0.95,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: 'Titan'),),
            SizedBox(height: 5,),
            Text(subTitle,style: TextStyle(color: Colors.white,fontSize: 18),),
          ],
        ),
      ),
    );
  }
}
