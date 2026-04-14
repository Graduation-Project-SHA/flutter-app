import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../cubit/chat_cubit.dart';
import '../../cubit/chat_state.dart';
import '../../presentation/data/models/message_model.dart';

class ChatDetailsScreen extends StatefulWidget {
  final String myId;
  final String conversationId;
  final String targetUserId;

  const ChatDetailsScreen({
    super.key,
    required this.myId,
    required this.conversationId,
    required this.targetUserId,
  });

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController messageController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  bool isEmojiVisible = false;

  @override
  void initState() {
    super.initState();
    context
        .read<ChatCubit>()
        .loadMessages(widget.conversationId, widget.myId);
  }

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
    if (messageController.text.trim().isEmpty) return;

    context.read<ChatCubit>().sendMessage(
      conversationId: widget.conversationId,
      senderId: widget.myId,
      targetUserId: widget.targetUserId,
      text: messageController.text.trim(),
    );

    messageController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
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

  Widget _buildTime(Message message, bool isMe) {
    final timeFormat = DateFormat('hh:mm');
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Text(
        timeFormat.format(message.createdAt),
        style: TextStyle(fontSize: 12.sp, color: Colors.black54),
      ),
    );
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
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),

              _AttachmentOption(
                icon: Icons.camera_alt,
                label: "كاميرا",
                onTap: () => Navigator.pop(context),
              ),

              _AttachmentOption(
                icon: Icons.photo_library,
                label: "صور/فيديو",
                onTap: () => Navigator.pop(context),
              ),

              _AttachmentOption(
                icon: Icons.folder,
                label: "مستند",
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
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
              _buildTime(message, true),
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
                  _buildTime(message, false),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            CircleAvatar(
              radius: 16.r,
              backgroundColor: Colors.grey.shade200,
              child: Icon(Icons.person, color: Colors.grey, size: 20.r),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.phone, color: Color(0xff2B73F3)),
          onPressed: () {},
        ),
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                _scrollToBottom();
              },
              builder: (context, state) {
                final cubit = context.watch<ChatCubit>();
                final messages = cubit.messages;

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(16),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isMe = message.senderId == widget.myId;

                          return isMe
                              ? _myMessage(message)
                              : _otherMessage(message);
                        },
                      ),
                    ),
                    if (state is ChatTypingState && state.isTyping)
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Typing...",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),


          Container(
            padding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    focusNode: focusNode,
                    textAlign: TextAlign.right,
                    onTap: () {
                      if (isEmojiVisible) {
                        setState(() => isEmojiVisible = false);
                      }
                    },
                    onChanged: (value) {
                      context
                          .read<ChatCubit>()
                          .sendTyping(widget.conversationId);
                    },
                    decoration: InputDecoration(
                      hintText: "اكتب رسالة",
                      hintStyle: TextStyle(
                          color: const Color(0xffC7C7CC),
                          fontSize: 14.sp),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: InkWell(
                        onTap: toggleEmojiKeyboard,
                        child: const Icon(Icons.emoji_emotions,
                            color: Color(0xffC7C7CC)),
                      ),
                      suffixIcon: InkWell(
                        onTap: _showAttachmentOptions,
                        child: const Icon(Icons.attach_file,
                            color: Color(0xffC7C7CC)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                            color: Color(0xffC7C7CC)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                            color: Color(0xffC7C7CC)),
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
                textEditingController: messageController,
                config: Config(
                  emojiViewConfig: EmojiViewConfig(
                    emojiSizeMax: 20 *
                        (foundation.defaultTargetPlatform ==
                            TargetPlatform.android
                            ? 1.2
                            : 1.0),
                  ),
                ),
              ),
            ),
          ),
        ],
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
            Text(label, style: TextStyle(fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }
}