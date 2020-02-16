import 'package:bratur/knowit_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  final Function onLogin;
  final bool loading;

  const LoginPage({
    Key key,
    @required this.onLogin,
    @required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        backgroundColor: KnowitColors.forest,
        brightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: KnowitColors.forest,
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle(
            systemNavigationBarColor: KnowitColors.forest,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/Rocket-Digital-black.svg',
                        semanticsLabel: 'Rakettlogo',
                        color: KnowitColors.white,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                      loading
                          ? CircularProgressIndicator()
                          : Row(
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: onLogin,
                                    child: Text('Logg inn med Knowit-konto'),
                                    padding:
                                        new EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
