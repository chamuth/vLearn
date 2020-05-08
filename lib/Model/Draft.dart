import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class Draft
{
  final String threadId;
  final String content;

  static Database dbInstance;
  
  static StoreRef store = StoreRef.main();

  Draft(this.threadId, this.content);

  Map<String, dynamic> toMap()
  {
    return {
      "threadId" : threadId,
      "content" : content
    };
  }

  static Future initialize() async
  {
    var appDocumentDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDocumentDir.path, 'drafts.db');
    DatabaseFactory dbFactory = databaseFactoryIo;
    dbInstance = await dbFactory.openDatabase(dbPath);
  }

  static Future insertOrUpdateDraft(Draft draft) async
  {
    store.record(draft.threadId).exists(dbInstance).then((exists) 
    {
      if (exists)
        store.record(draft.threadId).update(dbInstance, draft.content);
      else 
        store.record(draft.threadId).add(dbInstance, draft.content);
    });
  }
  
  static Future<Draft> readDraft(String threadId) async
  {
    return Draft(threadId, await store.record(threadId).get(dbInstance) as String);
  }

}