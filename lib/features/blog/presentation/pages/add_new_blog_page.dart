import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (_) => const AddNewBlogPage(),
      );
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleConntroller = TextEditingController();
  final contentConntroller = TextEditingController();
  File? image;

  List<String> selectedTopic = [];

  void selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      image = pickedImage;
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleConntroller.dispose();
    contentConntroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: selectImage,
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: DottedBorder(
                        radius: const Radius.circular(10),
                        color: AppPallete.borderColor,
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        dashPattern: const [10, 4],
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Select your image",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ["Technology", "Business", "Programming", "Entertainment"]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopic.contains(e)) {
                                    selectedTopic.remove(e);
                                  } else {
                                    selectedTopic.add(e);
                                  }
                                  // selectedTopic;
                                  setState(() {});
                                },
                                child: Chip(
                                  color: selectedTopic.contains(e)
                                      ? WidgetStateProperty.all(
                                          AppPallete.gradient1)
                                      : null,
                                  label: Text(e),
                                  side: selectedTopic.contains(e)
                                      ? null
                                      : const BorderSide(
                                          color: AppPallete.borderColor,
                                        ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              BlogEditor(controller: titleConntroller, hintText: "Blog Title"),
              const SizedBox(
                height: 10,
              ),
              BlogEditor(
                  controller: contentConntroller, hintText: "Blog Content"),
            ],
          ),
        ),
      ),
    );
  }
}
