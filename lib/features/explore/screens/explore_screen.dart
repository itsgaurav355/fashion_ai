import 'package:fashion_ai/features/explore/widgets/styler_tile.dart';
import 'package:fashion_ai/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Explore',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<UserProvider>(builder: (context, value, child) {
        return ListView.builder(
            itemCount: value.stylists.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return StylerTile(stylist: value.stylists[index]);
            });
      }),
    );
  }
}
