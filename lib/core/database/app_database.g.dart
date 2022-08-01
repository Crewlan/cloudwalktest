// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WeatherDao? _weatherDaoInstance;

  ForecastDao? _forecastDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `WeatherResponse` (`mainModel` TEXT, `weatherModel` TEXT, `name` TEXT, `cordModel` TEXT, PRIMARY KEY (`name`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `WeatherForecastResponse` (`mainModel` TEXT, `weatherModel` TEXT, `datetimeTxt` INTEGER, PRIMARY KEY (`datetimeTxt`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WeatherDao get weatherDao {
    return _weatherDaoInstance ??= _$WeatherDao(database, changeListener);
  }

  @override
  ForecastDao get forecastDao {
    return _forecastDaoInstance ??= _$ForecastDao(database, changeListener);
  }
}

class _$WeatherDao extends WeatherDao {
  _$WeatherDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _weatherResponseModelInsertionAdapter = InsertionAdapter(
            database,
            'WeatherResponse',
            (WeatherResponseModel item) => <String, Object?>{
                  'mainModel': _mainConverter.encode(item.mainModel),
                  'weatherModel': _weatherConverter.encode(item.weatherModel),
                  'name': item.name,
                  'cordModel': _coordConverter.encode(item.cordModel)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WeatherResponseModel>
      _weatherResponseModelInsertionAdapter;

  @override
  Future<WeatherResponseModel?> getWeatherResponse() async {
    return _queryAdapter.query('SELECT * FROM WeatherResponse',
        mapper: (Map<String, Object?> row) => WeatherResponseModel(
            mainModel: _mainConverter.decode(row['mainModel'] as String),
            weatherModel:
                _weatherConverter.decode(row['weatherModel'] as String),
            name: row['name'] as String?,
            cordModel: _coordConverter.decode(row['cordModel'] as String)));
  }

  @override
  Future<void> deleteWeatherResponse() async {
    await _queryAdapter.queryNoReturn('DELETE FROM WeatherResponse');
  }

  @override
  Future<void> insertWeatherResponse(
      WeatherResponseModel weatherResponseModel) async {
    await _weatherResponseModelInsertionAdapter.insert(
        weatherResponseModel, OnConflictStrategy.replace);
  }
}

class _$ForecastDao extends ForecastDao {
  _$ForecastDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _weatherForecastResponseModelInsertionAdapter = InsertionAdapter(
            database,
            'WeatherForecastResponse',
            (WeatherForecastResponseModel item) => <String, Object?>{
                  'mainModel': _mainConverter.encode(item.mainModel),
                  'weatherModel': _weatherConverter.encode(item.weatherModel),
                  'datetimeTxt': _dateTimeConverter.encode(item.datetimeTxt)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WeatherForecastResponseModel>
      _weatherForecastResponseModelInsertionAdapter;

  @override
  Future<List<WeatherForecastResponseModel>?>
      getWeatherForecastResponse() async {
    return _queryAdapter.queryList('SELECT * FROM WeatherForecastResponse',
        mapper: (Map<String, Object?> row) => WeatherForecastResponseModel(
            mainModel: _mainConverter.decode(row['mainModel'] as String),
            weatherModel:
                _weatherConverter.decode(row['weatherModel'] as String),
            datetimeTxt:
                _dateTimeConverter.decode(row['datetimeTxt'] as int?)));
  }

  @override
  Future<void> deleteWeatherForecastResponse() async {
    await _queryAdapter.queryNoReturn('DELETE FROM WeatherForecastResponse');
  }

  @override
  Future<void> insertWeatherForecastResponse(
      List<WeatherForecastResponseModel> weatherForecastResponseModel) async {
    await _weatherForecastResponseModelInsertionAdapter.insertList(
        weatherForecastResponseModel, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _mainConverter = MainConverter();
final _weatherConverter = WeatherConverter();
final _coordConverter = CoordConverter();
final _dateTimeConverter = DateTimeConverter();
