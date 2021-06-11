import 'package:angel3_app/src/config/plugins/orm.dart';
import 'package:angel3_app/models.dart';
import 'package:angel3_configuration/angel3_configuration.dart';
import 'package:angel3_migration_runner/angel3_migration_runner.dart';
import 'package:angel3_migration_runner/postgres.dart';
import 'package:file/local.dart';

void main(List<String> args) async {
  var fs = LocalFileSystem();
  var configuration = await loadStandaloneConfiguration(fs);
  var connection = await connectToPostgres(configuration);
  var migrationRunner = PostgresMigrationRunner(connection, migrations: [
    GreetingMigration(),
  ]);
  return await runMigrations(migrationRunner, args);
}