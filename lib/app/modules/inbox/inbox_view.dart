import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'inbox_logic.dart';

class InboxPage extends StatelessWidget {
  final logic = Get.find<InboxLogic>();

  InboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InboxLogic>(
          id: 'notificaciones',
          builder: (_) {
            final notificacionModel = _.notificacionModel;
            return notificacionModel != null
                ? notificacionModel.notificaciones.isNotEmpty
                    ? ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (__, index) => const Divider(),
                        itemBuilder: (__, index) {
                          final notificacion =
                              notificacionModel.notificaciones[index];
                          final day = DateFormat('d', 'es_ES')
                              .format(notificacion.dateLimit);
                          final mmm = DateFormat('MMM', 'es_ES')
                              .format(notificacion.dateLimit);
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xff1E4280),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: '$day\n',
                                    style: const TextStyle(fontSize: 16)),
                                TextSpan(
                                    text: mmm,
                                    style: const TextStyle(fontSize: 12))
                              ])),
                            ),
                            title: Text(
                              notificacion.titulo,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              notificacion.mensaje,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {},
                          );
                        },
                        itemCount: notificacionModel.notificaciones.length,
                      )
                    : const Center(child: Text('No hay notificaciones'))
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
