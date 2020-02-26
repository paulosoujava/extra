import 'package:extra/api/api_response.dart';
import 'package:extra/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse> loginGoogle() async {
    try {
      // Login com o Google
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;


      // Credenciais para o Firebase
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login no Firebase
      AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser fuser = result.user;
      print("Firebase Nome: " + fuser.displayName);
      print("Firebase Email: " + fuser.email);
      print("Firebase Foto: " + fuser.photoUrl);


      // Resposta genérica
      return ApiResponse.ok();
    } catch (error) {
      return ApiResponse.error(msg: Strings.ERROR_LOGIN);
    }
  }

  Future<ApiResponse> doLogin(String email, String pass) async {
    try {
      AuthResult result =
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
      if (result.user != null) {
        return ApiResponse.ok();
      } else {
        return ApiResponse.error(
            msg: Strings.ERROR_ACTION);
      }
    } catch (e) {
      return ApiResponse.error(msg: " ${Strings.OPS}: $e");
    }
  }


  Future<ApiResponse> doResetLogin(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return ApiResponse.error(
          msg: Strings.RESET_EMAIL);
    } catch (e) {
      return ApiResponse.error(msg: " ${Strings.OPS}: $e");
    }
  }

  Future<ApiResponse> doCreateUser(String email, String pass) async {
    try {
      AuthResult result =
      await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      if (result.user != null) {
        return ApiResponse.ok();
      } else {
        return ApiResponse.error(
            msg: Strings.CREATE_SUCCESS_USER);
      }
    } catch (e) {
      print(" ${Strings.OPS}: $e");
      return ApiResponse.error(msg: " ${Strings.OPS}: $e");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}