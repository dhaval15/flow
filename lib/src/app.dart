import 'package:flutter/material.dart';
import 'flavors/flavors.dart';
import 'providers/providers.dart';
import 'screens/screens.dart';
import 'styles/styles.dart';
import 'views/views.dart';
import 'widgets/widgets.dart';

class FlowApp extends StatelessWidget {
  const FlowApp();
  @override
  Widget build(BuildContext context) {
    return SchemeProvider(
      scheme: Schemes.withName(SharedPrefView.of(context).scheme),
      builder: (context, scheme) {
        return FutureBuilder<Flavor>(
          future: Future.microtask(() async {
            final path = await SingleProvider.of<AppProvider>(context).rootPath;
            return Flavor.getFlavour(path);
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final tagProvider = TagProvider(snapshot.data!.tagApi);
              final cardProvider = CardProvider(snapshot.data!.cardApi);
              final flowProvider = FlowProvider(cardProvider);
              return Providers(
                data: [tagProvider, cardProvider, flowProvider],
                child: MaterialApp(
                  theme: scheme.theme,
                  initialRoute: Screens.HOME,
                  onGenerateRoute: ScreenRouteGenerator(),
                  debugShowCheckedModeBanner: false,
                ),
              );
            }
            if (snapshot.hasError)
              return MaterialApp(
                home: Center(
                  child: ErrorContainer(
                    tag: 'App',
                    error: snapshot.error.toString(),
                  ),
                ),
              );
            return Center(
              child: BouncingDotsIndiactor(),
            );
          },
        );
      },
    );
  }
}
