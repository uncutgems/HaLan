part of 'popular_route_bloc.dart';

@immutable
abstract class PopularRouteState {}

class PopularRouteInitial extends PopularRouteState {}

class LoadingPopularRouteState extends PopularRouteState {}

class DisplayPopularRouteState extends PopularRouteState {
  DisplayPopularRouteState(this.popularRouteList);

  final List<RouteEntity> popularRouteList;
}
