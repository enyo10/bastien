class SortOption {
  final String id;
  final String name;

  SortOption(this.id, this.name);
  SortOption.fromJSON(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];

  bool operator ==(dynamic other) =>
      other != null && other is SortOption && this.name == other.name;

  @override
  int get hashCode => super.hashCode;
}

class SortOptionList {
  List<SortOption> options = <SortOption>[];

  SortOptionList.fromJSON(Map<String, dynamic> json)
      : options = (json["options"] as List<dynamic>)
            .map((item) => SortOption.fromJSON(item)).toList();
}
