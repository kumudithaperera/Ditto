import 'package:ditto/helper/models/errors/exceptions.dart';

import '../../enums.dart';

T getModel<T>(args){

  dynamic parsedXML = args['response'];

  switch(args['type']){
    case bool:
    case String:
    case int:
    case dynamic:
      return parsedXML as T;
    default:
      throw GeneralException(
        "Response class is unimplemented",
        ExceptionTypes.UNIMPLEMENTED_EXCEPTION,
      );
  }
}