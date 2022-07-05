import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../api_request.dart';

part 'authentication_state.dart';

abstract class AuthEvent extends Equatable {
  final String username;
  final String password;

  const AuthEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class AuthLogin extends AuthEvent {
  const AuthLogin(String username, String password) : super(username, password);
}

class AuthLogout extends AuthEvent {
  const AuthLogout() : super("", "");
}

class AuthChangeInfo extends AuthEvent {
  final File? file;
  const AuthChangeInfo(this.file) : super("", "");
}

class AuthRegister extends AuthEvent {
  const AuthRegister(String username, String password) : super(username, password);
}

class AuthRegisterSendNameSurname extends AuthEvent {
  final File? file;
  final String name;
  final String surname;
  const AuthRegisterSendNameSurname(
      {required String username,
      required String password,
      required this.name,
      required this.surname,
      this.file})
      : super(username, password);
}

class AuthConfirmPassword extends AuthEvent {
  final String code;
  const AuthConfirmPassword(String username, String password, this.code)
      : super(username, password);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> with HydratedMixin {
  AuthBloc() : super(const AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      // if (state.email != "") {
      //   emit(
      //     AuthSuccess(state.email),
      //   );
      // }
      emit(const AuthLoading(""));
      try {
        var r = await login(event.username, event.password);
        if (r.isNotEmpty) {
          var email = event.username;
          var nameSurname = await getNameSurname(event.username);
          emit(
            AuthSuccess(email, r, nameSurname[0], nameSurname[1],
                nameSurname[2], nameSurname[3]),
          );
        } else if (r.isEmpty) {
          emit(const AuthError());
        }
      } catch (r) {
        emit(const AuthError());
      }
    });
    on<AuthRegister>((event, emit) async {
      try {
        emit(const AuthLoading(""));
        var r = await register(event.username, event.password);
        if (r) {
          emit(const AuthRegisterSuccess());
        } else if (r == false) {
          emit(const AuthError());
        }
      } catch (e) {
        emit(const AuthError());
      }
    });
    on<AuthConfirmPassword>((event, emit) async {
      try {
        emit(const AuthLoading(""));
        var r = await confirmPassword(event.username, event.code);
        if (r) {
          emit(const AuthConfirmPasswordSucces());
        } else if (r == false) {
          emit(const AuthError());
        }
      } catch (_) {
        emit(const AuthError());
      }
    });
    on<AuthRegisterSendNameSurname>((event, emit) async {
      try {
        emit(const AuthLoading(""));
        var token = await login(event.username, event.password);
        await sendNameSurname(event.name, event.surname, token, event.file);
        AuthRegisterSendNameSurname(
          password: event.password,
          username: event.username,
          surname: event.surname,
          name: event.name,
        );
        emit(const AuthInitial());
      } catch (r) {
        emit(const AuthError());
      }
    });
    on<AuthLogout>((event, emit) {
      emit(const AuthLoading(""));
      emit(
        const AuthInitial(),
      );
    });
    on<AuthChangeInfo>(
      (event, emit) async {
        String email = state.email;
        String token = state.token;
        String name = state.name;
        String surname = state.surname;
        int id = state.idInfo;
        emit(const AuthLoading(""));
        try {
          String imageLink =
              await putImage(event.file, id, token, name, surname);
          emit(AuthSuccess(email, token, name, surname, imageLink, id));
        } catch (e) {
          emit(const AuthError());
        }
      },
    );
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    return state.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
  }
}
