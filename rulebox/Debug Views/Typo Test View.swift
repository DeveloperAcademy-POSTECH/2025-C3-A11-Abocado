//
//  Typo Test View.swift
//  rulebox
//
//  Created by Ken on 5/30/25.
//

import SwiftUI

struct TypoTestView: View {
    var body: some View {
        VStack {
            Text("xlHeading, 다람쥐 헌 쳇바퀴에 타고파\n")
            Text("xlHeading, 다람쥐 헌 쳇바퀴에 타고파\n").font(.xlHeading)
            Text("lgHeading, 다람쥐 헌 쳇바퀴에 타고파\n").font(.lgHeading)
            Text("mdHeading, 다람쥐 헌 쳇바퀴에 타고파\n").font(.mdHeading)
            Text("smHeading, 다람쥐 헌 쳇바퀴에 타고파\n").font(.smHeading)
            Text("lgRegular, 다람쥐 헌 쳇바퀴에 타고파\n").font(.lgRegular)
            Text("lgMedium, 다람쥐 헌 쳇바퀴에 타고파\n").font(.lgMedium)
            Text("lgMedium, 다람쥐 헌 쳇바퀴에 타고파").font(.mdMedium)
            Text("lgMedium, 다람쥐 헌 쳇바퀴에 타고파")
        }
    }
}
#Preview {
    TypoTestView()
}
