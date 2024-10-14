dart pub global activate dart_define

dart pub global run dart_define generate --OPENWEATHER_KEY=dd2d47e33af0d49102831009fd2ecddd --GEONAMES_USERNAME=Racesas

flutter pub get
flutter pub run easy_localization:generate --source-dir lib/core/localization --output-dir lib/core/localization/generated
flutter pub run easy_localization:generate  --source-dir lib/core/localization --output-dir lib/core/localization/generated -f keys -o locale_keys.g.dart
dart run build_runner build