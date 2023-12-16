class Token{
  int id;
 String jwt;
  Token({required this.id,required this.jwt});
  factory Token.fromJson( dynamic json) {
    return Token(
      id: json['id'] ?? 0,
      jwt: json['jwt'] ?? [],
    );
  }
}