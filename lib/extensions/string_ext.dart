extension StringExt on String {
  String get last => this.isNotEmpty ? this.substring(this.length - 1) : '';

  String removeLast() => this.isNotEmpty ? this.substring(0, this.length - 1) : '';
}
