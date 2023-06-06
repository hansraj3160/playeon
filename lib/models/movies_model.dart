class MoviesModel {
	String? sId;
	String? title;
	String? description;
	String? year;
	String? type;
	String? duration;
	String? imgLgPoster;
	String? imgSmPoster;
	String? trailer;
	String? video;
	String? video480;
	String? video720;
	int? views;
	String? genre;
	int? likes;
int? dislikes;
	int? watchlater;


	MoviesModel({this.sId, this.title, this.description, this.year, this.type, this.duration, this.imgLgPoster, this.imgSmPoster, this.trailer, this.video, this.video480, this.video720, this.views, this.genre, this.likes, this.dislikes, this.watchlater, });

	MoviesModel.fromJson(Map<String, dynamic> json) {
		sId = json['_id'];
		title = json['title'];
		description = json['description'];
		year = json['year'];
		type = json['type'];
		duration = json['duration'];
		imgLgPoster = json['imgLgPoster'];
                   		imgSmPoster = json['imgSmPoster']; 
		trailer = json['trailer'];
		video = json['video'];
		video480 = json['video480'];
		video720 = json['video720'];
		views = json['views'];
// genre=json['genre'][0];
		// if (json['genre'] != null) {
		// 	genre = <Genre>[];
		// 	json['genre'].forEach((v) { genre!.add( Genre.fromJson(v)); });
		// }
		// if (json['likes'] != null) {
		// 	likes = <int>[];
		// 	json['likes'].forEach((v) { likes!.add(new .fromJson(v)); });
		// }
		// if (json['dislikes'] != null) {
		// 	dislikes = <Null>[];
		// 	json['dislikes'].forEach((v) { dislikes!.add(new Null.fromJson(v)); });
		// }
		// if (json['watchlater'] != null) {
		// 	watchlater = <Null>[];
		// 	json['watchlater'].forEach((v) { watchlater!.add(new Null.fromJson(v)); });
		// }
		// createdAt = json['createdAt'];
		// updatedAt = json['updatedAt'];
		// iV = json['__v'];
	}
  

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['_id'] = this.sId;
// 		data['title'] = this.title;
// 		data['description'] = this.description;
// 		data['year'] = this.year;
// 		data['type'] = this.type;
// 		data['duration'] = this.duration;
// 		data['imgLgPoster'] = this.imgLgPoster;
// 		data['imgSmPoster'] = this.imgSmPoster;
// 		data['trailer'] = this.trailer;
// 		data['video'] = this.video;
// 		data['video480'] = this.video480;
// 		data['video720'] = this.video720;
// 		data['views'] = this.views;
// 		if (this.genre != null) {
//       data['genre'] = this.genre!.map((v) => v.toJson()).toList();
//     }
// 		if (this.likes != null) {
//       data['likes'] = this.likes!.map((v) => v.toJson()).toList();
//     }
// 		if (this.dislikes != null) {
//       data['dislikes'] = this.dislikes!.map((v) => v.toJson()).toList();
//     }
// 		if (this.watchlater != null) {
//       data['watchlater'] = this.watchlater!.map((v) => v.toJson()).toList();
//     }
// 		data['createdAt'] = this.createdAt;
// 		data['updatedAt'] = this.updatedAt;
// 		data['__v'] = this.iV;
// 		return data;
// 	}
 }

// class Genre {


// 	Genre({});

// 	Genre.fromJson(Map<String, dynamic> json) {
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		return data;
// 	}
// }
