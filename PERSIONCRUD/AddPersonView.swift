
import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var persons: [Person]

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthDate = Date()
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var address = ""

    @State private var showInvalidDateAlert = false

    var body: some View {
        NavigationView {
            Form {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                DatePicker("Birth Date", selection: $birthDate, in: ...Date(), displayedComponents: .date)
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                TextField("Address", text: $address)
            }
            .navigationTitle("Add Person")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if isValidDate(birthDate) {
                            let newPerson = Person(
                                firstName: firstName,
                                lastName: lastName,
                                birthDate: birthDate,
                                phoneNumber: phoneNumber,
                                email: email,
                                address: address
                            )
                            persons.append(newPerson)
                            dismiss()
                        } else {
                            showInvalidDateAlert = true
                        }
                    }
                    .disabled(firstName.isEmpty || lastName.isEmpty || !isValidEmail(email))
                }
            }
            .alert("Invalid Date", isPresented: $showInvalidDateAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("The birth date cannot be in the future.")
            }
        }
    }

    private func isValidDate(_ date: Date) -> Bool {
        return date <= Date()
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
}
