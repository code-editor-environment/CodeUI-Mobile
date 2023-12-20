import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/components/reusable_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/models/response/functionals/profile_res_model.dart';
import '../../common/models/response/functionals/view_profile_res_model.dart';
import '../../components/app_bar_chat.dart';
import '../../components/reusable_text_long.dart';
import '../../services/helpers/profile_helper.dart';

class SinglePeopleChatPage extends StatefulWidget {
  const SinglePeopleChatPage({super.key});

  @override
  State<SinglePeopleChatPage> createState() => _SinglePeopleChatPageState();
}

class _SinglePeopleChatPageState extends State<SinglePeopleChatPage> {
  // ... Other code remains unchanged
  String? chatviewId;
  String? senderId;
  String? recieverId;
  final ScrollController _scrollController = ScrollController();

  TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var _currentLoggedInUsername =
          prefs.getString("currentLoggedInUsername")!;
      var accountIdToBeViewedInElements =
          prefs.getString("accountIdToBeViewed");
      var accountIdToViewNotifications = prefs.getString("accountId");
      var chatViewId1 = prefs.getString("chatViewId");
      var senderId1 = prefs.getString("senderId");
      var recieverId1 = prefs.getString("recieverId");
      print("ChatView Id:$chatViewId1");
      print("Sender Id:$senderId1");
      print("Reciever Id:$recieverId1");
      print(_currentLoggedInUsername);
      print("Notification check: $accountIdToViewNotifications");
      setState(() {
        chatviewId = chatViewId1;
        senderId = senderId1;
        recieverId = recieverId1;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print("1.${chatviewId}2.${senderId}3.${recieverId}");
    return Scaffold(
      appBar: ChatAppBar(),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Container(
        height: height,
        child: Stack(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc("$chatviewId")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No data available'));
                  } else {
                    var document = snapshot.data;
                    if (document!.exists) {
                      var messages = snapshot.data!.data()?['messages'];
                      print(snapshot.data!.data());
                      if (messages != null && messages.isNotEmpty) {
                        WidgetsBinding.instance?.addPostFrameCallback((_) {
                          final bottomItems =
                              0.25; // adjust this value to your needs
                          final scrollPosition =
                              _scrollController.position.maxScrollExtent * 2 -
                                  _scrollController.position.viewportDimension *
                                      bottomItems;
                          _scrollController.animateTo(
                            scrollPosition,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                          );
                        });
                        return Container(
                          height: height * 0.75,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              var message = messages[index];
                              var senderID = message['senderID'];
                              var messageText = message['text'];

                              Timestamp timestamp = message['date'];
                              DateTime messageDate = timestamp.toDate();

                              String formattedDate(DateTime dateTime) {
                                return DateFormat('MMM d, y h:mm:ss a')
                                    .format(dateTime.toLocal());
                              }

                              String calculateTimeAgo(DateTime date) {
                                Duration difference =
                                    DateTime.now().difference(date);

                                if (difference.inDays > 0) {
                                  return '${difference.inDays} days ago';
                                } else if (difference.inHours > 0) {
                                  return '${difference.inHours} hours ago';
                                } else if (difference.inMinutes > 0) {
                                  return '${difference.inMinutes} minutes ago';
                                } else {
                                  return '${difference.inSeconds} seconds ago';
                                }
                              }

                              // Check senderID and return appropriate Container
                              if (senderID == '${senderId}') {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                          vertical: 10.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Colors.blue,
                                        ),
                                        child: Text(
                                          messageText,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      calculateTimeAgo(messageDate),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              if (senderID == '${recieverId}') {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 10.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Colors.grey,
                                        ),
                                        child: Text(
                                          messageText,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      calculateTimeAgo(messageDate),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                // Default container if senderID doesn't match predefined IDs
                                return Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    messageText,
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      } else {
                        return Center(child: Text('No messages available'));
                      }
                    } else {
                      return Center(child: Text('Document does not exist'));
                    }
                  }
                }
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _chatInput(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatInput() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.camera_alt_rounded,
                color: Color(0xffEC4899),
                size: 20,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Send message..",
                  // ... Your input decoration
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                // Get the message text from the input field
                String messageText = _messageController
                    .text; // Replace _messageController with your TextField controller
                String id = Uuid().v4();
                String id1 = Uuid().v4();
                String id2 = Uuid().v4();
                String id3 = id2 + senderId!;
                String id4 = id1 + recieverId!;
                print("ID sender whatever it is :$id");
                if (messageText.isNotEmpty) {
                  // Create a new message object with necessary fields
                  Map<String, dynamic> newMessage = {
                    'senderID': senderId,
                    'id': id, // Assuming senderId is already retrieved
                    'text': messageText,
                    'date': Timestamp
                        .now(), // Timestamp of the current date and time
                  };
                  // Map<String, dynamic> lastMessage = {
                  //   'lastmessage': {'text': messageText},
                  //   'date': Timestamp
                  //       .now(), // Timestamp of the current date and time
                  // };

                  try {
                    // Add the new message to Firestore under 'messages' array in the specified document
                    await FirebaseFirestore.instance
                        .collection('chats')
                        .doc("$chatviewId")
                        .update({
                      'messages': FieldValue.arrayUnion([newMessage])
                    });

                    // Clear the input field after sending the message
                    _messageController
                        .clear(); // Replace _messageController with your TextField controller
                  } catch (e) {
                    print('Error sending message: $e');
                    // Handle the error accordingly (e.g., show a snackbar or dialog)
                  }
                  // try {
                  //   // Add the new message to Firestore under 'messages' array in the specified document
                  //   await FirebaseFirestore.instance
                  //       .collection('userChats')
                  //       .doc("$senderId")
                  //       .update({
                  //     '$id3': FieldValue.arrayUnion([lastMessage])
                  //   });

                  //   // Clear the input field after sending the message
                  //   _messageController
                  //       .clear(); // Replace _messageController with your TextField controller
                  // } catch (e) {
                  //   print('Error sending message: $e');
                  //   // Handle the error accordingly (e.g., show a snackbar or dialog)
                  // }
                  // try {
                  //   // Add the new message to Firestore under 'messages' array in the specified document
                  //   await FirebaseFirestore.instance
                  //       .collection('userChats')
                  //       .doc("$recieverId")
                  //       .update({
                  //     '$id4': FieldValue.arrayUnion([lastMessage])
                  //   });

                  //   // Clear the input field after sending the message
                  //   _messageController
                  //       .clear(); // Replace _messageController with your TextField controller
                  // } catch (e) {
                  //   print('Error sending message: $e');
                  //   // Handle the error accordingly (e.g., show a snackbar or dialog)
                  // }
                }
              },
              icon: Icon(
                Icons.send,
                color: Color(0xffEC4899),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
