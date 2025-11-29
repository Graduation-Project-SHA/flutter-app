import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/searchField/search_field.dart';
import 'doctor_chat_details_screen.dart';

class Doctor {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final String imageUrl;

  const Doctor({
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
    required this.imageUrl,
  });
}

const List<Doctor> doctorsList = [
  Doctor(name: "د. مرام على", lastMessage: "جميل أنا شايفة أن في تحسن كبير", time: "12:45", unreadCount: 2, isOnline: true, imageUrl: "assets/images/doctor1.png"),
  Doctor(name: "د. أسامة مراد", lastMessage: "إيه الإخبار النهاردة ؟", time: "12:45", unreadCount: 1, isOnline: true, imageUrl: "assets/images/doctor2.png"),
  Doctor(name: "د. خلود محمد", lastMessage: "الحمدلله التحاليل كلها نتيجتها انك بخير", time: "12:45", unreadCount: 0, isOnline: true, imageUrl: "assets/images/doctor3.png"),
  Doctor(name: "د.مجمد مرعى", lastMessage: "الحج احمد بيدلع عليكم عاوز يعرف غلاوته..", time: "12:45", unreadCount: 0, isOnline: true, imageUrl: "assets/images/doctor4.png"),
  Doctor(name: "د. محمود عبداللطيف", lastMessage: "حاول تستخدم الدواء في مواعيد العلاج", time: "12:45", unreadCount: 0, isOnline: true, imageUrl: "assets/images/doctor5.png"),
  Doctor(name: "د.محمود عبداللطيف", lastMessage: "حاول تنتظم اكتر في مواعيد العلاج", time: "12:40", unreadCount: 0, isOnline: false, imageUrl: "assets/images/doctor.png"),
];

class MessageListItem extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;

  const MessageListItem({
    super.key,
    required this.doctor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  doctor.time,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xff8A8A8E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                if (doctor.unreadCount > 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(minWidth: 20.w, minHeight: 20.h),
                    child: Center(
                      child: Text(
                        doctor.unreadCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                else
                  SizedBox(height: 20.h),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    doctor.lastMessage,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xff8A8A8E),
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            CircleAvatar(
              radius: 28.r,
              backgroundImage: AssetImage(doctor.imageUrl),
              backgroundColor: Colors.grey.shade200,
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorStatusItem extends StatelessWidget {
  final Doctor doctor;

  const DoctorStatusItem({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 32.r,
                backgroundImage: AssetImage(doctor.imageUrl),
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            if (doctor.isOnline)
              Positioned(
                right: 2.w,
                bottom: 2.h,
                child: Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.w,
                    ),
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}

class DoctorMessagesScreen extends StatelessWidget {
  const DoctorMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final List<Doctor> statusDoctors = doctorsList.take(6).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xff4786F5),
            elevation: 0,
            expandedHeight: 280.h,
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
                          child: const Center(
                            child: SearchField(
                              hint: "بحث",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      SizedBox(
                        height: 85.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemBuilder: (_, index) {
                            return DoctorStatusItem(
                              doctor: statusDoctors[index],
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(width: 12.w),
                          itemCount: statusDoctors.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 300.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: doctorsList.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade100,
                        indent: 80.w,
                        endIndent: 20.w,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final doctor = doctorsList[index];
                        return MessageListItem(
                          doctor: doctor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DoctorChatDetailsScreen(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: bottomPadding + 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}