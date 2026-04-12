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

    final cubit = context.read<ChatCubit>();

    cubit.loadMessages(widget.conversationId, widget.myId);

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

  Widget _myMessage(Message message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
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
    );
  }

  Widget _otherMessage(Message message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
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
              child: ClipOval(
                child: Image.network(
                  "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.person, color: Colors.grey, size: 16.r),
                ),
              ),
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
        title: const Text("Chat", style: TextStyle(color: Colors.black)),
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
                      Padding(
                        padding: const EdgeInsets.all(8),
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
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xff2B73F3)),
                  onPressed: _sendMessage,
                ),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    focusNode: focusNode,
                    onChanged: (value) {
                      context
                          .read<ChatCubit>()
                          .sendTyping(widget.conversationId);
                    },
                    decoration: const InputDecoration(
                      hintText: "اكتب رسالة",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Offstage(
            offstage: !isEmojiVisible,
            child: SizedBox(
              height: 250,
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