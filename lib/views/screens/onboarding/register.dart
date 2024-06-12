import 'package:flutter/material.dart';
import 'package:settings_page/utils/routes.dart';
import 'package:settings_page/viewmodels/auth_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthViewmodel _authViewmodel = AuthViewmodel();

  final TextEditingController _passwordOneController = TextEditingController();

  final TextEditingController _passwordTwoController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String email = '';

  String password = '';

  void onSubmitPressed(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _authViewmodel.register(email: email, password: password).then(
          (value) {
            Navigator.pushReplacementNamed(context, RouteNames.login);
          },
        );
      } catch (e) {
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
    _passwordOneController.dispose();
    _passwordTwoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Register'),
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
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !RegExp(
                            "^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\$",
                          ).hasMatch(value)) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                    onSaved: (String? newValue) {
                      email = newValue ?? '';
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _passwordOneController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: _passwordTwoController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter password';
                      } else if (_passwordOneController.text !=
                          _passwordTwoController.text) {
                        return 'Password has to be similar';
                      }
                      return null;
                    },
                    onSaved: (String? newValue) {
                      password = newValue ?? '';
                    },
                  ),
                ],
              ),
            ),
            Column(
              children: [
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : TextButton(
                        onPressed: () => onSubmitPressed(context),
                        child: const Text('Sign up'),
                      ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RouteNames.login);
                  },
                  child: const Text('Go to login page'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
