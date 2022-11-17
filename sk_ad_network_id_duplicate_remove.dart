import 'dart:io';

void main() async {
  File file = File("SKAdNetworkIdentifier");

  List<String> lines = await file.readAsLines();

  ///去重后的string
  List<String> duplicateRemoveStrings = lines
      .where((element) {
        return element.trim().startsWith("<string>");
      })
      .toList()
      .map<String>((e) {
        return e.trim();
      })
      .toList()
      .toSet()
      .toList();

  String str = """<key>SKAdNetworkItems</key>\n<array>\n""";


  duplicateRemoveStrings.forEach((element) {

    str+="""    <dict>\n     <key>SKAdNetworkIdentifier</key>\n     $element\n   </dict>\n""";

  });

  str+="</array>";


  print(str);
}
