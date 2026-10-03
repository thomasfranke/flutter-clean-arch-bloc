import 'package:flutter_clean_arch_bloc/application/favorites/get_favorites_usecase.dart';
import 'package:flutter_clean_arch_bloc/core/either/either.dart';
import 'package:flutter_clean_arch_bloc/core/failures/failures.dart';
import 'package:flutter_clean_arch_bloc/domain/entities/favorite_entity.dart';
import 'package:flutter_clean_arch_bloc/domain/repositories/favorites_repository_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  late _MockFavoritesRepository repository;
  late GetFavoritesUseCase sut;

  setUp(() {
    repository = _MockFavoritesRepository();
    sut = GetFavoritesUseCase(repository: repository);
  });

  group('GetFavoritesUseCase', () {
    test('should delegate to repository.getFavorites', () async {
      when(() => repository.getFavorites()).thenAnswer(
        (_) async => const Right<Failure, List<FavoriteEntity>>(
          <FavoriteEntity>[FavoriteEntity(symbol: 'BTCUSDT')],
        ),
      );

      final Either<Failure, List<FavoriteEntity>> result = await sut();

      expect(
        result,
        const Right<Failure, List<FavoriteEntity>>(<FavoriteEntity>[
          FavoriteEntity(symbol: 'BTCUSDT'),
        ]),
      );
      verify(() => repository.getFavorites()).called(1);
    });

    test('should return Failure when the repository fails', () async {
      when(() => repository.getFavorites()).thenAnswer(
        (_) async =>
            const Left<Failure, List<FavoriteEntity>>(Failure.storage()),
      );

      final Either<Failure, List<FavoriteEntity>> result = await sut();

      expect(
        result,
        const Left<Failure, List<FavoriteEntity>>(Failure.storage()),
      );
    });
  });
}
