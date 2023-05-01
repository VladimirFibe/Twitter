import SwiftUI

struct SideMenuRowView: View {
    let row: SideMenuViewModel
    var body: some View {
        HStack(spacing: 16.0) {
            Image(systemName: row.imageName)
                .font(.headline)
                .foregroundColor(.secondary)
            Text(row.title)
                .font(.subheadline)
                .foregroundColor(Color(.label))
        }
        .frame(height: 40)
    }
}
