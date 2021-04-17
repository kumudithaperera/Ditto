enum PersonalityTypes {
  INFP,
  INTJ,
  INFJ,
  INTP,
  ENFP,
  ENTJ,
  ENTP,
  ENFJ,
  ISFJ,
  ISFP,
  ISTJ,
  ISTP,
  ESFJ,
  ESFP,
  ESTJ,
  ESTP
}

enum VideoType{
  NETWORK,
  FILE,
}

enum AppTheme {
  Pink,
  Blue,
  Gold,
  Green,
  Orange
}

enum ExceptionTypes {
  TIMEOUT_EXCEPTION,
  SOCKET_EXCEPTION,
  REQUEST_ERROR,
  AP_ERROR,
  UNIMPLEMENTED_EXCEPTION,
}

extension ExceptionExtension on ExceptionTypes {
  String get name {
    switch (this) {
      case ExceptionTypes.TIMEOUT_EXCEPTION:
        return 'Timeout Exception';
      case ExceptionTypes.SOCKET_EXCEPTION:
        return 'Socket Exception';
      case ExceptionTypes.REQUEST_ERROR:
        return 'Request Error';
      case ExceptionTypes.AP_ERROR:
        return 'WIFI Error';
      case ExceptionTypes.UNIMPLEMENTED_EXCEPTION:
        return 'Unimplemented Exception';
      default:
        return "";
    }
  }
}