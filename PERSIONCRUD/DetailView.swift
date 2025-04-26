
import SwiftUI

struct DetailView: View {
    @Binding var person: Person
    @State private var showInvalidDateAlert = false

    var body: some View {
        Form {
            Section(header: Text("Personal Info")) {
                TextField("First Name", text: $person.firstName)
                TextField("Last Name", text: $person.lastName)
                DatePicker("Birth Date", selection: $person.birthDate, in: ...Date(), displayedComponents: .date)
            }

            Section(header: Text("Contact Info")) {
                TextField("Phone Number", text: $person.phoneNumber)
                    .keyboardType(.phonePad)
                TextField("Email", text: $person.email)
                    .keyboardType(.emailAddress)
                TextField("Address", text: $person.address)
            }
        }
        .navigationTitle("\(person.firstName) \(person.lastName)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if isValidDate(person.birthDate) {
                        // Wszystkie zmiany są automatycznie zapisywane
                    } else {
                        showInvalidDateAlert = true
                    }
                }
            }
        }
        .alert("Invalid Date", isPresented: $showInvalidDateAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("The birth date cannot be in the future.")
        }
    }

    private func isValidDate(_ date: Date) -> Bool {
        return date <= Date()
    }
}
