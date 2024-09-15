import 'package:flutter/material.dart';
import 'package:recepies_app/common/common_colors.dart';
import 'package:recepies_app/common/const_strings.dart';
import 'package:recepies_app/common/widget/app_style.dart';
import 'package:recepies_app/services/auth_services.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
      ),
      body: SafeArea(child: _buildUi()),
    );
  }

  Widget _buildUi() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_title(), _loginForm()],
      ),
    );
  }

  Widget _title() {
    return Text(AppText.appName,
        style: appStyle(
          Kolors.black,
          30,
          FontWeight.w600,
        ));
  }

  Widget _loginForm() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.30,
      child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: 'emilys',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a username";
                  }
                },
                onSaved: (value) {
                  setState(() {
                    username = value;
                  });
                },
                decoration: InputDecoration(hintText: "Username"),
              ),
              TextFormField(
                initialValue: 'emilyspass',
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return "Enter a valid password";
                  }
                },
                decoration: InputDecoration(hintText: "Password"),
              ),
              _loginButton(),
            ],
          )),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.60,
      child: ElevatedButton(
          onPressed: () async {
            if (_loginFormKey.currentState?.validate() ?? false) {
              _loginFormKey.currentState?.save();
              bool result = await AuthService().login(username!, password!);
           
              print(result);
              if (result == true) 
              {
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                StatusAlert.show(context,
                    duration: Duration(seconds: 2),
                    title: 'Login Failed',
                    subtitle: 'Try again ',
                    configuration: const IconConfiguration(icon: Icons.error),
                    maxWidth: 260);
              }
            }
          },
          child: const Text("Login")),
    );
  }
}
