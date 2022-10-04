import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimens.dart';
import 'package:presentation/utils/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../base/bloc_data.dart';
import '../../base/bloc_screen.dart';
import '../../navigation/base_arguments.dart';
import '../../navigation/base_page.dart';
import '../../utils/images/paths.dart';
import 'login_bloc.dart';
import 'login_data.dart';

class LoginScreenArguments extends BaseArguments {
  LoginScreenArguments({
    Function(dynamic value)? result,
  }) : super(result: result);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const _routeName = '/LoginPage';

  static BasePage page(LoginScreenArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const LoginScreen(),
        arguments: arguments,
        hideNavBar: false,
      );

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BlocScreenState<LoginScreen, LoginBloc> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocData<LoginData?>>(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data != null) {
            return Scaffold(
              backgroundColor: PrimaryColors.primaryBackgroundColor,
              appBar: AppBar(
                backgroundColor: PrimaryColors.primaryBackgroundColor,
                centerTitle: false,
                title: Text(
                  AppLocalizations.of(context)!.titleProfile,
                  style: AppTextStyles.headerStyle(23),
                  textAlign: TextAlign.left,
                ),
                actions: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.signUp,
                        style: AppTextStyles.linkStyle(15),
                      ))
                ],
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.size20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.username,
                            style: AppTextStyles.descriptionStyle(12),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: Dimens.size10),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimens.size4),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: PrimaryColors.whiteWithOpacity45,
                              ),
                              filled: true,
                              fillColor: PrimaryColors.backgroundTextField,
                            ),
                          ),
                          const SizedBox(height: Dimens.size20),
                          Text(
                            AppLocalizations.of(context)!.password,
                            style: AppTextStyles.descriptionStyle(12),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: Dimens.size10),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimens.size4),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
                                color: PrimaryColors.whiteWithOpacity45,
                              ),
                              filled: true,
                              fillColor: PrimaryColors.backgroundTextField,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimens.size24,
                      ),
                      ElevatedButton(
                        onPressed: bloc.onLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.size145,
                            vertical: Dimens.size18,
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: AppTextStyles.headerStyle(16),
                        ),
                      ),
                      const SizedBox(
                        height: Dimens.size100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(ImagesPath.googleBtn),
                          ),
                          const SizedBox(width: Dimens.size30),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(ImagesPath.facebookBtn),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Container(),
            );
          }
        });


  }
}

