import 'package:fashion_ai/common/widgets/common_button.dart';
import 'package:fashion_ai/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userController, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black,
                      child: Text(
                        userController.name[0].toUpperCase().toString(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userController.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey,
                            ),
                            Text(
                              userController.location,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: CommonButton(
                        title: "Edit Profile",
                        fontSize: 12,
                        textColor: Colors.black,
                        buttonColor: Colors.grey,
                        onPressed: () {},
                        borderRadius: 10,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: CommonButton(
                        title: "View Instagram",
                        textColor: Colors.white,
                        buttonColor: Colors.black,
                        fontSize: 12,
                        onPressed: () {
                          launchUrl(Uri.parse(
                              "https://www.linkedin.com/in/gaurav-prajapati-85686728b/"));
                        },
                        borderRadius: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
