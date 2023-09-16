import 'dart:io';

import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';

import '../widget/game_pad.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> elements = ['', '', '', '', '', '', '', '', ''];

  int filledBoxes = 0;

  int xScore = 0;

  int oScore = 0;

  bool oTurn = true;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.height;
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: mediaQuery * 0.05,
              ),
              textBackground('X Score - $xScore', context, colorTheme.primary),
              SizedBox(
                height: mediaQuery * 0.05,
              ),
              textBackground('O Score - $oScore', context, colorTheme.primary),
              SizedBox(
                height: mediaQuery * 0.05,
              ),
              textBackground(
                oTurn ? 'O\'s Turn' : 'X\'s Turn',
                context,
                colorTheme.secondary,
              ),
              SizedBox(
                height: mediaQuery * 0.03,
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    child: GamePad(index, elements, tapped),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          height: mediaQuery * 0.1,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: colorTheme.primary,
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(25),
              topStart: Radius.circular(25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              customButton(
                clearScore,
                'Reset',
                context,
                colorTheme.secondary,
              ),
              customButton(
                () => exit(0),
                'Quit',
                context,
                colorTheme.error,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textBackground(String text, BuildContext context, Color color) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.height * 0.33,
        color: color,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget customButton(
      final VoidCallback fx, String text, BuildContext context, Color color) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ElevatedButton(
        onPressed: fx,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 4,
          shadowColor: Colors.black,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (oTurn && elements[index] == '') {
        elements[index] = 'O';
        filledBoxes++;
        oTurn = !oTurn;
      } else if (!oTurn && elements[index] == '') {
        elements[index] = 'X';
        filledBoxes++;
        oTurn = !oTurn;
      }

      checkWinner();
    });
  }

  void checkWinner() {
    // row wise

    if (elements[0] == elements[1] &&
        elements[0] == elements[2] &&
        elements[0] != '') {
      showWinner(elements[0]);
      return;
    }
    if (elements[3] == elements[4] &&
        elements[3] == elements[5] &&
        elements[3] != '') {
      showWinner(elements[3]);
      return;
    }

    if (elements[6] == elements[7] &&
        elements[6] == elements[8] &&
        elements[6] != '') {
      showWinner(elements[6]);
      return;
    }

    // col wise

    if (elements[0] == elements[3] &&
        elements[0] == elements[6] &&
        elements[0] != '') {
      showWinner(elements[0]);
      return;
    }
    if (elements[1] == elements[4] &&
        elements[1] == elements[7] &&
        elements[1] != '') {
      showWinner(elements[1]);
      return;
    }

    if (elements[2] == elements[5] &&
        elements[2] == elements[8] &&
        elements[2] != '') {
      showWinner(elements[2]);
      return;
    }

    // diagonal check

    if (elements[0] == elements[4] &&
        elements[0] == elements[8] &&
        elements[0] != '') {
      showWinner(elements[0]);
      return;
    }
    if (elements[2] == elements[4] &&
        elements[2] == elements[6] &&
        elements[2] != '') {
      showWinner(elements[2]);
      return;
    }

    if (filledBoxes == 9) {
      showDraw();
    }
  }

  void showWinner(String win) {
    AwesomeDialog(
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.SUCCES,
      title: '$win Won!',
      btnOkOnPress: () {
        clearBoard();
      },
      btnOkText: 'Play Again',
    ).show();

    if (win == 'X') {
      xScore++;
    } else if (win == 'O') {
      oScore++;
    }
  }

  void showDraw() {
    AwesomeDialog(
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.INFO,
      title: 'Draw!',
      btnOkOnPress: () {
        clearBoard();
      },
      btnOkText: 'Play Again',
    ).show();
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        elements[i] = '';
      }
      filledBoxes = 0;
    });
  }

  void clearScore() {
    setState(() {
      xScore = 0;
      oScore = 0;

      for (int i = 0; i < 9; i++) {
        elements[i] = '';
      }
      filledBoxes = 0;
    });
    clearBoard();
  }
}
