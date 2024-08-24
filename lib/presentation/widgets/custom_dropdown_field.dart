import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final Map<String, dynamic> field;
  const CustomDropdownField({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: field["controller"].text != '' ? field["controller"].text : null,
      key: field["key"],
      items: (field["items"] as List<String>).map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 201, 26, 13))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE2E2EF))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE2E2EF))),
        border: const OutlineInputBorder(),
        labelText: field["name"],
      ),
      onChanged: (String? newValue) {
        field["controller"].text = newValue!;
        field["key"].currentState?.validate();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your ${field["name"].toString().toLowerCase()}';
        }
        return null;
      },
    );
  }
}
