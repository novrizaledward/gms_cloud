import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gms_cloud/core/bloc/barang_bloc/barang_bloc.dart';
import 'package:gms_cloud/core/bloc/detail_suratJalan_bloc/detail_suratjalan_bloc.dart';
import 'package:gms_cloud/core/bloc/login_bloc/login_bloc.dart';
import 'package:gms_cloud/core/bloc/suratJalan_bloc/suratjalan_bloc.dart';
import 'package:gms_cloud/core/bloc/ttbk_bloc/ttbk_bloc.dart';
import 'package:gms_cloud/repository/endpoint.dart';
import 'package:gms_cloud/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiProvider apiProvider = ApiProvider();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(apiProvider),
        ),
        BlocProvider<SuratjalanBloc>(
          create: (context) => SuratjalanBloc(apiProvider),
        ),
        BlocProvider<DetailSuratjalanBloc>(
          create: (context) => DetailSuratjalanBloc(apiProvider),
        ),
        BlocProvider<BarangBloc>(
          create: (context) => BarangBloc(apiProvider),
        ),
        BlocProvider<TtbkBloc>(
          create: (context) => TtbkBloc(apiProvider),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
