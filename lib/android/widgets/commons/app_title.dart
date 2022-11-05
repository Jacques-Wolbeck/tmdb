import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          text: 'TM',
          style: Theme.of(context).textTheme.headline5!.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
          children: <TextSpan>[
            TextSpan(
              text: 'Db',
              style: Theme.of(context).textTheme.headline5!.merge(
                    TextStyle(
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
