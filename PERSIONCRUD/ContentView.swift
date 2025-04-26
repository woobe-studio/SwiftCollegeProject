
import SwiftUI

struct ContentView: View {
    @State private var persons: [Person] = []
    @State private var isPresentingAddView = false

    var body: some View {
        NavigationView {
            List {
                ForEach($persons) { $person in
                    NavigationLink(destination: DetailView(person: $person)) {
                        VStack(alignment: .leading) {
                            Text("\(person.firstName) \(person.lastName)")
                                .font(.headline)
                            Text(person.email)
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deletePerson)
            }
            .navigationTitle("Person")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddView) {
                AddPersonView(persons: $persons)
            }
        }
    }

    private func deletePerson(at offsets: IndexSet) {
        persons.remove(atOffsets: offsets)
    }
}
