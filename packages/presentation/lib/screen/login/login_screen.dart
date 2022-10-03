import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/text_styles.dart';
import '../../base/bloc_data.dart';
import '../../base/bloc_screen.dart';
import '../../navigation/base_arguments.dart';
import '../../navigation/base_page.dart';
import 'login_bloc.dart';
import 'login_data.dart';

class LoginScreenArguments extends BaseArguments {
  LoginScreenArguments({
    Function(dynamic value)? result,
  }) : super(result: result);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const _routeName = '/DetailsPage';

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
          if (data != null) {
            return Scaffold(
              backgroundColor: PrimaryColors.primaryBackgroundColor,
              appBar: AppBar(
                backgroundColor: PrimaryColors.primaryBackgroundColor,
                centerTitle: false,
                title: Text(
                  'Profile', //todo loca10n
                  style: AppTextStyles.headerStyle(23),
                  textAlign: TextAlign.left,
                ),
                actions: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Sing Up',
                        style: AppTextStyles.linkStyle(15),
                      ))
                ],
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'USER NAME',
                            style: AppTextStyles.descriptionStyle(12),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
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
                          const SizedBox(height: 20),
                          Text(
                            'PASSWORD',
                            style: AppTextStyles.descriptionStyle(12),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
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
                      const SizedBox(height: 24),
                      Text(
                        'Forgot Password?',
                        style: AppTextStyles.descriptionStyle(16),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 145,
                            vertical: 18,
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: AppTextStyles.headerStyle(16),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.lightBlue,
                              ),
                              child: Icon(Icons.color_lens_rounded),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.lightBlue,
                              ),
                              child: Icon(Icons.color_lens_rounded),
                            ),
                          )
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
