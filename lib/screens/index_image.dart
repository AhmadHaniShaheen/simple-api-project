import 'package:api_secand_project/get/images_getx_controller.dart';
import 'package:api_secand_project/models/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as devtool show log;

class IndexImages extends StatefulWidget {
  const IndexImages({Key? key}) : super(key: key);

  @override
  State<IndexImages> createState() => _IndexImagesState();
}

class _IndexImagesState extends State<IndexImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/upload_image');
              },
              icon: const Icon(Icons.broken_image))
        ],
      ),
      body: GetX<ImagesGetxController>(
        init: ImagesGetxController(),
        global: true,
        builder: (controller) {
          print(controller.images.length);
          if (controller.loading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.images.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Image.network(
                          controller.images[index].imageUrl,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.black45,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    'to show data and test to show data and test to show data and test',
                                    style: TextStyle(
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis),
                                  )),
                                  IconButton(
                                    onPressed: () {
                                      deleteImage(index: index);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.zero,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Text('No Data');
          }
        },
      ),
    );
  }

  Future<void> deleteImage({required int index}) async {
    ApiResponse apiResponse =
        await ImagesGetxController.to.deleteImage(index: index);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(apiResponse.status
            ? 'Delete Image successfully'
            : 'Deleted  failed'),
        backgroundColor: apiResponse.status ? Colors.green : Colors.red,
      ),
    );
  }
}
