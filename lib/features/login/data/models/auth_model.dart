// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthModel {
  final String? accessToken;
  final String? refreshToken;
  final int? expiresIn;

  AuthModel({
    this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
      refreshToken:
          map['refreshToken'] != null ? map['refreshToken'] as String : null,
      expiresIn: map['expiresIn'] != null ? map['expiresIn'] as int : null,
    );
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        accessToken:
            json['accessToken'] != null ? json['accessToken'] as String : null,
        refreshToken: json['refreshToken'] != null
            ? json['refreshToken'] as String
            : null,
        expiresIn: json['expiresIn'] != null ? json['expiresIn'] as int : null,
      );
}
