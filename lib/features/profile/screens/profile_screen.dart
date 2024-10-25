import 'dart:developer';
import 'dart:io';

import 'package:fashion_ai/common/widgets/common_button.dart';
import 'package:fashion_ai/common/widgets/utils.dart';
import 'package:fashion_ai/providers/user_provider.dart';
import 'package:fashion_ai/features/profile/widgets/user_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserHeader(),
            const SizedBox(height: 10),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mood_rounded),
                    SizedBox(width: 10),
                    Text(
                      'Upload your memories',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: CommonButton(
                    title: "Add Photos",
                    textColor: Colors.white,
                    buttonColor: Colors.black,
                    onPressed: () async {
                      var res = await Utils.pickImages();
                      if (res.isNotEmpty && context.mounted) {
                        userProvider.uploadImages(res); // Upload and notify
                      } else {
                        log("No image selected");
                      }
                    },
                    borderRadius: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Display images in a GridView if images exist
            userProvider.images.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: userProvider.images.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemBuilder: (context, index) {
                        // Use Image.file to display the image from the file path
                        return InkWell(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete Image'),
                                  content: const Text(
                                      'Are you sure you want to delete this image?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await Utils.deleteImage(
                                            userProvider.images[index]);
                                        userProvider.getData();
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                            // await Utils.deleteImage(userProvider.images[index]);
                            // userProvider.getData();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.file(
                              File(
                                userProvider.images[index],
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Expanded(
                    child: Center(child: Text('No images uploaded yet'))),
          ],
        ),
      ),
    );
  }
}
