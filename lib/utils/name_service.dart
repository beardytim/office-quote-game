class NameService {
  List<String> fetchNames(String ans) {
    List<String> nameList = [
      "Michael Scott",
      "Jim Halpert",
      "Dwight Schrute",
      "Pam Beesly",
      "Ryan Howard",
      "Kelly Kapoor",
      "Angela Martin",
      "Kevin Malone",
      "Oscar Martinez",
      "Andy Bernard",
      "Stanley Hudson",
      "Phyllis Lapin",
      "Toby Flenderson",
      "Erin Hannon",
      "Gabe Lewis",
      "Darryl Philbin",
      "Creed Bratton",
      "Jo Bennett",
      "Holly Flax",
      "Jan Levinson",
      "Todd Packer",
      "Charles Minor",
      "Deangelo Vickers",
      "Josh Porter",
      "Ed Truck",
      "Hunter null",
      "David Wallace"
    ];
    //need to remove the answer from the list of names then randomise names, then make new list with 3 of them and add the answer name to that list....
    List<String> names = [];
    names.addAll(nameList);
    names.remove(ans);
    names.shuffle();
    names.removeRange(3, names.length);
    names.add(ans);
    names.shuffle();
    return names;
  }
}
