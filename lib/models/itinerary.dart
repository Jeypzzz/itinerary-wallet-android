import 'itineraryDocument.dart';

class Itinerary {
  String id;
  String itineraryCustomerId;
  String itineraryName;
  String travelStartDate;
  String travelEndDate;
  String partnerId;
  String createdBy;
  String status;
  String isDeleted;
  String datetimeCreated;
  String datetimeModified;
  List<ItineraryDocument> documents;

  Itinerary(
      {this.id,
      this.itineraryCustomerId,
      this.itineraryName,
      this.travelStartDate,
      this.travelEndDate,
      this.partnerId,
      this.createdBy,
      this.status,
      this.isDeleted,
      this.datetimeCreated,
      this.datetimeModified,
      this.documents});

  Itinerary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itineraryCustomerId = json['itinerary_customer_id'];
    itineraryName = json['itinerary_name'];
    travelStartDate = json['travel_start_date'];
    travelEndDate = json['travel_end_date'];
    partnerId = json['partner_id'];
    createdBy = json['created_by'];
    status = json['status'];
    isDeleted = json['is_deleted'];
    datetimeCreated = json['datetime_created'];
    datetimeModified = json['datetime_modified'];
    documents = new List<ItineraryDocument>.from(json["documents"].map((x) => ItineraryDocument.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itinerary_customer_id'] = this.itineraryCustomerId;
    data['itinerary_name'] = this.itineraryName;
    data['travel_start_date'] = this.travelStartDate;
    data['travel_end_date'] = this.travelEndDate;
    data['partner_id'] = this.partnerId;
    data['created_by'] = this.createdBy;
    data['status'] = this.status;
    data['is_deleted'] = this.isDeleted;
    data['datetime_created'] = this.datetimeCreated;
    data['datetime_modified'] = this.datetimeModified;
    data['documents'] = this.documents;

    return data;
  }
}
