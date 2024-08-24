import 'package:blnk_mobile_task/utils/image_constant.dart';
import 'package:flutter/material.dart';

class RegistrationCompleteScreen extends StatelessWidget {
  const RegistrationCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset(ImageConstant.registrationCompleted),
                      const SizedBox(height: 30),
                      const Text(
                        "Registration Complete",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF333333)),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Congratulations! You have successfully completed the registration process. Your profile is now set up, and now you can start exploring all  features and benefits we offer",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF777777)),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration');
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 12),
                        backgroundColor: const Color(0xFF217FEB),
                        foregroundColor: Colors.white),
                    child: const Text('Register another user'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
