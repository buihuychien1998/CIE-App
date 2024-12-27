import 'package:flutter/material.dart';
import 'package:home/base/base_loading_state.dart';
import 'package:home/search/search_result_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base/api_url.dart';
import '../constants/app_constants.dart';
import '../constants/secure_storage.dart';
import '../constants/size_constants.dart';
import '../extension/string_extension.dart';
import '../home/dashboard_screen.dart';
import '../models/employee_response.dart';
import '../models/proposal_response.dart';
import '../models/topic_response.dart';
import 'filter_screen.dart'; // Thêm import cho trang HomeFilter

class SearchScreen extends StatefulWidget {
  final SearchType type;

  const SearchScreen({super.key, required this.type});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> with BaseLoadingState{
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchHistory = [];
  List<String> _searchResults = [];
  List<Proposal> proposals = [];
  List<Topic> topics = [];
  List<Employee> signers = [];

  // final List<String> _allResults = [
  //   'Tờ trình',
  //   'Đề tài',
  //   'Nhân sự',
  //   'Báo cáo',
  //   // Add more items here if needed
  // ];

  @override
  void initState() {
    super.initState();
    _fetchAllData();
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory = prefs.getStringList(SEARCH_HISTORY) ?? [];
    });
  }

  Future<void> _saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(SEARCH_HISTORY, _searchHistory);
  }

  void _performSearch() {
    setState(() {
      _searchResults.clear();
      final query = _searchController.text.trim().toLowerCase();
      if(!TextUtils.isEmpty(query)){
        _searchHistory.remove(_searchController.text); // Avoid duplicates
        _searchHistory.insert(0, _searchController.text);
        _saveSearchHistory();
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultScreen(
            query: _searchController.text.trim(),
            type: widget.type,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildWithLoading(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Tìm kiếm',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: TextField(
                      controller: _searchController,
                      onSubmitted: (_) => _performSearch(),
                      decoration: InputDecoration(
                        hintText: 'Nhập từ khóa',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFFEBEBEB), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEBEBEB), width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 11.0, horizontal: 10.0),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          _performSearch();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FilterScreen(onApplyFilter: (filters){

                              },
                                type: widget.type,),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            color: Color(0xFFEBEBEB),
                            width: 1.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          minimumSize: const Size(50, 50),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Icon(Icons.tune, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Lịch sử tìm kiếm',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      leading: Icon(
                        Icons.access_time_filled_outlined,
                        color: Colors.grey,
                        size: 24,
                      ),
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _searchHistory[index],
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _searchHistory.removeAt(index);
                            _saveSearchHistory(); // Save updated history
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          _searchController.text = _searchHistory[index];
                        });
                        _performSearch();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getAllProposal() async {
    

    // Lấy dữ liệu từ form
    try {
      final data = await apiService.get(
        ApiUrl.get_all_proposal(),
      );

      ProposalResponse response = ProposalResponse.fromJson(data);
      setState(() {
        proposals = response.proposal ?? [];
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
     
    }
  }

  Future<void> getAllTopic() async {
    

    // Lấy dữ liệu từ form
    try {
      final data = await apiService.get(
        ApiUrl.get_all_topic(),
      );

      TopicResponse response = TopicResponse.fromJson(data);
      setState(() {
        topics = response.topic ?? [];
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
     
    }
  }

  Future<void> getAllEmployee() async {
    

    // Lấy dữ liệu từ form
    try {
      final data = await apiService.get(
        ApiUrl.get_all_employee(),
      );

      EmployeeResponse response = EmployeeResponse.fromJson(data);
      setState(() {
        signers = response.employee ?? [];
      });
    } catch (e, stackTrace) {
      print(stackTrace);
    } finally {
     
    }
  }

  Future<void> _fetchAllData() async {
    showLoading();
    try {
      await Future.wait([
        _loadSearchHistory(),
        getAllProposal(),
        getAllTopic(),
        getAllEmployee(),
      ]);
    } catch (e, stackTrace) {
      print("Error fetching data: $e");
      print(stackTrace);
    } finally {
      hideLoading();
    }
  }

}
