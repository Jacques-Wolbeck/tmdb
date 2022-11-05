import 'package:flutter/material.dart';

class AppRichText extends StatelessWidget {
  final String text1;
  final String text2;
  const AppRichText({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: RichText(
        text: TextSpan(
          text: text1,
          style: Theme.of(context).textTheme.bodyText2!.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
          children: <TextSpan>[
            TextSpan(
              text: text2,
              style: Theme.of(context).textTheme.bodyText2!.merge(
                    const TextStyle(
                      color: Colors.white,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
