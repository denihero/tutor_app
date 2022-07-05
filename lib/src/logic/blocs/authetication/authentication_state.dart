part of 'authentication_bloc.dart';

abstract class AuthState extends Equatable {
  final String email;
  final String token;
  final String name;
  final String surname;
  final String? image;
  final int idInfo;
  const AuthState(
      {this.name = "",
      this.surname = "",
      this.email = "",
      this.token = "",
      this.image,
      this.idInfo = -1});

  fromMap(Map<String, dynamic> map) {
    if (map["email"] != "") {
      return AuthSuccess(
        map["email"] as String,
        map["token"] as String,
        map["name"] as String,
        map["surname"] as String,
        map["image"] as String,
        map["id_info"] as int,
      );
    }
    return AuthInitial(
      email: map["email"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "token": token,
      "name": name,
      "surname": surname,
      "image": image ?? "",
      "id_info": idInfo
    };
  }

  @override
  List<Object> get props => [email, image ?? "", idInfo, name, surname];
}

class AuthInitial extends AuthState {
  const AuthInitial({String email = "", String token = ""})
      : super(email: email, token: token);

  @override
  fromMap(Map<String, dynamic> map) {
    if (map["email"] != "") {
      return AuthSuccess(
        map["email"] as String,
        map["token"] as String,
        map["name"] as String,
        map["surname"] as String,
        map["image"] as String,
        map["id_info"] as int,
      );
    }
    return AuthInitial(
      email: map["email"] as String,
    );
  }
}

class AuthLoading extends AuthState {
  const AuthLoading(e) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthLoading(
      map["email"] as String,
    );
  }
}

class AuthSuccess extends AuthState {
  const AuthSuccess(String e, String token, String name, String surname,
      String? image, int idInfo)
      : super(
            email: e,
            token: token,
            name: name,
            surname: surname,
            image: image,
            idInfo: idInfo);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthSuccess(
      map["email"] as String,
      map["token"] as String,
      map["name"] as String,
      map["surname"] as String,
      map["image"] as String,
      map["id_info"] as int,
    );
  }

  @override
  String toString() {
    return "$name $surname $email $image $idInfo";
  }
}

class AuthRegisterSuccess extends AuthState {
  const AuthRegisterSuccess({e = ""}) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthRegisterSuccess(
      e: map["email"] as String,
    );
  }
}

class AuthError extends AuthState {
  const AuthError({e = ""}) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthError(
      e: map["email"] as String,
    );
  }
}

class AuthConfirmPasswordSucces extends AuthState {
  const AuthConfirmPasswordSucces({e = ""}) : super(email: e);
  @override
  fromMap(Map<String, dynamic> map) {
    return AuthError(
      e: map["email"] as String,
    );
  }
}
