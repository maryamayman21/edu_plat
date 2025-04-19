
class TabObject {
  String title;
  List<FileData>? files;
  TabObject(this.title,this.files);
}

class TabViewObject {
  List<TabObject> tabObject;
  int numOfTabs;
  int currentIndex;

  TabViewObject(this.tabObject, this.numOfTabs, this.currentIndex);
}
class FileData {
  final String name;
  final int size;
  final String path;
  final DateTime date;
  final String extension;

  FileData(
      {required this.extension,
        required this.name,
        required this.size,
        required this.path,
        required this.date,
      });
}

