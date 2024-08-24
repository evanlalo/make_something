// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

String API_URL = dotenv.get("API_URL", fallback: "https://api-yardgames.darkmode.live");