import SwiftUI

struct CubeView: View {
    let letter: Character
    var color: Color {
        switch letter {
        case "A": return .red
        case "B": return .blue
        case "C": return .green
        case "D": return .orange
        default: return .gray
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                CubeShape(deep: self.squareWidth(geometry)/6)
                    .fill(self.color)
                    .overlay(CubeShape(deep: self.squareWidth(geometry)/6)
                        .stroke())
                    .frame(width: self.squareWidth(geometry), height: self.squareWidth(geometry))
                Text(String(self.letter))
                    .font(.largeTitle)
                    .projectionEffect(.init(.init(
                        translationX: -self.squareWidth(geometry)/12, y: self.squareWidth(geometry)/12)))
            }
        }
    }

    func squareWidth(_ geometry: GeometryProxy) -> CGFloat {
        return min(geometry.frame(in: .local).width, geometry.frame(in: .local).height)
    }
}

struct CubeShape: Shape {
    let deep: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = min(rect.width, rect.height)
        path.move(to: CGPoint(
            x: deep,
            y: 0
        ))
        path.addLine(to: CGPoint(
            x: width,
            y: 0
        ))
        path.addLine(to: CGPoint(
            x: width,
            y: width - deep
        ))
        path.addLine(to: CGPoint(
            x: width - deep,
            y: width
        ))
        path.addLine(to: CGPoint(
            x: 0,
            y: width
        ))
        path.addLine(to: CGPoint(
            x: 0,
            y: deep
        ))
        path.addLine(to: CGPoint(
            x: deep,
            y: 0
        ))
        path.move(to: CGPoint(
            x: 0,
            y: deep
        ))
        path.addLine(to: CGPoint(
            x: width - deep,
            y: deep
        ))
        path.addLine(to: CGPoint(
            x: width - deep,
            y: width
        ))
        path.move(to: CGPoint(
            x: width - deep,
            y: deep
        ))
        path.addLine(to: CGPoint(
            x: width,
            y: 0
        ))
        return path
    }
}
