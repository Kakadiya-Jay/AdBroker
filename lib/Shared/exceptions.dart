class APIException implements Exception {
  String printErrorMessage() {
    return "There was an error in calling this APIS or Sending the Data";
  }
}
