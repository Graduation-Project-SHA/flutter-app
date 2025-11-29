import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../shared/component/customAppbarButton/custom_app_bar_button.dart';


class Message {
  final String text;
  final DateTime time;
  final bool isMe;
  final bool isDelivered;

  Message({
    required this.text,
    required this.time,
    required this.isMe,
    this.isDelivered = true,
  });
}

class DoctorChatDetailsScreen extends StatefulWidget {
  const DoctorChatDetailsScreen({super.key});

  @override
  State<DoctorChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<DoctorChatDetailsScreen> {
  final TextEditingController messageController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isEmojiVisible = false;

  final List<Message> _messages = [
    Message(
      text: "ارتاح شوية الأول، متضغطش على جسمك زيادة. عشان لو فضلت تِجهد نفسك، حالتك هتسوء أكتر وهيأثر على كل حاجة حواليك.",
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      isMe: true,
      isDelivered: true,
    ),
    Message(
      text: "ارتاح شوية الأول، متضغطش على جسمك زيادة. عشان لو فضلت تِجهد نفسك، حالتك هتسوء أكتر وهيأثر على كل حاجة حواليك.",
      time: DateTime.now().subtract(const Duration(minutes: 4)),
      isMe: false,
      isDelivered: true,
    ),
    Message(
      text: "ارتاح شوية الأول، متضغطش على جسمك زيادة. عشان لو فضلت تِجهد نفسك، حالتك هتسوء أكتر وهيأثر على كل حاجة حواليك.؟",
      time: DateTime.now().subtract(const Duration(minutes: 3)),
      isMe: false,
      isDelivered: true,
    ),
    Message(
      text: "ارتاح شوية الأول، متضغطش على جسمك زيادة. عشان لو فضلت تِجهد نفسك، حالتك هتسوء أكتر وهيأثر على كل حاجة حواليك.",
      time: DateTime.now().subtract(const Duration(minutes: 2)),
      isMe: true,
      isDelivered: true,
    ),
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    messageController.dispose();
    focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      final newMessage = Message(
        text: messageController.text.trim(),
        time: DateTime.now(),
        isMe: true,
        isDelivered: false,
      );

      setState(() {
        _messages.add(newMessage);
        messageController.clear();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void toggleEmojiKeyboard() {
    setState(() {
      if (!isEmojiVisible) {
        focusNode.unfocus();
        isEmojiVisible = true;
      } else {
        focusNode.requestFocus();
        isEmojiVisible = false;
      }
    });
  }

  void _showAttachmentOptions() {
    if (isEmojiVisible) {
      setState(() {
        isEmojiVisible = false;
        focusNode.requestFocus();
      });
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          height: 280.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "اختر نوع المرفق",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              _AttachmentOption(
                icon: Icons.camera_alt,
                label: "كاميرا",
                onTap: () {
                  Navigator.pop(context);
                  print("Camera selected");
                },
              ),
              _AttachmentOption(
                icon: Icons.photo_library,
                label: "صور/فيديو",
                onTap: () {
                  Navigator.pop(context);
                  print("Gallery selected");
                },
              ),
              _AttachmentOption(
                icon: Icons.folder,
                label: "مستند",
                onTap: () {
                  Navigator.pop(context);
                  print("Document selected");
                },
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildTimeAndStatus(Message message) {

    final timeFormat = DateFormat('hh:mm');

    Widget statusIcon;
    if (message.isMe) {
      statusIcon = Icon(
        message.isDelivered ? Icons.done_all : Icons.done,
        size: 14.sp,
        color: message.isDelivered ? Color(0xFF12B76A) : Colors.grey,
      );
    } else {
      statusIcon = const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(top: 4.h, right: message.isMe ? 0 : 8.w, left: message.isMe ? 8.w : 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          statusIcon,
          SizedBox(width: 4.w),
          Text(
            timeFormat.format(message.time),
            style: TextStyle(
              fontSize: 12.sp,
              color: message.isMe ? Colors.black54 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _myMessage(Message message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xff2B73F3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(4.r),
                  ),
                ),
                child: Text(
                  message.text,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.right,
                ),
              ),
              _buildTimeAndStatus(message),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otherMessage(Message message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                        bottomLeft: Radius.circular(4.r),
                      ),
                    ),
                    child: Text(
                      message.text,
                      style: const TextStyle(color: Colors.black),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  _buildTimeAndStatus(message),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            CircleAvatar(
              radius: 16.r,
              backgroundColor: Colors.grey.shade400,
              backgroundImage: AssetImage("assets/images/doctor.png"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,

        leading:  IconButton(
          icon: Icon(Icons.phone, color: const Color(0xff2B73F3)),
          onPressed: (){},
        ),
        title: const Text(
          "د. محمد حربي",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          CustomAppBarBtn()
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (isEmojiVisible) {
            setState(() => isEmojiVisible = false);
            return false;
          }
          return true;
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  if (message.isMe) {
                    return _myMessage(message);
                  } else {
                    return _otherMessage(message);
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: const Color(0xff2B73F3),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: _sendMessage,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      controller: messageController,
                      textAlign: TextAlign.right,
                      onTap: () {
                        if (isEmojiVisible) {
                          setState(() => isEmojiVisible = false);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "اكتب رسالة",
                        hintStyle: TextStyle(color: const Color(0xffC7C7CC), fontSize: 14.sp),
                        filled: true,
                        fillColor: Colors.white,

                        prefixIcon: InkWell(
                          onTap: toggleEmojiKeyboard,
                          borderRadius: BorderRadius.circular(24.r),
                          child: Icon(
                            Icons.sentiment_satisfied_alt,
                            color: const Color(0xffC7C7CC),
                            size: 24.sp,
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: _showAttachmentOptions,
                          borderRadius: BorderRadius.circular(24.r),
                          child: Icon(
                            Icons.attach_file,
                            color: const Color(0xffC7C7CC),
                            size: 24.sp,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                              color: Color(0xffC7C7CC), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                              color: Color(0xffC7C7CC), width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                              color: Color(0xffC7C7CC), width: 1.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Offstage(
              offstage: !isEmojiVisible,
              child: SizedBox(
                height: 250.h,
                child: EmojiPicker(
                  onBackspacePressed: () {
                    messageController.text = messageController.text.characters.skipLast(1).toString();
                  },
                  textEditingController: messageController,
                  config: Config(
                    checkPlatformCompatibility: true,
                    emojiViewConfig: EmojiViewConfig(
                      emojiSizeMax: 20 *
                          (foundation.defaultTargetPlatform == TargetPlatform.android
                              ?  1.20
                              :  1.0),
                    ),
                    categoryViewConfig: CategoryViewConfig(
                      initCategory: Category.RECENT,
                      backgroundColor: const Color(0xFFF2F2F2),
                      indicatorColor: const Color(0xff2B73F3),
                      iconColor: Colors.grey,
                      iconColorSelected: const Color(0xff2B73F3),
                      backspaceColor: const Color(0xff2B73F3),
                    ),
                    skinToneConfig: const SkinToneConfig(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AttachmentOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xff2B73F3)),
            SizedBox(width: 12.w),
            Text(
              label,
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}