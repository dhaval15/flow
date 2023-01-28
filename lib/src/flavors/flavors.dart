import 'sembast_flavor.dart' if (dart.library.html) 'dummy_flavor.dart';
import '../apis/apis.dart';

class Flavor {
  final TagApi tagApi;
  final CardApi cardApi;

  const Flavor({
    required this.tagApi,
    required this.cardApi,
  });

  static Future<Flavor> getFlavour(String path) => buildFlavor(path);
}
