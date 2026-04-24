import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/defaultTextFormField/defaultTextFormField.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';
import 'Pin.dart';

class VisaPay extends StatefulWidget {
  final String doctorId;
  final String appointmentDate;
  final String startTime;
  final int serviceId;

  const VisaPay({
    super.key,
    required this.doctorId,
    required this.appointmentDate,
    required this.startTime,
    required this.serviceId,
  });

  @override
  State<VisaPay> createState() => _VisaPayState();
}

class _VisaPayState extends State<VisaPay> {
  int selectedIndex = -1;
  bool saveVisaCardDetails = false;
  TextEditingController expiryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> logos = [
      'assets/images/meza_logo.png',
      'assets/images/mastecard_logo.png',
      'assets/images/visaa_logo.png',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
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
          'بطاقة بنكية',
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
      body: Padding(
        padding: EdgeInsets.all(25.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(logos.length, (index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      height: 50.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: isSelected ? const Color.fromRGBO(43, 115, 243, 0.1) : Colors.white,
                        border: Border.all(
                          color: isSelected ? const Color.fromRGBO(43, 115, 243, 1) : const Color.fromRGBO(220, 220, 220, 1),
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.h),
                            child: SizedBox(
                              height: 40.h,
                              width: 84.w,
                              child: Image.asset(logos[index], fit: BoxFit.cover),
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Icon(
                                Icons.check_circle,
                                color: const Color.fromRGBO(43, 115, 243, 1),
                                size: 24.sp,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 30.h),
              Text('اسم حامل البطاقة', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 10.h),
              Defaulttextformfield(
                hintText: 'ادخل اسم حامل البطاقة',
                borderColor: const Color.fromRGBO(220, 220, 220, 1),
              ),
              SizedBox(height: 20.h),
              Text('رقم البطاقة', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 10.h),
              Defaulttextformfield(
                hintText: 'ادخل رقم البطاقة',
                borderColor: const Color.fromRGBO(220, 220, 220, 1),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('تاريخ الانتهاء', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
                        SizedBox(height: 10.h),
                        Defaulttextformfield(
                          readOnly: true,
                          controller: expiryController,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              String formattedDate = '${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString().substring(2)}';
                              setState(() => expiryController.text = formattedDate);
                            }
                          },
                          suffixIcon: Icon(Icons.calendar_month_outlined, size: 20.sp, color: const Color.fromRGBO(43, 115, 243, 1)),
                          hintText: 'MM/YY',
                          borderColor: const Color.fromRGBO(220, 220, 220, 1),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('رمز التحقق', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
                        SizedBox(height: 10.h),
                        Defaulttextformfield(
                          hintText: 'CVV',
                          borderColor: const Color.fromRGBO(220, 220, 220, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Text('احفظ بيانات البطاقة', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  Switch(
                    value: saveVisaCardDetails,
                    onChanged: (value) => setState(() => saveVisaCardDetails = value),
                    activeColor: Colors.white,
                    activeTrackColor: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('300 جنيه', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
                  const Spacer(),
                  Text('حجز الكشف', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp)),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Text("مجانا", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
                  const Spacer(),
                  Text("إعادة", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp)),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                height: 1,
                width: double.infinity,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text("300 جنيه", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
                  const Spacer(),
                  Text("المجموع", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp)),
                ],
              ),
              SizedBox(height: 15.h),
              DefaultButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Pin(
                        doctorId: widget.doctorId,
                        serviceId: widget.serviceId,
                        appointmentDate: widget.appointmentDate,
                        startTime: widget.startTime,
                      ),
                    ),
                  );
                },
                buttonText: 'أدفع',
                buttonTextSize: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}