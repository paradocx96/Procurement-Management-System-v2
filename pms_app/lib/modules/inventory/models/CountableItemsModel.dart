class CountableItemsModel{
  final String id;
  final String name;
  final String type;
  final int quantity;
  final int minimumQuantity;
  final String siteid;
  final String sitename;

  CountableItemsModel({ required this.id, required this.name,
    required this.type, required this.quantity,
    required this.minimumQuantity, required this.siteid, required this.sitename } );

  factory CountableItemsModel.fromjson(Map<String, dynamic> json){
    return CountableItemsModel(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        quantity: json['quantity'],
        minimumQuantity: json['minimumQuantity'],
        siteid: json['siteid'],
        sitename: json['sitename']);
  }
}