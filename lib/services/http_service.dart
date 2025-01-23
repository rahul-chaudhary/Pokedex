import 'package:dio/dio.dart';
import '../utils/helpers/debug_print.dart';

class HTTPService {
  HTTPService();

  final _dio = Dio();

  Future<Response?> get({required String path}) async {
    try{
    Response res = await _dio.get(path);
    } catch(e){
      dbPrint('HTTPService get() error $e');
    }

    return null;
  }
}