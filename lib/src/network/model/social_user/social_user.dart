import 'package:json_annotation/json_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i2hand/src/network/model/common/social_type.dart';

part 'social_user.g.dart';

@JsonSerializable()
class MSocialUser {
  MSocialUser(
      {required this.type,
      this.userID,
      this.accessToken,
      this.idToken,
      this.fullName,
      this.email,
      this.avatar,
      this.birthDate,
      this.gender,
      this.phone});

  final MSocialType type;

  /// Apple userID
  final String? userID;

  /// Google Access Token
  final String? accessToken;

  /// Google ID Token
  final String? idToken;

  /// Google information
  final String? fullName;
  final String? email;
  final String? avatar;
  final String? birthDate;
  final int? gender;
  final String? phone;

  factory MSocialUser.fromGoogleAccount(
    GoogleSignInAccount account,
    GoogleSignInAuthentication googleAuth,
  ) {
    return MSocialUser(
      type: MSocialType.google,
      fullName: account.displayName,
      email: account.email,
      avatar: account.photoUrl,
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }
  MSocialUser copyWith(
      {MSocialType? type,
      String? userID,
      String? accessToken,
      String? idToken,
      String? fullName,
      String? email,
      String? avatar,
      String? birthDate,
      int? gender,
      String? phone}) {
    return MSocialUser(
        type: type ?? this.type,
        userID: userID ?? this.userID,
        accessToken: accessToken ?? this.accessToken,
        idToken: idToken ?? this.idToken,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        phone: phone ?? this.phone);
  }

  @override
  String toString() {
    return 'MSocialUser{type=$type, userID=$userID, accessToken=$accessToken, idToken=$idToken, fullName=$fullName, email=$email, avatar=$avatar, birthDate=$birthDate, gender=$gender, phone=$phone}';
  }

  Map<String, dynamic> toJson() => _$MSocialUserToJson(this);

  factory MSocialUser.fromJson(Map<String, dynamic> json) =>
      _$MSocialUserFromJson(json);
}
