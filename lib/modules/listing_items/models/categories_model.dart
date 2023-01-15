import 'package:linktsp_api/data/list/models/list_model.dart';

class CategoriesFilterModel {
  CategoriesFilterModel({
    this.id,
    this.title,
    this.children,
  });

  int? id;
  String? title;
  int? resultsCount;
  List<BreadCrumb>? children;
  String? hexaCode;

  factory CategoriesFilterModel.fromJson(Map<String, dynamic> json) =>
      CategoriesFilterModel(
        id: json["id"],
        title: json["title"],
        children: json["children"] == null
            ? null
            : List<BreadCrumb>.from(
                json["children"].map((x) => BreadCrumb.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x.toJson())),
      };
}
