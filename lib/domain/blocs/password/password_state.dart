part of 'password_bloc.dart';

@immutable
class PasswordState extends Equatable {

  final int typePassword;
  final IconsLogo? iconLogo;
  final bool showPassword;

  const PasswordState({
    this.typePassword = 1,
    this.iconLogo,
    this.showPassword = false,
  });


  PasswordState copyWith({
    int? typePassword,
    IconsLogo? iconLogo,
    bool? showPassword,
  }) => PasswordState(
    typePassword: typePassword ?? this.typePassword,
    iconLogo: iconLogo,
    showPassword: showPassword ?? this.showPassword,
  );

  @override
  List<Object?> get props => [
    typePassword,
    iconLogo,
    showPassword,
  ];
}

class SuccessCreatePasswordStatus extends PasswordState {}

class SuccessFailurePasswordStatus extends PasswordState {}

