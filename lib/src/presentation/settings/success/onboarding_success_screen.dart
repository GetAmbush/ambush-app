import 'package:ambush_app/src/designsystem/buttons.dart';
import 'package:flutter/material.dart';

class OnboardingSuccessScreen extends StatelessWidget {
  const OnboardingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Success!',
                  style: textTheme.titleLarge,
                ),
                SizedBox(
                    height: 8),
                Text(
                  "All set! YOUR company's information has been\nsuccessfully submitted. We're ready to move\nforward with your invoice!",
                  textAlign: TextAlign.start, // Align left for subtitle
                  style: textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
                ),
              ],
            ),
            SizedBox(height: 32),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(

                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Image.asset(
                  'assets/illustration_success.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 64.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      
                    },
                    child: Text(
                      "I'll do it later",
                      style: TextStyle(
                        color: colorTheme.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0,),
                  PrimaryButton(
                    text: "Create Invoice",
                    onPressed: () {
                      
                    }
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
