import Combine

protocol UserProvider {
    func fetchUser() -> AnyPublisher<User, Error>
    func logout() -> AnyPublisher<Void, Error>
}

class SampleUserProvider: UserProvider {
    func fetchUser() -> AnyPublisher<User, Error> {
        // ここに実際のユーザーデータ取得処理を実装
        // 例: UserDefaults、APIリクエスト、または他のデータソースからユーザー情報を取得
        return Just(User(id: "123", name: "太郎", email: "taro@example.com"))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher() 
    }

    func logout() -> AnyPublisher<Void, Error> {
        // ここに実際のログアウト処理を実装
        // 例: UserDefaultsのクリア、APIリクエストなど
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher() 
    }
}