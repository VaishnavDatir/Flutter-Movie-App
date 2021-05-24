import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/locator.dart';
import 'core/providers.dart';
import 'core/routes/router.dart' as router;
import 'core/routes/router_path.dart';
import 'core/services/navigator_service.dart';
import 'theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // statusBarBrightness: Brightness.light,
      // statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: _wrapWithBanner(
        MaterialApp(
          title: "Show Pickup",
          theme: appTheme,
          navigatorKey: locator<NavigationService>().navigationKey,
          onGenerateRoute: router.generateRoute,
          initialRoute: kHomeScreen,
          // home: HomeView(),
        ),
      ),
    );
  }

  Widget _wrapWithBanner(Widget child) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        child: child,
        location: BannerLocation.bottomEnd,
        message: 'BETA',
        color: Colors.green[800],
        textStyle: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
