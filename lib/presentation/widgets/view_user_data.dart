import 'package:blnk_mobile_task/presentation/screens/national_id_screen.dart';
import 'package:flutter/material.dart';

class ViewUserData extends StatelessWidget {
  final Map<String, dynamic> userProfile;
  const ViewUserData({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    bool nationalID = userProfile["title"] == "National ID";

    return Column(children: [
      Row(children: [
        Image.asset(userProfile["icon"]),
        const SizedBox(width: 10),
        Text(userProfile["title"],
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF777777))),
      ]),
      const SizedBox(height: 10),
      for (var value in userProfile["value"])
        Column(
          children: [
            GestureDetector(
              onTap: () {
                if (nationalID) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NationalIDScreen(
                                imagePath: value,
                              )));
                }
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2ECF7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: nationalID
                                ? Colors.blue
                                : const Color(0xFF333333),
                            decoration:
                                nationalID ? TextDecoration.underline : null,
                            decorationColor: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        )
    ]);
  }
}
