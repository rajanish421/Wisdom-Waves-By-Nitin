import 'package:flutter/material.dart';
class CoursesCard extends StatelessWidget {
  int lastIndex ;
  bool upComing ;

   CoursesCard({super.key , this.lastIndex = 4,this.upComing = false});
  static const List<Map<String, dynamic>> courses = [
    {
      'title': 'Mathematics',
      'icon': Icons.calculate,
      'class': "class -> 1st to 10th",
      'comingSoon': false,
    },
    {
      'title': 'Science',
      'icon': Icons.science,
      'class': "class -> 1st to 10th",
      'comingSoon': false,
    },
    {
      'title': 'English',
      'icon': Icons.language,
      'class': "class -> 1st to 10th",
      'comingSoon': false,
    },
    {
      'title': 'SST',
      'icon': Icons.public,
      'class': "class -> 1st to 10th",
      'comingSoon': false,
    },
    {
      'title': 'Mathematics',
      'icon': Icons.calculate,
      'class': "Class: 11th & 12th",
      'comingSoon': true,
    },
    {
      'title': 'Physics',
      'icon': Icons.flash_on,
      'class': "Class: 11th & 12th",
      'comingSoon': true,
    },
    {
      'title': 'Chemistry',
      'icon': Icons.bubble_chart,
      'class': "Class: 11th & 12th",
      'comingSoon': true,
    },
    {
      'title': 'Biology',
      'icon': Icons.biotech,
      'class': "Class: 11th & 12th",
      'comingSoon': true,
    },
  ];

  //
  // final upComingCourses = [
  //
  // ]

  @override
  Widget build(BuildContext context) {
    final filteredCourses = courses.where((course) {
      return upComing
          ? course['comingSoon'] == true
          : course['comingSoon'] != true;
    }).toList();
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 1,
      // mainAxisSpacing: 1,
      // crossAxisSpacing: 1,
      children: filteredCourses.map((course){
        return Card(
          color: Colors.white,
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(course['icon'] as IconData,size: 100,color: Colors.blue,),
              Text(course['title'] as String,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              Text(course['class'] as String,style: TextStyle(fontSize: 18,color: Colors.grey.shade800),),
            ],
          ),
        );
      }).toList(),
    );
  }
}
