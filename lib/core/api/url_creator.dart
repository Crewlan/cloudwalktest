import 'i_url_creator.dart';

class UrlCreator implements IUrlCreator {
  static const _urlKey = 'api.openweathermap.org';

  @override
  String create({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    List<String>? pathSegments,
    String scheme = 'https',
    String? hostKey,
    int? port,
  }) {
    return Uri(
      scheme: scheme,
      host: _urlKey,
      port: port,
      pathSegments: [...endpoint.split('/'), ...(pathSegments ?? [])],
      queryParameters: queryParameters,
    ).toString();
  }
}
