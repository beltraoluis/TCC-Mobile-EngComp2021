import 'package:tcc_eng_comp/repository/preference_repository.dart';

class TestBusinessModel {
  Future<int> getMessageSize() async {
  return PreferenceRepository.getMessageSize();
  }

  Future<int> getMessageDelta() async {
    return PreferenceRepository.getMessageDelta();

  }

  Future<int> getMessageQty() async {
    return PreferenceRepository.getMessageQty();
  }
}