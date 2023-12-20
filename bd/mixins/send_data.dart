abstract class SendData{
  Future<Map<String,dynamic>> displayData();
  Future<void> deleteMessage(int message);

  Future<Map<String,dynamic>> displayGroundData();

  Future<Map<String,dynamic>> displayPlantsData();

  Future<Map<String,dynamic>> displayGroundMessages();

  Future<Map<String,dynamic>> displayPlantMessages();

  Future<void> deleteAllData(List<int> messages);
}