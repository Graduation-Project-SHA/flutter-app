import 'package:flutter/material.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/visa_pay.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'insta_pay.dart';

class Payment extends StatefulWidget {
  final String doctorProfileId;
  final int serviceId;
  final String appointmentDate;
  final String startTime;

  const Payment({
    super.key,
    required this.doctorProfileId,
    required this.serviceId,
    required this.appointmentDate,
    required this.startTime,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int radio_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 10.h),
          child: Container(
            color: const Color.fromRGBO(237, 237, 237, 1),
            height: 2.h,
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'بيانات الدفع',
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
                border: Border.all(color: const Color.fromRGBO(205, 205, 205, 1)),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15.h),
            Container(
              padding: EdgeInsets.all(20.w),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    height: 70.h,
                    width: 70.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/doctor.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " تقييم",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(113, 113, 122, 1),
                        ),
                      ),
                      Text(
                        "د.مرام علي",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'أنف واذن وحنجرة',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color.fromRGBO(113, 113, 122, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              padding: EdgeInsets.all(20.w),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "تاريخ الحجز",
                        style: TextStyle(
                          color: const Color.fromRGBO(17, 24, 38, 1),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          children: [
                            Text(
                              'تعديل',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromRGBO(37, 78, 219, 1),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Icon(Icons.edit_outlined, color: const Color.fromRGBO(37, 78, 219, 1), size: 18.sp),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Container(
                        height: 64.h,
                        width: 64.w,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(204, 204, 255, 1),
                          borderRadius: BorderRadius.circular(30.r),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/appointment.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الحجز المختار',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color.fromRGBO(113, 113, 122, 1),
                            ),
                          ),
                          Text(
                            "${widget.appointmentDate} - ${widget.startTime}",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اختيار طريقه الدفع',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Image.asset('assets/images/visa_logo.png', width: 90.w, height: 20.h, fit: BoxFit.fill),
                      SizedBox(width: 20.w),
                      Text("بطاقه بنكيه ", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp)),
                      const Spacer(),
                      Radio(
                        value: 0,
                        groupValue: radio_index,
                        activeColor: const Color.fromRGBO(37, 78, 219, 1),
                        onChanged: (value) => setState(() => radio_index = value!),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Image.asset('assets/images/InstaPay_Logo.png', width: 30.w, height: 30.h, fit: BoxFit.fill),
                      SizedBox(width: 20.w),
                      Text('انستا باي', style: TextStyle(fontSize: 15.sp)),
                      const Spacer(),
                      Radio(
                        activeColor: const Color.fromRGBO(37, 78, 219, 1),
                        value: 1,
                        groupValue: radio_index,
                        onChanged: (value) => setState(() => radio_index = value!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
              color: Colors.white,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('مجموع المدفوعات', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('كشف', style: TextStyle(fontSize: 14.sp, color: const Color.fromRGBO(113, 113, 122, 1))),
                      Text('300 جنيه', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15.sp)),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('إعادة', style: TextStyle(fontSize: 14.sp, color: const Color.fromRGBO(113, 113, 122, 1))),
                      Text('مجانية', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15.sp)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8.r, offset: const Offset(0, -2))],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('المجموع', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
                Text('300 جنيه', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800)),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 70.h,
              width: 160.w,
              child: DefaultButton(
                onPressed: () {
                  if (radio_index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InstaPay(
                          doctorId: widget.doctorProfileId,
                          serviceId: widget.serviceId,
                          appointmentDate: widget.appointmentDate,
                          startTime: widget.startTime,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VisaPay(
                          doctorId: widget.doctorProfileId,
                          serviceId: widget.serviceId,
                          appointmentDate: widget.appointmentDate,
                          startTime: widget.startTime,
                        ),
                      ),
                    );
                  }
                },
                buttonText: 'ادفع',
              ),
            ),
          ],
        ),
      ),
    );
  }
}