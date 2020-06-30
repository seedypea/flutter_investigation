/// References
/// https://pub.dev/packages/chopper
/// https://hadrien-lejard.gitbook.io/chopper/

import 'package:chopper/chopper.dart';

import 'package:investigation/models/users.dart';
//import 'http_header_interceptor.dart';

import 'package:investigation/converters/users_converter.dart';

part 'user_service.chopper.dart';

/// UserService
@ChopperApi()
abstract class UserService extends ChopperService {

  @Get(path: 'users')
  Future<Response<Users>> getAllUsers();

  static UserService create() {
    
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      interceptors: [
        //HttpHeaderInterceptor, 
        HttpLoggingInterceptor()
      ],
      converter: UsersConverter(),
      errorConverter: JsonConverter(),      
      services: [
        _$UserService(),
      ],
    );
    
    return _$UserService(client);
  }
}