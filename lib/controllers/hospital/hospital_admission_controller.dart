import 'package:get/get.dart';
import 'package:admin_jantasewa/models/hospital/hospital_admission_model.dart';

class HospitalAdmissionController extends GetxController {
  RxList<HospitalAdmissionModel> admissionList = <HospitalAdmissionModel>[].obs;
  RxList<HospitalAdmissionModel> filteredList = <HospitalAdmissionModel>[].obs;

  RxString selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    loadAdmissions();
  }
  void loadAdmissions() {
    List<HospitalAdmissionModel> data = [
      HospitalAdmissionModel(
        requestId: "HAD0001",
        userId: "USR1001",
        patientName: "Ramesh Kumar",
        patientAge: 45,
        patientGender: "Male",
        admissionType: "Emergency",
        diseaseName: "Heart Attack",
        requestDate: "2025-08-18",
        status: "Pending",
        hospitalName: "AIIMS Delhi",
        hospitalAddress: "Ansari Nagar, Delhi",
        hospitalContactPerson: "Dr. Sharma",
        hospitalContactMobile: "9876543210",
        hospitalContactWhatsApp: "9876543210",
        reason: "Needs urgent cardiac surgery",
        uploadedDocument: "medical_report_1.png",
        sourceName: "Rajesh Kumar",
        sourceDesignation: "Local MLA",
        sourceContactNumber: "9998887776",
        relationWithPatient: "Brother",
        attendentName: "Suresh Kumar",
      ),
      HospitalAdmissionModel(
        requestId: "HAD0002",
        userId: "USR1002",
        patientName: "Meena Devi",
        patientAge: 34,
        patientGender: "Female",
        admissionType: "Planned",
        diseaseName: "Kidney Stone",
        requestDate: "2025-08-17",
        status: "Approved",
        hospitalName: "Safdarjung Hospital",
        hospitalAddress: "New Delhi",
        hospitalContactPerson: "Dr. Verma",
        hospitalContactMobile: "9123456780",
        hospitalContactWhatsApp: "9123456780",
        reason: "Planned surgery for stone removal",
        uploadedDocument: "medical_report_2.pdf",
        sourceName: "Anita Sharma",
        sourceDesignation: "NGO Worker",
        sourceContactNumber: "8887776665",
        relationWithPatient: "Husband",
        attendentName: "Ravi Sharma",
      ),
      HospitalAdmissionModel(
        requestId: "HAD0003",
        userId: "USR1003",
        patientName: "Adnan Nayyar",
        patientAge: 29,
        patientGender: "Male",
        admissionType: "Emergency",
        diseaseName: "Accident Trauma",
        requestDate: "2025-08-16",
        status: "Rejected",
        hospitalName: "Fortis Hospital",
        hospitalAddress: "Gurgaon, Haryana",
        hospitalContactPerson: "Dr. Iqbal",
        hospitalContactMobile: "9001122334",
        hospitalContactWhatsApp: "9001122334",
        reason: "Insufficient documents",
        uploadedDocument: "medical_report_3.png",
        sourceName: "Mohd Sameer",
        sourceDesignation: "Police Officer",
        sourceContactNumber: "7776665554",
        relationWithPatient: "Friend",
        attendentName: "Faizan Ali",
      ),
    ];

    admissionList.assignAll(data);
    filteredList.assignAll(data);
  }

  void filterAdmissions(String status) {
    selectedFilter.value = status;
    if (status == "All") {
      filteredList.assignAll(admissionList);
    } else {
      filteredList.assignAll(
        admissionList.where((item) => item.status == status),
      );
    }
  }
}
