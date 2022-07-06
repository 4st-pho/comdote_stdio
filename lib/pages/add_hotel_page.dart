import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stdio_week_6/blocs/change_image_bloc.dart';
import 'package:stdio_week_6/blocs/loading_bloc.dart';
import 'package:stdio_week_6/constants/assets_icon.dart';
import 'package:stdio_week_6/constants/collection_path.dart';
import 'package:stdio_week_6/constants/const_string.dart';
import 'package:stdio_week_6/constants/my_font.dart';
import 'package:stdio_week_6/helper/build_text_form_field.dart';
import 'package:stdio_week_6/helper/hide_keyboard.dart';
import 'package:stdio_week_6/helper/show_snackbar.dart';
import 'package:stdio_week_6/pages/widgets/dotted_image.dart';
import 'package:stdio_week_6/pages/widgets/image_border.dart';
import 'package:stdio_week_6/services/cloud_firestore/hotel_firestore.dart';
import 'package:stdio_week_6/widgets/custom_button.dart';
import 'package:stdio_week_6/widgets/custom_outline_button.dart';

class AddHotelPage extends StatefulWidget {
  const AddHotelPage({Key? key}) : super(key: key);

  @override
  State<AddHotelPage> createState() => _AddHotelPageState();
}

class _AddHotelPageState extends State<AddHotelPage> {
  late final TextEditingController nameController;
  late final TextEditingController addressController;
  late final TextEditingController descriptionController;
  File? file;
  final _addHotelBloc = ChangeImageBloc();
  final _loadingBloc = LoadingBloc();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    _addHotelBloc.dispose();
    _loadingBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context: context);
      },
      child: Scaffold(
        extendBody: true,
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildForm(),
                      const SizedBox(height: 10),
                      _buildPickImage()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Flexible(
                      flex: 4,
                      child: CustomOutlineButton(
                          text: ConstString.cancel,
                          onPress: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    const Flexible(
                        flex: 1, fit: FlexFit.tight, child: SizedBox()),
                    StreamBuilder<bool>(
                      stream: _loadingBloc.stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final loading = snapshot.data!;
                        return Flexible(
                          flex: 8,
                          child: CustomButton(
                            text: ConstString.done,
                            onPressed: loading
                                ? null
                                : () async {
                                    hideKeyboard(context: context);
                                    _loadingBloc.toggleState();
                                    if (!_formKey.currentState!.validate()) {
                                      _loadingBloc.toggleState();
                                      return;
                                    }
                                    String error = '';
                                    if (nameController.text.length > 40) {
                                      error =
                                          ConstString.nameExceeds40Characters;
                                    }
                                    if (file == null) {
                                      error += ConstString.imageIsRequired;
                                    }
                                    if (error.isNotEmpty) {
                                      showSnackBar(
                                        context: context,
                                        content: error,
                                        error: true,
                                      );
                                      _loadingBloc.toggleState();
                                      return;
                                    }

                                    await HotelFirestore().createHotel(
                                        name: nameController.text,
                                        address: addressController.text,
                                        description: descriptionController.text,
                                        file: file,
                                        collectionImagePath:
                                            CollectionPath.hotelImage);
                                    if (!mounted) return;
                                    showSnackBar(
                                        context: context,
                                        content: ConstString.addSuccesfully,
                                        title: ConstString.addNewHotel);
                                    Navigator.of(context).pop();
                                  },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildPickImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hotel image', style: MyFont.blackTitle),
        const SizedBox(height: 10),
        StreamBuilder<File?>(
            stream: _addHotelBloc.stream,
            initialData: null,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              final imageFile = snapshot.data;
              file = imageFile;
              return imageFile == null
                  ? DottedImage(onPressed: () async {
                      await _addHotelBloc.getImage();
                    })
                  : InkWell(
                      onTap: () async {
                        await _addHotelBloc.getImage();
                      },
                      child: ImageBorder(imageFile: imageFile));
            }),
        const SizedBox(height: 20),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Image.asset(AssetsIcon.arrowBack, height: 24),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text('Add hotel', style: MyFont.blackHeading),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 10),
          BuildTextFormFeild(
              controller: nameController,
              subtitle: 'Do not exceed 40 characters when entering.',
              title: 'Hotel name',
              type: TextInputType.text),
          const SizedBox(height: 10),
          BuildTextFormFeild(
              controller: addressController,
              title: 'Address',
              type: TextInputType.text),
          const SizedBox(height: 10),
          BuildTextFormFeild(
              controller: descriptionController,
              title: 'Desciption',
              type: TextInputType.multiline),
        ],
      ),
    );
  }
}
