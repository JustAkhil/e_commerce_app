import '../../../data/models/cat_model.dart';

abstract class CatState{}
class CatInitialState extends CatState{}
class CatLoadingState extends CatState{}
class CatSuccessState extends CatState{
  List<CategoryModel> mCatList;
  CatSuccessState({required this.mCatList});
}
class CatErrorState extends CatState{
  String errMsg;
  CatErrorState({required this.errMsg});
}
