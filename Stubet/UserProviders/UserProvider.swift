import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine

class UserProvider: ObservableObject {
    static let shared = UserProvider()
    
    // ローカルの現在のユーザーを保持するためのPublishedプロパティ
    @Published var currentUser: User?

    // クラスの初期化時に実行される
    private init() {
        // 現在のユーザー情報を取得する
        refreshCurrentUser()
    }

    // 外部からアクセス可能: 現在のユーザー情報を更新する
    public func refreshCurrentUser() {
        // Authから現在のユーザーを取得
        if let firebaseUser = Auth.auth().currentUser {
            // Firestoreからユーザー情報を取得
            fetchUserFromCloud(userID: firebaseUser.uid) { [weak self] user in
                if let user = user {
                    self?.setUserLocally(user)
                    print("Firestoreからのユーザー情報の取得成功: \(user)")
                } else {
                    print("Firestoreからのユーザー情報取得に失敗しました。")
                    // Firestoreから取得できなかった場合、ローカルのFirebaseキーを削除
                    self?.deleteLocalFirebaseKeys()
                    // ユーザーをサインアウト
                    self?.signOutFirebaseUser()                }
            }
        } else {
            print("現在のユーザーが認証されていません。")
        }
    }
    
    // userIDの取得
    public func getCurrentUserId() -> String? {
        return currentUser?.id
    }

    public func getUser() -> User? {
        return currentUser
    }

    // 外部からアクセス可能: ユーザー名を更新する
    public func updateUserName(_ newName: String) {
        guard let user = currentUser else { return }
        let updatedUser = User(
            id: user.id,
            data: [
                "userName": newName,
                "icon_url": user.iconUrl,
                "email": user.email,
                "createdAt": user.createdAt,
                "updatedAt": Timestamp(date: Date())
            ]
        )
        setUserLocally(updatedUser)
    }

    // 外部からアクセス可能: メールアドレスを更新する
    public func updateUserEmail(_ newEmail: String) {
        guard let user = currentUser else { return }
        let updatedUser = User(
            id: user.id,
            data: [
                "userName": user.userName,
                "icon_url": user.iconUrl,
                "email": newEmail,
                "createdAt": user.createdAt,
                "updatedAt": Timestamp(date: Date())
            ]
        )
        setUserLocally(updatedUser)
    }
    
    // クラウドからユーザー情報を取得し、ローカルにもセット (内部処理)
    private func fetchUserFromCloud(userID: String, completion: @escaping (User?) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists, let data = document.data() {
                // Userモデルの初期化
                let user = User(id: userID, data: data)
                self.setUserLocally(user)
                completion(user)
            } else {
                print("Firestoreからの取得エラー: \(error?.localizedDescription ?? "不明なエラー")")
                // Firestoreから取得できなかった場合、ローカルのFirebaseキーを削除
                self.deleteLocalFirebaseKeys()
                // ユーザーをサインアウト
                self.signOutFirebaseUser()
                completion(nil)
            }
        }
    }

    // ローカルにユーザー情報をセットし、クラウドにも更新 (内部処理)
    private func setUserLocally(_ user: User) {
        self.currentUser = user
        updateCloudUser(user)
    }

    // Firestoreにユーザー情報を更新 (内部処理)
    private func updateCloudUser(_ user: User) {
        let db = Firestore.firestore()
        db.collection("users").document(user.id).setData([
            "userName": user.userName,
            "icon_url": user.iconUrl,
            "email": user.email,
            "createdAt": user.createdAt,
            "updatedAt": user.updatedAt
        ]) { error in
            if let error = error {
                print("Firestoreの更新エラー: \(error.localizedDescription)")
            } else {
                print("Firestoreの更新成功")
            }
        }
    }
    
    private func deleteLocalFirebaseKeys() {
        UserDefaults.standard.removeObject(forKey: "userRefreshToken")
        UserDefaults.standard.removeObject(forKey: "userID")
        print("ローカルのFirebase関連キーが削除されました。")
    }

    private func signOutFirebaseUser() {
        do {
            try Auth.auth().signOut()
            print("ユーザーがサインアウトされました。")
        } catch let signOutError as NSError {
            print("サインアウト中にエラーが発生しました: \(signOutError.localizedDescription)")
        }
    }
    
}
