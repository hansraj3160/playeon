class SeriesModel {
  String? sId;
  String? title;
  String? description;
  String? year;
  String? type;
  String? duration;
  String? imgLgPoster;
  String? imgSmPoster;
  String? trailer;
  int? views;
  List<Episodes>? episodes;
  String? genre;
  int? likes;
int? dislikes;
	int? watchlater;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SeriesModel(
      {this.sId,
      this.title,
      this.description,
      this.year,
      this.type,
      this.duration,
      this.imgLgPoster,
      this.imgSmPoster,
      this.trailer,
      this.views,
      this.episodes,
      this.genre,
      this.likes,
      this.dislikes,
      this.watchlater,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SeriesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    year = json['year'];
    type = json['type'];
    duration = json['duration'];
    imgLgPoster = json['imgLgPoster'];
    imgSmPoster = json['imgSmPoster'];
    trailer = json['trailer'];
    views = json['views'];
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(new Episodes.fromJson(v));
      });
    }
    genre = json['genre'];
    // if (json['likes'] != null) {
    //   likes = <String>[];
    //   json['likes'].forEach((v) {
    //     likes!.add(new String.fromJson(v));
    //   });
    // }
    // if (json['dislikes'] != null) {
    //   dislikes = <String>[];
    //   json['dislikes'].forEach((v) {
    //     dislikes!.add(new String.fromJson(v));
    //   });
    // }
    // if (json['watchlater'] != null) {
    //   watchlater = <String>[];
    //   json['watchlater'].forEach((v) {
    //     watchlater!.add(new String.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

 
}

class Episodes {
  String? episodeName;
  String? video;
  String? sId;

  Episodes({this.episodeName, this.video, this.sId});

  Episodes.fromJson(Map<String, dynamic> json) {
    episodeName = json['episodeName'];
    video = json['video'];
    sId = json['_id'];
  }

}
