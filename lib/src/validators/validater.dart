class Validation{
  static  bool isvaliUser(String user){
    return user!=null && user.length > 6 && user.contains("@");
  }
  static bool isvaliPass(String pass){
    return pass!=null && pass.length>6;
  }
}