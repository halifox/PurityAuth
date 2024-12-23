import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:purity_auth/auth.dart';
import 'package:purity_auth/encrypt_codec.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

abstract class AuthRepository {
  List<AuthenticationConfig> snapshot = <AuthenticationConfig>[];

  Future<List<AuthenticationConfig>> selectAll();

  Future<List<AuthenticationConfig>> selectByIssuerAndAccount(String issuer, String account);

  Future<String> insert(AuthenticationConfig config);

  Future<String> update(AuthenticationConfig config);

  Future<String> upsert(AuthenticationConfig config);

  Future<String?> delete(AuthenticationConfig config);

  void addListener(Listener listener);

  void removeListener(Listener listener);
}

typedef Listener = void Function(List<AuthenticationConfig>);

class AuthRepositoryImpl extends AuthRepository {
  final StoreRef<String, Map<String, Object?>> store = stringMapStoreFactory.store();
  final Completer<Database> _authDBCompleter = Completer();

  Future<Database> get _authDB async => _authDBCompleter.future;

  AuthRepositoryImpl() {
    _initDatabase().then((_) => _listenAuthDB()).then((_) => debug());
  }

  debug() async {
    final Database db = await _authDB;
    if (kDebugMode) {
      await store.delete(db);
      upsert(AuthenticationConfig(secret: 'JQSR2VNH75AMLYRV'));
      upsert(AuthenticationConfig(secret: 'JQSR2VNH75AMLYRV', type: Type.hotp));
    }
  }

  final List<Listener> _listeners = <Listener>[];

  @override
  void addListener(Listener listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(Listener listener) {
    _listeners.remove(listener);
  }

  void notifyListeners(List<AuthenticationConfig> configs) {
    for (Listener listener in _listeners) {
      listener(configs);
    }
  }

  Future<void> _initDatabase() async {
    if (kIsWeb) {
      final Database db = await EncryptedDatabaseFactory(databaseFactory: databaseFactoryWeb, password: '99999').openDatabase('auth');
      _authDBCompleter.complete(db);
    } else {
      final Directory dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);
      final String path = join(dir.path, 'auth.db');
      final Database db = await EncryptedDatabaseFactory(databaseFactory: databaseFactoryIo, password: '99999').openDatabase(path);
      _authDBCompleter.complete(db);
    }
  }

  Future<void> _listenAuthDB() async {
    final Database db = await _authDB;
    store.query().onSnapshot(db).listen((_) async {
      snapshot = await selectAll();
      notifyListeners(snapshot);
    });
  }

  @override
  Future<List<AuthenticationConfig>> selectAll() async {
    final Database db = await _authDB;
    final List<RecordSnapshot<String, Map<String, Object?>>> records = await store.find(db);
    return records.map((RecordSnapshot<String, Map<String, Object?>> e) {
      final AuthenticationConfig auth = AuthenticationConfig.fromJson(e.value)..key = e.key;
      return auth;
    }).toList();
  }

  @override
  Future<List<AuthenticationConfig>> selectByIssuerAndAccount(String issuer, String account) async {
    final Database db = await _authDB;
    final Finder finder = Finder(
        filter: Filter.and(<Filter>[
      Filter.equals('issuer', issuer),
      Filter.equals('account', account),
    ]));
    final List<RecordSnapshot<String, Map<String, Object?>>> records = await store.find(db, finder: finder);
    return records.map((RecordSnapshot<String, Map<String, Object?>> e) => AuthenticationConfig.fromJson(e.value)..key = e.key).toList();
  }

  @override
  Future<String> insert(AuthenticationConfig config) async {
    final Database db = await _authDB;
    if (config.isBase32Encoded && !AuthenticationConfig.verifyBase32(config.secret)) {
      throw ArgumentError('Invalid secret');
    }
    if ((await selectByIssuerAndAccount(config.issuer, config.account)).isNotEmpty) {
      throw ArgumentError('label and issuer repeat on the db');
    }
    return await store.add(db, AuthenticationConfig.toJson(config));
  }

  @override
  Future<String> update(AuthenticationConfig config) async {
    final Database db = await _authDB;
    final String key = config.key ?? (throw ArgumentError('Invalid dbKey is null'));
    if (config.isBase32Encoded && !AuthenticationConfig.verifyBase32(config.secret)) {
      throw ArgumentError('Invalid secret');
    }
    await store.record(key).update(db, AuthenticationConfig.toJson(config));
    return key;
  }

  @override
  Future<String> upsert(AuthenticationConfig config) async {
    return config.key != null ? await update(config) : await insert(config);
  }

  @override
  Future<String?> delete(AuthenticationConfig config) async {
    final Database db = await _authDB;
    final String key = config.key ?? (throw ArgumentError('Invalid dbKey is null'));
    return await store.record(key).delete(db);
  }
}
