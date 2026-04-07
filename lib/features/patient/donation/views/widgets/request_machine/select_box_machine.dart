import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectBoxOfMachine extends StatefulWidget {
  const SelectBoxOfMachine({super.key});

  @override
  State<SelectBoxOfMachine> createState() => _SelectBoxOfMachineState();
}

class _SelectBoxOfMachineState extends State<SelectBoxOfMachine> {
  String? selectedValue;

  List<String> items = ['جهاز تنفس صناعي', 'جهاز غسيل كلى', 'جهاز تنظيم ضربات القلب', 'جهاز مراقبة ضغط الدم'];

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
        hint: Text('اختار نوع الجهاز'),
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