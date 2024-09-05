//
//  TimeSettingViewModel.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/05.
//
//
//import Foundation
//import Combine
//import FirebaseFirestore
//
//class TimeSettingViewModel: ObservableObject {
//    @Published var date: Date = Date()
//    @Published var time: Date = Date()
//    
//    private var db = Firestore.firestore()
//    private let betId: String
//
//    init(betId: String) {
//        self.betId = betId
//    }
//
//    func setDeadline(completion: @escaping (Result<Void, Error>) -> Void) {
//        let calendar = Calendar.current
//        var components = calendar.dateComponents([.year, .month, .day], from: date)
//        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
//        components.hour = timeComponents.hour
//        components.minute = timeComponents.minute
//        
//        guard let deadlineDate = calendar.date(from: components) else {
//            completion(.failure(NSError(domain: "Invalid date", code: 0, userInfo: nil)))
//            return
//        }
//
//        let deadline = Timestamp(date: deadlineDate)
//        
//        db.collection("bets").document(betId).updateData(["deadline": deadline]) { error in
//            if let error = error {
//                print("Error updating deadline: \(error)")
//                completion(.failure(error))
//            } else {
//                completion(.success(()))
//            }
//        }
//    }
//}
