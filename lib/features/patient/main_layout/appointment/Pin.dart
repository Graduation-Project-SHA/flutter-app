import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_appointment_cubit/patient_appointment_cubit.dart';
import 'package:health_care_project/features/patient/main_layout/appointment/patient_appointment_cubit/patient_appointment_states.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';
import 'appointment.dart';

class Pin extends StatefulWidget {
  final String doctorId;
  final String appointmentDate;
  final String startTime;
  final int serviceId;

  const Pin({
    super.key,
    required this.doctorId,
    required this.appointmentDate,
    required this.startTime,
    required this.serviceId,
  });

  @override
  State<Pin> createState() => _PinState();
}

class _PinState extends State<Pin> {
  String pin = '';

  void addDigit(String digit) {
    if (pin.length < 6) {
      setState(() {
        pin += digit;
      });
    }
  }


  void submitPin() {
    if (pin.length == 6) {
      AppointmentCubit.get(context).bookAppointment(
        doctorProfileId: int.parse(widget.doctorId),
        serviceId: widget.serviceId,
        appointmentDate: widget.appointmentDate,
        startTime: widget.startTime,
        notes: "حجز عبر تطبيق وقاية",
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك أدخل الرمز المكون من 6 أرقام')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

    return BlocListener<AppointmentCubit, AppointmentState>(
      listener: (context, state) {
        if (state is BookAppointmentSuccess) {
          _showSuccessDialog();
        } else if (state is AppointmentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 10.h),
            child: Container(color: const Color.fromRGBO(237, 237, 237, 1), height: 2.h),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text('التأكد من الهوية',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.sp)),
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
                    icon: Icon(Icons.arrow_forward_ios, size: 18.sp)),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 16.h),
            CircleAvatar(
              radius: 25.r,
              backgroundColor: const Color.fromRGBO(43, 115, 243, 1),
              child: Icon(Icons.lock, size: 25.sp, color: Colors.white),
            ),
            SizedBox(height: 16.h),
            Text('ادخل الرمز', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 8.h),
            Text('ادخل رمز الهاتف الخاص بك',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(147, 147, 147, 1))),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                bool filled = pin.length > index;
                return Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: filled ? Colors.blue : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 20.w,
                ),
                itemCount: numbers.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () => addDigit(numbers[index]),
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color.fromRGBO(220, 220, 220, 1)),
                    ),
                    child: Text(numbers[index],
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                  );
                },
              ),
            ),
            const Spacer(),
            Text('هذه الخطوة تجعل بياناتك امنة',
                style: TextStyle(fontSize: 14.sp, color: const Color.fromRGBO(147, 147, 147, 1))),
            Padding(
              padding: EdgeInsets.all(24.0.w),
              child: BlocBuilder<AppointmentCubit, AppointmentState>(
                builder: (context, state) {
                  return (state is AppointmentLoading)
                      ? const CircularProgressIndicator()
                      : DefaultButton(
                    onPressed: submitPin,
                    buttonText: 'تأكيد',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/pay_done_back1.png', width: 200, height: 124),
                  Image.asset('assets/images/pay_done_back2.png', width: 185, height: 160),
                  Image.asset('assets/images/pay_done.png', width: 148, height: 148),
                ],
              ),
              SizedBox(height: 16.h),
              Text('تم الحجز بنجاح',
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              Text('لقد اتممت عملية الدفع بنجاح',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
              SizedBox(height: 24.h),
              DefaultButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Appointment()),
                        (route) => false,
                  );
                },
                buttonText: 'مواعيدي',
              ),
            ],
          ),
        ),
      ),
    );
  }
}