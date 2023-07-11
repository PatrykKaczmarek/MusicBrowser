//
// ActivityIndicatorView.swift
// MusicBrowser
//

import UIKit
import NVActivityIndicatorView

final class ActivityIndicatorView: UIView {

    /// An enum that specifies how background color should look like.
    enum Background {
        case blurred
        case color(UIColor)
    }

    // MARK: Properties

    /// An optional message displayed below a loading icon.
    var message: String? {
        get { messageLabel.text }
        set { messageLabel.text = newValue }
    }

    private lazy var activityIndicatorView = NVActivityIndicatorView(
        frame: CGRect(x: 0, y: 0, width: 60, height: 60),
        type: .lineScalePulseOut,
        color: .red
    ).layoutable()

    private lazy var containerView: UIView = {
        let view = UIView.autoLayoutView()
        view.backgroundColor = .clear
        view.alpha = 0
        return view
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel.autoLayoutView()
        label.textAlignment = .center
        return label
    }()

    private var animator: UIViewPropertyAnimator?

    // MARK: Initializer

    /// Initializes an instance of the receiver.
    /// - Parameter frame: Describes the view’s location and size in its superview’s coordinate system.
    /// - Parameter background: A background type.
    init(frame: CGRect = .zero, background: Background = .blurred) {
        super.init(frame: frame)

        backgroundColor = .clear
        addSubview(containerView)

        switch background {
        case .blurred:
            if UIAccessibility.isReduceTransparencyEnabled {
                containerView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
            } else {
                backgroundColor = .clear
                let blurEffect = UIBlurEffect(style: .extraLight)
                let blurEffectView = UIVisualEffectView(effect: blurEffect).layoutable()
                containerView.addSubview(blurEffectView)
                NSLayoutConstraint.activate(blurEffectView.constrainEdges(to: containerView))
            }
        case let .color(color):
            containerView.backgroundColor = color
        }

        activityIndicatorView.startAnimating()
        containerView.addSubviews(activityIndicatorView, messageLabel)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            activityIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            messageLabel.topAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: 32),
            messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16)
        ])
    }

    @available(*, unavailable, message: "Use init(frame:) method instead.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: API

    /// Starts HUD animation.
    func startAnimating() {
        activityIndicatorView.startAnimating()
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            self.containerView.alpha = 1
        }
        animator.addCompletion { _ in
            self.animator = nil
        }
        animator.startAnimation()
        self.animator = animator
    }

    /// Stops HUD animation.
    ///
    /// - Parameter completion: A completion closure being invoked on the main thread when hide animation ended.
    ///                         Contains self as a parameter.
    func stopAnimating(completion: @escaping (ActivityIndicatorView) -> Void) {
        self.animator?.stopAnimation(true)
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn) {
            self.containerView.alpha = 0
        }
        animator.addCompletion { _ in
            self.animator = nil
            completion(self)
        }
        animator.startAnimation()
        self.animator = animator
    }
}
