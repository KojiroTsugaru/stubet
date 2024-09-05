import Foundation
import FirebaseFirestore

class UserProvider {
    static let shared: UserProvider = UserProvider()
    private var currentUser: User?

    private init() {
        // 初期化時にユーザー情報を取得
        // 例として固定のユーザーIDを使用しています。適宜変更してください。
        fetchUserFromCloud(userID: "exampleUserID") { user in
            if let user = user {
                print("初期化時にFirestoreからのユーザー情報の取得成功: \(user)")
            } else {
                print("初期化時のFirestoreからのユーザー情報取得に失敗しました。")
            }
        }
    }

    // クラウドからユーザー情報を取得し、ローカルにもセット(init, login, signup時に呼び出し)
    func fetchUserFromCloud(userID: String, completion: @escaping (User?) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists, let data = document.data(), let user = User(data: data) {
                self.setUserLocally(user)
                completion(user)
            } else {
                print("Firestoreからの取得エラー: \(error?.localizedDescription ?? "不明なエラー")")
                completion(nil)
            }
        }
    }

    // ローカルにユーザー情報をセットし、クラウドにも更新
    private func setUserLocally(_ user: User) {
        self.currentUser = user
        updateCloudUser(user)
    }

    // ローカルからユーザー情報を取得
    func getUserFromLocal() -> User? {
        return self.currentUser
    }

    // Firestoreにユーザー情報を更新
    private func updateCloudUser(_ user: User) {
        let db = Firestore.firestore()
        db.collection("users").document(user.id).setData([
            "id": user.id,
            "name": user.name,
            "email": user.email
        ]) { error in
            if let error = error {
                print("Firestoreの更新エラー: \(error.localizedDescription)")
            } else {
                print("Firestoreの更新成功")
            }
        }
    }

    // ユーザー名を更新し、ローカルとクラウドに反映
    func updateUserName(_ name: String) {
        guard var user = currentUser else { return }
        user.name = name
        setUserLocally(user)
    }

    // メールアドレスを更新し、ローカルとクラウドに反映
    func updateUserEmail(_ email: String) {
        guard var user = currentUser else { return }
        user.email = email
        setUserLocally(user)
    }
}
