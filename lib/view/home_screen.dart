import 'package:barcode_scanner/controller/home_provider.dart';
import 'package:barcode_scanner/core/constants.dart';
import 'package:barcode_scanner/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.getApi();
    provider.getAllApi();
    return Scaffold(
      backgroundColor: kGreyColor,
      appBar: AppBar(
        title: const Text("DropDown List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<HomeProvider>(
                builder: (context, value, child) {
                  return Center(
                    child: SizedBox(
                      width: size.width,
                      height: 60,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.blue.shade300, width: 3)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.white,
                            hint: const Text('Select'),
                            icon: const Icon(Icons.arrow_drop_down),
                            items: provider.categoryItemlist.map((item) {
                              return DropdownMenuItem(
                                value: item['title'].toString(),
                                child: SizedBox(
                                  width: size.width * .8,
                                  child: Text(
                                    item['title'].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              value.valueChanging(newVal);
                            },
                            value: value.dropdownvalue,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              kHeight20,
              Consumer<HomeProvider>(
                builder: (context, value, child) {
                  return value.isLoading == true
                      ? SizedBox(
                          height: size.height * .7,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox(
                          height: size.height,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final data = value.products[index];
                              return ListTile(
                                minVerticalPadding: 30,
                                contentPadding:
                                    const EdgeInsets.only(left: 0, right: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                tileColor: kTileColor,
                                leading: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(data.image),
                                  ),
                                ),
                                title: Text(
                                  data.title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    '₹${data.price}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(index: index),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => kHeight20,
                            itemCount: value.products.length,
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
