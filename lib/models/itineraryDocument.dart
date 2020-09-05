class ItineraryDocument {
  String id;
  String itineraryId;
  String documentName;
  String documentType;
  String documentFileName;
  String startDate;
  String endDate;
  String datetimeCreated;
  String datetimeModified;

  ItineraryDocument(
      {this.id,
      this.itineraryId,
      this.documentName,
      this.documentType,
      this.documentFileName,
      this.startDate,
      this.endDate,
      this.datetimeCreated,
      this.datetimeModified});

  ItineraryDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itineraryId = json['itinerary_id'];
    documentName = json['document_name'];
    documentType = json['document_type'];
    documentType.toLowerCase();
    documentFileName = json['document_file_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    datetimeCreated = json['datetime_created'];
    datetimeModified = json['datetime_modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itinerary_id'] = this.itineraryId;
    data['document_name'] = this.documentName;
    data['document_type'] = this.documentType;
    data['document_file_name'] = this.documentFileName;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['datetime_created'] = this.datetimeCreated;
    data['datetime_modified'] = this.datetimeModified;
    return data;
  }
}
