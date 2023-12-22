
class Vehicle{
  String id;
  String code;
  String matricule;
  String cartegrise;
  String marque;
  String circuldate;
  String type;
  String filter;
  UploadFileResponse file;
  Vehicle({required this.id,required this.code,required this.matricule,required this.cartegrise,required this.circuldate,required this.file,required this.filter,required this.type,required this.marque});
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] ?? "",
      code: json['code'] ?? "",
      matricule: json['matricule'] ?? "",
      cartegrise: json['cartegrise'] ?? "",
      circuldate: json['circuldate'] ?? "",
      marque: json['marque'] ?? "",
      type: json['type'] ?? "",
      filter: json['filter'] ?? "",
      file: UploadFileResponse.fromJson(json['file'] ?? {}),

    );
  }}
class UploadFileResponse{
  String id;
  String fileName;
  String fileDownloadUri;
  String fileType;
  int size;
UploadFileResponse({required this.id,required this.fileDownloadUri,required this.fileName,required this.fileType,required this.size});
 factory UploadFileResponse.fromJson( Map<String, dynamic>  json) {
    return UploadFileResponse(
      id: json['id'] ?? "",
      fileName: json['fileName'] ?? "",
      fileDownloadUri: json['fileDownloadUri'] ?? "",
      fileType: json['fileType'] ?? "",
      size: json['size'] ?? 0,  // Convert to String
      
      
    );
  }


}