import 'flavors.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import '../apis/apis.dart';

Future<Flavor> buildFlavor(String path) async {
  String dbPath = join(path, 'inbox.db');
  final dbFactory = databaseFactoryIo;
  final database = await dbFactory.openDatabase(dbPath);
  return Flavor(
    tagApi: TagApi(database),
    cardApi: CardApi(database),
  );
}
