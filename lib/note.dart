// B1: Tạo project, nhớ custom package name
// B2: Tạo project trên firebase, điền tên package name vào.
// B3: Tải file cofnfig google service, cho vào thư mục app
// B4: Thêm classpath 'com.google.gms:google-services:4.3.15' vào dependencies GRADLE CỦA  PROJECT
// B5: Thêm apply plugin: 'com.google.gms.google-services' và
//     implementation platform('com.google.firebase:firebase-bom:31.2.3') vào GRADLE CỦA APP
// B6: Check minSDK: trong D:\flutter\packages\flutter_tools\gradle\flutter.gradle
// B7: Thêm   firebase_database firebase_core firebase_core_platform_interface
//     Nhớ update lên version cao nhất
// B8: Nhớ init app:   WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp();
// B9: Nếu chọn server không phải ở mỹ thì phải config: google-services->project_info: "firebase_url": "https://testfirebase-46448-default-rtdb.asia-southeast1.firebasedatabase.app",
// B9: Check trạng thái đọc ghi của firebase là dùng oke.