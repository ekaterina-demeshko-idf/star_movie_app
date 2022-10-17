import 'package:domain/enum/validation_error_type.dart';
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
          final screenData = data?.data;
          final l10n = AppLocalizations.of(context)!;
          if (data != null) {
            return Scaffold(
              backgroundColor: PrimaryColors.primaryBackgroundColor,
              appBar: AppBar(
                backgroundColor: PrimaryColors.primaryBackgroundColor,
                centerTitle: false,
                title: Text(
                  l10n.titleProfile,
                  style: AppTextStyles.headerStyle(Dimens.size24),
                  textAlign: TextAlign.left,
                ),
                actions: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        l10n.signUp,
                        style: AppTextStyles.linkStyle(Dimens.size16),
                      ))
                ],
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.size20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: bloc.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l10n.username,
                                style: AppTextStyles.descriptionStyle(
                                    Dimens.size12),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: Dimens.size10),
                              TextFormField(
                                validator: (_) {
                                  if (screenData?.loginValidation ==
                                      ValidationErrorType.requiredTypeError) {
                                    return l10n.emailRequired;
                                  } else if (screenData?.loginValidation ==
                                      ValidationErrorType.minLengthTypeError) {
                                    return l10n.emailInvalid;
                                  } else {
                                    return '';
                                  }
                                },
                                controller: bloc.emailController,
                                style: AppTextStyles.descriptionStyle(
                                    Dimens.size16),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.size4),
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
                                l10n.password,
                                style: AppTextStyles.descriptionStyle(
                                    Dimens.size12),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: Dimens.size10),
                              TextFormField(
                                validator: (_) {
                                  if (screenData?.passwordValidation ==
                                      ValidationErrorType.requiredTypeError) {
                                    return l10n.passwordRequired;
                                  } else if (screenData?.passwordValidation ==
                                      ValidationErrorType.regexTypeError) {
                                    return l10n.passwordInvalid;
                                  } else {
                                    return '';
                                  }
                                },
                                controller: bloc.passwordController,
                                style: AppTextStyles.descriptionStyle(
                                    Dimens.size16),
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.size4),
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
                            l10n.login,
                            style: AppTextStyles.headerStyle(Dimens.size16),
                          ),
                        ),
                        const SizedBox(
                          height: Dimens.size100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: bloc.authByGoogle,
                              child: SvgPicture.asset(
                                ImagesPath.googleBtn,
                                height: Dimens.size60,
                                width: Dimens.size60,
                              ),
                            ),
                            const SizedBox(width: Dimens.size30),
                            InkWell(
                              onTap: bloc.authByFacebook,
                              child: SvgPicture.asset(
                                ImagesPath.facebookBtn,
                                height: Dimens.size60,
                                width: Dimens.size60,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
