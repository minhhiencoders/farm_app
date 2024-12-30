import 'package:hive/hive.dart';

class HiveUtils {
  /// Opens a Hive box with the given name.
  /// If the box is already open, it returns the existing instance.
  static Future<Box<T>> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  /// Add data to a box
  static Future<void> addData<T>(String boxName, T data) async {
    final box = await openBox<T>(boxName);
    await box.add(data);
  }

  /// Stores a value in the specified Hive box.
  ///
  /// [boxName]: Name of the Hive box.
  /// [key]: Key to store the value under.
  /// [value]: Value to store.
  static Future<void> putValue<T>(String boxName, dynamic key, T value) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
  }

  /// Retrieves a value from the specified Hive box.
  ///
  /// [boxName]: Name of the Hive box.
  /// [key]: Key to retrieve the value from.
  /// [defaultValue]: Default value to return if the key is not found.
  static Future<T?> getValue<T>(String boxName, dynamic key,
      {T? defaultValue}) async {
    final box = await openBox<T>(boxName);
    return box.get(key, defaultValue: defaultValue);
  }

  /// Deletes a value from the specified Hive box.
  ///
  /// [boxName]: Name of the Hive box.
  /// [key]: Key of the value to delete.
  static Future<void> deleteValue<T>(String boxName, dynamic key) async {
    final box = await openBox<T>(boxName);
    await box.delete(key);
  }

  /// Clears all the values from the specified Hive box.
  ///
  /// [boxName]: Name of the Hive box.
  static Future<void> clearBox<T>(String boxName) async {
    final box = await openBox<T>(boxName);
    await box.clear();
  }

  /// Closes the specified Hive box.
  ///
  /// [boxName]: Name of the Hive box.
  static Future<void> closeBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.box(boxName);
      await box.close();
    }
  }

  /// Checks if a key exists in the specified Hive box.
  ///
  /// [boxName]: Name of the Hive box.
  /// [key]: Key to check.
  static Future<bool> containsKey<T>(String boxName, dynamic key) async {
    final box = await openBox<T>(boxName);
    return box.containsKey(key);
  }

  /// Close all boxes
  static Future<void> closeAll() async {
    // await Hive.close();
    await Hive.deleteFromDisk();
  }
}
