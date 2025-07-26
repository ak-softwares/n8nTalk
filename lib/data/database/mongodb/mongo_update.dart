import 'package:mongo_dart/mongo_dart.dart';
import 'mongo_base.dart';
import '../../../utils/constants/db_constants.dart';

class MongoUpdate extends MongoDatabase {
  // Singleton implementation
  static final MongoUpdate _instance = MongoUpdate._internal();
  factory MongoUpdate() => _instance;
  MongoUpdate._internal();

  Future<void> _ensureConnected() async {
    await MongoDatabase.ensureConnected();
  }

  ObjectId? safeObjectIdFromHex(String? id) {
    if (id == null || id.length != 24) return null;

    try {
      return ObjectId.fromHexString(id);
    } catch (e) {
      print('Invalid ObjectId: $id - Error: $e');
      return null;
    }
  }

  Future<void> updateDocumentById({
    required String collectionName,
    required String id,
    required Map<String, dynamic> updatedData,
  }) async {
    await _ensureConnected();
    try {
      final objectId = ObjectId.fromHexString(id);

      // Remove _id from updatedData (if it exists)
      final filteredData = Map<String, dynamic>.from(updatedData)
        ..remove('_id');

      final result = await db!.collection(collectionName).updateOne(
        {'_id': objectId},
        {
          '\$set': filteredData,
        },
        upsert: true,
      );

      if (!result.isSuccess && result.nModified == 0) {
        throw Exception('No document was updated. Possibly invalid ID or no data changes.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDocument({
    required String collectionName,
    required Map<String, dynamic> filter,
    required Map<String, dynamic> updatedData,
  }) async {
    await _ensureConnected();
    try {
      await db!.collection(collectionName).update(
        filter,
        {'\$set': updatedData},
        upsert: true,
      );
    } catch (e) {
      throw Exception('Failed to update document: $e');
    }
  }


  Future<void> updateBalance({
    required String collectionName,
    required String entityId,
    required double amount,
    required bool isAddition,
  }) async {
    await _ensureConnected();
    try {
      final objectId = ObjectId.fromHexString(entityId);

      await db!.collection(collectionName).update(
        where.id(objectId),
        {'\$inc': {'balance': isAddition ? amount : -amount}},
        upsert: true,
      );
    } catch (e) {
      throw Exception('Failed to update balance: $e');
    }
  }

  Future<void> updateDocuments({
    required String collectionName,
    required Map<String, dynamic> filter,
    required Map<String, dynamic> updatedData,
  }) async {
    await _ensureConnected();
    try {
      final collection = db!.collection(collectionName);
      await collection.updateMany(
        filter,
        {'\$set': updatedData},
        upsert: true,
      );
    } catch (e) {
      throw Exception('Failed to update documents: $e');
    }
  }

  Future<void> updateManyDocuments({
    required String collectionName,
    required List<Map<String, dynamic>> updates,
  }) async {
    try {
      await _ensureConnected();
      final collection = db!.collection(collectionName);

      for (var update in updates) {
        final id = update['id'];
        if (id != null) {
          final updateData = Map<String, dynamic>.from(update)..remove('id');
          await collection.updateOne(
            where.eq('id', id),
            {'\$set': updateData},
            upsert: false,
          );
        }
      }
    } catch (e) {
      throw Exception('Failed to update documents: $e');
    }
  }

  Future<void> updateManyDocumentsById({
    required String collectionName,
    required List<String> ids,
    required Map<String, dynamic> updatedData,
  }) async {
    await _ensureConnected();

    try {
      if (ids.isEmpty) {
        throw ArgumentError('IDs list cannot be empty');
      }

      final objectIds = ids.map((id) {
        try {
          return ObjectId.fromHexString(id);
        } catch (e) {
          throw FormatException('Invalid ObjectId format for ID: $id');
        }
      }).toList();

      final writeResult = await db!.collection(collectionName).updateMany(
        {OrderFieldName.id: {'\$in': objectIds}},
        {'\$set': updatedData},
        upsert: true,
      );

      if (writeResult.nModified == 0) {
        throw Exception('⚠️ No orders were updated - check if IDs exist');
      }
    } on FormatException catch (e) {
      throw Exception('ID format error: ${e.message}');
    } on MongoDartError catch (e) {
      throw Exception('Database operation failed: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update documents: ${e.toString()}');
    }
  }
}