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
import 'package:wisdom_waves_by_nitin/Custom_Widget/toast_message.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';
import 'package:wisdom_waves_by_nitin/features/publics/services/message_services.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final String email = "wisdomwaves28091907@gmail.com";
  final String instagram = "https://www.instagram.com/wisdom_wavesofficial2005";
  final String facebook = "https://facebook.com/yourpage";
  final String youtube = "https://youtube.com/@wisdomwavesbynitin";
  final String mobile = "7081333178";
  final String whatsapp = "917081333178";

  // ✅ must include country code
  MessageServices messageServices = MessageServices();
  TextEditingController nameController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;

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

  final String mapUrl = "https://goo.gl/maps/7CKqX69QjEic6zuN6";

  void send() async {
    setState(() {
      isLoading = true;
    });
    await messageServices.sendMessage(
      nameController.text,
      messageController.text,
      context,
    );
    setState(() {
      isLoading = false;
      nameController.clear();
      messageController.clear();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    messageController.dispose();
  }

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
                child: Image.asset(
                  "assets/images/support_agent1.png",
                  fit: BoxFit.contain,
                ),
              ),
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
                subtitle:
                    "Sapaha , Sekhwaniya road , in front of Central Bank.",
                color: Colors.blue,
                onTap: () => _launchUrl(mapUrl),
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
                  socialIcon(
                    FontAwesomeIcons.facebook,
                    Colors.blue,
                    () {

                    },
                    // () => _launchUrl(facebook),
                  ),
                  const SizedBox(width: 20),
                  socialIcon(
                    FontAwesomeIcons.instagram,
                    Colors.purple,
                    () => _launchUrl(instagram),
                  ),
                  const SizedBox(width: 20),
                  socialIcon(
                    FontAwesomeIcons.youtube,
                    Colors.red,
                    () => _launchUrl(youtube),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // 📝 Message Form
              const Text(
                "Send Us a Message",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              textField(nameController, "Your Name"),
              const SizedBox(height: 12),
              textField(messageController, "Type your message...", maxLines: 4),
              const SizedBox(height: 15),
              CustomButton(
                isLoading: isLoading,
                text: "submit",
                onPressed: () {
                  // logic for ending message
                  if(nameController.text.trim().toString().isNotEmpty && messageController.text.trim().toString().isNotEmpty){
                    send();
                  }else{
                    ToastMessage.show(message: "Please enter name and message!");
                  }
                },

              ),
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
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
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

  Widget textField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 18,
        ),
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
