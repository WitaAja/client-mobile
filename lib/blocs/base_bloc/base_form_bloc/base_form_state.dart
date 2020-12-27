import 'package:equatable/equatable.dart';

abstract class StatusStateBloc extends Equatable{

}

class StateLoading extends StatusStateBloc{
  @override
  List<Object> get props => [];

}

class StateLoaded extends StatusStateBloc{
  @override
  List<Object> get props => [];

}

class StateInitial extends StatusStateBloc{
  @override
  List<Object> get props => [];

}


class StateFailed extends StatusStateBloc{
  @override
  List<Object> get props => [];

}

