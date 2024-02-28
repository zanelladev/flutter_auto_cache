import '../dtos/save_cache_dto.dart';
import '../repositories/i_cache_repository.dart';
import '../types/cache_types.dart';

abstract interface class SaveCacheUsecase {
  SaveCacheResponseType execute<T>(SaveCacheDTO<T> dto);
}

class SaveCache implements SaveCacheUsecase {
  final ICacheRepository _repository;

  const SaveCache(this._repository);

  @override
  SaveCacheResponseType execute<T>(SaveCacheDTO<T> dto) async {
    final isKeyExisting = throw UnimplementedError();
  }
}


///Busca pela key
///Se não existir nada, salvar no cache
///Se já existir, verificar método de invalidação/substituição
///Se for refresh, atualizar o cache baseado na key
///Se for TTL, dar throw em erro dizendo que a key já é utilizada
