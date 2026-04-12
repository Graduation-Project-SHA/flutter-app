import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../cubit/chat_cubit.dart';
import '../../cubit/chat_state.dart';
import 'chat_details_screen.dart';

class MessagesScreen extends StatefulWidget {
  final String myId;

  const MessagesScreen({super.key, required this.myId});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    super.initState();

    final cubit = context.read<ChatCubit>();
    cubit.loadConversations();

  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          final cubit = context.watch<ChatCubit>();

          if (state is! ChatConversationsLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final conversations = state.conversations;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: const Color(0xff4786F5),
                elevation: 0,
                expandedHeight: 200.h,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff4786F5),
                          Color(0xff2B73F3),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: topPadding + 20.h),
                      child: Center(
                        child: Text(
                          "الرسائل",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              SliverToBoxAdapter(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight:
                    MediaQuery.of(context).size.height - 200.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: conversations.length,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade100,
                      indent: 80.w,
                      endIndent: 20.w,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final conv = conversations[index];

                      bool isOnline = cubit.onlineUsers
                          .contains(conv.targetUserId);

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatDetailsScreen(
                                myId: widget.myId,
                                conversationId: conv.id,
                                targetUserId: conv.targetUserId,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 12.h),
                          child: Row(
                            children: [

                              Column(
                                children: [

                                  Text(
                                    conv.lastMessageAt != null
                                        ? DateFormat('hh:mm a').format(conv.lastMessageAt!)
                                        : "_",
                                    style: TextStyle(fontSize: 12.sp, color: const Color(0xff8A8A8E)),
                                  ),
                                  SizedBox(height: 5.h),
                                ],
                              ),

                              SizedBox(width: 12.w),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      conv.name,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      conv.lastMessage.isEmpty
                                          ? "ابدأ المحادثة..."
                                          : conv.lastMessage,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color:
                                        const Color(0xff8A8A8E),
                                      ),
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),

                                    SizedBox(height: 4.h),


                                    Text(
                                      isOnline
                                          ? "Online🟢 "
                                          : "Offline⚫ ",
                                      style:
                                      TextStyle(fontSize: 11.sp),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 16.w),
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 28.r,
                                    backgroundColor: Colors.grey.shade200,
                                    child: ClipOval(
                                      child: Image.network(
                                        (conv.image != null && conv.image!.isNotEmpty)
                                            ? "http://api.wiqaya.duckdns.org${conv.image!.startsWith('/') ? '' : '/'}${conv.image}"
                                            : "",
                                        fit: BoxFit.cover,
                                        width: 56.r,
                                        height: 56.r,
                                        errorBuilder: (context, error, stackTrace) => Icon(Icons.person, color: Colors.grey, size: 28.r),
                                      ),
                                    ),
                                  ),
                                  if (isOnline)
                                    Positioned(
                                      right: 2,
                                      bottom: 2,
                                      child: Container(
                                        width: 14,
                                        height: 14,
                                        decoration:
                                        BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: bottomPadding + 20.h),
              ),
            ],
          );
        },
      ),
    );
  }
}