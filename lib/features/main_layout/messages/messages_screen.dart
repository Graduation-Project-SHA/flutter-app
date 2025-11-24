import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/searchField/search_field.dart';
import 'chat_details_screen.dart';

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
  Doctor(
    name: "د. مرام على",
    lastMessage: "جميل أنا شايفة أن في تحسن كبير",
    time: "12:45",
    unreadCount: 2,
    isOnline: true,
    imageUrl: "assets/images/doctor1.png",
  ),
  Doctor(
    name: "د. أسامة مراد",
    lastMessage: "إيه الإخبار النهاردة ؟",
    time: "12:45",
    unreadCount: 1,
    isOnline: true,
    imageUrl: "assets/images/doctor2.png",
  ),
  Doctor(
    name: "د. خلود محمد",
    lastMessage: "الحمدلله التحاليل كلها نتيجتها انك بخير",
    time: "12:45",
    unreadCount: 0,
    isOnline: true,
    imageUrl: "assets/images/doctor3.png",
  ),
  Doctor(
    name: "د.مجمد مرعى",
    lastMessage: "الحج احمد بيدلع عليكم عاوز يعرف غلاوته..",
    time: "12:45",
    unreadCount: 0,
    isOnline: true,
    imageUrl: "assets/images/doctor4.png",
  ),
  Doctor(
    name: "د. محمود عبداللطيف",
    lastMessage: "حاول تستخدم الدواء في مواعيد العلاج",
    time: "12:45",
    unreadCount: 0,
    isOnline: true,
    imageUrl: "assets/images/doctor5.png",
  ),

  Doctor(
    name: "د.محمود عبداللطيف",
    lastMessage: "حاول تنتظم اكتر في مواعيد العلاج",
    time: "12:40",
    unreadCount: 0,
    isOnline: false,
    imageUrl: "assets/images/doctor.png",
  ),
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
                    color: Color(0xff8A8A8E),
                  ),
                ),
                if (doctor.unreadCount > 0)
                  Container(
                    height: 20.h,
                    width: 20.w,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        doctor.unreadCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
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
                    doctor.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  SizedBox(height:4.h),
                  Text(
                    doctor.lastMessage,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff8A8A8E),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
             CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(doctor.imageUrl),
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
            CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(doctor.imageUrl),
            ),
            if (doctor.isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
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

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final List<Doctor> statusDoctors = doctorsList.take(6).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.transparent,
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
                            return DoctorStatusItem(
                              doctor: statusDoctors[index],
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(width: 16.w),
                          itemCount: statusDoctors.length,
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: doctorsList.length * 2,
                itemBuilder: (context, index) {
                  final doctor = doctorsList[index % doctorsList.length];
                  return MessageListItem(
                    doctor: doctor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChatDetailsScreen(),
                        ),
                      );
                    },
                  );
                },
              ),
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

