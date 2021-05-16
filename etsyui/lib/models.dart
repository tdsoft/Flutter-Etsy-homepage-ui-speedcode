enum ListItemType{
  FlashSalesCard,
  ImageCard,
  TwoColumnGrid,
  TwoColumnList
}

abstract class ListItem{
  ListItemType getListItemType();
}

class FlashSalesCard extends ListItem{
  final String title;
  final String description;

  FlashSalesCard(this.title, this.description);

  @override
  ListItemType getListItemType() {
    return ListItemType.FlashSalesCard;
  }

}

class ImageCard extends ListItem{
  final String title;
  final String description;
  final String image;

  ImageCard(this.title, this.description, this.image);

  @override
  ListItemType getListItemType() {
    return ListItemType.ImageCard;
  }

}

class TwoColumnGrid extends ListItem{
  final List<String> images;

  TwoColumnGrid(this.images);


  @override
  ListItemType getListItemType() {
    return ListItemType.TwoColumnGrid;
  }

}

class TwoColumnList extends ListItem{
  final List<ImageWithTitle> images;

  TwoColumnList(this.images);

  @override
  ListItemType getListItemType() {
    return ListItemType.TwoColumnList;
  }

}

class ImageWithTitle{
  final String title;
  final String image;

  ImageWithTitle(this.title, this.image);
}