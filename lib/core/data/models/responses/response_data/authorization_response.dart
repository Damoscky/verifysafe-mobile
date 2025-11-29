import 'package:verifysafe/core/data/models/authorization.dart';
import 'package:verifysafe/core/data/models/onboarding.dart';
import 'package:verifysafe/core/data/models/user.dart';

class AuthorizationResponse {
  String? accessToken;
  String? tokenType;
  String? expiresAt;
  User? user;
  bool? twoFaEnabled;
  Authorization? authorization;
  Onboarding? onboarding;
  String? tokenExpiresAt;

  AuthorizationResponse({
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.user,
    this.twoFaEnabled,
    this.authorization,
    this.onboarding,
    this.tokenExpiresAt,
  });

  factory AuthorizationResponse.fromJson(Map<String, dynamic> json) {
    return AuthorizationResponse(
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      expiresAt: json['expires_at'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      twoFaEnabled: json['2fa_enabled'] as bool?,
      authorization: json['authorization'] != null
          ? Authorization.fromJson(json['authorization'])
          : null,
      onboarding: json['onboarding'] != null
          ? Onboarding.fromJson(json['onboarding'])
          : null,
      tokenExpiresAt: json['token_expires_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_at': expiresAt,
      'user': user?.toJson(),
      '2fa_enabled': twoFaEnabled,
      'authorization': authorization?.toJson(),
      'onboarding': onboarding?.toJson(),
      'token_expires_at': tokenExpiresAt,
    };
  }
}
