import 'package:get/get.dart';
import 'package:admin_jantasewa/models/parliament_visit/parliament_visit_model.dart';

class ParliamentVisitController extends GetxController {
  // Full list of visits
  RxList<ParliamentVisitModel> visitList = <ParliamentVisitModel>[].obs;

  // Selected filter status
  RxString selectedFilter = 'All'.obs;

  // Filtered visits based on status
  RxList<ParliamentVisitModel> filteredList = <ParliamentVisitModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadVisits();
  }

  // Load initial data
  void loadVisits() {
    List<ParliamentVisitModel> data = [
      ParliamentVisitModel(
        visitId: 'PV001',
        visitorName: 'Ravi Kumar',
        constituency: 'Delhi South',
        mpName: 'Meenakshi Lekhi',
        visitDate: '2025-09-10',
        requestDate: '2025-08-01',
        status: 'Approved',
      ),
      ParliamentVisitModel(
        visitId: 'PV002',
        visitorName: 'Meena Sharma',
        constituency: 'Mumbai North',
        mpName: 'Gopal Shetty',
        visitDate: '2025-09-12',
        requestDate: '2025-08-02',
        status: 'Pending',
      ),
      ParliamentVisitModel(
        visitId: 'PV003',
        visitorName: 'Ankit Verma',
        constituency: 'Lucknow',
        mpName: 'Rajnath Singh',
        visitDate: '2025-09-14',
        requestDate: '2025-08-03',
        status: 'Rejected',
      ),
      ParliamentVisitModel(
        visitId: 'PV004',
        visitorName: 'Pooja Yadav',
        constituency: 'Jaipur Rural',
        mpName: 'Col. Rajyavardhan Rathore',
        visitDate: '2025-09-15',
        requestDate: '2025-08-04',
        status: 'Approved',
      ),
      ParliamentVisitModel(
        visitId: 'PV005',
        visitorName: 'Amit Sharma',
        constituency: 'Varanasi',
        mpName: 'Narendra Modi',
        visitDate: '2025-09-18',
        requestDate: '2025-08-05',
        status: 'Pending',
      ),
      ParliamentVisitModel(
        visitId: 'PV006',
        visitorName: 'Sunita Joshi',
        constituency: 'Bhopal',
        mpName: 'Pragya Singh Thakur',
        visitDate: '2025-09-20',
        requestDate: '2025-08-06',
        status: 'Approved',
      ),
      ParliamentVisitModel(
        visitId: 'PV007',
        visitorName: 'Rahul Meena',
        constituency: 'Kolkata Uttar',
        mpName: 'Sudip Bandyopadhyay',
        visitDate: '2025-09-21',
        requestDate: '2025-08-07',
        status: 'Rejected',
      ),
      ParliamentVisitModel(
        visitId: 'PV008',
        visitorName: 'Kavita Joshi',
        constituency: 'Chandigarh',
        mpName: 'Kirron Kher',
        visitDate: '2025-09-22',
        requestDate: '2025-08-08',
        status: 'Approved',
      ),
      ParliamentVisitModel(
        visitId: 'PV009',
        visitorName: 'Deepak Kumar',
        constituency: 'Amritsar',
        mpName: 'Gurjit Singh Aujla',
        visitDate: '2025-09-23',
        requestDate: '2025-08-09',
        status: 'Pending',
      ),
      ParliamentVisitModel(
        visitId: 'PV010',
        visitorName: 'Priya Singh',
        constituency: 'Pune',
        mpName: 'Girish Bapat',
        visitDate: '2025-09-25',
        requestDate: '2025-08-10',
        status: 'Approved',
      ),
    ];

    visitList.assignAll(data);
    filteredList.assignAll(data);
  }

  // Set filter and update UI
  void filterVisits(String status) {
    selectedFilter.value = status;
    if (status == 'All') {
      filteredList.assignAll(visitList);
    } else {
      filteredList.assignAll(
        visitList.where((v) => v.status == status),
      );
    }
  }
}

