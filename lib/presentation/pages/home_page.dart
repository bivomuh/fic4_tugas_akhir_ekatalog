import 'package:fic4_flutter_auth/bloc/product/create_product/create_product_bloc.dart';
import 'package:fic4_flutter_auth/bloc/product/get_all_product/get_all_product_bloc.dart';
import 'package:fic4_flutter_auth/bloc/product/update_product/update_product_bloc.dart';
import 'package:fic4_flutter_auth/bloc/profile/profile_bloc.dart';
import 'package:fic4_flutter_auth/data/models/request/product_model.dart';
import 'package:fic4_flutter_auth/data/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/delete_product/delete_product_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    context.read<GetAllProductBloc>().add(DoGetAllProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffB7E3C8),
      body: Stack(children: [
        const Align(
          alignment: Alignment.bottomCenter,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    return Column(
                      children: [
                        const SizedBox(height: 80),
                        Text(
                          'Hello ${state.profile.name}!',
                          style: blackTextStyle.copyWith(
                              fontSize: 28, fontWeight: bold),
                        ),
                        const SizedBox(height: 20),
                        // IconButton(
                        //     onPressed: () {
                        //       AuthLocalStorage().removeToken();
                        //       Navigator.pushNamed(context, '/login');
                        //     },
                        //     icon: const Icon(Icons.logout_rounded)),
                      ],
                    );
                  }
                  return Text('No Data',
                      style: blackTextStyle.copyWith(fontSize: 28));
                },
              ),
              Expanded(
                child: BlocBuilder<GetAllProductBloc, GetAllProductState>(
                  builder: (context, state) {
                    if (state is GetAllProductLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is GetAllProductLoaded) {
                      return ListView.builder(itemBuilder: (context, index) {
                        final product =
                            state.listProduct.reversed.toList()[index];
                        return Card(
                            elevation: 5,
                            margin: const EdgeInsets.only(bottom: 24),
                            color: kBackgroundColor,
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              padding: const EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          product.title ?? '',
                                          style: blackTextStyle.copyWith(
                                              fontSize: 24, fontWeight: bold),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          product.description ?? '',
                                          style: greyTextStyle,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        children: [
                                          Text('\$',
                                              style: TextStyle(
                                                  fontWeight: bold,
                                                  color: const Color.fromARGB(
                                                      255, 37, 126, 40))),
                                          Text(product.price.toString(),
                                              style: blackTextStyle.copyWith(
                                                  fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            titleController =
                                                TextEditingController(
                                                    text: product.title);
                                            descriptionController =
                                                TextEditingController(
                                                    text: product.description);
                                            priceController =
                                                TextEditingController(
                                                    text: product.price
                                                        .toString());
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0), // Atur radius yang diinginkan
                                                    ),
                                                    title: const Text(
                                                        'Update Product'),
                                                    content: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          TextField(
                                                            decoration:
                                                                const InputDecoration(
                                                                    labelText:
                                                                        'Title'),
                                                            controller:
                                                                titleController,
                                                          ),
                                                          TextField(
                                                            decoration:
                                                                const InputDecoration(
                                                                    labelText:
                                                                        'Price'),
                                                            controller:
                                                                priceController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                          ),
                                                          TextField(
                                                            maxLines: 3,
                                                            decoration:
                                                                const InputDecoration(
                                                                    labelText:
                                                                        'Description'),
                                                            controller:
                                                                descriptionController,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'Cancel')),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      BlocListener<
                                                          UpdateProductBloc,
                                                          UpdateProductState>(
                                                        listener:
                                                            (context, state) {
                                                          if (state
                                                              is UpdateProductLoaded) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text('Berhasil Update')));
                                                            Navigator.pop(
                                                                context);
                                                            context
                                                                .read<
                                                                    GetAllProductBloc>()
                                                                .add(
                                                                    DoGetAllProductEvent());
                                                          }
                                                        },
                                                        child: BlocBuilder<
                                                            UpdateProductBloc,
                                                            UpdateProductState>(
                                                          builder:
                                                              (context, state) {
                                                            if (state
                                                                is UpdateProductLoading) {
                                                              return const ElevatedButton(
                                                                  onPressed:
                                                                      null,
                                                                  child: SizedBox(
                                                                      width: 25,
                                                                      height:
                                                                          25,
                                                                      child:
                                                                          CircularProgressIndicator()));
                                                            }
                                                            return ElevatedButton(
                                                              onPressed: () {
                                                                final productModel =
                                                                    ProductModel(
                                                                  title:
                                                                      titleController
                                                                          .text,
                                                                  price: int.parse(
                                                                      priceController
                                                                          .text),
                                                                  description:
                                                                      descriptionController
                                                                          .text,
                                                                );
                                                                context
                                                                    .read<
                                                                        UpdateProductBloc>()
                                                                    .add(DoUpdateProductEvent(
                                                                        productModel:
                                                                            productModel,
                                                                        id: product.id ??
                                                                            0));
                                                              },
                                                              child: const Text(
                                                                  'Save'),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(
                                              Icons.mode_edit_outline_rounded)),

                                      // !DELETE
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0), // Atur radius yang diinginkan
                                                  ),
                                                  title: const Text(
                                                      'Delete Product'),
                                                  content: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                            'Are you sure want to delete this product?'),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    BlocListener<
                                                        DeleteProductBloc,
                                                        DeleteProductState>(
                                                      listener:
                                                          (context, state) {
                                                        if (state
                                                            is DeleteProductLoaded) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Berhasil Menghapus Produk')));
                                                          Navigator.pop(
                                                              context);
                                                          context
                                                              .read<
                                                                  GetAllProductBloc>()
                                                              .add(
                                                                  DoGetAllProductEvent());
                                                        }
                                                      },
                                                      child: BlocBuilder<
                                                          DeleteProductBloc,
                                                          DeleteProductState>(
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is DeleteProductLoading) {
                                                            const ElevatedButton(
                                                                onPressed: null,
                                                                child: SizedBox(
                                                                    width: 25,
                                                                    height: 25,
                                                                    child:
                                                                        CircularProgressIndicator()));
                                                          }
                                                          return ElevatedButton(
                                                            onPressed: () {
                                                              context
                                                                  .read<
                                                                      DeleteProductBloc>()
                                                                  .add(DoDeleteProductEvent(
                                                                      id: product
                                                                              .id ??
                                                                          0));
                                                            },
                                                            child: const Text(
                                                                'Delete'),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                            // ListTile(
                            //   title: Text(product.title ?? '  '),
                            //   subtitle: Text(product.description ?? '  '),
                            //   leading:
                            //       CircleAvatar(child: Text('${product.price}')),
                            // ),
                            );
                      });
                    }
                    return const Text('No Data');
                  },
                ),
              )
            ],
          ),
        ),
      ]),

      floatingActionButton: FloatingActionButton(
        backgroundColor: kGreenColor,
        onPressed: () {
          titleController = TextEditingController();
          descriptionController = TextEditingController();
          priceController = TextEditingController();
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Atur radius yang diinginkan
                  ),
                  title: const Text('Add Product'),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: const InputDecoration(labelText: 'Title'),
                          controller: titleController,
                        ),
                        TextField(
                          decoration: const InputDecoration(labelText: 'Price'),
                          controller: priceController,
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          maxLines: 3,
                          decoration:
                              const InputDecoration(labelText: 'Description'),
                          controller: descriptionController,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    BlocListener<CreateProductBloc, CreateProductState>(
                      listener: (context, state) {
                        if (state is CreateProductLoaded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Berhasil Menambahkan Produk')));
                          Navigator.pop(context);
                          context
                              .read<GetAllProductBloc>()
                              .add(DoGetAllProductEvent());
                        }
                      },
                      child: BlocBuilder<CreateProductBloc, CreateProductState>(
                        builder: (context, state) {
                          if (state is CreateProductLoading) {
                            const ElevatedButton(
                                onPressed: null,
                                child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator()));
                          }
                          return ElevatedButton(
                            onPressed: () {
                              final productModel = ProductModel(
                                title: titleController.text,
                                price: int.parse(priceController.text),
                                description: descriptionController.text,
                              );
                              context.read<CreateProductBloc>().add(
                                  DoCreateProductEvent(
                                      productModel: productModel));

                              // context
                              //     .read<GetAllProductBloc>()
                              //     .add(DoGetAllProductEvent());
                            },
                            child: const Text('Save'),
                          );
                        },
                      ),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),

      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {

      //       },
      //       child: const Icon(
      //         Icons.add,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Future<dynamic> formProduct({BuildContext? context, bool? isEdit, int? id}) {
    return showDialog(
        context: context!,
        builder: (context) {
          return AlertDialog(
            title: Text(isEdit == false ? 'Add Product' : 'Edit Product'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: titleController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  controller: priceController,
                  keyboardType: TextInputType.number,
                ),
                isEdit == false
                    ? TextField(
                        maxLines: 3,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        controller: descriptionController,
                      )
                    : const SizedBox()
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(
                width: 4,
              ),
              BlocListener<CreateProductBloc, CreateProductState>(
                listener: (context, state) {
                  if (state is CreateProductLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('${state.productResponseModel.id}')));
                    Navigator.pop(context);
                    context
                        .read<GetAllProductBloc>()
                        .add(DoGetAllProductEvent());
                  }
                },
                child: BlocBuilder<UpdateProductBloc, UpdateProductState>(
                  builder: (context, state) {
                    if (State is UpdateProductLoading) {
                      // Future.delayed(const Duration(seconds: 5));
                      return const CircularProgressIndicator();
                    }

                    return BlocBuilder<CreateProductBloc, CreateProductState>(
                      builder: (context, state) {
                        if (state is CreateProductLoading) {
                          return const CircularProgressIndicator();
                        }
                        return ElevatedButton(
                          onPressed: () {
                            final productModel = ProductModel(
                              title: titleController.text,
                              price: int.parse(priceController.text),
                              description: descriptionController.text,
                            );
                            isEdit == false
                                ? context.read<CreateProductBloc>().add(
                                    DoCreateProductEvent(
                                        productModel: productModel))
                                : context.read<UpdateProductBloc>().add(
                                    DoUpdateProductEvent(
                                        productModel: productModel, id: id!));

                            // context
                            //     .read<GetAllProductBloc>()
                            //     .add(DoGetAllProductEvent());
                          },
                          child: Text(isEdit == false ? 'Save' : 'Update'),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  Future<dynamic> updateFormProduct({BuildContext? context, int? id}) {
    return showDialog(
        context: context!,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit Product'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: titleController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  controller: priceController,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(
                width: 4,
              ),
              BlocBuilder<UpdateProductBloc, UpdateProductState>(
                builder: (context, state) {
                  if (State is UpdateProductLoading) {
                    // Future.delayed(const Duration(seconds: 5));
                    return const CircularProgressIndicator();
                  }

                  return ElevatedButton(
                    onPressed: () {
                      final productModel = ProductModel(
                        title: titleController.text,
                        price: int.parse(priceController.text),
                        description: descriptionController.text,
                      );
                      context.read<UpdateProductBloc>().add(
                          DoUpdateProductEvent(
                              productModel: productModel, id: id!));

                      // context
                      //     .read<GetAllProductBloc>()
                      //     .add(DoGetAllProductEvent());
                    },
                    child: const Text('Update'),
                  );
                },
              ),
            ],
          );
        });
  }
}
