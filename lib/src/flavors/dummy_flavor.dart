import '../apis/apis.dart';
import 'flavors.dart';

const _dummyFlavor = Flavor(
  cardApi: DummyCardApi(),
  tagApi: DummyTagApi(),
);

Future<Flavor> buildFlavor(String path) async => _dummyFlavor;
