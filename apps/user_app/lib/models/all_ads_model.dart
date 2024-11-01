class Ads {
  Ads({
    required this.id,
    required this.description,
    required this.bannerimg,
    required this.clicks,
    required this.startdate,
    required this.enddate,
    required this.offerType,
    required this.branchId,
    required this.views,
    required this.category,
    required this.branch,
  });
  late final String? id;
  late final String? description;
  late final String? bannerimg;
  late final int? clicks;
  late final String? startdate;
  late final String? enddate;
  late final String? offerType;
  late final String? branchId;
  late final int? views;
  late final String? category;
  late final Branch? branch;
  
  Ads.fromJson(Map<String, dynamic> json){
    id = json['id'];
    description = json['description'];
    bannerimg = json['bannerimg'];
    clicks = json['clicks'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    offerType = json['offer_type'];
    branchId = json['branch_id'];
    views = json['views'];
    category = json['category'];
    branch = Branch.fromJson(json['branch']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['bannerimg'] = bannerimg;
    data['clicks'] = clicks;
    data['startdate'] = startdate;
    data['enddate'] = enddate;
    data['offer_type'] = offerType;
    data['branch_id'] = branchId;
    data['views'] = views;
    data['category'] = category;
    data['branch'] = branch?.toJson();
    return data;
  }
}

class Branch {
  Branch({
    required this.id,
    required this.address,
    required this.business,
    required this.latitude,
    required this.longitude,
    required this.businessId,
  });
  late final String? id;
  late final String? address;
  late final Business? business;
  late final double? latitude;
  late final double? longitude;
  late final String? businessId;
  
  Branch.fromJson(Map<String, dynamic> json){
    id = json['id'];
    address = json['address'];
    business = Business.fromJson(json['business']);
    latitude = json['latitude'];
    longitude = json['longitude'];
    businessId = json['business_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['business'] = business?.toJson();
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['business_id'] = businessId;
    return data;
  }
}

class Business {
  Business({
    required this.id,
    required this.name,
    required this.email,
    required this.logoImg,
    required this.freeTrial,
    required this.subscribed,
    required this.contactNumber,
  });
  late final String? id;
  late final String? name;
  late final String? email;
  late final String? logoImg;
  late final bool? freeTrial;
  late final bool? subscribed;
  late final String? contactNumber;
  
  Business.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    logoImg = json['logo_img'];
    freeTrial = json['free_trial'];
    subscribed = json['subscribed'];
    contactNumber = json['contact_number'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['logo_img'] = logoImg;
    data['free_trial'] = freeTrial;
    data['subscribed'] = subscribed;
    data['contact_number'] = contactNumber;
    return data;
  }
}