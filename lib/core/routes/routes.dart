import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:material_weather/bloc/search/search_bloc.dart';
import 'package:material_weather/bloc/weather/weather_bloc.dart';
import 'package:material_weather/core/models/location.dart';
import 'package:material_weather/core/utils/getit.dart';
import 'package:material_weather/presentation/screens/7day_screen.dart';
import 'package:material_weather/presentation/screens/HomeScreen.dart';
import 'package:material_weather/presentation/screens/location_change_screen.dart';

final bloc = WeatherBloc(serviceLocator.get<LocationInfo>());

final GoRouter routerConfig = GoRouter(
  initialLocation: "/",
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: "home",
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => bloc)],
          child: HomeScreen(),
        );
      },
      pageBuilder: GoTransitions.cupertino.call,
    ),
    GoRoute(
      path: '/forecast',
      name: "forecast",
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: bloc,
          child: SevenDaysForecastScreen(),
        );
      },
      pageBuilder: GoTransitions.cupertino.call,
    ),
    GoRoute(
      path: '/change',
      name: "change",
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: bloc),
            BlocProvider(create: (context) => SearchBloc()),
          ],
          child: LocationChangeScreen(),
        );
      },
      pageBuilder: GoTransitions.cupertino.call,
    ),
  ],
);
