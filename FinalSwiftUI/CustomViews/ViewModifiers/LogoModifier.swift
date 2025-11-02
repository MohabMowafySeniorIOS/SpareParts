import SwiftUI

struct LogoModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 150,height: 70)
    }
}

extension View {
    func logoSize() -> some View {
        self.modifier(LogoModifier())
    }
}
