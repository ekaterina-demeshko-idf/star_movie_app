import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../navigation/base_page.dart';
import '../../utils/dimens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const _routeName = '/ProfileScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const ProfileScreen(),
        hideNavBar: true,
      );

  @override
  State createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColors.primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: PrimaryColors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: PrimaryColors.primaryColor,
              size: Dimens.size50,
            ),
            const SizedBox(height: Dimens.size20),
            Text(
              AppLocalizations.of(context)!.success,
              style: AppTextStyles.headerStyle(Dimens.size30),
            ),
          ],
        ),
      ),
    );
  }
}
