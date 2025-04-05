import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            Text("ダッシュボード")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("ログインに成功しました！")
                .font(.headline)
                .foregroundColor(.green)
        }
    }
}

#Preview {
    DashboardView()
}