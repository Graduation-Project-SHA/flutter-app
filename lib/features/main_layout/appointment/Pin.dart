import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/shared/component/defaultbutton/defaultbutton.dart';

class Pin extends StatefulWidget {
  const Pin({super.key});

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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Column(
            children: [Stack(children: [
              
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/pay_done_back1.png', width: 200, height: 124)),
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/pay_done_back2.png', width: 185, height: 160)),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset('assets/images/pay_done.png', width: 148, height: 148)),
            ],),
            SizedBox(height: 16,),
            Text('تم الحجز بنجاح', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            Text( 'لقد اتممت عملية الدفع بنجاح', style: TextStyle(fontSize: 16, color: Colors.grey),),
            SizedBox(height: 24,),
            DefaultButton(onPressed: (){}, buttonText:'مواعيدي' )
            
            ]
          ),
        ),
        
        
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('خطأ'),
        content: Text('من فضلك أدخل 6 أرقام'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('حسناً'),
          ),
        ],
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final List<String> numbers = ['1','2','3','4','5','6','7','8','9'];

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 10.h),
          child: Container(color: Color.fromRGBO(237, 237, 237, 1), height: 2.h),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'التأكد من الهوية',
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
                border: Border.all(color: Color.fromRGBO(205, 205, 205, 1)),
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
      body: Column(
        children: [
          SizedBox(height: 16.h),
          CircleAvatar(
            radius: 25.r,
            backgroundColor: Color.fromRGBO(43, 115, 243, 1),
            child: Icon(Icons.lock, size: 25.sp, color: Colors.white),
          ),
          SizedBox(height: 16.h),
          Text(
            'ادخل الرمز',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8.h),
          Text(
            'ادخل رمز الهاتف الخاص بك',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color.fromRGBO(147, 147, 147, 1)),
          ),
          SizedBox(height: 24.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              bool filled = pin.length > index;
              return Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: filled ? Colors.blue : Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),

          SizedBox(height: 24.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
                        shadowColor: Colors.blue,
    elevation: 4,
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Color.fromRGBO(220, 220, 220, 1)),
                  ),
                  child: Text(
                    numbers[index],
                    style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20.h),

        Text('هذه الخطوة تجعل بياناتك امنة', style: TextStyle(fontSize: 14.sp, color: Color.fromRGBO(147, 147, 147, 1))),
          Padding(
            padding:  EdgeInsets.all(14.0.w),
            child: ElevatedButton(
              onPressed:submitPin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 15.h),
              ),
              child: Text('تأكيد', style: TextStyle(fontSize: 18.sp, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
