import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main_layout/appointment/Payment.dart';

class NurseDetailsScreen extends StatelessWidget {
  static const String routeName = "NurseDetailsScreen";
  final Map<String, dynamic> nurse;

  const NurseDetailsScreen({super.key, required this.nurse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "رعاية منزلية",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromRGBO(205, 205, 205, 1)),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: Image.asset(
                  nurse['image'],
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 70.w, color: Colors.grey),
                ),
              ),SizedBox(width: 21.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nurse['name'], style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.h),
                      Text(nurse['specialty'], style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700)),
                      SizedBox(height: 8.h),
                      Text("سعر ساعة الرعاية المنزلية : ${nurse['price']}",
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade900)),
                    ],
                  ),
                ),


              ],
            ),

            SizedBox(height: 25.h),
            _buildSectionTitle("سيرة ذاتية"),
            Text("دكتورة مرام علي، أخصائية أنف وأذن وحنجرة، وتعمل في القصر العيني. إنها حقيقة مثبتة منذ زمن طويل أن المحتوى المقروء سيشتت انتباه القارئ......"
            ,  textAlign: TextAlign.right,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700, height: 1.5),
            ),

            SizedBox(height: 28.h),
            _buildSectionTitle("الموقع"),
            Text("المنيل، قسم مصر القديمة، محافظة القاهرة 11956",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700)),
            SizedBox(height: 8.h),
            Container(
              height: 120.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: const DecorationImage(
                  image: AssetImage("assets/images/Maps.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 28.h),
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F7FF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.auto_awesome, color: const Color(0xFF2B73F3), size: 20.sp),
                      SizedBox(width: 12.w),
                      Text("ملخص الذكاء الاصطناعي",
                          style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold, color: const Color(0xFF101828))),
                    ],
                  ),
                  SizedBox(height: 21.h),
                  _buildAIBullet("طبيب ذو خبرة واستماع جيد للمرضى"),
                  SizedBox(height: 10.h,),
                  _buildAIBullet("بيئة نظيفة ومريحة للغاية"),
                  SizedBox(height: 10.h,),
                  _buildAIBullet("أحياناً ممكن يكون في تأخير بسيط في المواعيد"),
                  SizedBox(height: 12.h,),
                  Divider(color: Color(0xFFDBEAFE),),
                  SizedBox(height: 14.h,),
                  Text("تم إنشاء هذا الملخص تلقائياً بواسطة الذكاء الاصطناعي",style: TextStyle(
                    color: Colors.grey,fontSize: 12.sp,fontWeight: FontWeight.w400
                  ),)
                ],
              ),
            ),

            SizedBox(height: 20.h),
            _buildSectionTitle("التقييمات (74)"),
            SizedBox(height: 20.h,),
            _buildReviewItem("أحمد كريم", "4.5", "قمة في الذوق والادب وخبرة في مجالها"),
            SizedBox(height: 15.h,),
            _buildReviewItem("محمود ممدوح", "4.5", "لما روحت للدكتورة مرام، أول حاجة عجبتني إنها سمعت كل شكوتي بالتفصيل ومقاطعتنيش، وكانت صبورة جداً. شرحتلي المشكلة ببساطة ومن غير مصطلحات طبية مكلكعة"),
            SizedBox(height: 20.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const Icon(Icons.chat_outlined, color: Colors.black),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Payment(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2B73F3),
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text("حجز موعد", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
  );

  Widget _buildAIBullet(String text) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(Icons.circle, size: 7.sp, color: const Color(0xFF2B73F3)),
      SizedBox(width: 8.w),
      Text(text, style: TextStyle(fontSize: 14.sp, color:const Color(0xFF364153))),

    ],
  );

  Widget _buildReviewItem(String name, String rate, String comment) => Padding(
    padding: EdgeInsets.only(bottom: 15.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(foregroundImage: AssetImage("assets/images/doctor.png"),radius: 15.r),
            SizedBox(width: 12.w),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold)),


          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.orange,size: 14, )),
        ),
        SizedBox(height: 8.h),
        Text(comment, textAlign: TextAlign.right, style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
      ],
    ),
  );
}