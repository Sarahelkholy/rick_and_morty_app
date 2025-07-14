import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp(RickyAndMorty(
    appRouter: AppRouter(),
  ));
}

class RickyAndMorty extends StatelessWidget {
  final AppRouter appRouter;
  const RickyAndMorty({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
