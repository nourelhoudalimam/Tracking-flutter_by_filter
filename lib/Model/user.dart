
class User{
  String id;
  String fullname;
  String username;
  String email;
  String filter;
  List<Authority> authorities;
  bool enabled;
  bool accountNonLocked;
  bool accountNonExpired;
bool credentialsNonExpired;
User({required this.id,required this.fullname,required this.username,required this.email ,required this.filter,required this.accountNonExpired,required this.accountNonLocked,required this.authorities,required this.credentialsNonExpired,required this.enabled});
   factory User.fromJson(dynamic json) {
    return User(
      id: json['id'] ?? "",
      fullname: json['fullname'] ?? "",
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      filter: json['filter'] ?? "",
      accountNonExpired: json['accountNonExpired'] ?? true,
      accountNonLocked: json['accountNonLocked'] ?? true,
      credentialsNonExpired: json['credentialsNonExpired'] ?? true,
      enabled: json['enabled'] ?? true,
      authorities: (json['authorities'] as List<dynamic>?)
              ?.map((authorityJson) =>
                  Authority.fromJson(authorityJson))
              .toList() ??
          [],
    );
  }
  
  }
  class Authority{String authority;
  Authority({required this.authority});
   factory Authority.fromJson( dynamic json) {
    return Authority(
      authority: json['authority'] ?? "",
    );
  }
  }