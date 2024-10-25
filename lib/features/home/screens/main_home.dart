import 'dart:developer';

import 'package:fashion_ai/common/widgets/common_text_field.dart';
import 'package:fashion_ai/features/home/services/home_services.dart';
import 'package:fashion_ai/features/home/widgets/message_card.dart';
import 'package:fashion_ai/localdb/local_db.dart';
import 'package:fashion_ai/models/message.dart';
import 'package:fashion_ai/providers/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  bool isLoading = false;
  final TextEditingController queryController = TextEditingController();
  List<Message> messages = [];
  String error = '';
  HomeServices homeServices = HomeServices();
  String? data;
  String userName = 'itsgaurav355';
  @override
  void initState() {
    fetchAllMessages();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.getData();
      data = userProvider.data;
    });
    super.initState();
  }

  fetchAllMessages() async {
    setState(() {
      isLoading = true;
    });
    // Fetch all messages from the database
    LocalDb.instance.getAllMessages().then((value) {
      setState(() {
        messages = value;
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        error = error.toString();
        isLoading = false;
      });
    });
    // messages = await messageService.getAllMessages();
    setState(() {
      isLoading = false;
    });
  }

  askToAi() async {
    setState(() {
      isLoading = true;
    });
    //add to local db
    if (queryController.text.toString().isEmpty) {
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

    //add question to local db
    Message message = Message(
      query: queryController.text.toString(),
      answer: '',
      isQuestion: true,
      timestamp: DateTime.now(),
    );
    LocalDb.instance.insert(message);
    queryController.clear();

    // var response = await homeServices.aiPost("$data  ${message.query}");
    var response =
        await homeServices.aiPost(userName, "$data ${message.query}");

    //add to local db
    Message res = Message(
      query: queryController.text.toString(),
      answer: response.toString(),
      isQuestion: false,
      timestamp: DateTime.now(),
    );
    await LocalDb.instance.insert(res);
    await fetchAllMessages(); // Fetch all messages after insertion
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () {
                fetchAllMessages();
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: messages.length,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    log(messages[index].toString());
                    return MessageCard(message: messages[index]);
                  },
                ),
              ),
            ),
            isLoading
                ? const Center(
                    child: RepaintBoundary(child: CircularProgressIndicator()))
                : error.isNotEmpty
                    ? Text(error)
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          alignment: Alignment.center,
                          child: MyTextField(
                            controller: queryController,
                            hintText: "How can i help you sir?",
                            suffixIcon: const Icon(
                              Icons.send,
                              color: Colors.black,
                            ),
                            onSuffixIconPressed: () {
                              askToAi();
                            },
                          ),
                        ))
          ],
        ),
      ),
    );
  }
}
