import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/url.dart';
import 'package:halan/model/entity.dart';

class TicketRepository {
  Future<List<Ticket>> getListTicketForUser(
      String tripId, String pointUpId, String pointDownId) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.tripId] = tripId;
    body[Constant.pointUpId] = pointUpId;
    body[Constant.pointDownId] = pointDownId;
    final AVResponse response = await callPOST(
      path: URL.getListTicket,
      body: body,
    );
    if (response.isOK) {
      final List<Ticket> ticketList = <Ticket>[];
      response.response[Constant.tickets].forEach((final dynamic itemJson) {
        final Ticket ticket = Ticket.fromJson(itemJson as Map<String, dynamic>);
        ticketList.add(ticket);
      });
      return ticketList;
    } else {
      throw APIException(response);
    }
  }

  Future<List<Ticket>> getListTicketHistory(int page) async {
    final AVResponse response = await callGET(
        '${URL.getListTicketByUser}?page=$page&count=10&option=0');
    if (response.isOK) {
      final List<Ticket> ticketList = <Ticket>[];
      response.response[Constant.listTicket].forEach((final dynamic itemJson) {
        final Ticket ticket = Ticket.fromJson(itemJson as Map<String, dynamic>);
        ticketList.add(ticket);
      });
      return ticketList;
    } else {
      throw APIException(response);
    }
  }

  Future<List<Ticket>> getTicketsByCode(String ticketCode) async {
    final AVResponse response =
        await callGET('${URL.checkTicketByCode}?ticketCode=$ticketCode');
    if (response.isOK) {
      final List<Ticket> ticketList = <Ticket>[];
      response.response[Constant.listTicket].forEach((final dynamic itemJson) {
        final Ticket ticket = Ticket.fromJson(itemJson as Map<String, dynamic>);
        ticketList.add(ticket);
      });
      return ticketList;
    } else {
      throw APIException(response);
    }
  }
}
