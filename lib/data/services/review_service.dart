import 'package:taxi_driver/core/constants/network_constants.dart';
import 'package:taxi_driver/data/models/review_model.dart';
import 'package:taxi_driver/data/services/api_client.dart';

class ReviewService {
  final ApiClient _api;
  ReviewService(this._api);

  Future<List<ReviewModel>> getReviews() async {
    final res = await _api.get(NetworkConstants.reviews);
    final list = (res['data'] as List?) ?? [];
    return list.map((e) => ReviewModel.fromJson(e)).toList();
  }
}
