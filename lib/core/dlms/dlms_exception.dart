class DlmsException implements Exception {
  const DlmsException(this.message);
  final String message;

  @override
  String toString() => 'DlmsException: $message';
}

class DlmsAssociationException extends DlmsException {
  const DlmsAssociationException(super.message, {this.resultCode});
  final int? resultCode;
}

class DlmsGetException extends DlmsException {
  const DlmsGetException(super.message, {this.accessResult});
  final int? accessResult; // data-access-result enum value
}
