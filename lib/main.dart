import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_project/features/auth/cubit/auth_cubit.dart';
import 'package:health_care_project/features/onboarding/pages/onboarding_screen.dart';
import 'package:health_care_project/features/patient/donation/donation_cubit/donation_cubit.dart';
import 'package:health_care_project/features/patient/donation/views/donation_screen.dart';
import 'package:health_care_project/features/patient/donation/views/request_blood.dart';
import 'package:health_care_project/features/patient/donation/views/request_donation.dart';
import 'package:health_care_project/features/patient/donation/views/request_machine.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'core/ theme/app_theme.dart';
import 'core/network/dio.dart';
import 'features/auth/login/login_screen.dart';
import 'features/auth/register/register_user_screen.dart';
import 'features/auth/reset_password/reset_password_screen.dart';
import 'features/chat/cubit/chat_cubit.dart';
import 'features/chat/presentation/data/repository/chat_repository.dart';
import 'features/chat/services/socket_service.dart';
import 'features/doctor/availabilities/availability_cubit.dart';
import 'features/doctor/main_layout/doctor_main_layout.dart';
import 'features/doctor/main_layout/doctor_profile/doctor_me_cubit/doctor_me_cubit.dart';
import 'features/doctor/main_layout/doctor_profile/manage_appointment_screen.dart';
import 'features/doctor/main_layout/doctor_profile/update_doctor_profile_cubit/update_doctor_profile_cubit.dart';
import 'features/patient/care/care_map_screen.dart';
import 'features/patient/care/care_screen.dart';
import 'features/patient/care/nurses_list_screen.dart';
import 'features/patient/main_layout/appointment/doctor_details_cubit/doctor_details_cubit.dart';
import 'features/patient/main_layout/appointment/paient_doctor_cubit/patient_doctors_cubit.dart';
import 'features/patient/main_layout/profile/medical_record_screen.dart';
import 'features/patient/main_layout/profile/user_payment_methods_screen.dart';
import 'features/doctor/main_layout/doctor_profile/doctor_personal_information_screen.dart';
import 'features/patient/main_layout/main_layout.dart';
import 'features/patient/main_layout/profile/user_personal_information_screen.dart';
import 'features/patient/nearby_services/emergency_request_screen.dart';
import 'features/patient/nearby_services/find_nearby_services_screen.dart';
import 'features/patient/nearby_services/hospital_details_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  await Hive.openBox('authBox');
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => AvailabilityCubit(),),
        BlocProvider(create: (context) => PatientDoctorsCubit()),
        BlocProvider(create: (context) => DoctorDetailsCubit()),
        BlocProvider(create: (context) => DoctorMeCubit()),
        BlocProvider(create: (context) => UpdateDoctorProfileCubit()),
        BlocProvider(create: (context) => DonationCubit()..getDonationData()),

        BlocProvider(
          lazy: false,
          create: (context) => ChatCubit(
            SocketService(),
            ChatRepository(DioHelper.dio),
          ),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(412, 924),
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
              supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
              locale: const Locale('ar', 'EG'),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              initialRoute: OnboardingScreen.routeName,
          //   initialRoute: MainLayout.routeName,
              onGenerateRoute: (settings) {
                if (settings.name == MainLayout.routeName) {
                  final selectedIndex = settings.arguments as int? ?? 0;
                  return MaterialPageRoute(
                    builder: (_) => MainLayout(selectedIndex: selectedIndex),
                  );
                }
                return null;
              },
              routes: {
                OnboardingScreen.routeName: (context) => OnboardingScreen(),
                Loginscreen.routeName: (context) => Loginscreen(),
                RegisterUserScreen.routeName: (context) => RegisterUserScreen(),
                MainLayout.routeName: (context) => MainLayout(),
                ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(email: '', code: '',),
                FindNearbyServicesScreen.routeName: (_) => FindNearbyServicesScreen(),
                HospitalDetailsScreen.routeName: (_) => HospitalDetailsScreen(),
                EmergencyRequestScreen.routeName: (_) => EmergencyRequestScreen(),
                DoctorMainLayout.routeName: (context) => DoctorMainLayout(),
                ManageAppointmentsScreen.routeName: (_) => ManageAppointmentsScreen(),
                DoctorPersonalInformationScreen.routeName: (_) => DoctorPersonalInformationScreen(),
                UserPaymentMethodsScreen.routeName: (_) => UserPaymentMethodsScreen(),
                MedicalRecordScreen.routeName: (_) => MedicalRecordScreen(),
                UserPersonalInformationScreen.routeName: (_) => UserPersonalInformationScreen(),
                CareScreen.routeName: (_) => CareScreen(),
                CareMapScreen.routeName: (_) => CareMapScreen(),
                NursesListScreen.routeName: (_) => NursesListScreen(),
                DonationScreen.routeName: (_) => DonationScreen(),
                RequestDonation.routeName: (_) => RequestDonation(),
                RequestBlood.routeName: (_) => RequestBlood(),
                RequestMachine.routeName: (_) => RequestMachine(),

              },
            );
          }
      ),
    );
  }
}