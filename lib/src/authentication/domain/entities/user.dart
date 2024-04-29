import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String createdAt;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.empty()
      : this(
          id: 1,
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.avatar',
        );

  @override
  List<Object> get props => [id];
}


/*

class User {
  final int id;
  final String createdAt;
  final String name;
  final String avatar;

  User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });
  
  @override
  bool operator==(other){
    return identical(this, other) ||
      other is User &&
      other.runtimeType == runtimeType &&
      other.id == id &&
      other.name == name;
  }
  
  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

 */