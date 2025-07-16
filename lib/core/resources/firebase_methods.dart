import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_room_model.dart';

class FirebaseHelper {
  // Firestore instance
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // FirebaseAuth instance
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// 🔐 Register with email and password
  static Future<UserCredential?> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Register Error: $e");
      return null;
    }
  }

  /// 🔐 Sign in with email and password
  static Future<UserCredential?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Sign In Error: $e");
      return null;
    }
  }

  /// 🔐 Sign in with Google

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) return null; // User canceled the sign-in

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("Google Sign In Error: $e");
      return null;
    }
  }

  /// 🔓 Logout
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('Signed out from Firebase Auth');
    } catch (e) {
      print('Sign Out Error: $e');
    }
  }

  /// Sign out from Firebase and disconnect GoogleSignIn fully (revokes permissions)
  static Future<void> signOutGoogle() async {
    try {
      await _auth.signOut();
      await _googleSignIn
          .disconnect(); // revoke permissions & sign out Google account
      await _googleSignIn
          .signOut(); // sign out Google (optional after disconnect)
      print('Signed out from Firebase and Google (disconnected)');
    } catch (e) {
      print('Google Sign Out Error: $e');
    }
  }

  /// 📁 Create or update document in a collection
  static Future<void> setDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
    bool merge = true,
  }) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(docId)
          .set(data, SetOptions(merge: merge));
    } catch (e) {
      print("Set Document Error: $e");
    }
  }

  /// 📥 Add document to collection (auto ID)
 static Future<void> addDocument({
  required String collectionPath,
  String? docId,
  required Map<String, dynamic> data,
}) async {
  final collection = FirebaseFirestore.instance.collection(collectionPath);

  if (docId != null) {
    await collection.doc(docId).set(data);
  } else {
    await collection.add(data);
  }
}


  /// 📤 Get all documents from a collection
  static Future<List<Map<String, dynamic>>> getCollectionData({
    required String collectionPath,
  }) async {
    try {
      final snapshot = await _firestore.collection(collectionPath).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Get Collection Data Error: $e");
      return [];
    }
  }

  /// 📤 Get document by ID
  static Future<Map<String, dynamic>?> getDocumentById({
    required String collectionPath,
    required String docId,
  }) async {
    try {
      final doc = await _firestore.collection(collectionPath).doc(docId).get();
      return doc.data();
    } catch (e) {
      print("Get Document By ID Error: $e");
      return null;
    }
  }

  /// 🔍 Query documents with a condition
  static Future<List<Map<String, dynamic>>> queryCollection({
    required String collectionPath,
    required String field,
    required dynamic isEqualTo,
  }) async {
    try {
      final snapshot = await _firestore
          .collection(collectionPath)
          .where(field, isEqualTo: isEqualTo)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Query Error: $e");
      return [];
    }
  }

  /// ❌ Delete document
  static Future<void> deleteDocument({
    required String collectionPath,
    required String docId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).delete();
    } catch (e) {
      print("Delete Document Error: $e");
    }
  }

  /// 👤 Get current user
  static User? get currentUser => _auth.currentUser;

  /// 📧 Send email verification
  static Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      print("Send Email Verification Error: $e");
    }
  }

  /// 🔄 Reload user to refresh emailVerified status
  static Future<void> reloadUser() async {
    try {
      await _auth.currentUser?.reload();
    } catch (e) {
      print("Reload User Error: $e");
    }
  }

  /// 📤 Fetch all documents from a collection except for a specific UID field
  static Future<List<Map<String, dynamic>>> fetchAllExceptUid({
    required String collectionPath,
    required String uidField,
    required String excludedUid,
  }) async {
    try {
      final snapshot = await _firestore
          .collection(collectionPath)
          .where(uidField, isNotEqualTo: excludedUid)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Fetch Except UID Error: $e");
      return [];
    }
  }

 static  Stream<List<ChatRoom>> getChatRoomsStream(String myUid) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(myUid)
        .collection('chatrooms')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatRoom.fromMap(doc.data());
      }).toList();
    });
  }

   static Stream<List<ChatMessage>> getMessagesStream(String myUid, String otherUid) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(myUid)
        .collection('chatrooms')
        .doc(otherUid)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      if (data == null || data['messages'] == null) return [];

      final List messagesData = data['messages'];
      return messagesData
          .map((msg) => ChatMessage.fromMap(Map<String, dynamic>.from(msg)))
          .toList();
    });
  }
}
