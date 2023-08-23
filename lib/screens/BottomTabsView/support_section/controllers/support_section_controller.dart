import 'package:get/get.dart';
import 'package:user_apps/Services/api_manager.dart';

class SupportSectionController extends GetxController {

  RxBool expand = false.obs;
  var isLoading = false.obs;
  var supportList = [].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    supportData();


  }
  supportData() async{


    try{
      isLoading(true);

      var provData =await ApiManger.supportResponse();
      if(provData!=null){
        supportList.value = provData.data;
        update();
        print("testtstss");


        print(provData.data.length);



      }
      else{

      }
    }
    catch(e){print(e.toString());}
    finally{
      isLoading(false);
    }




  }

}