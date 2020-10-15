part of 'select_place_bloc.dart';

@immutable
abstract class SelectPlaceEvent {}
class SelectPlaceEventGetData extends SelectPlaceEvent{
}
class SelectPlaceEventChooseScenario extends SelectPlaceEvent{
  SelectPlaceEventChooseScenario(this.scenario, this.points);
  final int scenario;
  final List<Point> points;
}
class SelectPlaceEventChooseStartPoint extends SelectPlaceEvent{
  SelectPlaceEventChooseStartPoint(this.scenario, this.points, this.startPoint);
  final int scenario;
  final List<Point>points;
  final Point startPoint;
}
class SelectPlaceEventChooseEndPoint extends SelectPlaceEvent{
  SelectPlaceEventChooseEndPoint(this.scenario, this.points, this.endPoint);
  final int scenario;
  final List<Point>points;
  final Point endPoint;
}
class SelectPlaceEventReset extends SelectPlaceEvent{
  SelectPlaceEventReset(this.points);
  final List<Point> points;
}
