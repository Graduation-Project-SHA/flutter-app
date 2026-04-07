import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectBoxOfBlood extends StatefulWidget {
  const SelectBoxOfBlood({super.key});

  @override
  State<SelectBoxOfBlood> createState() => _SelectBoxOfBloodState();
}

class _SelectBoxOfBloodState extends State<SelectBoxOfBlood> {
  String? selectedValue;

  List<String> items = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        hint: Text('اختار فصيلة الدم'),
        isExpanded: true,
        underline: SizedBox(), 
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item,style: TextStyle(fontWeight: FontWeight.w700),),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
      ),
    );
  }
}