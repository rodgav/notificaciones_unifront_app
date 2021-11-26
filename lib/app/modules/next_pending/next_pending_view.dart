import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'next_pending_logic.dart';

class NextPendingPage extends StatelessWidget {
  final logic = Get.find<NextPendingLogic>();

  NextPendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<NextPendingLogic>(
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
                          final day = DateFormat('yMd', 'es_ES')
                              .format(notificacion.dateLimit);
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xff1E4280),
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width * 0.5,
                                  child: Text(notificacion.titulo,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(day,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)
                              ],
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
