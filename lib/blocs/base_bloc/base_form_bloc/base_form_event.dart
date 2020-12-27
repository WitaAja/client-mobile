import 'package:equatable/equatable.dart';

abstract class StatusEventBloc extends Equatable{

}

class EventLoading extends StatusEventBloc{
  @override
  List<Object> get props => [];

}

class EventLoaded extends StatusEventBloc{
  @override
  List<Object> get props => [];

}

class EventFailed extends StatusEventBloc{
  @override
  List<Object> get props => [];

}