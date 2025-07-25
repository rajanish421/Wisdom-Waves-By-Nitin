import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';

import '../../../Custom_Widget/button.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               SizedBox(
                   height: 250,
                   child: Image.asset("assets/images/support_agent1.png",fit: BoxFit.contain,)),
              const Text(
                "Have Questions?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                "We’re Here to Help!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Feel free to reach out",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // Contact Info Boxes
              contactBox(Icons.phone, "7081333178"),
              const SizedBox(height: 15),
              contactBox(Icons.email, "support@smartclass.com"),
              const SizedBox(height: 15),
              contactBox(Icons.location_on, "Wisdom Waves by Nitin Bhaiya, Near Center Bank Of India, Sapaha Road",
                  trailing: Text(
                    "Get Directions",
                    style: TextStyle(color: Colors.blue),
                  )),
              const SizedBox(height: 20),

              // Social Media Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FaIcon(FontAwesomeIcons.facebook, size: 28),
                  SizedBox(width: 20),
                  FaIcon(FontAwesomeIcons.instagram, size: 28),
                  SizedBox(width: 20),
                  FaIcon(FontAwesomeIcons.youtube, size: 28),
                  SizedBox(width: 20),
                  FaIcon(FontAwesomeIcons.message, size: 28),
                ],
              ),
              const SizedBox(height: 30),

              // Name Field
              textField("Your Name"),
              const SizedBox(height: 15),

              // Email Field
              textField("Your roll n."),
              const SizedBox(height: 15),

              // Message Box
              textField("Type your message...", maxLines: 4),
              SizedBox(height: 10,),
              CustomButton(onPressed: (){},text: "Submit",),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactBox(IconData icon, String text, {Widget? trailing}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget textField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
