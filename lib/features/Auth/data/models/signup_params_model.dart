class SignupParamsModel {
  final String? email;
  final String? password;
  final String? name;
  final String? profilePic;
  final String? uid;

  SignupParamsModel({ this.email, this.password,  this.name,this.profilePic, this.uid, });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'profilePic': profilePic,
        'uid': uid,
      };
}