import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaitingEmergencyScreen extends StatefulWidget {
  const WaitingEmergencyScreen({super.key});

  @override
  State<WaitingEmergencyScreen> createState() => _WaitingEmergencyScreenState();
}

class _WaitingEmergencyScreenState extends State<WaitingEmergencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 10.h),
          child: Container(
            color: Color.fromRGBO(237, 237, 237, 1),
            height: 2.h,
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'طلب سيارة اسعاف',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(205, 205, 205, 1)),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              spacing: 15.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/emergency_car_icon.png',
                  width: 32.w,
                  height: 32.h,
                ),
                Text(
                  'متابعة وصول فريق الإسعاف',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              height: 252.h,
              width: 330.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),

                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(231, 0, 11, 1),
                    Color.fromRGBO(251, 44, 54, 1),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time, size: 32.sp, color: Colors.white),
                      SizedBox(width: 8.w),
                      Text(
                        'الوقت المتوقع للوصول',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    '7',
                    style: TextStyle(
                      fontSize: 72.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'دقيقة',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    width: 232.w,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(4.r),
                      value: 0.7,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 8.h,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: 330.w,
              height: 140.h,
              decoration: BoxDecoration(
                border: BoxBorder.all(
                  color: Color.fromRGBO(190, 219, 255, 1),
                  width: 1.w,
                ),
                color: Color.fromRGBO(239, 246, 255, 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                child: Column(
                  spacing: 10.h,

                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 14.r,
                          backgroundColor: Color.fromRGBO(21, 93, 252, 1),
                          child: Text(
                            '!',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'تعليمات هامة',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(28, 57, 142, 1),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'يرجى إرسال شخص لاستقبال الفريق على الشارع الرئيسي وتوجيههم للموقع الدقيق.',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(28, 57, 142, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.h,
                horizontal: 25.w,
              ),
              height: 555.h,
              width: 327.w,
              decoration: BoxDecoration(
                border: BoxBorder.all(
                  color: Color.fromRGBO(229, 229, 229, 1),
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(14.r),
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              child: Column(
                children: [
                  Row(
                    spacing: 10.w,
                    children: [
                      Image.asset(
                        'assets/images/message-icon.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                      Text(
                        'تواصل فوري مع المسعف',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(43, 115, 243, 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 16.w,
                    ),
                    height: 256.h,
                    width: 271.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Color.fromRGBO(242, 242, 247, 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [

                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                        horizontal: 14.w,
                                      ),

                                      decoration: BoxDecoration(
                                        color: Colors
                                            .grey[300],
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      child: Text(
                                        'لو لسة المريض فاقد الوعي، ميله على جنبه (بلاش تحركه)، وجهز أي أدوية بياخدها عند الباب ووفرله مساحة كافية للنفس',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),

                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),

                                    // الوقت
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 16.r,
                                    backgroundImage: AssetImage(
                                      'assets/images/doctor3.png',
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 7.r,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 6.r,
                                      backgroundColor:
                                      Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Text(
                          '16.09',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    height: 70.h,
                    width: 270.w,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(239, 246, 255, 1),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 24.sp,
                          color: Color.fromRGBO(21, 93, 252, 1),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'يمكنك إرسال تحديثات أو صور دون الحاجة لإنهاء المكالمة',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(28, 57, 142, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(242, 242, 247, 1),
                      hintText: 'اكتب رسالتك هنا...',
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Color.fromRGBO(153, 153, 153, 1),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  Row(
                    children: [
                      SizedBox(
                        width: 200.w,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff156DFC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 24.w,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                'إرسال',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 8.w,),
                              Icon(Icons.send, size: 20.sp),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      IconButton(onPressed: (){}, icon: Icon(Icons.add),
                        iconSize: 35,
                        color: Color.fromRGBO(71, 134, 245, 1),)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(

              width: 330.w,
              height: 205.h,
              decoration: BoxDecoration(
                border: BoxBorder.all(
                  color: Color.fromRGBO(190, 219, 255, 1),
                  width: 1.w,
                ),
                color: Color.fromRGBO(239, 246, 255, 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                child: Column(
                  spacing: 10.h,

                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 14.r,
                              backgroundColor: Color.fromRGBO(21, 93, 252, 1),
                              child: Text(
                                '!',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'تعليمات هامة',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(28, 57, 142, 1),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                    Text(
                      'يرجى إرسال شخص لاستقبال الفريق على الشارع الرئيسي وتوجيههم للموقع الدقيق.',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(28, 57, 142, 1),
                      ),

                    ),

                    ElevatedButton


                      (
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(43, 115, 243, 1)
                        ),
                        onPressed: (){}, child:Text('تمت بنجاح',style: TextStyle(
                        fontSize: 16.sp

                    ),))
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}