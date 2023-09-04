import 'package:flutter/material.dart';
import 'package:saur_customer/models/warranty_request_model.dart';
import 'package:saur_customer/screens/blocked_user/blocked_users_screen.dart';
import 'package:saur_customer/screens/home_container/home_container.dart';
import 'package:saur_customer/screens/password_recovery/recover_password_screen.dart';
import 'package:saur_customer/screens/profile/change_password.dart';
import 'package:saur_customer/screens/profile/edit_profile.dart';
import 'package:saur_customer/screens/raise_warranty_request/conclusion_screen.dart';
import 'package:saur_customer/screens/raise_warranty_request/installation_address_screen.dart';
import 'package:saur_customer/screens/raise_warranty_request/other_information_screen.dart';
import 'package:saur_customer/screens/raise_warranty_request/owner_address_screen.dart';
import 'package:saur_customer/screens/raise_warranty_request/photo_upload_screen.dart';
import 'package:saur_customer/screens/raise_warranty_request/system_details_screen.dart';
import 'package:saur_customer/screens/request/new_request.dart';
import 'package:saur_customer/screens/request/request_detail_screen.dart';
import 'package:saur_customer/screens/user_onboarding/agreement_screen.dart';
import 'package:saur_customer/screens/user_onboarding/login_screen.dart';
import 'package:saur_customer/screens/user_onboarding/change_phone_number.dart';
import 'package:saur_customer/screens/user_onboarding/register_screen.dart';

import '../models/warranty_model.dart';
import '../screens/app_intro/app_intro_screen.dart';

class NavRoute {
  static MaterialPageRoute<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppIntroScreen.routePath:
        return MaterialPageRoute(builder: (_) => const AppIntroScreen());
      case LoginScreen.routePath:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RegisterScreen.routePath:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AgreementScreen.routePath:
        return MaterialPageRoute(builder: (_) => const AgreementScreen());
      case RecoverPasswordScreen.routePath:
        return MaterialPageRoute(builder: (_) => const RecoverPasswordScreen());
      case ChangePhoneNumber.routePath:
        return MaterialPageRoute(builder: (_) => const ChangePhoneNumber());
      case HomeContainer.routePath:
        return MaterialPageRoute(builder: (_) => const HomeContainer());
      case EditProfile.routePath:
        return MaterialPageRoute(builder: (_) => const EditProfile());
      case ChangePassword.routePath:
        return MaterialPageRoute(builder: (_) => const ChangePassword());
      case BlockedUserScreen.routePath:
        return MaterialPageRoute(builder: (_) => const BlockedUserScreen());
      case NewRequestScreen.routePath:
        return MaterialPageRoute(builder: (_) => const NewRequestScreen());
      case InstallationAddressScreen.routePath:
        return MaterialPageRoute(
            builder: (_) => const InstallationAddressScreen());

      case OwnerAddressScreen.routePath:
        return MaterialPageRoute(
          builder: (_) => OwnerAddressScreen(
            warrantyRequestModel: settings.arguments as WarrantyRequestModel,
          ),
        );
      case SystemDetailScreen.routePath:
        return MaterialPageRoute(
          builder: (_) => SystemDetailScreen(
            warrantyRequestModel: settings.arguments as WarrantyRequestModel,
          ),
        );
      case OtherInformationScreen.routePath:
        return MaterialPageRoute(
          builder: (_) => OtherInformationScreen(
            warrantyRequestModel: settings.arguments as WarrantyRequestModel,
          ),
        );
      case PhotoUploadScreen.routePath:
        return MaterialPageRoute(
          builder: (_) => PhotoUploadScreen(
            warrantyRequestModel: settings.arguments as WarrantyRequestModel,
          ),
        );
      case ConclusionScreen.routePath:
        return MaterialPageRoute(
          builder: (_) => ConclusionScreen(
            warrantyRequestModel: settings.arguments as WarrantyRequestModel,
          ),
        );

      case RequestDetalScreen.routePath:
        return MaterialPageRoute(
          builder: (_) => RequestDetalScreen(
            warrantyRequest: settings.arguments as WarrantyModel,
          ),
        );
      default:
        return errorRoute();
    }
  }
}

errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return const Scaffold(
      body: Center(
        child: Text('Undefined route'),
      ),
    );
  });
}
