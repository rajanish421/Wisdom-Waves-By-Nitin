import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';

import '../../publics/widgets/icon_info_card.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});

  final List<String> bannerList = [
    "assets/images/banner1.jpeg",
    "assets/images/banner2.jpeg",
    "assets/images/banner3.jpeg",
  ];
  final List<String> facultyList = [
    "assets/images/banner1.jpeg",
    "assets/images/banner2.jpeg",
    "assets/images/banner3.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/images/logo1.png"),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Text(
                      "Empowering Students...",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Your Success is Our Goal!",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: 210,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
              ),
              items:
                  bannerList.map((imagePath) {
                    return Builder(
                      builder: (context) {
                        return Container(
                          // width: double.infinity,
                          // margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.cover,
                            ),
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
                      },
                    );
                  }).toList(),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "About Our Coaching",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("At Wisdom Waves Coaching, we don't just teach—we transform futures. With expert faculty, personalized attention, and a results-driven approach, we help students unlock their full potential and achieve academic excellence"),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Our Faculty",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: facultyList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.95,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(facultyList[index]),fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
              },),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconInfoCard(
                  icon: Icons.track_changes,
                  title: "Mission",
                  description: "To empower students with quality education.",
                  color: Colors.deepPurple,
                ),
                const IconInfoCard(
                  icon: Icons.remove_red_eye,
                  title: "Vision",
                  description: "To be India’s most trusted platform.",
                  color: Colors.indigo,
                ),
                const IconInfoCard(
                  icon: Icons.lightbulb,
                  title: "Values",
                  description: "Integrity, innovation, and care.",
                  color: Colors.orange,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
