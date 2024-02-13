class UserProperties {
  final String uid;
  final String? fullName;
  final String? email;
  final String? photoUrl;
  final bool? emailVerified;
  // final String phone;

  UserProperties(
      {this.photoUrl,
      this.emailVerified,
      this.fullName,
      this.email,
      required this.uid});
}
