part of 'select_place_bloc.dart';

@immutable
abstract class SelectPlaceState {}

class SelectPlaceInitial extends SelectPlaceState {}
class SelectPlaceStateShowData extends SelectPlaceState{
  SelectPlaceStateShowData(this.points, this.routes);
  final List<Point> points;
  final List<RouteEntity> routes;
}
class SelectPlaceStateLoading extends SelectPlaceState {}
class SelectPlaceStateDismissLoading extends SelectPlaceState {}
class SelectPlaceStateFail extends SelectPlaceState {
  SelectPlaceStateFail(this.error);
  final String error;
}
class SelectPlaceStateInitiateScenario extends SelectPlaceState{
  SelectPlaceStateInitiateScenario(this.scenario, this.points);
  final int scenario;
  final List<Point> points;
}
class SelectPlaceStateReset extends SelectPlaceState{
  SelectPlaceStateReset(this.point);
  final List<Point> point;
}
class SelectPlaceStateShowStartPoint extends SelectPlaceState{
  SelectPlaceStateShowStartPoint(this.scenario, this.points, this.startPoint);
  final int scenario;
  final List<Point>points;
  final Point startPoint;
}
class SelectPlaceStateShowDropOffPoint extends SelectPlaceState{
  SelectPlaceStateShowDropOffPoint(this.scenario, this.points, this.dropOffPoint);
  final int scenario;
  final List<Point>points;
  final Point dropOffPoint;
}


