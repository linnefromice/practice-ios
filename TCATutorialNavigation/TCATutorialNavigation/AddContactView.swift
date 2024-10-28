//
//  AddContactView.swift
//  TCATutorialNavigation
//
//  Created by arata.haruyama on 2024/10/29.
//

import ComposableArchitecture
import SwiftUI

struct AddContactView: View {
    @Bindable var store: StoreOf<AddContactFeature>
    
    var body: some View {
        Form {
            TextField("Name", text: $store.contact.name.sending(\.setName))
            Button("Save") {
                store.send(.saveButtonTapped)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}

#Preview {
    AddContactView(
        store: Store(initialState: AddContactFeature.State(
            contact: Contact(id: UUID(), name: "Blob")
        )) {
            AddContactFeature()._printChanges()
        }
    )
}
