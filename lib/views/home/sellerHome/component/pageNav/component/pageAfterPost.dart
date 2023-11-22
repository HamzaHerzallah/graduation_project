import 'package:flutter/material.dart';
import 'package:graduation_project/Models/data_post.dart';
import 'package:graduation_project/controller/card_data_post.dart';
import 'package:graduation_project/views/home/sellerHome/component/pageNav/component/sheetDataProduct.dart';

class PageAfterCreatePost extends StatelessWidget {
  const PageAfterCreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ListView.builder(
          itemCount: ControllerDataPost.dataLength,
          itemBuilder: (context, index) {
            return cardPost(data: ControllerDataPost.getNews(index));
          },
        ),
        addPostFromCircleButton(context),
      ],
    ));
  }

//***********************************4.circle botton add post*******************
  Widget addPostFromCircleButton(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 1,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const BottomSheetAdd();
              });
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(35)),
          child: const Icon(Icons.post_add, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}

//***********************************3.Structure post **********************************
Card cardPost({required DataPost data}) {
  return Card(
    elevation: 5,
    child: ListTile(
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {},
              child: const Text('Edit', style: TextStyle(color: Colors.blue))),
          const SizedBox(height: 5),
          InkWell(
              onTap: () {},
              child:
                  const Text('delete', style: TextStyle(color: Colors.blue))),
        ],
      ),
      leading: Image(image: AssetImage(data.imageProduct)),
      title: Text('${data.title} \n \t\$ ${data.price}'),
      subtitle: Text(data.description),
    ),
  );
}
