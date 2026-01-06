import 'package:equatable/equatable.dart';

class UserPoints extends Equatable {
  final String id;
  final String userId;
  final int totalPoints;
  final int currentStreak;
  final int longestStreak;
  final int level;
  final int experience;
  final DateTime? lastStudyDate;
  final int hearts;
  final int maxHearts;
  final DateTime? heartsRefillAt;
  final bool unlimitedHearts;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserPoints({
    required this.id,
    required this.userId,
    required this.totalPoints,
    required this.currentStreak,
    required this.longestStreak,
    required this.level,
    required this.experience,
    this.lastStudyDate,
    required this.hearts,
    required this.maxHearts,
    this.heartsRefillAt,
    required this.unlimitedHearts,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    totalPoints,
    currentStreak,
    longestStreak,
    level,
    experience,
    lastStudyDate,
    hearts,
    maxHearts,
    heartsRefillAt,
    unlimitedHearts,
    createdAt,
    updatedAt,
  ];
}

class User extends Equatable {
  final String id;
  final String email;
  final String username;
  final String fullName;
  final String? avatar;
  final String? bio;
  final String role;
  final String currentLevel;
  final String provider;
  final bool isVerified;
  final bool isActive;
  final DateTime? lastLoginAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserPoints? points;

  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.fullName,
    this.avatar,
    this.bio,
    required this.role,
    required this.currentLevel,
    required this.provider,
    required this.isVerified,
    required this.isActive,
    this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
    this.points,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    username,
    fullName,
    avatar,
    bio,
    role,
    currentLevel,
    provider,
    isVerified,
    isActive,
    lastLoginAt,
    createdAt,
    updatedAt,
    points,
  ];

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? fullName,
    String? avatar,
    String? bio,
    String? role,
    String? currentLevel,
    String? provider,
    bool? isVerified,
    bool? isActive,
    DateTime? lastLoginAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserPoints? points,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      role: role ?? this.role,
      currentLevel: currentLevel ?? this.currentLevel,
      provider: provider ?? this.provider,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      points: points ?? this.points,
    );
  }
}
