
import 'package:english_learner/services/vocab_services.dart';

class VocabRepository {
  late  VocabService _vocabService;

  VocabRepository(){
    _vocabService = VocabService();
  } 

  // Getter method for VocabService
  VocabService get vocabService => _vocabService;
}
