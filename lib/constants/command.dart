class Command {
  final all = [open, goto];

  static const open = 'open';
  static const goto = 'back';
}

class Utils {
  static void scanText(String rawText) {
    final text = rawText.toLowerCase();

    if (text.contains(Command.goto)) null;
  }
}
