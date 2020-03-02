import 'package:extra/api/api_response.dart';
import 'package:extra/entity/profile.dart';
import 'package:extra/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Profile p;

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
      AuthResult result = await _auth.signInWithCredential(credential);
      //final FirebaseUser fuser = result.user;
      saveInPrefs(result.user);
      // Login no Firebase
      /*
      AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser fuser = result.user;
      print("Firebase Nome: " + fuser.displayName);
      print("Firebase Email: " + fuser.email);
      print("Firebase Foto: " + fuser.photoUrl);

       */

      // Resposta genérica

      return ApiResponse.ok(result: result.user.displayName);
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
        return ApiResponse.error(msg: Strings.ERROR_ACTION);
      }
    } catch (e) {
      print(e);
      return ApiResponse.error(msg: " ${Strings.OPS}: $e");
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  Future<ApiResponse> doResetLogin(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return ApiResponse.ok(msg: Strings.FORGET_TEXT);
    } catch (e) {
      return ApiResponse.error(msg: " ${Strings.OPS}: $e");
    }
  }

  Future<ApiResponse> doCreateUser(String email, String pass) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (result.user != null) {
        saveInPrefs(result.user);
        return ApiResponse.ok();
      } else {
        return ApiResponse.error(msg: Strings.CREATE_SUCCESS_USER);
      }
    } catch (e) {
      return ApiResponse.error(msg: " ${Strings.OPS}: $e");
    }
  }
//save login with google or create account
  void saveInPrefs(FirebaseUser user) async {
     this.p = await Profile.get();
    bool flag = false;
    if (p == null) {
      p = Profile(
          id: user.uid,
          name: user.displayName,
          email: user.email,
          urlPhoto: user.photoUrl,
          phone: user.phoneNumber);
      flag = true;
    } else {
      if (p.id == null) {
        this.p.id = user.uid;
        flag = true;
      }
      if (p.name == null) {
        p.name = user.displayName;
        flag = true;
      }
      if (p.email == null) {
        p.email = user.email;
        flag = true;
      }
      if (p.urlPhoto == null) {
        p.urlPhoto = user.photoUrl;
        flag = true;
      }
      if (p.phone == null) {
        p.phone = user.phoneNumber;
        flag = true;
      }
    }
    if (flag){
      p.isDataOk = false;
      p.save();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
