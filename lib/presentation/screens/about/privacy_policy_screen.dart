import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              PolicyPoint(
                heading: '',
                text: 'Thank you for PassGuard. This Privacy Policy explains how we handle your personal information when you use our offline password manager application. Please note that our App does not require an internet connection, and we do not collect any data or information from you.',

              ),
              PolicyPoint(

                heading: 'Data Collection',
                text:'PassGuard operates entirely offline, and we do not collect any personal information from you. The App securely stores your passwords and sensitive information locally on your device, ensuring that your data remains under your control.',
              ),
              PolicyPoint(
                heading:'Data Security',
                text: 'We take data security seriously. PassGuard is designed to store your passwords and sensitive information securely on your device. We use industry-standard encryption and security measures to protect your data from unauthorized access, loss, or disclosure.',
              ),
              PolicyPoint(

                heading: 'Third-Party Services',
                text: 'PassGuard does not utilize any third-party services or integrations that may collect your data or personal information. All your data remains within the App and on your device.',
              ),
              PolicyPoint(
                heading: '''Children's Privacy''',
                text: 'PassGuard is not intended for use by children under the age of 13. We do not knowingly collect any personal information from children under the age of 13.',
              ),
              PolicyPoint(
                heading: 'Changes to this Privacy Policy',
                text: 'We may update this Privacy Policy from time to time to reflect any changes in our practices or legal requirements. Any updates will be provided once the application is available on Play store.',
              ),
              PolicyPoint(
                heading: 'Contact Us',
                text: 'If you have any questions or concerns about this Privacy Policy or our privacy practices, please contact us at [will be updated].',
              ),
              // Add more PolicyPoint widgets for additional policy points
            ],
          ),
        ),
      ),
    );
  }
}

class PolicyPoint extends StatelessWidget {
  final String? heading;
  final String text;

  const PolicyPoint({
    Key? key,
    this.heading,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null)
          Text(
            heading!,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (heading != null) const SizedBox(height: 8.0),
        Text(
          text,
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}