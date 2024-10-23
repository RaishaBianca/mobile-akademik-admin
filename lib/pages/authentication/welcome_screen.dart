import 'package:admin_fik_app/pages/authentication/signin_screen.dart';
import 'package:admin_fik_app/pages/authentication/signup_screen.dart';
import 'package:admin_fik_app/customstyle/theme.dart';
import 'package:admin_fik_app/customstyle/custom_scaffold.dart';
import 'package:admin_fik_app/customstyle/welcome_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
            flex:8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 0.0,
              ),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome to ClassLeap\n',
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text:
                        '\nYour one stop solution for Lab and Classroom management',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign in',
                      // onTap: SignInScreen(),
                      onTap: () {
                        Navigator.pushNamed(context, '/signin');
                      },
                      color: Colors.transparent,
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign up',
                      // onTap: const SignUpScreen(),
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      color: Colors.white,
                      textColor: lightColorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
