import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _performLogin() async {
    final storedPin = await _secureStorage.read(key: 'pin');
    final enteredPin = _pinController.text;

    if (storedPin == enteredPin) {
      // Perform login success logic
      print('Login Successful!');
    } else {
      // Perform login failure logic
      print('Invalid PIN. Please try again!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _pinController,
                decoration: const InputDecoration(
                  labelText: 'Enter 6-digit PIN',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your 6-digit PIN';
                  }
                  if (value.length != 6) {
                    return 'PIN must be 6 digits long';
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _performLogin();
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
