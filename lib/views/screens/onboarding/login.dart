import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_page/utils/routes.dart';
import 'package:settings_page/viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthViewmodel _authViewmodel = AuthViewmodel();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';

  String _password = '';
  bool isLoading = false;

  void onLoginPressed() async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _authViewmodel
            .login(email: _email, password: _password)
            .then((_) {
          Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
        });
      } catch (e) {
        print(e);
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Error'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    e.toString(),
                  ),
                ],
              ),
            ),
          );
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Login'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (String? newValue) {
                      _email = newValue ?? '';
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter a valid password';
                      }
                      return null;
                    },
                    onSaved: (String? newValue) {
                      _password = newValue ?? '';
                    },
                  ),
                ],
              ),
            ),
            Column(
              children: [
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : TextButton(
                        onPressed: onLoginPressed,
                        child: const Text('Log in'),
                      ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RouteNames.register);
                  },
                  child: const Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.resetPassword);
                  },
                  child: const Text('Reset password'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
