import 'package:admin_jantasewa/models/construction_model/workdemand_model.dart';
import 'package:get/get.dart';

class WorkDemandController extends GetxController {
  var demands = <WorkDemandModel>[].obs;
  var isLoading = false.obs;

  // NEW: filter state (like Hospital controller)
  var selectedFilter = 'All'.obs;
  var filteredList = <WorkDemandModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDemands().then((_) => filterDemands('All'));
  }

  Future<void> fetchDemands() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));

      demands.assignAll([
        WorkDemandModel(
          workId: "WD001",
          workName: "Community Hall",
          workDetail: "Construction of multipurpose community hall in Ward 5",
          tentativeAmount: "250000",
          remark: "Essential for social and cultural gatherings",
          demandedPerson: "Suresh Sharma",
          demandedPersonMobile: "9876543210",
          district: "Raipur",
          block: "Abhanpur",
          villageWard: "Ward 5",
          constituency: "Raipur Gramin",
          uploadedFiles: ["community_hall.pdf"],
          status: "Pending",
          requestedDate: "15/06/2025",
        ),
        WorkDemandModel(
          workId: "WD002",
          workName: "Village Road",
          workDetail: "Repair and construction of 2 km CC road in village",
          tentativeAmount: "450000",
          remark: "Current road is damaged, villagers facing issues",
          demandedPerson: "Ramesh Verma",
          demandedPersonMobile: "9988776655",
          district: "Durg",
          block: "Patan",
          villageWard: "Ward 3",
          constituency: "Durg Rural",
          uploadedFiles: ["road_repair.png"],
          status: "Approved",
          requestedDate: "10/06/2025",
        ),
        WorkDemandModel(
          workId: "WD003",
          workName: "Primary School Renovation",
          workDetail: "Renovation and new furniture for Govt Primary School",
          tentativeAmount: "180000",
          remark: "For better education environment",
          demandedPerson: "Geeta Patel",
          demandedPersonMobile: "9123456789",
          district: "Bilaspur",
          block: "Takhatpur",
          villageWard: "Ward 7",
          constituency: "Bilaspur Rural",
          uploadedFiles: ["school_project.pdf"],
          status: "Rejected",
          requestedDate: "12/06/2025",
        ),
        WorkDemandModel(
          workId: "WD004",
          workName: "Community Park Development",
          workDetail: "Development of a new community park in the city center",
          tentativeAmount: "500000",
          remark: "To enhance green space and community well-being",
          demandedPerson: "Amit Singh",
          demandedPersonMobile: "9876543210",
          district: "Raipur",
          block: "Raipur",
          villageWard: "Ward 1",
          constituency: "Raipur Urban",
          uploadedFiles: ["community_park.pdf"],
          status: "Pending",
          requestedDate: "15/06/2025",
        ),
        WorkDemandModel(
          workId: "WD005",
          workName: "Drainage System Improvement",
          workDetail: "Upgrading the drainage system in the old city area",
          tentativeAmount: "300000",
          remark: "To prevent waterlogging during monsoons",
          demandedPerson: "Rajesh Kumar",
          demandedPersonMobile: "9876543210",
          district: "Raipur",
          block: "Raipur",
          villageWard: "Ward 2",
          constituency: "Raipur Urban",
          uploadedFiles: ["drainage_improvement.pdf"],
          status: "Pending",
          requestedDate: "15/06/2025",
        ),
        WorkDemandModel(
          workId: "WD006",
          workName: "Community Center Construction",
          workDetail: "Building a new community center in the village",
          tentativeAmount: "600000",
          remark: "To provide a space for community activities",
          demandedPerson: "Sita Devi",
          demandedPersonMobile: "9876543210",
          district: "Raipur",
          block: "Raipur",
          villageWard: "Ward 1",
          constituency: "Raipur Urban",
          uploadedFiles: ["community_center.pdf"],
          status: "Pending",
          requestedDate: "15/06/2025",
        ),
        WorkDemandModel(
          workId: "WD007",
          workName: "Road Repair",
          workDetail: "Repairing potholes and resurfacing roads",
          tentativeAmount: "250000",
          remark: "To improve road safety",
          demandedPerson: "Ravi Shukla",
          demandedPersonMobile: "9876543210",
          district: "Raipur",
          block: "Raipur",
          villageWard: "Ward 3",
          constituency: "Raipur Urban",
          uploadedFiles: ["road_repair.pdf"],
          status: "Pending",
          requestedDate: "15/06/2025",
        ),
        WorkDemandModel(
          workId: "WD008",
          workName: "Street Lighting",
          workDetail: "Installation of street lights in the community",
          tentativeAmount: "150000",
          remark: "To enhance night-time visibility",
          demandedPerson: "Anjali Verma",
          demandedPersonMobile: "9876543210",
          district: "Raipur",
          block: "Raipur",
          villageWard: "Ward 4",
          constituency: "Raipur Urban",
          uploadedFiles: ["street_lighting.pdf"],
          status: "Pending",
          requestedDate: "15/06/2025",
        ),
      ]);
    } finally {
      isLoading.value = false;
    }
  }

  // NEW: filter logic
  void filterDemands(String status) {
    selectedFilter.value = status;
    if (status == 'All') {
      filteredList.assignAll(demands);
    } else {
      filteredList.assignAll(demands.where((d) => d.status == status));
    }
  }
}
