// import 'dart:html';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apptest/pages/plantList.dart';
import 'package:apptest/pages/pdfreport.dart';
import 'package:apptest/services/auth.dart';
import 'package:apptest/services/localization_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:readmore/readmore.dart';
import 'package:apptest/widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class report extends StatefulWidget {
  final String imagePath;
  final String? category;

  bool isprevreport;
  report({required this.imagePath, this.category, this.isprevreport = false});

  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  final Pdfreport pdf = Pdfreport();
  var remedy = {
    'Early blight':
        'Prune or stake plants to improve air circulation and reduce fungal problems.Make sure to disinfect your pruning shears (one part bleach to 4 parts water) after each cut.Keep the soil under plants clean and free of garden debris. Add a layer of organic compost to prevent the spores from splashing back up onto vegetation.',
    'Tomato mosaic virus':
        'Remove all infected plants and destroy them. Do NOT put them in the compost pile, as the virus may persist in infected plant matter. Burn infected plants or throw them out with the garbage.Monitor the rest of your plants closely, especially those that were located near infected plants.Disinfect gardening tools after every use. Keep a bottle of a weak bleach solution or other antiviral disinfectant to wipe your tools down with',
    'Septoria leaf spot':
        'Remove infected leaves immediately, and be sure to wash your hands and pruners thoroughly before working with uninfected plants.Consider organic fungicide options. Fungicides containing either copper or potassium bicarbonate will help prevent the spreading of the disease. Begin spraying as soon as the first symptoms appear and follow the label directions for continued management.',
    'Bacterial spot':
        'Remove symptomatic plants from the field or greenhouse to prevent the spread of bacteria to healthy plants.  Burn, bury or hot compost the affected plants and DO NOT eat symptomatic fruit.',
    'Target Spot':
        'Remove symptomatic plants from the field or greenhouse to prevent the spread of bacteria to healthy plants.  Burn, bury or hot compost the affected plants and DO NOT eat symptomatic fruit.',
    'Spider mites Two-spotted spider mite':
        'CulturalAvoid continuous cropping of tomato and related plants which makes it difficult to control red spider mites, since they always have a plant to feed on.Remove remains (residues) from a previous crop and destroy before planting new crop.Before transferring sticks (stakes) from an infested field to another, wash with soap and water and dry properly under direct sun for a week to avoid transfer of mites. Do the same for twines in the greenhouse.Inspect your crop borders for typical symptoms of red spider mite.Spray water regularly on plants to reduce dust, spider mites do well in dusty conditions.ChemicalWhen spraying ensure underside of leaf is covered by the chemical.Use fungicides with sulphur, since they reduce populations of mites.You can also use miticides which are specific for mites e.g. Dynamec (active ingredient abamectin), Oberon (spiromesifen) or Omite (propargite).',
    'Tomato Yellow Leaf Curl Virus':
        'Fields should be inspected daily for the presence of whiteflies. A trap can be made with a piece of board 12 inches x 12 inches painted bright yellow. Spread petroleum jelly or Biotac on it. The yellow colour attracts the whiteflies to the boards and they stick to them. The boards are placed at the height of the plants. Monitor all crops, not just tomato plants as the whitefly may have passed the virus onto another crop.Plants that show signs of the virus after 3-4 weeks of transplanting should be bagged (to prevent the whiteflies leaving), uprooted and burned to reduce spread of the virus.Plants should be watered and fertilized adequately to reduce stress and to build plant health.',
    'Late blight':
        'Continue weekly spray applications to protect plants from further infection. Severely infected plants can be rogued and either buried or burned. Avoid composting diseased plants.Rotate tomatoes with vegetables unrelated botanically to tomatoes or potatoes. Do not plant these sites with these groups of vegetables for two to three years. Avoid harvesting tomato fruits with visible disease lesions.',
    'Healthy': 'None',
    'Leaf Mold':
        'When treating tomato plants with fungicide, be sure to cover all areas of the plant that are above the soil, especially the underside of leaves, where the disease often forms. Calcium chloride-based sprays are recommended for treating leaf mold issues. ',
  };

  var desc = {
    'Early blight':
        'It affects leaves, fruits and stems and can be severely yield limiting when susceptible cultivars are used and weather is favorable.Severe defoliation can occur and result in sunscald on the fruit,* is caused by the fungus Alternaria soleni ',
    'Tomato mosaic virus':
        ' The symptoms vary from tiles, wrinkle, reduction and curvature of leaflets, and irregular ripening of fruits. This disease requires attention because of its easy dissemination by contact, cultural practices, or contaminated seed. - It is caused by aphid insects (known as zobugs)',
    'Septoria leaf spot':
        'Septoria Leaf Spot of Tomato Vegetable  is caused by the fungus Septoria lycopersici. The disease is particularly destructive in seasons of moderate temperature and abundant rainfall, with the ability to reduce tomato yields dramatically. - is caused by the fungus septoria iycopersici speg',
    'Bacterial spot':
        'Bacterial spot of tomato is caused by Xanthomonas vesicatoria, Xanthomonas euvesicatoria, Xanthomonas gardneri, and Xanthomonas perforans. Bacterial spot can occur wherever tomatoes are grown, but is found most frequently in warm, wet climates, as well as in greenhouses.Bacterial spot can affect all above ground parts of a tomato plant, including the leaves, stems, and fruit. - is caused by the bacteria Xanthomonas vesicatoria',
    'Target Spot':
        'Target spot on tomato fruit is difficult to control because the spores, which survive on plant refuse in the soil, are carried over from season to season. - is caused by the fungus Corynespora cassiicola ',
    'Spider mites Two-spotted spider mite':
        'The two-spotted spider mite is the most common mite species that attacks vegetable and fruit crops .  They have up to 20 generations per year and are favored by excess nitrogen and dry and dusty conditions. Outbreaks are often caused by the use of broad-spectrum insecticides which interfere with the numerous natural enemies that help to manage mite populations. As with most pests, catching the problem early will mean easier control. - It is caused by the mites Tetranychus urticae ',
    'Tomato Yellow Leaf Curl Virus': '',
    'Late blight':
        'Late blight is a potentially devastating disease of tomato and potato, infecting leaves, stems and tomato fruit.The disease spreads quickly in fields and can result in total crop failure if untreated. - is caused by the fungus Phytophthora infestans',
    'Healthy': 'Wohoo your plant is healthy!!!',
    'Leaf Mold':
        'Tomato leaf mold is a foliar disease that is especially problematic in greenhouse and high tunnels. It is a pathogen that causes leaf lesions. - is caused by the fungus Fulvia fulva',
  };

  final db = AuthService().db;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var transdesc = "";
  var transremedy = "";

  final AuthService _aauth = AuthService();
  final lang = LocalizationService();
  var lCode;
  final FlutterTts flutterTts = FlutterTts();

  void translate() async {
    final translator = GoogleTranslator();
    var td = await translator.translate(desc[widget.category]!,
        from: 'en', to: lCode);
    var tr = await translator.translate(remedy[widget.category]!,
        from: 'en', to: lCode);
    setState(() {
      transdesc = td.text;
      transremedy = tr.text;
    });
  }

  @override
  void initState() {
    lCode = lang.getLanguageCode(lang.getCurrentLang());
    translate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future speakdesc() async {
      String languageCode = (lCode == "hi") ? "hi-IN" : "en-US";

      await flutterTts.setLanguage(languageCode);
      await flutterTts.setPitch(1);
      await flutterTts.setVoice(
          {"name": "Karen", "locale": (lCode == "hi") ? "en-AU" : "pt-BR"});
      await flutterTts.speak(transdesc);
    }

    Future speakremedy() async {
      String languageCode = (lCode == "hi") ? "hi-IN" : "en-US";

      await flutterTts.setLanguage(languageCode);
      await flutterTts.setPitch(1);
      await flutterTts.setVoice(
          {"name": "Karen", "locale": (lCode == "hi") ? "en-AU" : "pt-BR"});
      await flutterTts.speak(transremedy);
    }

    Future speakdisease() async {
      String languageCode = (lCode == "hi") ? "hi-IN" : "en-US";

      await flutterTts.setLanguage(languageCode);
      await flutterTts.setPitch(1);
      await flutterTts.setVoice(
          {"name": "Karen", "locale": (lCode == "hi") ? "en-AU" : "pt-BR"});
      await flutterTts.speak('${widget.category}'.tr);
    }

    return Scaffold(
      appBar: common_nav_bar(appBar: AppBar(), auth: _aauth),
      // body: const Center(
      //   // child: Image(image: AssetImage('assets/img2.png'),
      //   // ),

      //    ),

      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0, top: 40.0, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Report Generated'.tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  var res = await pdf.generatepdf(
                                      widget.category!,
                                      desc[widget.category],
                                      remedy[widget.category],
                                      widget.imagePath);
                                  print(res);
                                },
                                icon: Icon(Icons.download),
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.share),
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    color: Colors.teal[800],
                    height: MediaQuery.of(context).size.height * 0.4),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(15.0),
                        padding: EdgeInsets.all(17.0),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.teal[50],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: const Offset(
                                0,
                                3,
                              ),
                              blurRadius: 5.0,
                              spreadRadius: 0.2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Doença:'.tr,
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.volume_up_rounded,
                                    size: 25.0,
                                  ),
                                  onPressed: () {
                                   // speakdisease();
                                  },
                                )
                              ],
                            ),
                            Text(
                              '${widget.category}'.tr,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontFamily: 'Roboto'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.all(15.0),
                          padding: EdgeInsets.all(17.0),
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.teal[50],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: const Offset(
                                  0,
                                  3,
                                ),
                                blurRadius: 5.0,
                                spreadRadius: 0.2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Descrição:'.tr,
                                      style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Roboto'),
                                      children: <TextSpan>[
                                        // TextSpan(
                                        //   text: '${desc[category]}',
                                        //   style: TextStyle(
                                        //       fontSize: 20,
                                        //       fontWeight: FontWeight.w400,
                                        //       color: Colors.black,
                                        //       fontFamily: 'Roboto'),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.volume_up_rounded,
                                      size: 25.0,
                                    ),
                                    onPressed: () {
                                     // speakdesc();
                                    },
                                  )
                                ],
                              ),
                              ReadMoreText(
                                transdesc,
                                trimLines: 2,
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                                trimCollapsedText: 'show more'.tr,
                                trimExpandedText: 'show less'.tr,
                                moreStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                                lessStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.all(15.0),
                        padding: EdgeInsets.all(17.0),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.teal[50],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: const Offset(
                                0,
                                3,
                              ),
                              blurRadius: 5.0,
                              spreadRadius: 0.2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Remédio:'.tr,
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Roboto'),
                                    children: <TextSpan>[
                                      // TextSpan(
                                      //   text: '${remedy[category]}',
                                      //   style: TextStyle(
                                      //       fontSize: 20,
                                      //       color: Colors.black,
                                      //       fontWeight: FontWeight.w400,
                                      //       fontFamily: 'Roboto'),
                                      // ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.volume_up_rounded,
                                    size: 25.0,
                                  ),
                                  onPressed: () {
                                   // speakremedy();
                                  },
                                )
                              ],
                            ),
                            ReadMoreText(
                              transremedy,
                              trimLines: 2,
                              colorClickableText: Colors.pink,
                              trimMode: TrimMode.Line,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              trimCollapsedText: 'show more'.tr,
                              trimExpandedText: 'show less'.tr,
                              moreStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              lessStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      !widget.isprevreport
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    final User? user = _auth.currentUser;
                                    final uid = user!.uid;
                                    DateTime dateToday = new DateTime.now();
                                    String date =
                                        dateToday.toString().substring(0, 10);
                                    // final results = await db
                                    //     .collection('users')
                                    //     .doc(uid)
                                    //     .collection('reports')
                                    //     .doc()
                                    //     .set({
                                    //   "Disease": widget.category,
                                    //   "Description": desc[widget.category],
                                    //   "Remedy": desc[widget.category],
                                    //   "Date": date,
                                    //   "image": widget.imagePath
                                    // });
                                    await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => plantList(
                                          // Pass the automatically generated path to
                                          // the DisplayPictureScreen widget.
                                          disease: widget.category,
                                          description: desc[widget.category],
                                          remedy: desc[widget.category],
                                          date: date,
                                          image: widget.imagePath,
                                          save: true),
                                    ));
                                  },
                                  child: Text(
                                    'Salvar'.tr,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        letterSpacing: 1.25),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          (MaterialStateProperty.all(
                                              Colors.teal[900])),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ))),
                                ),
                              ],
                            )
                          : SizedBox(width: 5.0),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 100.0,
                    ),
                    Container(
                      height: 250.0,
                      width: 250.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(widget.imagePath)),
                              fit: BoxFit.cover),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ecoration: BoxDecoration(
//                       border: Border.all(width: 4, color: Colors.white),
//                       image: DecorationImage(
//                           image: AssetImage("assets/image1.jpg"),
//                           fit: BoxFit.cover),
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(10))),