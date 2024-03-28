import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('test')) {
    return File('$dir/$name').readAsStringSync();
  } else if (dir.endsWith('tvshow')) {
    return File('$dir/test/$name').readAsStringSync();
  } else if (dir.endsWith('features')) {
    return File('$dir/tvshow/test/$name').readAsStringSync();
  } else {
    return File('$dir/features/tvshow/test/$name').readAsStringSync();
  }
}
