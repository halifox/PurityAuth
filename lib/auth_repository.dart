import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:purity_auth/auth.dart';
import 'package:purity_auth/encrypt_codec.dart';
import 'package:purity_auth/otp.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

abstract class AuthRepository {
  List<AuthConfiguration> snapshot = [];

  Future<List<AuthConfiguration>> selectAll();

  Future<List<AuthConfiguration>> selectByIssuerAndAccount(String issuer, String account);

  Future<String> insert(AuthConfiguration configuration);

  Future<String> update(AuthConfiguration configuration);

  Future<String> upsert(AuthConfiguration configuration);

  Future<String?> delete(AuthConfiguration configuration);

  void addListener(Listener listener);

  void removeListener(Listener listener);
}

typedef Listener = void Function(List<AuthConfiguration>);

class AuthRepositoryImpl extends AuthRepository {
  final store = stringMapStoreFactory.store();
  final Completer<Database> _authDBCompleter = Completer();

  Future<Database> get _authDB async => _authDBCompleter.future;

  AuthRepositoryImpl() {
    _initDatabase().then((_) => _listenAuthDB()).then((_) => debug());
  }

  debug() async {
    final Database db = await _authDB;
    if (kDebugMode) {
      await store.delete(db);
      upsert(AuthConfiguration(secret: "JQSR2VNH75AMLYRV"));
      upsert(AuthConfiguration(secret: "JQSR2VNH75AMLYRV", type: Type.hotp));
    }
  }

  final List<Listener> _listeners = [];

  @override
  void addListener(Listener a) {
    _listeners.add(a);
  }

  @override
  void removeListener(Listener a) {
    _listeners.remove(a);
  }

  void notifyListeners(List<AuthConfiguration> data) {
    for (var listener in _listeners) {
      listener(data);
    }
  }

  Future<void> _initDatabase() async {
    if (kIsWeb) {
      final db = await EncryptedDatabaseFactory(databaseFactory: databaseFactoryWeb, password: '99999').openDatabase('auth');
      _authDBCompleter.complete(db);
    } else {
      final dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);
      final path = join(dir.path, 'auth.db');
      final db = await EncryptedDatabaseFactory(databaseFactory: databaseFactoryIo, password: '99999').openDatabase(path);
      _authDBCompleter.complete(db);
    }
  }

  Future<void> _listenAuthDB() async {
    final db = await _authDB;
    store.query().onSnapshot(db).listen((_) async {
      snapshot = await selectAll();
      notifyListeners(snapshot);
    });
  }

  @override
  Future<List<AuthConfiguration>> selectAll() async {
    final db = await _authDB;
    final records = await store.find(db);
    return records.map((e) {
      final auth = AuthConfiguration.fromJson(e.value)..dbKey = e.key;
      return auth;
    }).toList();
  }

  @override
  Future<List<AuthConfiguration>> selectByIssuerAndAccount(String issuer, String account) async {
    final db = await _authDB;
    final finder = Finder(
        filter: Filter.and([
      Filter.equals('issuer', issuer),
      Filter.equals('account', account),
    ]));
    final records = await store.find(db, finder: finder);
    return records.map((e) => AuthConfiguration.fromJson(e.value)..dbKey = e.key).toList();
  }

  @override
  Future<String> insert(AuthConfiguration configuration) async {
    final db = await _authDB;
    if (configuration.isBase32Encoded && !AuthConfiguration.verifyBase32(configuration.secret)) {
      throw ArgumentError("Invalid secret");
    }
    if ((await selectByIssuerAndAccount(configuration.issuer, configuration.account)).isNotEmpty) {
      throw ArgumentError("label and issuer repeat on the db");
    }
    return await store.add(db, AuthConfiguration.toJson(configuration));
  }

  @override
  Future<String> update(AuthConfiguration configuration) async {
    final db = await _authDB;
    final key = configuration.dbKey ?? (throw ArgumentError("Invalid dbKey is null"));
    if (configuration.isBase32Encoded && !AuthConfiguration.verifyBase32(configuration.secret)) {
      throw ArgumentError("Invalid secret");
    }
    await store.record(key).update(db, AuthConfiguration.toJson(configuration));
    return key;
  }

  @override
  Future<String> upsert(AuthConfiguration configuration) async {
    return configuration.dbKey != null ? await update(configuration) : await insert(configuration);
  }

  @override
  Future<String?> delete(AuthConfiguration configuration) async {
    final db = await _authDB;
    final key = configuration.dbKey ?? (throw ArgumentError("Invalid dbKey is null"));
    return await store.record(key).delete(db);
  }
}
