abstract class UserState{
}
class InitialUserState extends UserState{

}
class LoadingUserState extends UserState{}
class ErrorUserState extends UserState{
  String msg;
  ErrorUserState({required this.msg});
}
class SuccessUserState extends UserState{
}