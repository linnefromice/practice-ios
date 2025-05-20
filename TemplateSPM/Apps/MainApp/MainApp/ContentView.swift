import SwiftUI
import CoreComponents
import CoreDesignSystem
import PhotosUI

enum ContentViewState {
    case root
    case gallery
    case camera
}

struct ContentView: View {
    @State private var state: ContentViewState = .root

    var body: some View {
        VStack {
            ThreeSectionBar(
                left: {
                    Button(action: {
                        state = .gallery
                    }) {
                        Image(systemName: "photo.on.rectangle")
                    }
                },
                center: { Text("Title") },
                right: {
                    Button(action: {
                        state = .camera
                    }) {
                        Image(systemName: "camera")
                    }
                }
            )

            Spacer()
            switch state {
            case .root:
                ContentRootView()
            case .gallery:
                GalleryView()
            case .camera:
                CameraView()
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentRootView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            VStack {
                Text("Primary")
                    .foregroundStyle(AppTheme.primary)
                Text("On Primary")
                    .foregroundStyle(AppTheme.onPrimary)
                Text("Info")
                    .foregroundStyle(AppTheme.info)
            }
            .background(.gray)
            .padding()
            HStack {
                Button("Dark") {
                    changeTheme(to: .dark)
                }
                Button("Light") {
                    changeTheme(to: .light)
                }
                Button("System") {
                    changeTheme(to: .unspecified)
                }
            }
            Spacer()
        }
        .padding()
    }

    private func changeTheme(to: UIUserInterfaceStyle) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        window?.overrideUserInterfaceStyle = to
    }
}

struct GalleryView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    @State private var showingImageViewer = false
    
    var body: some View {
        VStack {
            if selectedImages.isEmpty {
                Text("No images selected")
                    .foregroundStyle(.secondary)
            } else {
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 100, maximum: 200))
                    ], spacing: 8) {
                        ForEach(0..<selectedImages.count, id: \.self) { index in
                            Image(uiImage: selectedImages[index])
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .onTapGesture {
                                    showingImageViewer = true
                                }
                        }
                    }
                    .padding()
                }
            }

            Spacer().frame(height: 16)
            PhotosPicker(
                selection: $selectedItems,
//                maxSelectionCount: 10,
                matching: .images
            ) {
                Label("Select Photos", systemImage: "photo.stack")
                    .foregroundStyle(AppTheme.primary)
            }
            Spacer().frame(height: 16)
            Button("Reset") {
                selectedItems = []
                selectedImages = []
            }
        }
        .onChange(of: selectedItems) { _, _ in
            Task {
                selectedImages = []
                for item in selectedItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImages.append(image)
                    }
                }
            }
        }
        .sheet(isPresented: $showingImageViewer) {
            ImageViewer(images: selectedImages)
        }
    }
}

struct ImageViewer: View {
    let images: [UIImage]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            TabView {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(uiImage: images[index])
                        .resizable()
                        .scaledToFit()
                }
            }
            .tabViewStyle(.page)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct CameraView: View {
    var body: some View {
        Text("Camera")
    }
}

#Preview {
    ContentView()
}
