import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/customAppbarButton/custom_app_bar_button.dart';

class UserPaymentMethodsScreen extends StatelessWidget {
  static const String routeName = "UserPaymentMethodsScreen";

  const UserPaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
       actions: [
         CustomAppBarBtn()
       ],
        automaticallyImplyLeading: false,
        title:
        Text(
          "طرق الدفع",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            children: [
              Column(
                children: [
                  _buildPaymentItem(
                    title: "باي بال",
                    number: "37842 ***** ***** *****",
                    status: "متصل",
                    image:"assets/images/paypal_logo.png",
                  ),
                 SizedBox(height:36.h ,),
                  _buildPaymentItem(
                    title: "بطاقة ماستر كارد",
                    number: "42482 ***** ***** *****",
                    status: "متصل",
                    image:"assets/images/mastercard_logo2.png"
                  ),
                  SizedBox(height:36.h ,),
                  _buildPaymentItem(
                    title: "آبل باي",
                    number: "37476 ***** ***** *****",
                    status: "متصل",
                    image:"assets/images/applepay_logo.png" ,
                  ),
                ],
              ),

              const Spacer(),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff247CFF),
                  minimumSize: Size(double.infinity, 52.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                onPressed: () {},
                child: Text(
                  "أضف جديد",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildPaymentItem({
    required String title,
    required String number,
    required String status,
    required String image,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [

          Container(
            width: 40.w,
            height: 40.h,
            child: Image.asset(image),
          ),

          SizedBox(width: 14.w),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                number,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey.shade500,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),

          const Spacer(),
          Text(
            status,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff247CFF),
            ),
          ),
        ],
      ),
    );
  }
}