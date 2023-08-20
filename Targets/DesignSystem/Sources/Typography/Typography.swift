//
//  Copyright © 2023 Tapster AB. All rights reserved.
//

import SwiftUI

extension SwiftUI.Font {
    public enum DesignSystem {
        public static let title1: Font = Font.custom("Helvetica", size: 18).weight(.regular)
        public static var title2: Font = DesignSystemFontFamily.Poppins.medium.swiftUIFont(size: 14)
        public static let subtitle1: Font = Font.custom("Helvetica", size: 12).weight(.semibold)
        public static let footer1: Font = DesignSystemFontFamily.Inter.medium.swiftUIFont(size: 10)
        public static let headline1: Font = Font.custom("Helvetica", size: 24).weight(.regular)
        public static let headline2: Font = Font.custom("Helvetica", size: 16).weight(.regular)
    }
}

#if DEBUG
struct Typography_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Text("Headline1 with Helvetica/24/Regular")
                .font(.DesignSystem.headline1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Title1 with Helvetica/18/Regular")
                .font(.DesignSystem.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Headline2 with Helvetica/16/Regular")
                .font(.DesignSystem.headline2)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Title2 with Poppins/14/Medium")
                .font(.DesignSystem.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Subtitle with Helvetica/12/Medium")
                .font(.DesignSystem.subtitle1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Footer1 with Inter/10/Medium")
                .font(.DesignSystem.footer1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
#endif
