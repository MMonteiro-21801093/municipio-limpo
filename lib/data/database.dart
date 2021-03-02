class DataBase{
  final _dataBase=[];
  static DataBase _instance;
  DataBase._internal();

  static DataBase getInstance(){
    if(_instance==null){
      _instance =  DataBase._internal();
    }
    return _instance;
  }

  void updateDataBase(data)=>_dataBase.add(data);

  List getAll()=>_dataBase;

  void clearAll() {
    _dataBase.clear();
  }

  void insertIncident( data)=>_dataBase.add(data);

  void deleteIncident(incident) {
    _dataBase.remove(incident);
  }


}