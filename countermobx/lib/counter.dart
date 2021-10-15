import 'package:mobx/mobx.dart';

// vai gerar um novo arquivo com o nome abaixo
// g = generate
part 'counter.g.dart';

//classe Counter e um mix das classes
//_Counter e _$Counter que e a que foi gerada
class Counter = _Counter with _$Counter;

//o store indica que vai pegar todas as notation/actions e observar
//gerencia o contador
// classe com store tem que ser abstrata pra nao ser instanciada
//sem o abstract o gerador de codigo nao vai roda
abstract class _Counter with Store {
  //mandeira 2 de fazer
  //uma var observavel
  @observable
  int count = 0;

  @action
  void increment() {
    count++;
  }

  @action
  void decrement() {
    count--;
  }

  //maneira 1 de fazer
  // class Counter {
  // //valor inicial dele é 0
  // //o estado fica dentro do Observable
  // //modica o estado pela action
  // Observable _count = Observable(0);
  // //passa a função increment por construtor
  // Counter() {
  //   increment = Action(_increment);
  //   decrement = Action(_decrement);
  // }
  // //acesando o valor
  // int get count => _count.value;

  // //definindo ação
  // //action muda o estado do contador
  // Action? increment;
  // Action? decrement;

  // //soma mais 1 ao contador
  // void _increment() {
  //   _count.value++;
  // }

  // void _decrement() {
  //   _count.value--;
  // }
  // }

}
