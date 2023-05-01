import SwiftUI

struct RoundedShape: Shape {
    var corners: UIRectCorner
    var cornerRadii = CGSize(width: 80, height: 80)
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: cornerRadii)
        return Path(path.cgPath)
    }
}
