import '../../core/enums/request_type.dart';

class SendRequestArgs {
  const SendRequestArgs({
    this.providerId,
    this.providerName,
    this.providerImageUrl,
    this.requestType,
    this.isPersonal = false,
  });

  final String? providerId;
  final String? providerName;
  final String? providerImageUrl;
  final RequestType? requestType;
  final bool isPersonal;

  bool get hasPreselectedProvider =>
      isPersonal && providerId != null && providerName != null;
}
