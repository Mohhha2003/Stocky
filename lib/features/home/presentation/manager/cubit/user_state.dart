part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserUpdated extends UserState {}

final class UserSuccess extends UserState {}

final class UserFailed extends UserState {}

final class UserLogout extends UserState {}
