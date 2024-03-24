import 'package:auto_cache_manager/src/modules/cache/domain/dtos/clear_cache_dto.dart';

import '../../../../core/core.dart';
import '../../domain/dtos/get_cache_dto.dart';
import '../../domain/dtos/save_cache_dto.dart';
import '../../domain/repositories/i_cache_repository.dart';
import '../../domain/types/cache_types.dart';
import '../datasources/i_prefs_datasource.dart';
import '../datasources/i_sql_storage_datasource.dart';

class CacheRepository implements ICacheRepository {
  final IPrefsDatasource _prefsDatasource;
  final ISQLStorageDatasource _sqlDatasource;

  const CacheRepository(this._prefsDatasource, this._sqlDatasource);

  @override
  Future<GetCacheResponse<T>> findByKey<T extends Object>(GetCacheDTO dto) async {
    try {
      final action = dto.storageType.isPrefs ? _prefsDatasource.findByKey : _sqlDatasource.findByKey;

      final response = await action.call<T>(dto.key);

      return right(response);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }

  @override
  Future<Either<AutoCacheManagerException, Unit>> save<T extends Object>(SaveCacheDTO<T> dto) async {
    try {
      final action = dto.storageType.isPrefs ? _prefsDatasource.save : _sqlDatasource.save;

      await action.call<T>(dto);

      return right(unit);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }

  @override
  Future<Either<AutoCacheManagerException, Unit>> clear(ClearCacheDTO dto) async {
    try {
      final action = dto.storageType.isPrefs ? _prefsDatasource.clear : _sqlDatasource.clear;

      await action.call();

      return right(unit);
    } on AutoCacheManagerException catch (exception) {
      return left(exception);
    }
  }
}
