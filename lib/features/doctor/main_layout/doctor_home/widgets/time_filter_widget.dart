import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeFilterWidget extends StatefulWidget {

  final ValueChanged<String>? onFilterChanged;

  const TimeFilterWidget({super.key, this.onFilterChanged});

  @override
  State<TimeFilterWidget> createState() => _TimeFilterWidgetState();
}

class _TimeFilterWidgetState extends State<TimeFilterWidget> {
  int _selectedIndex = 0;

  final List<String> _labels = ['اليوم', 'الاسبوع', 'الشهر', 'السنه'];

  final List<String> _values = ['today', 'week', 'month', 'year'];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 12.h, bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: List.generate(_labels.length, (index) {
            final isSelected = _selectedIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => _selectedIndex = index);
                  widget.onFilterChanged?.call(_values[index]);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF2B73F3) : Colors.transparent,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    _labels[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xff434343),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
