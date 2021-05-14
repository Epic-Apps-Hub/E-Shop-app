import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object event) {print('$bloc event occured : $event');}


  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('$bloc transition occured : $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {print('$bloc error occured : $error');}

  @override
  void onClose(BlocBase bloc) {print('$bloc closed');}
}
