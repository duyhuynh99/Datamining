#### Bài tập lớn môn Khai phá dữ liệu
##### Hiện thực giải thuật DBSCAN và KD Tree
***
1. Yêu cầu 
	* Cài đặt Free Pascal Compiler
	* Cài đặt Python 3 với các thư viện numpy, sklearn, matplotlib

2. Sử dụng
	* Thay đổi tham số đầu vào epsilon (mặc định là 1.5), minPts (mặc định là 2) ở file config.txt
	* Thay đổi số lượng điểm dữ liệu tạo ra trong file **generate_dataset.py**, mặc định là 30000.
	* Chạy file bash run.sh để tiến hành phân cụm dữ liệu lần lượt với từng giải thuật và tạo các hình minh họa kết quả phân cụm:
	./run.sh hoặc sh run.sh trên Linux Bash Shell
 	* Cụ thể:
		* Chạy file dbscan.pas để ghi kết quả phân cụm sử dụng kd-tree vào file dạng preds.txt và thời gian thực thi vào file improved_runtime_points.txt
			* fpc dbscan
			* ./dbscan.exe
		* Chạy file original_dbscan.pas để ghi thời gian thực thi vào file origin_runtime_points.txt
			* fpc original_dbscan
			* ./original_dbscan.exe
		* Chạy file truth_dbscan.py để ghi kết quả phân cụm sử dụng thư viện của Python vào file truth.txt, thời gian thực thi vào file py_runtime_points.txt
			* python truth_dbscan.py
		* Chạy file plot.py để minh họa kết quả phân cụm cho các kết quả đã được xuất ra trong file preds.txt và truth.txt nêu trên
    		* python plot.py
3. Mã nguồn
	* kdtree.pas: hiện thực KD Tree, tạo KD Tree và radius neighbor search
	* original_dbscan.pas: hiện thực DBSCAN với giải thuật tìm kiếm tuần tự
	* dbscan.pas: hiện thực DBSCAN với tìm kiếm sử dụng KD Tree
	* các file Python khác: tạo dữ liệu, vẽ đồ thị, so sánh kết quả,...
4. Kết quả
	* Màn hình terminal sẽ hiện ra thời gian thực thi của 2 phiên bản DBSCAN và DBSCAN của sklearn. Có thể tìm thấy trong thư mục *runtime*.
	* Màn hình hiện PASS nếu 2 kết quả từ DBSCAN cải tiến và từ sklearn giống nhau. Tuy nhiên, nếu số lượng điểm lớn hơn 60K điểm thì DBSCAN với tìm kiếm tuần tự bị lỗi, nên ***khuyến nghị*** chạy tới số điểm khoảng 50K.
	* Hình vẽ minh họa trong thư mục ***images***, chỉ hỗ trợ vẽ tối đa 12 cụm
