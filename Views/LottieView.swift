import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {

    let animationName: String
    var loopMode: LottieLoopMode = .playOnce

    func makeUIView(context: Context) -> UIView {

        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView(name: animationName)

        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
