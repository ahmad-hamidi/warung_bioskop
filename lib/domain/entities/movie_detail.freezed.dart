// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MovieDetail {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get posterPath => throw _privateConstructorUsedError;
  String get overView => throw _privateConstructorUsedError;
  String? get backdropPath => throw _privateConstructorUsedError;
  int get runtime => throw _privateConstructorUsedError;
  double get voteAverage => throw _privateConstructorUsedError;
  List<String> get genres => throw _privateConstructorUsedError;

  /// Create a copy of MovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieDetailCopyWith<MovieDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieDetailCopyWith<$Res> {
  factory $MovieDetailCopyWith(
          MovieDetail value, $Res Function(MovieDetail) then) =
      _$MovieDetailCopyWithImpl<$Res, MovieDetail>;
  @useResult
  $Res call(
      {int id,
      String title,
      String? posterPath,
      String overView,
      String? backdropPath,
      int runtime,
      double voteAverage,
      List<String> genres});
}

/// @nodoc
class _$MovieDetailCopyWithImpl<$Res, $Val extends MovieDetail>
    implements $MovieDetailCopyWith<$Res> {
  _$MovieDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? posterPath = freezed,
    Object? overView = null,
    Object? backdropPath = freezed,
    Object? runtime = null,
    Object? voteAverage = null,
    Object? genres = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      overView: null == overView
          ? _value.overView
          : overView // ignore: cast_nullable_to_non_nullable
              as String,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      runtime: null == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieDetailImplCopyWith<$Res>
    implements $MovieDetailCopyWith<$Res> {
  factory _$$MovieDetailImplCopyWith(
          _$MovieDetailImpl value, $Res Function(_$MovieDetailImpl) then) =
      __$$MovieDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String? posterPath,
      String overView,
      String? backdropPath,
      int runtime,
      double voteAverage,
      List<String> genres});
}

/// @nodoc
class __$$MovieDetailImplCopyWithImpl<$Res>
    extends _$MovieDetailCopyWithImpl<$Res, _$MovieDetailImpl>
    implements _$$MovieDetailImplCopyWith<$Res> {
  __$$MovieDetailImplCopyWithImpl(
      _$MovieDetailImpl _value, $Res Function(_$MovieDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of MovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? posterPath = freezed,
    Object? overView = null,
    Object? backdropPath = freezed,
    Object? runtime = null,
    Object? voteAverage = null,
    Object? genres = null,
  }) {
    return _then(_$MovieDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      overView: null == overView
          ? _value.overView
          : overView // ignore: cast_nullable_to_non_nullable
              as String,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      runtime: null == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$MovieDetailImpl implements _MovieDetail {
  _$MovieDetailImpl(
      {required this.id,
      required this.title,
      this.posterPath,
      required this.overView,
      this.backdropPath,
      required this.runtime,
      required this.voteAverage,
      required final List<String> genres})
      : _genres = genres;

  @override
  final int id;
  @override
  final String title;
  @override
  final String? posterPath;
  @override
  final String overView;
  @override
  final String? backdropPath;
  @override
  final int runtime;
  @override
  final double voteAverage;
  final List<String> _genres;
  @override
  List<String> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  String toString() {
    return 'MovieDetail(id: $id, title: $title, posterPath: $posterPath, overView: $overView, backdropPath: $backdropPath, runtime: $runtime, voteAverage: $voteAverage, genres: $genres)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.overView, overView) ||
                other.overView == overView) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.runtime, runtime) || other.runtime == runtime) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            const DeepCollectionEquality().equals(other._genres, _genres));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      posterPath,
      overView,
      backdropPath,
      runtime,
      voteAverage,
      const DeepCollectionEquality().hash(_genres));

  /// Create a copy of MovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieDetailImplCopyWith<_$MovieDetailImpl> get copyWith =>
      __$$MovieDetailImplCopyWithImpl<_$MovieDetailImpl>(this, _$identity);
}

abstract class _MovieDetail implements MovieDetail {
  factory _MovieDetail(
      {required final int id,
      required final String title,
      final String? posterPath,
      required final String overView,
      final String? backdropPath,
      required final int runtime,
      required final double voteAverage,
      required final List<String> genres}) = _$MovieDetailImpl;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get posterPath;
  @override
  String get overView;
  @override
  String? get backdropPath;
  @override
  int get runtime;
  @override
  double get voteAverage;
  @override
  List<String> get genres;

  /// Create a copy of MovieDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieDetailImplCopyWith<_$MovieDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
