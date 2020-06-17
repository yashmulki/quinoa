
class SuggestGetResponse {
   String tag;
   DateTime startTime;
   int length;
   String repeats;

   SuggestGetResponse({this.tag,this.startTime,this.length,this.repeats});
   factory SuggestGetResponse.fromJson(Map<String, dynamic> json) {

     var startTime = DateTime.tryParse(json['start_date']);
     if(startTime == null) return null;
     
     
     return SuggestGetResponse(
       tag: json['tag'],
       startTime: startTime,
       length: json["length"],
       repeats: json['repeats']
     );
   }
}