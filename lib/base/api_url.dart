class ApiUrl{
  // static String baseUrl = 'http://localhost:3002/';
  static String baseUrl = 'http://192.168.1.42:3002/';

  //Authentication
  static post_login() => 'api/login';

  //User
  static get_profile() => 'api/profile';

  //Proposal
  static get_all_proposal() => 'api/v1/proposal/all';
  static post_filter_proposal() => 'api/v1/proposal/filter';
  static post_create_proposal() => 'api/v1/proposal/create';
  static post_update_proposal() => 'api/v1/proposal/update';
  static post_delete_proposal() => 'api/v1/proposal/delete';

  //Topic
  static get_all_topic() => 'api/v1/topic/all';
  static get_filter_topic() => 'api/v1/topic/filter';
  static post_create_topic() => 'api/v1/topic/create';
  static post_update_topic() => 'api/v1/topic/update';
  static post_delete_topic() => 'api/v1/topic/delete';

  //Employee
  static get_all_employee() => 'api/v1/employee/all';
  static post_create_employee() => 'api/v1/employee/create';
  static post_filter_employee() => 'api/v1/employee/filter';
  static post_update_employee() => 'api/v1/employee/update';
  static post_delete_employee() => 'api/v1/employee/delete';

}