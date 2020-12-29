
import 'dart:html';
import 'dart:typed_data';

class UploadImage{

  Uint8List uri;
  File imageFile;
  String networkUri;

  UploadImage({this.uri, this.imageFile,this.networkUri});
}