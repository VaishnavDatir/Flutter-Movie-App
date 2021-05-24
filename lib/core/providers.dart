import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/locator.dart';
import '../core/services/navigator_service.dart';

class ProviderInjector {
  static List<SingleChildWidget> providers = [
    ..._independentServices,
    ..._dependentServices,
    ..._consumableServices,
  ];

  static List<SingleChildWidget> _independentServices = [
    Provider.value(value: locator<NavigationService>()),
  ];

  static List<SingleChildWidget> _dependentServices = [];

  static List<SingleChildWidget> _consumableServices = [];
}
