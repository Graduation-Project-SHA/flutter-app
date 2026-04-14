import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../shared/component/searchField/search_field.dart';
import '../../cubit/chat_cubit.dart';
import '../../cubit/chat_state.dart';
import '../data/models/conversation_model.dart';
import 'chat_details_screen.dart';

class MessagesScreen extends StatefulWidget {
  final String myId;

  const MessagesScreen({super.key, required this.myId});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  final TextEditingController searchController = TextEditingController();
  List<Conversation> filteredConversations = [];

  @override
  void initState() {
    super.initState();

    context.read<ChatCubit>().loadConversations();


  }

  void _filterConversations(String query, List<Conversation> allConversations) {
    setState(() {
      filteredConversations = allConversations
          .where((conv) => conv.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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

          final allConversations = state.conversations;


          if (searchController.text.isEmpty) {
            filteredConversations = allConversations;
          }

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
                          Color(0xff3077F3),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: topPadding + 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                              "الرسائل",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: SearchField(
                                  hint: "بحث",
                                  controller: searchController,
                                  onChanged: (value) {
                                    _filterConversations(value, allConversations);
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25.h),

                        ],
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
                    itemCount: filteredConversations.length,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade100,
                      indent: 80.w,
                      endIndent: 20.w,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final conv = filteredConversations[index];

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
                                        ? DateFormat('hh:mm a')
                                        .format(conv.lastMessageAt!)
                                        : "_",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xff8A8A8E)),
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