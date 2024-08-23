import 'package:flutter/material.dart';

class RegistrationStepper1 extends StatefulWidget {
  const RegistrationStepper1({super.key});

  @override
  State<RegistrationStepper1> createState() => _RegistrationStepper1State();
}

class _RegistrationStepper1State extends State<RegistrationStepper1> {
  List<Map<String, dynamic>> textFormFields = [
    {
      "name": "First Name",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>()
    },
    {
      "name": "Last Name",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>()
    },
    {
      "name": "Mobile Number",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>()
    },
    {
      "name": "Landline",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>()
    },
    {
      "name": "Email",
      "controller": TextEditingController(),
      "focusNode": FocusNode(),
      "key": GlobalKey<FormFieldState>()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Welcome! Let's get started by gathering some basic information about you. Please fill out the following fields.",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF777777),
              ),
            ),
            const SizedBox(height: 20),
            for (var textFormField in textFormFields)
              Column(
                children: [
                  TextFormField(
                    key: textFormField["key"],
                    focusNode: textFormField["focusNode"],
                    onTapOutside: (text) {
                      textFormField["focusNode"].unfocus();
                    },
                    controller: textFormField["controller"],
                    decoration: InputDecoration(
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 201, 26, 13))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE2E2EF))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE2E2EF))),
                      border: const OutlineInputBorder(),
                      labelText: textFormField["name"],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your ${textFormField["name"].toString().toLowerCase()}';
                      } else if (textFormField["name"] == "Email" &&
                          !isValidEmail(value)) {
                        return "Please enter a valid email.";
                      }
                      return null;
                    },
                    onChanged: (_) {
                      textFormField["key"].currentState!.validate();
                    },
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (textFormFields.every(
                    (element) => element["key"].currentState!.validate())) {
                  _submitForm();
                }
              },
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                  backgroundColor: const Color(0xFF217FEB),
                  foregroundColor: Colors.white),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$',
      caseSensitive: false,
      multiLine: false,
    );

    return emailRegex.hasMatch(email);
  }

  void _submitForm() async {
    // Add the Google Sheets and Drive integration here
  }
}
