import '../../core/enums/request_type.dart';
import '../models/mock_shop.dart';
import '../models/mock_tailor.dart';

class RequestRecipientService {
  RequestRecipientService._();

  static List<String> resolveRecipientNames({
    required RequestType requestType,
    required bool isPersonal,
    String? selectedProviderId,
    String? personalProviderName,
  }) {
    if (isPersonal && personalProviderName != null) {
      return [personalProviderName];
    }

    if (selectedProviderId != null) {
      final name = _nameForId(requestType, selectedProviderId);
      if (name != null) return [name];
    }

    return switch (requestType) {
      RequestType.tailoring =>
        MockTailor.sampleData.map((tailor) => tailor.name).toList(),
      RequestType.material =>
        MockShop.sampleData.map((shop) => shop.name).toList(),
    };
  }

  static String broadcastLabel(RequestType requestType) {
    return switch (requestType) {
      RequestType.tailoring => 'all tailors',
      RequestType.material => 'all shopkeepers',
    };
  }

  static String? _nameForId(RequestType type, String id) {
    return switch (type) {
      RequestType.tailoring => MockTailor.sampleData
          .where((t) => t.id == id)
          .map((t) => t.name)
          .firstOrNull,
      RequestType.material => MockShop.sampleData
          .where((s) => s.id == id)
          .map((s) => s.name)
          .firstOrNull,
    };
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) return iterator.current;
    return null;
  }
}
