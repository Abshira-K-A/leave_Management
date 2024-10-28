// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'login.dart';

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final _formKey = GlobalKey<FormState>();
//   final _auth = FirebaseAuth.instance;

//   bool _showProgress = false;
//   bool _isPasswordObscure = true;
//   bool _isConfirmPasswordObscure = true;

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();

//   List<String> roles = ['Employee', 'HR', 'Manager'];
//   String selectedRole = 'Employee';
//   String selectedGender = 'Male';

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     nameController.dispose();
//     lastNameController.dispose();
//     usernameController.dispose();
//     ageController.dispose();
//     phoneController.dispose(); 
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 164, 229, 239),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 color: const Color.fromARGB(255, 164, 223, 226),
//                 width: MediaQuery.of(context).size.width,
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const SizedBox(height: 80),
//                         const Text(
//                           "Register Now",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: 40,
//                           ),
//                         ),
//                         const SizedBox(height: 50),
//                         _buildTextField(
//                           controller: nameController,
//                           hintText: 'First Name',
//                           validator: _validateName,
//                         ),
//                         const SizedBox(height: 20),
//                         _buildTextField(
//                           controller: lastNameController,
//                           hintText: 'Last Name',
//                           validator: _validateLastName,
//                         ),
//                         const SizedBox(height: 20),
//                         _buildTextField(
//                           controller: usernameController,
//                           hintText: 'Username',
//                           validator: _validateUsername,
//                         ),
//                         const SizedBox(height: 20),
//                         _buildTextField(
//                           controller: emailController,
//                           hintText: 'Email',
//                           keyboardType: TextInputType.emailAddress,
//                           validator: _validateEmail,
//                         ),
//                         const SizedBox(height: 20),
//                         _buildTextField(
//                           controller: passwordController,
//                           hintText: 'Password',
//                           obscureText: _isPasswordObscure,
//                           suffixIcon: _togglePasswordVisibility(isConfirmPassword: false),
//                           validator: _validatePassword,
//                         ),
//                         const SizedBox(height: 20),
//                         _buildTextField(
//                           controller: confirmPasswordController,
//                           hintText: 'Confirm Password',
//                           obscureText: _isConfirmPasswordObscure,
//                           suffixIcon: _togglePasswordVisibility(isConfirmPassword: true),
//                           validator: _validateConfirmPassword,
//                         ),
//                         const SizedBox(height: 20),
//                         _buildTextField(
//                           controller: phoneController,
//                           hintText: 'Phone',
//                           validator: _validatePhoneNumber,
//                         ),
//                         const SizedBox(height: 20),
//                         _buildTextField(
//                           controller: ageController,
//                           hintText: 'Age',
//                           keyboardType: TextInputType.number,
//                           validator: _validateAge,
//                         ),
//                         const SizedBox(height: 20),
//                         _buildRoleDropdown(),
//                         const SizedBox(height: 20),
//                         _buildGenderDropdown(),
//                         const SizedBox(height: 20),
//                         _buildActionButtons(),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     TextInputType keyboardType = TextInputType.text,
//     bool obscureText = false,
//     Widget? suffixIcon,
//     required String? Function(String?) validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white,
//         hintText: hintText,
//         suffixIcon: suffixIcon,
//         contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 14),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.white),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         enabledBorder: UnderlineInputBorder(
//           borderSide: const BorderSide(color: Colors.white),
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//       validator: validator,
//     );
//   }

//   Widget _togglePasswordVisibility({required bool isConfirmPassword}) {
//     return IconButton(
//       icon: Icon(isConfirmPassword
//           ? _isConfirmPasswordObscure
//               ? Icons.visibility_off
//               : Icons.visibility
//           : _isPasswordObscure
//               ? Icons.visibility_off
//               : Icons.visibility),
//       onPressed: () {
//         setState(() {
//           if (isConfirmPassword) {
//             _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
//           } else {
//             _isPasswordObscure = !_isPasswordObscure;
//           }
//         });
//       },
//     );
//   }

//   Widget _buildRoleDropdown() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           "Role: ",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         DropdownButton<String>(
//           dropdownColor: Colors.blue[900],
//           value: selectedRole,
//           items: roles.map((String role) {
//             return DropdownMenuItem(
//               value: role,
//               child: Text(
//                 role,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//             );
//           }).toList(),
//           onChanged: (newValue) {
//             setState(() {
//               selectedRole = newValue!;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildGenderDropdown() {
//     List<String> genders = ['Male', 'Female', 'Other'];
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           "Gender: ",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         DropdownButton<String>(
//           dropdownColor: Colors.blue[900],
//           value: selectedGender,
//           items: genders.map((String gender) {
//             return DropdownMenuItem(
//               value: gender,
//               child: Text(
//                 gender,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//             );
//           }).toList(),
//           onChanged: (newValue) {
//             setState(() {
//               selectedGender = newValue!;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const LoginPage()),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//           child: const Text("Login", style: TextStyle(fontSize: 20)),
//         ),
//         ElevatedButton(
//           onPressed: _register,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//           child: const Text("Register", style: TextStyle(fontSize: 20)),
//         ),
//       ],
//     );
//   }

//   String? _validateName(String? value) {
//     if (value!.isEmpty) {
//       return "First Name cannot be empty";
//     }
//     return null;
//   }

//   String? _validateLastName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your last name';
//     }
//     if (value.length < 2) {
//       return 'Last name must be at least 2 characters long';
//     }
//     return null;
//   }

//   String? _validateUsername(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a username';
//     }
//     return null;
//   }

//   String? _validateEmail(String? value) {
//     if (value!.isEmpty || !RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
//       return "Please enter a valid email";
//     }
//     return null;
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }

//   String? _validateConfirmPassword(String? value) {
//     if (value != passwordController.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   String? _validatePhoneNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your phone number';
//     }
//     return null;
//   }

//   String? _validateAge(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your age';
//     }
//     int? age = int.tryParse(value);
//     if (age == null || age < 18) {
//       return 'Age must be 18 or older';
//     }
//     return null;
//   }

//   Future<void> _register() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _showProgress = true;
//       });
//       try {
//         UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//           email: emailController.text,
//           password: passwordController.text,
//         );
        
//         int employeeId = await _getNextEmployeeId();
//         await _postDetailsToFirestore(userCredential.user!.uid, employeeId);

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginPage()),
//         );
//       } catch (e) {
//         print(e);
//       } finally {
//         setState(() {
//           _showProgress = false;
//         });
//       }
//     }
//   }

//   Future<int> _getNextEmployeeId() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     DocumentReference counterDoc = firebaseFirestore.collection('employee_id').doc('counter');
 
//     try {
//       DocumentSnapshot snapshot = await counterDoc.get();
//       int currentCounter = snapshot.exists && snapshot['counter'] != null ? snapshot['counter'] : 0;
//       int newCounter = currentCounter + 1;

//       await counterDoc.set({'counter': newCounter});

//       return newCounter;
//     } catch (e) {
//       print("Error in fetching and updating employee ID counter: $e");
//       return -1;
//     }
//   }

//   Future<void> _postDetailsToFirestore(String uid, int employeeId) async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     CollectionReference users = firebaseFirestore.collection('users');

//     await users.doc(uid).set({
//       'name': nameController.text,
//       'lastName': lastNameController.text,
//       'username': usernameController.text,
//       'email': emailController.text,
//       'role': selectedRole,
//       'gender': selectedGender,
//       'phno': phoneController.text,
//       'age': int.parse(ageController.text),
//       'employeeId': employeeId,
//     });
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  bool _showProgress = false;
  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  List<String> roles = ['Employee', 'HR', 'Manager'];
  String selectedRole = 'Employee';
  String selectedGender = 'Male';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    ageController.dispose();
    phoneController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[700],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.blueAccent[700],
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 80),
                        const Text(
                          "Register Now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(height: 50),
                        _buildTextField(
                          controller: nameController,
                          hintText: 'First Name',
                          validator: _validateName,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: lastNameController,
                          hintText: 'Last Name (optional)',
                          validator: _validateLastName,  // Updated validator
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: usernameController,
                          hintText: 'Username',
                          validator: _validateUsername,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: emailController,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: _isPasswordObscure,
                          suffixIcon: _togglePasswordVisibility(isConfirmPassword: false),
                          validator: _validatePassword,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: _isConfirmPasswordObscure,
                          suffixIcon: _togglePasswordVisibility(isConfirmPassword: true),
                          validator: _validateConfirmPassword,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: phoneController,
                          hintText: 'Phone',
                          validator: _validatePhoneNumber,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: ageController,
                          hintText: 'Age',
                          keyboardType: TextInputType.number,
                          validator: _validateAge,
                        ),
                        const SizedBox(height: 20),
                        _buildRoleDropdown(),
                        const SizedBox(height: 20),
                        _buildGenderDropdown(),
                        const SizedBox(height: 20),
                        _buildActionButtons(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 14),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: validator,
    );
  }

  Widget _togglePasswordVisibility({required bool isConfirmPassword}) {
    return IconButton(
      icon: Icon(isConfirmPassword
          ? _isConfirmPasswordObscure
              ? Icons.visibility_off
              : Icons.visibility
          : _isPasswordObscure
              ? Icons.visibility_off
              : Icons.visibility),
      onPressed: () {
        setState(() {
          if (isConfirmPassword) {
            _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
          } else {
            _isPasswordObscure = !_isPasswordObscure;
          }
        });
      },
    );
  }

  Widget _buildRoleDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Role: ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        DropdownButton<String>(
          dropdownColor: Colors.blue[900],
          value: selectedRole,
          items: roles.map((String role) {
            return DropdownMenuItem(
              value: role,
              child: Text(
                role,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedRole = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    List<String> genders = ['Male', 'Female', 'Other'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Gender: ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        DropdownButton<String>(
          dropdownColor: Colors.blue[900],
          value: selectedGender,
          items: genders.map((String gender) {
            return DropdownMenuItem(
              value: gender,
              child: Text(
                gender,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedGender = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text("Login", style: TextStyle(fontSize: 20)),
        ),
        ElevatedButton(
          onPressed: _register,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text("Register", style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }

  String? _validateName(String? value) {
    if (value!.isEmpty) {
      return "First Name cannot be empty";
    }
    return null;
  }

  String? _validateLastName(String? value) {
    return null; // Last Name is optional
  }

  String? _validateUsername(String? value) {
    if (value!.isEmpty) {
      return "Username cannot be empty";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Email cannot be empty";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Password cannot be empty";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return "Phone cannot be empty";
    }
    return null;
  }

  String? _validateAge(String? value) {
    if (value!.isEmpty) {
      return "Age cannot be empty";
    }
    return null;
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _showProgress = true);
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'firstName': nameController.text.trim(),
          'lastName': lastNameController.text.trim(),
          'username': usernameController.text.trim(),
          'email': emailController.text.trim(),
          'role': selectedRole,
          'age': ageController.text.trim(),
          'phone': phoneController.text.trim(),
          'gender': selectedGender,
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } catch (error) {
        print("Registration error: $error");
      } finally {
        setState(() => _showProgress = false);
      }
    }
  }
}
