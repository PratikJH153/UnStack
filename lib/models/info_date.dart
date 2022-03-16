class SliderModel {
  String? imageAssetPath;
  String? title;
  String? desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String? getImageAssetPath() {
    return imageAssetPath;
  }

  String? getTitle() {
    return title;
  }

  String? getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  final List<SliderModel> slides = [];
  SliderModel sliderModel = SliderModel();

  //1
  sliderModel.setDesc(
    "Add & Track your Todo's daily for your exponential Growth.",
  );
  sliderModel.setTitle("Construct your Todo's Everyday");
  sliderModel.setImageAssetPath("assets/images/notodo.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
    "Keep track of your Timeline & Notice the difference in your learning path daily.",
  );
  sliderModel.setTitle("Set Timelines for tracking your daily progress");
  sliderModel.setImageAssetPath("assets/images/timeline.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc(
    "Keep a track of your Todolist and make necessary changes to your Todos.",
  );
  sliderModel.setTitle("Allowing Tracking of your Todolist");
  sliderModel.setImageAssetPath("assets/images/todolist.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();
  //4

  sliderModel.setDesc(
    "A feature coming soon about Daily tracking your Consistency",
  );
  sliderModel.setTitle("Consistency & Hard Work helps you to Grow More!");
  sliderModel.setImageAssetPath("assets/images/soon1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
