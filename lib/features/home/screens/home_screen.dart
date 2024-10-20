import 'package:fashion_ai/controllers/user_controller.dart';
import 'package:fashion_ai/features/home/services/home_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  var response;
  String error = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading = true;
      });
      var userController = Provider.of<UserController>(context, listen: false);

      try {
        response = await HomeServices().getAdvice({
          "name": userController.name,
          "age": userController.age,
          "gender": userController.gender,
          "location": userController.location,
          "preferredStyle": userController.preferredStyle,
          "color": userController.color.toString(),
          "pattern": userController.pattern,
          "size": userController.size,
          "brand": userController.brand,
          "budget": userController.budget,
        });
      } catch (e) {
        setState(() {
          error = 'Failed to fetch data. Please try again later.';
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    var userController = Provider.of<UserController>(context, listen: false);

    try {
      response = await HomeServices().getAdvice({
        "name": userController.name,
        "age": userController.age,
        "gender": userController.gender,
        "location": userController.location,
        "preferredStyle": userController.preferredStyle,
        "color": userController.color.toString(),
        "pattern": userController.pattern,
        "size": userController.size,
        "brand": userController.brand,
        "budget": userController.budget,
        "category": userController.category,
        "product": userController.product,
      });
      error = '';
    } catch (e) {
      setState(() {
        error = 'Failed to fetch data. Please try again later.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                fetchData();
              })
        ],
      ),
      body: isLoading
          ? const Center(
              child:
                  RepaintBoundary(child: CircularProgressIndicator.adaptive()),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  error.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                          ),
                        )
                      : Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.height,
                          child: response != null && response['answer'] != null
                              ? Markdown(
                                  data: response['answer'].toString(),
                                  styleSheet: MarkdownStyleSheet(
                                    h1: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                    p: const TextStyle(
                                        fontSize: 16, height: 1.5),
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'No data available.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                        ),
                ],
              ),
            ),
    );
  }
}
