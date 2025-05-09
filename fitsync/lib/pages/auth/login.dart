import 'package:fitsync/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              Text("SIGN IN", style: TextStyle(fontSize: 60)),
              const SizedBox(height: 60),
              TextFormField(
                controller: _controllerEmail,
                focusNode: _focusNodeEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email.";
                  } else if (!(value.contains('@') && value.contains('.'))) {
                    return "Invalid email";
                  }
                  return null;
                },
                onEditingComplete: () => _focusNodePassword.requestFocus(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerPassword,
                focusNode: _focusNodePassword,
                obscureText: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon:
                        _obscurePassword
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ), // Border putih
                  ),
                  backgroundColor: Colors.white, // Tombol dengan warna putih
                  foregroundColor: Colors.black, // Teks berwarna hitam
                  elevation: 0, // Menghilangkan bayangan
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }
                },
                child: const Text("Login"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      _formKey.currentState?.reset();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const Signup();
                          },
                        ),
                      );
                    },
                    child: const Text("Signup"),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  // Garis dengan tulisan "Sign in with"
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey, thickness: 1),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Sign in with"),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey, thickness: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20), // Jarak ke ikon
                  // Baris ikon sosial media
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Facebook Icon
                      IconButton(
                        icon: Image.asset(
                          "facebook.png",
                          height: 30, // Ukuran gambar diubah jadi 30
                          width: 30, // Ukuran gambar diubah jadi 30
                        ),
                        onPressed: () {
                          // Aksi login dengan Facebook
                        },
                      ),

                      const SizedBox(width: 20), // Jarak antar ikon
                      // Apple Icon
                      IconButton(
                        icon: Image.asset(
                          "iphone.png",
                          height: 30, // Ukuran gambar diubah jadi 30
                          width: 30, // Ukuran gambar diubah jadi 30
                        ),
                        onPressed: () {
                          // Aksi login dengan Apple
                        },
                      ),

                      const SizedBox(width: 20),

                      // Google Icon
                      IconButton(
                        icon: Image.asset(
                          "google.png",
                          height: 30, // Ukuran gambar diubah jadi 30
                          width: 30, // Ukuran gambar diubah jadi 30
                        ),
                        onPressed: () {
                          // Aksi login dengan Google
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _focusNodeEmail.dispose();
    _controllerPassword.dispose();
    _controllerEmail.dispose();

    super.dispose();
  }
}
