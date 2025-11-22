import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/searchField/search_field.dart';

import 'chat_details_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            expandedHeight: 300.h,
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
                  padding: EdgeInsets.only(top: 60.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Center(
                        child: Text(
                          "الرسائل",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      SizedBox(height: 21.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: const SearchField(
                            hint: "بحث",
                          ),
                        ),
                      ),

                      SizedBox(height: 28.h),

                      SizedBox(
                        height: 85.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemBuilder: (_, index) {
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    const CircleAvatar(
                                      radius: 28,
                                      backgroundImage: AssetImage(
                                        "assets/images/doctor.png",
                                      ),
                                    ),

                                    Positioned(
                                      right: 2,
                                      bottom: 2,
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 6.h),
                              ],
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(width: 14.w),
                          itemCount: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.h),
              child: Container(
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChatDetailsScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "12:45",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.grey),
                            ),

                            SizedBox(height: 6.h),

                            if (index == 0)
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "2",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "د. محمد حربي",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "جميل انا شايفة ان في تحسن كبير",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey[700],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        const CircleAvatar(
                          radius: 28,
                          backgroundImage:
                          AssetImage("assets/images/doctor.png"),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 10,
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: bottomPadding + 60.h),
          ),
        ],
      ),
    );
  }
}
