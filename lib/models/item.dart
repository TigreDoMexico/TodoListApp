class Item {
  String title;
  String description;
  DateTime limitDate;
  bool done;

  Item({
    this.title,
    this.description,
    this.limitDate,
    this.done
  });

  Item.fromJson(Map<String, dynamic> json){
    title = json['title'];
    done  = json['description'];
    done  = json['limitDate'];
    done  = json['done'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['limitDate'] = this.limitDate;
    data['done'] = this.done;

    return data;
  }
}