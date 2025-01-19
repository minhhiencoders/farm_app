import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveUtils {
  static late Box box;

  /// Initialize Hive with a custom path and open the default box
  static Future<void> initHive([String boxName = 'myBox']) async {
    final appDocumentDirectory =
    await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    box = await Hive.openBox(boxName);
  }

  /// Register an adapter for a custom object
  static void registerAdapter<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }

  /// Save data to the box
  static Future<void> saveData<T>({
    required String key,
    required T value,
  }) async {
    await box.put(key, value);
  }

  /// Get data from the box
  static T? getData<T>({
    required String key,
  }) {
    return box.get(key) as T?;
  }

  /// Delete data from the box
  static Future<void> deleteData({
    required String key,
  }) async {
    await box.delete(key);
  }

  /// Clear all data in the box
  static Future<void> clearBox() async {
    await box.clear();
  }

  /// Delete the box and all its contents
  static Future<void> deleteBox() async {
    await box.deleteFromDisk();
  }

  /// Get all keys in the box
  static List<dynamic> getAllKeys() {
    return box.keys.toList();
  }

  /// Get all values in the box
  static List<dynamic> getAllValues() {
    return box.values.toList();
  }

  /// Check if a key exists in the box
  static bool containsKey({
    required String key,
  }) {
    return box.containsKey(key);
  }

  /// Add multiple items to the box
  static Future<void> addMultiple({
    required Map<String, dynamic> entries,
  }) async {
    await box.putAll(entries);
  }

  /// Close all open Hive boxes
  static Future<void> closeAllBoxes() async {
    try {
      await box.clear();
      await box.deleteFromDisk();
      await box.flush();
      await box.close();
    } catch (e) {
      print('Error closing Hive boxes: $e');
      rethrow;
    }
  }

  /// Check if the box is open
  static bool isBoxOpen() {
    return box.isOpen;
  }

  /// Get the box name
  static String getBoxName() {
    return box.name;
  }
}