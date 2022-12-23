//
//  DetailViewGradiant.swift
//  Touche
//
//  Created by youngseo on 2022/12/20.
//

import SwiftUI

struct DetailViewGradiant: View {
    @State var perfume: Perfume
    var body: some View {
        FloatingClouds( generalBackground: getSRGBColor(hexString: perfume.color![1]))
    }
    //convertSRGB(hexString: perfume.color_hex)`
    func getSRGBColor(hexString: String) -> Color{
        let scanner = Scanner(string: hexString)
        _ = scanner.scanString("#")
                                  
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
                                  
        let sR = Double((rgb >> 16) & 0xFF) / 255.0
        let sG = Double((rgb >>  8) & 0xFF) / 255.0
        let sB = Double((rgb >>  0) & 0xFF) / 255.0
        
        print("sR:\(sR), sG:\(sG), sB:\(sB)")
        return Color(red:sR, green:sG, blue:sB)
    }
}


class CloudProvider: ObservableObject {
    let offset: CGSize
    let frameHeightRatio: CGFloat

    init() {
        frameHeightRatio = CGFloat.random(in: 0.7 ..< 1.4)
        offset = CGSize(width: CGFloat.random(in: -100 ..< 100),
                        height: CGFloat.random(in: -100 ..< 100))
    }   
}

struct Cloud: View {
    @StateObject var provider = CloudProvider()
    @State var move = false
    let proxy: GeometryProxy
    let color: Color
    let rotationStart: Double
    let duration: Double
    let alignment: Alignment

    var body: some View {
        Circle()
            .fill(color)
            .frame(height: proxy.size.height /  provider.frameHeightRatio)
            .offset(provider.offset)
            .rotationEffect(.init(degrees: move ? rotationStart : rotationStart + 360) )
            .animation(Animation.linear(duration: duration).repeatForever(autoreverses: false))
            .frame(maxWidth: 100, maxHeight: 100, alignment: alignment)
//            .opacity(0.8)
            .onAppear {
                move.toggle()
            }
    }
}

struct FloatingClouds: View {
    @Environment(\.colorScheme) var scheme
    let blur: CGFloat = 60
    var generalBackground:Color
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                generalBackground.opacity(0.25)
                Cloud(proxy: proxy,
                      color: Theme.ellipsesBottomTrailing(color: generalBackground),
                      rotationStart: 0,
                      duration: 6,
                      alignment: .bottomTrailing)
                Cloud(proxy: proxy,
                      color: Theme.ellipsesTopTrailing(color: generalBackground),
                      rotationStart: 240,
                      duration: 5,
                      alignment: .topTrailing)
                Cloud(proxy: proxy,
                      color: Theme.ellipsesBottomLeading(color: generalBackground),
                      rotationStart: 120,
                      duration: 8,
                      alignment: .bottomLeading)
                Cloud(proxy: proxy,
                      color: Theme.ellipsesTopLeading(color: generalBackground),
                      rotationStart: 180,
                      duration: 7,
                      alignment: .topLeading)
            }
            .blur(radius: blur)
//            .ignoresSafeArea()
        }
        
    }
    
    
}


struct Theme {
    static func ellipsesTopLeading(color: Color) -> Color {
        return color
    }

    static func ellipsesTopTrailing(color: Color) -> Color {
        let temp = color.components
        return Color(red: temp.red * 0.75 , green: temp.green*0.75, blue:temp.blue*0.75)
    }

    static func ellipsesBottomTrailing(color: Color) -> Color {
        let temp = color.components
        return Color(red: temp.red * 0.5 , green: temp.green*0.5, blue:temp.blue*0.5)
    }

    static func ellipsesBottomLeading(color: Color) -> Color {
        let temp = color.components
        return Color(red: temp.red * 0.25 , green: temp.green*0.25, blue:temp.blue*0.25)
    }
}


extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {

        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            // You can handle the failure here as you want
            return (0, 0, 0, 0)
        }

        return (r, g, b, o)
    }
}
