import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/components/reusable_text.dart';

import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../components/app_bar_chat.dart';
import '../../components/reusable_text_long.dart';

class SinglePeopleChatPage extends StatefulWidget {
  const SinglePeopleChatPage({super.key});

  @override
  State<SinglePeopleChatPage> createState() => _SinglePeopleChatPageState();
}

class _SinglePeopleChatPageState extends State<SinglePeopleChatPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: ChatAppBar(),
      backgroundColor: Colors.black,
      body: Column(children: [
        Expanded(
          child: Center(
              child: ReusableText(
                  text: "No message found",
                  style: appstyle(14, Color(0xffEC4899), FontWeight.w400))),
        ),
        _chatInput(),
      ]),
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
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Send message..",
                hintStyle: appstyle(14, Color(0xFFAB55F7), FontWeight.w400),
                border: InputBorder.none,
              ),
            )),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                color: Color(0xffEC4899),
                size: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.emoji_emotions,
                color: Color(0xffEC4899),
                size: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.camera_alt_rounded,
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
