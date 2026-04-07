import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/donation_screen_widgets/List_of_donation.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/custom_appbar.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/donation_screen_widgets/need_help.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/donation_screen_widgets/see_all_donations.dart';
import 'package:health_care_project/shared/component/defaultTextButton/defaultTextButton.dart';
import 'package:health_care_project/shared/component/filterButton/filter_button.dart';
import 'package:health_care_project/shared/component/searchField/search_field.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  static const String routeName = "DonationScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'تبرعات'),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 25.w,vertical: 10.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  child: SearchField(
                    hint: 'البحث',
                  ),
                ),
                SizedBox(width: 14.w,),
                FilterButton()
                
              ],
            )
            ,SizedBox(height: 15.h,),
            NeedHelp(),
            SizedBox(height: 15.h,),
              Row(
          children: [
            Text(
              'تبرعات',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            Spacer(),
            DefaultTextButton(
              textButtonTitle: 'عرض الكل',
              textButtonColor: Color(0xff2B73F3),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAllDonations()));
              },
            ),
          ],
        ),
            ListOfDonation(),
          ],),
        ),
      )
    );
  }
}
