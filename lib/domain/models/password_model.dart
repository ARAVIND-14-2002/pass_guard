import 'package:hive/hive.dart';

part 'password_model.g.dart';

@HiveType(typeId: 0)
class PasswordModel {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String nickname;
  @HiveField(2)
  final int type;
  @HiveField(3)
  final String pathLogo;
  @HiveField(4, defaultValue: '')
  final String email;
  @HiveField(5)
  final String password;
  @HiveField(6, defaultValue: '')
  final String website;
  @HiveField(7)
  final DateTime date;
  @HiveField(8, defaultValue: false)
  final bool isFavorite;

  PasswordModel({
    required this.uid,
    required this.nickname,
    required this.type,
    required this.pathLogo,
    this.email = '',
    required this.password,
    this.website = '',
    required this.date,
    required this.isFavorite,
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'nickname': nickname,
    'type': type,
    'pathLogo': pathLogo,
    'email': email,
    'password': password,
    'website': website,
    'date': date.toIso8601String(),
    'isFavorite': isFavorite,
  };

  factory PasswordModel.fromJson(Map<String, dynamic> json) {
    return PasswordModel(
      uid: json['uid'] as String,
      nickname: json['nickname'] as String,
      type: json['type'] as int,
      pathLogo: json['pathLogo'] as String,
      email: json['email'] as String? ?? '',
      password: json['password'] as String,
      website: json['website'] as String? ?? '',
      date: DateTime.parse(json['date'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

}
