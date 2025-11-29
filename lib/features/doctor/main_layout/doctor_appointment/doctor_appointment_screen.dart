import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/component/customAppbarButton/custom_app_bar_button.dart';
import '../../../../shared/component/searchField/search_field.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  static const String routeName = "AppointmentScreen";
  const DoctorAppointmentScreen({super.key});

  @override
  State<DoctorAppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<DoctorAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
           actions: [
              CustomAppBarBtn(
               onTap: (){},
             ),
           ],
          title: Text(
            "جميع الحجوزات",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              const SearchField(hint: "بحث"),
              SizedBox(height: 20.h),
              Container(
                height: 44.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: TabBar(
                  indicatorColor: const Color(0xff2B73F3),
                  indicatorWeight: 2.h,
                  dividerColor: Color(0xffE8E8E8),
                  labelColor: const Color(0xff2B73F3),
                  unselectedLabelColor: Colors.black54,
                  labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: "قادمة"),
                    Tab(text: "مكتمل"),
                    Tab(text: "ملغية"),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildAppointmentsList(status: 'upcoming'),

                    _buildAppointmentsList(status: 'completed'),

                    _buildAppointmentsList(status: 'cancelled'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentsList({required String status}) {
    return ListView.builder(
      itemCount: 4,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 20.h),
      itemBuilder: (context, index) {
        return AppointmentCard(
          doctorName: "احمد الشافعي",
          specialty: "نوع الحجز: استشارة",
          date: "Wed, 17 May | 08:30 AM",
          image: "assets/images/person_image.png",
          status: status,
        );
      },
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String date;
  final String image;
  final String status;

  const AppointmentCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.image,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    bool isUpcoming = status == 'upcoming';
    Color statusColor = Colors.black;
    String statusText = "";

    if (status == 'completed') {
      statusColor = Colors.green;
      statusText = "حجز مكتمل";
    } else if (status == 'cancelled') {
      statusColor = Colors.red;
      statusText = "حجز غير مكتمل";
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          if (!isUpcoming)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xff616161),
                          ),
                        ),
                      ],
                      ),
                      Icon(Icons.more_vert,color: Colors.grey,)
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Divider(color: Colors.grey.shade300),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      specialty,
                      style: TextStyle(fontSize: 12.sp, color: const Color(0xff616161)),
                    ),

                    if (isUpcoming) ...[
                      SizedBox(height: 8.h),
                      Text(
                        date,
                        style: TextStyle(fontSize: 12.sp, color: const Color(0xff616161)),
                      ),
                    ],
                  ],
                ),
              ),
              Image.asset("assets/images/message-icon.png"),
            ],
          ),
          if (isUpcoming) ...[
            SizedBox(height: 16.h),
            Divider(color: Colors.grey.shade300),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2B73F3),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    child: Text(
                      "إعادة جدولة المعاد",
                      style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      side: const BorderSide(color: Color(0xff2B73F3)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    child: Text(
                      "إلغاء الموعد",
                      style: TextStyle(color: const Color(0xff2B73F3), fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}