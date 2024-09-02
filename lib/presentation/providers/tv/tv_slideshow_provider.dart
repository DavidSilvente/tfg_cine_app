import 'package:cine_tfg_app/domain/entities/tv.dart';
import 'package:cine_tfg_app/presentation/providers/tv/tv_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final tvSlideshowProvider = Provider<List<Tv>>((ref){
  final airingTodayTv = ref.watch(airingTodayProvider);

  if (airingTodayTv.isEmpty) return [];

  return airingTodayTv.sublist(0,6);
});