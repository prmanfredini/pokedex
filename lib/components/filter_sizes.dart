List<int> getHeight(String value) {
  switch (value) {
    case 'short':
      return [0, 10];
    case 'medium':
      return [11, 20];
    default:
      return [21, 100];
  }
}

List<int> getWeight(String value) {
  switch (value) {
    case 'light':
      return [0, 500];
    case 'normal':
      return [501, 3000];
    default:
      return [3001, 10000];
  }
}
