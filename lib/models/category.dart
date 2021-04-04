
class Category {
  String sId;
  String name;
  String icon;
  String imageHash;
  int iV;

  Category({this.sId, this.name, this.icon, this.imageHash, this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    icon = json['icon'];
    imageHash = json['imageHash'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['imageHash'] = this.imageHash;
    data['__v'] = this.iV;
    return data;
  }

 
}