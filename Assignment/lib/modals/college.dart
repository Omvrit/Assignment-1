class College {
  String? name;
  String? alphaTwoCode;
  List<String>? webPages;
  Null? stateProvince;
  String? country;
  List<String>? domains;

  College(
      {this.name,
        this.alphaTwoCode,
        this.webPages,
        this.stateProvince,
        this.country,
        this.domains});

  College.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alphaTwoCode = json['alpha_two_code'];
    webPages = json['web_pages'].cast<String>();
    stateProvince = json['state-province'];
    country = json['country'];
    domains = json['domains'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['alpha_two_code'] = this.alphaTwoCode;
    data['web_pages'] = this.webPages;
    data['state-province'] = this.stateProvince;
    data['country'] = this.country;
    data['domains'] = this.domains;
    return data;
  }
}