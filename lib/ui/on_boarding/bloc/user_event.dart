abstract class UserEvent {}

class SignUpUserEvent extends UserEvent {
  final String name;
  final String email;
  final String pass;
  final String mobNo;

  SignUpUserEvent({
    required this.name,
    required this.email,
    required this.pass,
    required this.mobNo,
  });
}

class LoginUserEvent extends UserEvent {
  String email;
  String pass;

  LoginUserEvent({required this.email, required this.pass});
}
