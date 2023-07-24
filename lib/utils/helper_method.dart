String getShortMessageByStatus(String status) {
  switch (status) {
    case 'PENDING':
      return 'Request in review';
    case 'APPROVED':
      return 'Request is approved';
    case 'DECLINED':
      return 'Request is rejected';
    default:
      return 'Request is ${status.toLowerCase()}';
  }
}

String getDetailedMessageByStatus(String status) {
  switch (status) {
    case 'PENDING':
      return 'Your request is under validation, you will be notified in 24 hours';
    case 'APPROVED':
      return 'Your warranty card is generated. You get download or get it on email or whatsapp.';
    case 'DECLINED':
      return 'Your request is rejected by admin';
    default:
      return 'Request is ${status.toLowerCase()}';
  }
}
