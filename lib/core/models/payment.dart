class Payment {
    Payment({
        this.typeMethod,
        this.car,
        this.countDays,
        this.driveInclude,
        this.user
    });

    String typeMethod;
    int countDays;
    bool driveInclude;
    String car;
    String user;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        typeMethod: json["typeMethod"],
        countDays: json["countDays"],
        driveInclude: json["driveInclude"],
        car: json["car"],
        user: json["user"]["_id"]
    );

    Map<String, dynamic> toJson() => {
        "typeMethod": typeMethod,
        "countDays": countDays,
        "driveInclude": driveInclude,
        "car": car,
        "user": user
    };
}