# http_request

a http request package bases on the dio packages.

```dart
http_request:
  git:
    url: git@github.com:superfiend/http_request.git
```

```dart
import 'package:http_request/http_request.dart';

void main() {
    final headers = {'referer': 'xxx'};
    final url = 'https://xxx';
    final queryParameters = {'p': '1'};
    final data = FormData.fromMap({'n': '20'});
    HttpRequest.get(url, queryParameters: queryParameters, headers: headers).then((res) {
        print(res);
    });
    // HttpRequest.getJson(...) 
    HttpRequest.postJson(url, data: data, queryParameters: queryParameters, headers: headers).then((
        res) {
        print(res);
    });
    // HttpRequest.post(...)
}
```

