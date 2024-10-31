import 'dart:developer';

import 'package:fashion_ai/common/widgets/common_text_field.dart';
import 'package:fashion_ai/features/home/services/home_services.dart';
import 'package:fashion_ai/features/home/widgets/message_card.dart';
import 'package:fashion_ai/localdb/local_db.dart';
import 'package:fashion_ai/models/message.dart';
import 'package:fashion_ai/models/response.dart';
import 'package:fashion_ai/providers/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  bool isLoading = false;
  final TextEditingController queryController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Message> messages = [];
  List<RecommendedProducts> products = [];
  String error = '';
  HomeServices homeServices = HomeServices();
  List<String> userImage = [
    // "http://192.168.1.104:5000/uploads/1729706773175.jpg",
    // "http://192.168.1.104:5000/uploads/1729891570578.jpg",
    // "http://192.168.1.104:5000/uploads/1729893742308.jpg",
  ];
  String? data;
  String userName = 'itsgaurav355';

  @override
  void initState() {
    fetchAllMessages();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.getData();
      data = userProvider.data;
      products = userProvider.recommendedProducts;
      _scrollToBottom();

      // userImage = userProvider.reusableProducts;
    });
    super.initState();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  fetchAllMessages() async {
    setState(() {
      isLoading = true;
    });
    try {
      messages = await LocalDb.instance.getAllMessages();
    } catch (e) {
      error = e.toString();
    }
    setState(() {
      isLoading = false;
    });
  }

  askToAi() async {
    setState(() {
      isLoading = true;
    });
    products.clear();
    if (queryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a query.'),
        ),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    Message message = Message(
      query: queryController.text,
      answer: '',
      isQuestion: true,
      timestamp: DateTime.now(),
    );
    LocalDb.instance.insert(message);
    queryController.clear();
    var user = Provider.of<UserProvider>(context, listen: false);
    Response response =
        await homeServices.aiPost(userName, data.toString(), message.query);
    // products = response['recommended_products']
    //     .map<RecommendateProduct>(
    //         (product) => RecommendateProduct.fromJson(product))
    //     .toList();
    // var images = response['reusable_products'] as List;
    products = response.recommendedProducts ?? [];
    var images = response.reusableProducts ?? [];
    log(images.toString());
    // for (var image in images) {
    //   userImage.add(image['image_path']);
    // }
    user.setRecommendedProducts(products);
    user.setReusableProducts(userImage);
    Message res = Message(
      query: message.query,
      answer: response.answer ?? '',
      isQuestion: false,
      timestamp: DateTime.now(),
    );
    await LocalDb.instance.insert(res);
    await fetchAllMessages();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Fashion AI',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: fetchAllMessages)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  log(messages[index].toString());
                  return MessageCard(message: messages[index]);
                },
              ),
              if (userImage.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Reusable Products :",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: userImage.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                userImage[index],
                                fit: BoxFit.cover,
                                height: 100,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              if (products.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Recommendations :",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Image.network(
                                    "http://192.168.1.104:5000/${products[index].imagePath}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              if (isLoading)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LottieBuilder.asset(
                        height: 100,
                        'assets/images/loader.json',
                        animate: isLoading,
                        repeat: true,
                      ),
                    ),
                  ],
                )
              else if (error.isNotEmpty)
                Text(error)
              else
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    alignment: Alignment.center,
                    child: MyTextField(
                      isDisabled: isLoading,
                      borderRadius: 30,
                      textColor: Colors.white,
                      controller: queryController,
                      hintText: "How can I help you?",
                      suffixIcon: const Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                      onSuffixIconPressed: askToAi,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
