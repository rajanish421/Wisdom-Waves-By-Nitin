import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/Model/students_model.dart';

import '../../features/students/auth/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Students student;
  const ProfileScreen({super.key,required this.student});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Profile Header with Banner and Avatar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.indigo],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 45,
                  backgroundImage:AssetImage('assets/images/profile_default.png'), // Your profile image
                ),
                const SizedBox(height: 10),
                Text(
                  student.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "WW${student.userId}",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "class - ${student.std}",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          // Profile Info Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildProfileTile(Icons.phone, 'Phone', student.contact_number.toString()),
                _buildProfileTile(Icons.person, 'Father', student.father_name),
                _buildProfileTile(Icons.woman, 'Mother', student.mother_name,),
                _buildProfileTile(Icons.school, 'School', student.school_name),
                _buildProfileTile(Icons.group, 'Batch', student.batch),
                _buildProfileTile(Icons.language, 'Medium', student.medium),
                _buildProfileTile(Icons.calendar_today, 'Age', student.age.toString()),
                _buildProfileTile(Icons.person, 'Gender', student.gender),
                _buildProfileTile(Icons.location_on, 'Address', student.address),


                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    // Open a simple Settings Screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SettingsScreen(), // create this screen
                    //   ),
                    // );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildProfileTile(IconData icon, String title, String subtitle) {
  return ListTile(
    leading: Icon(icon, color: Colors.deepPurple),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(subtitle),
  );
}
