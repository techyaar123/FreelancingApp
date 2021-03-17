class Profile {
  final String entryusername;
  final String entryname;
  final String entryLocation;
  final String entrypassword;
  Profile(
      {this.entryusername,
      this.entryLocation,
      this.entryname,
      this.entrypassword});

  Map<String, dynamic> toMap() {
    return {
      'Full Name': entryname,
      'Username': entryusername,
      'Password': entrypassword,
      'Location': entryLocation
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      entryname: json['Full name'],
      entryusername: json['Username'],
      entrypassword: json['Password'],
      entryLocation: json['Location'],
    );
  }
}
