import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  // الأسئلة والإجابات
  List<Map<String, String>> faq = [
    {
      "question": 'ماذا يجب أن أتوقع خلال موعد الطبيب؟',
      "answer":
          'خلال موعدك مع الطبيب، يمكنك أن تتوقع مناقشة تاريخك الطبي، والأعراض أو المخاوف الحالية، وأي أدوية أو علاجات تتناولها. من المرجح أن يقوم الطبيب بإجراء فحص جسدي وقد يطلب اختبارات أو إجراءات إضافية إذا لزم الأمر.',
    },
    {"question": 'ما الذي يجب أن أحضره إلى موعدي مع الطبيب؟', "answer": ''},
    {
      "question": 'ماذا لو كنت بحاجة إلى إلغاء أو إعادة جدولة موعدي؟',
      "answer": '',
    },
    {"question": 'كيف يمكنني تحديد موعد مع الطبيب؟', "answer": ''},
    {"question": 'في أي وقت يجب أن أصل لموعد طبيبي؟', "answer": ''},
    {"question": 'كم من الوقت سيستغرق موعد طبيبي؟', "answer": ''},
    {"question": 'كم سيكلف موعد طبيبي؟', "answer": ''},
    {"question": 'ما الذي يجب أن أبحث عنه عند الطبيب الجيد؟', "answer": ''},
    {"question": 'ماذا يجب أن أتوقع خلال موعد الطبيب؟', "answer": ''},
  ];
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'اسئلة شائعة',
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
                border: Border.all(
                  color: const Color.fromRGBO(205, 205, 205, 1),
                ),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 18.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),

      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemBuilder: (context, index) {
          return ExpansionTile(
            onExpansionChanged: (value) {
              setState(() {
                isClick = !isClick;
              });
              ;
            },

            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.only(top: 10.h, bottom: 10.h),

            title: Text(
              faq[index]["question"]!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(36, 36, 36, 1),
              ),
            ),

            trailing: Icon(
              isClick ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
              size: 24.sp,
              color: Colors.grey[700],
            ),

            collapsedIconColor: Colors.grey[600],

            children: [
              Text(
                faq[index]["answer"]!,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Color.fromRGBO(117, 117, 117, 1),
                ),
                textAlign: TextAlign.start,
              ),
            ],
          );
        },

        separatorBuilder: (context, index) =>
            Divider(thickness: 1, color: Color.fromRGBO(220, 220, 220, 1)),

        itemCount: faq.length,
      ),
    );
  }
}
