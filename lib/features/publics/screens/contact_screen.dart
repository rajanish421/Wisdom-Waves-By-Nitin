// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';
//
// import '../../../Custom_Widget/button.dart';
//


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wisdom_waves_by_nitin/Custom_Widget/button.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  final String email = "wisdomwaves28091907@gmail.com";
  final String instagram = "https://www.instagram.com/wisdom_wavesofficial2005";
  final String facebook = "https://facebook.com/yourpage";
  final String youtube = "https://youtube.com/@wisdomwavesbynitin";
  final String mobile = "7081333178";
  final String whatsapp = "918830387561"; // ✅ must include country code

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  Future<void> _openWhatsApp(String phone, String message) async {
    final encodedMessage = Uri.encodeComponent(message);
    final url = "https://wa.me/$phone?text=$encodedMessage";
    await _launchUrl(url);
  }

  final String message =
      "Hello Wisdom Waves Team,"
      "I am interested in taking admission at your institute."
      "Please share the admission process, fee structure, and available courses."
      "Thank you.";

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
              const SizedBox(height: 25),

              contactAction(
                icon: Icons.phone,
                title: "Call Us",
                subtitle: mobile,
                color: Colors.green,
                onTap: () => _launchUrl("tel:$mobile"),
              ),
              contactAction(
                icon: FontAwesomeIcons.whatsapp,
                title: "WhatsApp",
                subtitle: "Chat instantly",
                color: Colors.teal,
                onTap: () => _openWhatsApp(whatsapp, message),
              ),
              contactAction(
                icon: Icons.email,
                title: "Email",
                subtitle: email,
                color: Colors.red,
                onTap: () => _launchUrl("mailto:$email"),
              ),
              contactAction(
                icon: Icons.location_on,
                title: "Visit Us",
                subtitle: "Sapaha Road, Near Central Bank, Kushinagar UP , Wisdom Waves",
                color: Colors.blue,
                onTap: () => _launchUrl("https://maps.google.com/?q=Wisdom Waves Coaching"),
              ),

              const SizedBox(height: 25),

              const Text(
                "Follow Us",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialIcon(FontAwesomeIcons.facebook, Colors.blue, () => _launchUrl(facebook)),
                  const SizedBox(width: 20),
                  socialIcon(FontAwesomeIcons.instagram, Colors.purple, () => _launchUrl(instagram)),
                  const SizedBox(width: 20),
                  socialIcon(FontAwesomeIcons.youtube, Colors.red, () => _launchUrl(youtube)),
                ],
              ),

              const SizedBox(height: 30),

              // 📝 Message Form
              const Text(
                "Send Us a Message",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              textField("Your Name"),
              const SizedBox(height: 12),
              textField("Your Roll No."),
              const SizedBox(height: 12),
              textField("Type your message...", maxLines: 4),
              const SizedBox(height: 15),
              CustomButton(text: "submit", onPressed: (){
                // logic for ending message
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactAction({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget socialIcon(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }

  Widget textField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}









// class ContactScreen extends StatelessWidget {
//   const ContactScreen({super.key});
//
//
//   final String email = "wisdomwaves28091907@gmail.com";
//   final String instagram = "https://www.instagram.com/wisdom_wavesofficial2005?igsh=MTlmZnp3Nzl0aXMwYg==";
//   final String facebook = "https://facebook.com/yourpage";
//   final String youtube = "https://youtube.com/@wisdomwavesbynitin?si=daLAM5_GX4_HuBup";
//   final String mobile = "7081333178";
//
//   Future<void> _launchUrl(String url) async {
//     final Uri uri = Uri.parse(url);
//     if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//       throw Exception('Could not launch $url');
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//                SizedBox(
//                    height: 250,
//                    child: Image.asset("assets/images/support_agent1.png",fit: BoxFit.contain,)),
//               const Text(
//                 "Have Questions?",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const Text(
//                 "We’re Here to Help!",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "Feel free to reach out",
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//               const SizedBox(height: 30),
//
//               // Contact Info Boxes
//               contactBox(Icons.phone, mobile),
//               const SizedBox(height: 15),
//               contactBox(Icons.email, email),
//               const SizedBox(height: 15),
//               contactBox(Icons.location_on, "Wisdom Waves by Nitin Bhaiya, Near Center Bank Of India, Sapaha Road",
//                   trailing: Text(
//                     "Get Directions",
//                     style: TextStyle(color: Colors.blue),
//                   )),
//               const SizedBox(height: 20),
//
//               // Social Media Icons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: (){},
//                       child: FaIcon(FontAwesomeIcons.facebook, size: 28)),
//                   SizedBox(width: 20),
//                   GestureDetector(
//                       onTap: ()=>_launchUrl(instagram),
//                       child: FaIcon(FontAwesomeIcons.instagram, size: 28)),
//                   SizedBox(width: 20),
//                   GestureDetector(
//                       onTap: ()=>_launchUrl(youtube),
//                       child: FaIcon(FontAwesomeIcons.youtube, size: 28)),
//                   SizedBox(width: 20),
//                   GestureDetector(
//                       onTap: ()=>_launchUrl("mailto:$email"),
//                       child: FaIcon(FontAwesomeIcons.message, size: 28)),
//                 ],
//               ),
//               const SizedBox(height: 30),
//
//               // Name Field
//               textField("Your Name"),
//               const SizedBox(height: 15),
//
//               // Email Field
//               textField("Your roll n."),
//               const SizedBox(height: 15),
//
//               // Message Box
//               textField("Type your message...", maxLines: 4),
//               SizedBox(height: 10,),
//               CustomButton(onPressed: (){},text: "Submit",),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget contactBox(IconData icon, String text, {Widget? trailing}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.black),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Text(
//               text,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//           if (trailing != null) trailing,
//         ],
//       ),
//     );
//   }
//
//   Widget textField(String hint, {int maxLines = 1}) {
//     return TextField(
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         hintText: hint,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     );
//   }
// }
