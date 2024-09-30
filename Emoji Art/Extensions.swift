//
//  Extensions.swift
//  Emoji Art
//
//  Created by Vasilije Pavicevic on 26.9.24..
//

import SwiftUI

typealias CGOfsett = CGSize

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    init(center: CGPoint, size: CGSize) {
        self.init(origin: CGPoint(x: center.x-size.width/2, y: center.y-size.height/2), size: size)
    }
}

extension CGOfsett {
    static func +(lhs: CGOfsett, rhs: CGOfsett) -> CGOfsett {
        CGOfsett(width: lhs.width + rhs.width, height: lhs.width + rhs.width)
    }
    static func +=(lhs: inout CGOfsett, rhs: CGOfsett) {
        lhs = lhs + rhs
    }
}

extension String {
    
    var uniqued: String {
        reduce(into: "") { sofar, element in
            if !sofar.contains(element){
                sofar.append(element)
            }
        }
    }
}

extension AnyTransition {
    static let rollUp: AnyTransition = .asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top))
    static let rollDown: AnyTransition = .asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom))
}

struct AnimatedActionButton: View {
    var title: String? = nil
    var systemImage: String? = nil
    var role: ButtonRole?
    let action: () -> Void
    
    init(_ title: String? = nil, systemImage: String? = nil, role: ButtonRole? = nil, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.role = role
        self.action = action
    }
    
    var body: some View {
        Button(role: role) {
            withAnimation{
                action()
            }
        } label: {
            if let title, let systemImage {
                Label(title, systemImage: systemImage)
            } else if let title {
                Text(title)
            }else if let systemImage {
                Image(systemName: systemImage)
            }
        }
    }
}
