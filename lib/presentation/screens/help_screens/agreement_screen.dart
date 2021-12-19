import 'package:ad_drive/app_colors.dart';
import 'package:ad_drive/presentation/components/custom_app_bar.dart';
import 'package:ad_drive/presentation/components/general_scaffold.dart';
import 'package:flutter/material.dart';

class AgreementScreen extends StatelessWidget {
  const AgreementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralScaffold(
        appBar: CustomAppBar(title: "Agreement"),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Privacy policy",
                            style: TextStyle(
                              color: AppColors.PRIMARY_BLUE,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Rules of use of Qapta service",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      "(Prikol LLP BIN 123456789123)",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Nur-Sultan Current version from April 11, 2021",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam eget blandit enim, vel auctor eros. Nullam laoreet pretium quam, nec tempus arcu pretium eget. Suspendisse quis enim eu ipsum porttitor volutpat. Suspendisse quis lobortis urna. In in diam malesuada, varius justo in, euismod enim. Donec fringilla sapien lobortis arcu ultricies aliquet. Donec ornare faucibus leo, in congue mi tincidunt eu. Morbi felis felis, fringilla sed neque ut, tincidunt feugiat urna. Integer molestie dapibus leo, eget interdum neque elementum sed. Nullam iaculis maximus massa, ac iaculis mi. Proin aliquet sem sed leo tristique, aliquet venenatis mi lacinia. Donec consequat maximus ornare."
                      "Fusce vitae libero a augue porttitor finibus. Aliquam laoreet nec tellus sit amet sodales. Duis posuere accumsan nisi, ut tristique nunc facilisis quis. Donec semper felis metus, nec tristique lectus tincidunt vitae. Aliquam ac lobortis lorem. Integer rutrum, magna sit amet egestas pulvinar, nibh urna tempor ligula, id tristique turpis augue semper sapien. Ut enim felis, sodales eu hendrerit facilisis, feugiat vitae purus. Ut gravida ullamcorper dui, sed luctus sem vulputate quis. Pellentesque pretium velit risus, vitae aliquet leo faucibus a. Proin nisi tortor, pharetra non libero vitae, interdum malesuada dolor. Interdum et malesuada fames ac ante ipsum primis in faucibus. In id viverra lectus. Suspendisse vel diam sit amet erat aliquam sagittis."
                      "Interdum et malesuada fames ac ante ipsum primis in faucibus. Mauris commodo, ex non suscipit suscipit, enim eros sodales augue, eu facilisis dolor mi non lectus. Nullam non sapien massa. Nullam pellentesque, justo imperdiet sollicitudin placerat, leo quam gravida lectus, a dignissim orci lacus vitae leo. Ut orci massa, congue in lacinia in, eleifend aliquam est. Nullam ut justo nec ex condimentum facilisis. Fusce vel rhoncus nulla, id convallis ante. Morbi orci lorem, pulvinar vitae diam ut, sagittis viverra ante. Quisque aliquam lectus dolor. Suspendisse quis orci laoreet tellus volutpat mattis. Integer ut lorem lacinia, euismod lorem blandit, pretium enim. Nam a vestibulum nisl. Praesent vestibulum metus massa, ac elementum augue viverra id."
                      "Morbi quam justo, laoreet non augue nec, molestie auctor urna. Sed a justo tincidunt lectus pharetra fringilla. In nunc mi, sodales eu tempor vel, interdum nec odio. Cras id dui erat. Phasellus eu lorem non lectus scelerisque porttitor. Duis in dui fermentum, egestas enim nec, tincidunt nisi. Phasellus accumsan est ac purus posuere, et gravida lectus posuere. Sed luctus consectetur volutpat. Donec consequat ac erat id consectetur. Nunc venenatis scelerisque magna, a dignissim massa varius eu."
                      " Vivamus eleifend nibh sit amet varius faucibus. Suspendisse magna ante, cursus a luctus eu, semper ac nisl. Pellentesque sodales, elit sit amet elementum varius, arcu tortor posuere nunc, eget iaculis ante augue in ligula. Aliquam erat volutpat. In erat metus, gravida lobortis urna nec, tincidunt sagittis sem. Phasellus finibus elementum dolor, vitae congue tellus sagittis ac. Praesent a odio sed metus sollicitudin imperdiet ac sit amet diam. Nam malesuada elementum tincidunt. Pellentesque in ipsum nec lectus scelerisque convallis. Cras ac lorem at turpis cursus porttitor ut vitae sem. Donec pretium erat nec dui mollis, sed posuere ex rhoncus. Vivamus lobortis purus id augue fermentum, mattis sollicitudin nulla elementum. Praesent tristique facilisis nisl, vel vehicula velit dignissim facilisis.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.MONO_WHITE);
  }
}
