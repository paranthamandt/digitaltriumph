class Signupmodel {
final String name;
final String email;
final String Mobilenumber;
final String password;

Signupmodel({
  required this.name,
  required this.email,
  required this.Mobilenumber,
  required this.password
});

Map<String,dynamic> toJson()=>{
  "name":name,
  "email":email,
  "mobile number":Mobilenumber,
  "password":password
};
}