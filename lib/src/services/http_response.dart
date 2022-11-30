import 'dart:convert';

class HttpResponse<T> {
  bool ok = false;
  String message = "";
  T? data;
  final int _statusCode;
  final String _body;

  HttpResponse(
    this._statusCode,
    this._body,
  ) {
    _verifyStatus();
  }

  void _verifyStatus() {
    switch (_statusCode) {
      case 200:
      case 201:
        ok = true;
        break;
      case 204:
        ok = true;
        break;
      case 400:
        break;
      case 401:
        break;
      case 404:
        break;
      case 500:
        message = "Sem conexão com servidor";
        break;
      default:
        message = "Erro inesperado";
    }

    _setResponse();
  }

  void _setResponse() {
    if (ok) {
      if (_body.isNotEmpty) {
        T response = jsonDecode(_body);
        data = response;
      }
    } else {
      if (message.isEmpty) {
        dynamic response = jsonDecode(_body);

        message = response['message'];
      }
    }
  }
}
