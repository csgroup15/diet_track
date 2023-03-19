class ResultModel {
  String dateChecked, foodPicURL;
  ResultModel({
    required this.dateChecked,
    required this.foodPicURL,
  });
}

List<ResultModel> results = [
  ResultModel(
    dateChecked: '08/01/2023',
    foodPicURL: 'assets/images/result_5.jpg',
  ),
  ResultModel(
    dateChecked: '10/01/2023',
    foodPicURL: 'assets/images/result_2.jpg',
  ),
  ResultModel(
    dateChecked: '13/01/2023',
    foodPicURL: 'assets/images/result_3.jpg',
  ),
  ResultModel(
    dateChecked: '15/01/2023',
    foodPicURL: 'assets/images/result_4.jpg',
  ),
  ResultModel(
    dateChecked: '17/01/2023',
    foodPicURL: 'assets/images/result_1.jpg',
  )
];
