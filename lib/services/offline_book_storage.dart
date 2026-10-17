
export 'offline_book_model.dart';

export 'offline_book_storage_stub.dart'
    if (dart.library.html) 'offline_book_storage_web.dart'
    if (dart.library.io) 'offline_book_storage_io.dart';

