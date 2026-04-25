import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/patient/donation/donation_cubit/donation_cubit.dart';

class SelectBoxOfBlood extends StatefulWidget {
  const SelectBoxOfBlood({super.key});

  @override
  State<SelectBoxOfBlood> createState() => _SelectBoxOfBloodState();
}

class _SelectBoxOfBloodState extends State<SelectBoxOfBlood> {


  List<String> items = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-'];

  @override
  Widget build(BuildContext context) {
    DonationCubit cubit = DonationCubit.get(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButton<String>(
        value: cubit.selectedValueOfBlood,
        hint: Text('اختار فصيلة الدم'),
        isExpanded: true,
        underline: SizedBox(), 
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              textDirection: TextDirection.ltr,
              item,style: TextStyle(fontWeight: FontWeight.w700,fontFamily: "Roboto"),),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            cubit.selectedValueOfBlood = value;
          });
        },
      ),
    );
  }
}