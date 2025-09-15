import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopperCarousel extends StatelessWidget {
   TopperCarousel({super.key});
  final List<String> topperImages = [
    'assets/images/topper1.jpeg',
    'assets/images/topper2.jpeg',
    'assets/images/topper3.jpeg',
    'assets/images/topper4.jpeg',
    // Add more images as needed
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          height: 200,
          viewportFraction: 0.5,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 2),
        ), items: topperImages.map((imagePath) {
      return Builder(builder: (context) {
        return Container(
          // width: double.infinity,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.red,
            image: DecorationImage(image: AssetImage(imagePath),fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(2, 4),
              ),
            ],
          ),
          // child: Image.asset(imagePath,fit: BoxFit.cover,width: double.infinity,),
        );
      },);
    },).toList());
  }
}
