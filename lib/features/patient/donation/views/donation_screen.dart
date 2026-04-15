import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care_project/features/patient/donation/donation_cubit/donation_cubit.dart';
import 'package:health_care_project/features/patient/donation/donation_cubit/donation_states.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/donation_screen_widgets/List_of_donation.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/custom_appbar.dart';
import 'package:health_care_project/features/patient/donation/views/widgets/donation_screen_widgets/menu.dart';
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
    return BlocConsumer<DonationCubit, DonationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbar(title: 'تبرعات'),
          body: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 25.w,
              vertical: 10.h,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SearchField(
                          hint: 'البحث',
                          onChanged: (value) {
                            DonationCubit.get(
                              context,
                            ).getDonationData(search: value);
                          },
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Menu()
                    ],
                  ),
                  SizedBox(height: 15.h),
                  NeedHelp(),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Text(
                        'تبرعات',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      DefaultTextButton(
                        textButtonTitle: 'عرض الكل',
                        textButtonColor: Color(0xff2B73F3),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeeAllDonations(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Builder(
                    builder: (context) {
                      final cubit = DonationCubit.get(context);

                      if (state is GetDonationDataLoadingState) {
                        return SizedBox(
                          height: 300.h,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (cubit.donations.isEmpty) {
                        return SizedBox(
                          height: 300.h,
                          child: Center(
                            child: Text(
                              "لا يوجد تبرعات",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }

                      return ListOfDonation();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
