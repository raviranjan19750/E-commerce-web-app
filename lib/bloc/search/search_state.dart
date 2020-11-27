part of 'search_bloc.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  const SearchState._({
    this.status = SearchStatus.initial,
    this.suggestions = const <String>[],
  });

  const SearchState.initial() : this._();

  const SearchState.loading() : this._(status: SearchStatus.loading);

  const SearchState.success(List<String> suggestions)
      : this._(status: SearchStatus.success, suggestions: suggestions);

  const SearchState.failure() : this._(status: SearchStatus.failure);

  final SearchStatus status;
  final List<String> suggestions;

  @override
  List<Object> get props => [status, suggestions];
}
