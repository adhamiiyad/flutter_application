import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageI(),
    );
  }
}

class HomePageI extends StatefulWidget {
  const HomePageI({super.key});

  @override
  State<HomePageI> createState() => _HomePageIState();
}

class _HomePageIState extends State<HomePageI> {
    final ref = FirebaseDatabase.instance.ref('products');
    late final stream = FirebaseDatabase.instance.ref('products/electronics/').onValue;

    void getProduct() async{

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drw(context),
      appBar: AppBar(
        title: const Text('mp'),
        backgroundColor: appBarColor,
      ),

      // body: Column(
      //   children: [
      //     Expanded(
      //         child: FirebaseAnimatedList(
      //             query: ref,
      //             itemBuilder: (context, snapshot, animation, index) {
      //               return ListTile(
      //                 title: Text(snapshot.child('xxx/name').value.toString()),
      //                 subtitle: Text(snapshot.child('xxx/password').value.toString()),
      //               );
      //             }))
      //   ],
      // ),

      // body: GridView.builder(
      //     padding: const EdgeInsets.all(15),
      //     itemCount: 3,
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2),
      //     itemBuilder: (context, index) {
      //       return Padding(
      //         padding: const EdgeInsets.all(10),
      //         child: Container(
      //           padding: const EdgeInsets.all(10),
      //           height: 20,
      //           width: 20,
      //           decoration: const BoxDecoration(
      //             color: Color.fromARGB(255, 71, 44, 43),
      //           ),
      //         ),
      //       );
      //     }),


      body: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data?.snapshot.value as Map?;
                if (data == null) {
                  return Text('No data');
                }
                final description = data['description'];
                final productNmae = data['productName'];
                final productPrice = data['productPrice'];
                // final pressure = data['pressure'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('dht11: $description'),
                    Text('gas: $productNmae'),
                    Text('humidity: $productPrice'),
                    // Text('pressure: $pressure'),
                  ],
                );
              }
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Text(snapshot.error.toString());
              }

              return Text('....');
            },
          ),
        
      
    
  

      /*
      StreamBuilder(
          stream: FirebaseDatabase.instance
              .ref()
              .child("products")
              .onValue,
          builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> map = snapshot.data.snapshot.value;


              products.clear();

             map.forEach((dynamic, v) =>
                 products.add( new Product(v["key"],v["cardid"] , v["cardname"],v["cardimage"] ,v["cardprice"], v["carddiscription"]))
             );

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: products.length,
                padding: EdgeInsets.all(2.0),
                itemBuilder: (BuildContext context, int index) {
                  return     GestureDetector(
                    onTap: (){

                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(

                        // width: (screenWidth(context)/2)-15,
                        height: 150,
                        decoration: BoxDecoration(

                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          image: DecorationImage(
                            image: NetworkImage(products[index].cardimage),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child:  Padding(
                          padding: EdgeInsets.all(0),
                          child: Container(

                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.black,
                                    const Color(0x19000000),
                                  ],
                                  begin: const FractionalOffset(0.0, 1.0),
                                  end: const FractionalOffset(0.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    products[index].cardname,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white),
                                  ),
                                  Text('Rs. ${products[index].cardprice}'
                                    ,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200,color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ), /* add child content here */
                      ),
                    ),
                  );

},
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
      */

      bottomNavigationBar: btm(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ref = FirebaseDatabase.instance.ref();
          final snapshot = await ref.child('user').get();
          if (snapshot.exists) {
            print(snapshot.value);
          } else {
            print('No data available.');
          }
        },
        child: Icon(Icons.abc),
      ),
    );
  }
}