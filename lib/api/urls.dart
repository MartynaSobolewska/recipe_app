import 'package:food_app/api/keys.dart';

String appendKeyAndHost(String url) {
  return url + "?rapidapi-key=" + tasty_key + "&rapidapi-host=" + tasty_host;
}

String feedUrl = appendKeyAndHost("https://tasty.p.rapidapi.com/feeds/list");