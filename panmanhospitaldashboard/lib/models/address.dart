class FullAddress {
  String address;
  String city;
  String state;
  String zipcode;
  String country;

  FullAddress(
      {this.address, this.city, this.state, this.zipcode, this.country});

  FullAddress.fromMap(Map data)
      : this(
          address: data['address'],
          city: data['city'],
          country: data['country'],
          state: data['state'],
          zipcode: data['zipcode'],
        );

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'city': city,
      'state' : state,
      'country':country,
      'zipcode': zipcode,
    };
  }
}
