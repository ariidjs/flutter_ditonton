import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('test')) {
    return File('$dir/$name').readAsStringSync();
  } else if (dir.endsWith('movies')) {
    return File('$dir/test/$name').readAsStringSync();
  } else if (dir.endsWith('features')) {
    return File('$dir/movies/test/$name').readAsStringSync();
  } else {
    return File('$dir/features/movies/test/$name').readAsStringSync();
  }
}
