import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/onboarding/pages/onboarding_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'core/ theme/app_theme.dart';
import 'core/network/dio.dart';
import 'features/auth/login/login_screen.dart';
import 'features/auth/register/register_user_screen.dart';
import 'features/auth/reset_password/reset_password_screen.dart';
import 'features/doctor/main_layout/doctor_main_layout.dart';
import 'features/patient/main_layout/appointment/AppointmentTimeScreen.dart';
import 'features/patient/main_layout/appointment/DoctorDetailsScreen.dart';
import 'features/patient/main_layout/main_layout.dart';
import 'features/patient/nearby_services/emergency_request_screen.dart';
import 'features/patient/nearby_services/find_nearby_services_screen.dart';
import 'features/patient/nearby_services/hospital_details_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  await Hive.openBox('authBox');
  DioHelper.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(412, 924),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
    return MaterialApp(
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
        theme: AppTheme.lightTheme.copyWith(
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'SF Arabic'),
        ),
      supportedLocales: [Locale('ar', 'EG'), Locale('en', 'US')],
      locale: const Locale('ar', 'EG'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
  //    initialRoute: RegisterUserScreen.routeName,
     initialRoute: DoctorMainLayout.routeName,
      onGenerateRoute: (settings) {
        if (settings.name == DoctorMainLayout.routeName) {
          final selectedIndex = settings.arguments as int? ?? 0;

          return MaterialPageRoute(
            builder: (_) => DoctorMainLayout(selectedIndex: selectedIndex),
          );
        }
        return null;
      },

      routes: {
        OnboardingScreen.routeName:(context)=>OnboardingScreen(),
        Loginscreen.routeName:(context)=>Loginscreen(),
        RegisterUserScreen.routeName:(context)=>RegisterUserScreen(),
        MainLayout.routeName:(context)=>MainLayout(),
        AppointmentTimeScreen.routeName:(context)=>AppointmentTimeScreen(),
        DoctorDetailsScreen.routeName:(context)=>DoctorDetailsScreen(),
        ResetPasswordScreen.routeName:(context)=>ResetPasswordScreen(email: '', code: '',),
        FindNearbyServicesScreen.routeName: (_) =>  FindNearbyServicesScreen(),
        HospitalDetailsScreen.routeName: (_) =>  HospitalDetailsScreen(),
        EmergencyRequestScreen.routeName: (_) =>  EmergencyRequestScreen(),
        DoctorMainLayout.routeName:(context)=>DoctorMainLayout(),
      },
      );
     }
    );
  }
}
