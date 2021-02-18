class City {
    City({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["_id"],
        name: json["name"],
    );

    factory City.fromJsonEdit(String json) => City(
        id: json
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}