import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedDate = DateTime.now();
  var selected = false;
  var f = DateFormat("dd/MM/yyyy EEEE");

  var modVal = 0;
  var houseName = "";
  var isChecked = false;
  List houseNum = [1, 4, 0, 3, 6, 2, 5];
  List selectHouseNum = [];

  void setSelectedHouseNumber() {
    selectHouseNum = [];
    var modIndex = 0;
    var mIndex;
    houseNum.forEach((element) {
      if (element == modVal) {
        mIndex = modIndex;
      }
      modIndex++;
    });

    int index = mIndex;

    for (int i = 0; i <= 6; i++) {
      if (index <= 6) {
        selectHouseNum.add(houseNum[index]);
        index++;
      } else {
        index = index - 7;
        selectHouseNum.add(houseNum[index]);
        index++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Mahabote"),
      ),
      body: _homeDesign(),
    );
  }

  TextStyle _selectedColor(val) => TextStyle(
      color: houseName == val ? Theme.of(context).primaryColor : Colors.black);

  Text _labelText(val) => Text(val, style: _selectedColor(val));

  Widget _mahaboteLayout() => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(""),
                _labelText("အဓိပတိ"),
                const Text(""),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _labelText("အထွန်း"),
                _labelText("သိုက်"),
                _labelText("ရာဇ"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _labelText("မရဏ"),
                _labelText("ဘင်္ဂ"),
                _labelText("ပုတိ"),
              ],
            ),
          ],
        ),
      );

  Widget _houseNumberLayout() => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(""),
                Text(selectHouseNum[6].toString(),
                    style: TextStyle(
                        color: selectedDate.weekday - 1 == selectHouseNum[6]
                            ? Theme.of(context).primaryColor
                            : Colors.black)),
                const Text(""),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(selectHouseNum[2].toString(),
                    style: TextStyle(
                        color: selectedDate.weekday - 1 == selectHouseNum[2]
                            ? Theme.of(context).primaryColor
                            : Colors.black)),
                Text(selectHouseNum[3].toString(),
                    style: TextStyle(
                        color: selectedDate.weekday - 1 == selectHouseNum[3]
                            ? Theme.of(context).primaryColor
                            : Colors.black)),
                Text(selectHouseNum[4].toString(),
                    style: TextStyle(
                        color: selectedDate.weekday - 1 == selectHouseNum[4]
                            ? Theme.of(context).primaryColor
                            : Colors.black)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(selectHouseNum[1].toString(),
                    style: TextStyle(
                        color: selectedDate.weekday - 1 == selectHouseNum[1]
                            ? Theme.of(context).primaryColor
                            : Colors.black)),
                Text(selectHouseNum[0].toString(),
                    style: TextStyle(
                        color: selectedDate.weekday - 1 == selectHouseNum[0]
                            ? Theme.of(context).primaryColor
                            : Colors.black)),
                Text(selectHouseNum[5].toString(),
                    style: TextStyle(
                        color: selectedDate.weekday - 1 == selectHouseNum[5]
                            ? Theme.of(context).primaryColor
                            : Colors.black)),
              ],
            ),
          ],
        ),
      );

  String _houseResult(year, day) {
    var houses = ["ဘင်္ဂ", "အထွန်း", "ရာဇ", "အဓိပတိ", "မရဏ", "သိုက်", "ပုတိ"];
    return houses[(year - day - 1) % 7];
  }

  //1,4,0,3,6,2,5
  Widget _homeDesign() => ListView(
        children: <Widget>[
          Container(
            height: 120,
            color: Theme.of(context).primaryColor,
            child: ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1800),
                      lastDate: DateTime(2025),
                      helpText: 'Select Your Birthday', // Can be used as title
                      cancelText: 'Not now');
                  if (picked != null) {
                    if (picked.month != 4) {
                      var myanmarYear = picked.year - 638;
                      if (picked.month < 4) {
                        myanmarYear = picked.year - 637;
                      }

                      setState(() {
                        selectedDate = picked;
                        modVal = myanmarYear % 7;
                        houseName = _houseResult(myanmarYear, picked.weekday);

                        setSelectedHouseNumber();
                        selected = true;
                      });
                    } else {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  }
                },
                child: selected
                    ? Text(f.format(selectedDate))
                    : const Text("Select Your Birthday")),
          ),
          selectedDate.month == 4
              ? Row(
                  children: [
                    Expanded(child: Container()),
                    Checkbox(
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        print(selectedDate.weekday.toString());
                        setState(() {
                          isChecked = value!;
                          var myanmarYear;
                          if (isChecked) {
                            myanmarYear = selectedDate.year - 638;
                          } else {
                            myanmarYear = selectedDate.year - 637;
                          }

                          modVal = myanmarYear % 7;
                          houseName =
                              _houseResult(myanmarYear, selectedDate.weekday);
                          setSelectedHouseNumber();
                          selected = true;
                          print(selectedDate.weekday.toString());
                        });
                      },
                    ),
                    const Text('နှစ်သစ်ကူးအလွန်မှာမွေးတာလား?'),
                    Expanded(child: Container()),
                  ],
                )
              : Container(),
          Container(
            margin: const EdgeInsets.all(12),
            height: 170,
            child: Card(child: Center(child: _mahaboteLayout())),
          ),
          selected == false
              ? Container()
              : Container(
                  margin: const EdgeInsets.all(12),
                  child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text("အကြွင်း $modVal"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                houseName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ))),
                ),
          selected == false
              ? Container()
              : Container(
                  margin: EdgeInsets.all(12),
                  child: Card(
                    elevation: 5,
                    child: _houseNumberLayout(),
                  ),
                )
        ],
      );
}
