import 'package:flutter_clean_arch_bloc/core/either/either.dart';
import 'package:flutter_clean_arch_bloc/core/failures/failures.dart';
import 'package:flutter_clean_arch_bloc/domain/entities/favorite_entity.dart';
import 'package:flutter_clean_arch_bloc/domain/repositories/favorites_repository_interface.dart';

/// Use case for toggling a cryptocurrency as favorite.
///
/// Atomically adds or removes the given symbol based on its favorite status
/// at the time the operation runs, avoiding a check-then-act race between
/// concurrent toggles of the same symbol.
class ToggleFavoriteUseCase {
  /// Creates a [ToggleFavoriteUseCase] with the required [FavoritesRepository].
  const ToggleFavoriteUseCase({required this.repository});

  /// The repository used to manage favorites.
  final FavoritesRepository repository;

  /// Executes the use case, returning either a [Failure] or the updated list
  /// of [FavoriteEntity] entities.
  Future<Either<Failure, List<FavoriteEntity>>> call(final String symbol) =>
      repository.toggleFavorite(symbol);
}
