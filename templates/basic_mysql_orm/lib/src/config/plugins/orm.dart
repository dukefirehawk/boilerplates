import 'dart:async';
import 'dart:io';

import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_orm/angel3_orm.dart';
import 'package:angel3_orm_mysql/angel3_orm_mysql.dart';
import 'package:mysql_client/mysql_client.dart';

// For MariaDb
Future<void> configureServer(Angel app) async {
  try {
    var connection = await connectToMySQL(app.configuration);
    var executor = MySqlExecutor(connection, logger: app.logger);

    app
      ..container.registerSingleton<QueryExecutor>(executor)
      ..shutdownHooks.add((_) => connection.close());
  } catch (e) {
    app.logger.severe("Failed to connect to MySQL. ORM disabled.", e);
  }
}

// MariaDB connection
Future<MySQLConnection> connectToMySQL(Map configuration) async {
  var mysqlDbConfig = configuration['mysql'] as Map? ?? {};

  var connection = await MySQLConnection.createConnection(
    databaseName:
        mysqlDbConfig['database_name'] as String? ??
        Platform.environment['USER'] ??
        Platform.environment['USERNAME'] ??
        '',
    port: mysqlDbConfig['port'] as int? ?? 3306,
    host: mysqlDbConfig['host'] as String? ?? 'localhost',
    userName: Platform.environment['MYSQL_USERNAME'] ?? 'test',
    password: Platform.environment['MYSQL_PASSWORD'] ?? 'Test123',
    secure: mysqlDbConfig['use_ssl'] as bool? ?? false,
  );

  var timeout = mysqlDbConfig['timeout_in_seconds'] as int? ?? 30000;
  await connection.connect(timeoutMs: timeout);

  return connection;
}
