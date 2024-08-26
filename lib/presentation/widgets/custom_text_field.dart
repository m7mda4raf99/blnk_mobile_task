import 'package:blnk_mobile_task/services/email_validation.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Map<String, dynamic> field;
  const CustomTextField({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: field["type"],
      key: field["key"],
      focusNode: field["focusNode"],
      onTapOutside: (text) {
        field["focusNode"].unfocus();
      },
      controller: field["controller"],
      decoration: InputDecoration(
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 201, 26, 13),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE2E2EF)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFE2E2EF)),
        ),
        border: const OutlineInputBorder(),
        labelText: field["name"],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your ${field["name"].toString().toLowerCase()}';
        } else if (field["name"] == "Email" &&
            !EmailValidation.isValidEmail(value)) {
          return "Please enter a valid email.";
        }
        return null;
      },
      onChanged: (_) {
        field["key"].currentState!.validate();
      },
      onSaved: (_) {
        if (field["next"] != null) {
          field["next"]!.requestFocus();
        }
      },
      onFieldSubmitted: (_) {
        if (field["next"] != null) {
          field["next"]!.requestFocus();
        }
      },
    );
  }
}
