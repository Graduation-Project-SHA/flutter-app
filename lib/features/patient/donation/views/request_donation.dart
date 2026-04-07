import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/request_donation_widgets/blood_donation.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/custom_appbar.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/request_donation_widgets/machine_donation.dart';

class RequestDonation extends StatelessWidget {
  const RequestDonation({super.key});
  static const String routeName = "RequestDonation";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'طلب تبرع'),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30.h,),
          BloodDonation(),
          SizedBox(height: 30.h,),
          
          MachineDonation()

        ],
      )
    );
  }
}
