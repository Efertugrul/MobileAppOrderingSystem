import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/dimensions.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: Dimensions.width30 * 1.8,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(Dimensions.height15),
              height: Dimensions.height45 + Dimensions.height10,
              width: Dimensions.width30 * 1.8,
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 5),
            Text(text!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: Dimensions.font16 / 1.4))
          ],
        ),
      ),
    );
  }
}
