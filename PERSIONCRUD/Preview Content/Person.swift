import Foundation

struct Person: Identifiable {
    let id = UUID()
    var firstName: String
    var lastName: String
    var birthDate: Date
    var phoneNumber: String
    var email: String
    var address: String
}
