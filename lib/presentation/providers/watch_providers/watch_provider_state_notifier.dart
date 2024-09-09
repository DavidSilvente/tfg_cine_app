import 'package:cine_tfg_app/presentation/providers/watch_providers/usecases_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_tfg_app/domain/usecases/get_watch_provider_id.dart';
import 'package:cine_tfg_app/domain/usecases/save_watch_provider_id.dart';

final selectedWatchProviderIdProvider = StateNotifierProvider<SelectedProviderNotifier, String?>((ref) {
  final getWatchProviderId = ref.watch(getWatchProviderIdProvider);
  final saveWatchProviderId = ref.watch(saveWatchProviderIdProvider);
  return SelectedProviderNotifier(getWatchProviderId, saveWatchProviderId);
});

class SelectedProviderNotifier extends StateNotifier<String?> {
  final GetWatchProviderId getWatchProviderId;
  final SaveWatchProviderId saveWatchProviderId;
  

  SelectedProviderNotifier(this.getWatchProviderId, this.saveWatchProviderId) : super(null) {
    _loadInitialProvider(); // Cargar el estado inicial desde la persistencia
  }

  Future<void> _loadInitialProvider() async {
    state = await getWatchProviderId(); // Recupera el proveedor seleccionado anteriormente
  }

  Future<void> updateProvider(String providerId) async {
    state = providerId;
    await saveWatchProviderId(providerId); // Persiste el nuevo proveedor seleccionado
  }
  Future<void> setDefaultProvider(String providerId) async {
    if (state == null) {
      state = providerId;
      await saveWatchProviderId(providerId); // Guardar el proveedor por defecto seleccionado
      print("Proveedor por defecto establecido: $providerId");
    }
  }
}
