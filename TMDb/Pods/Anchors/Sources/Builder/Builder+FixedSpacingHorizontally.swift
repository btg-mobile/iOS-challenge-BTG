#if os(iOS) || os(tvOS)
  import UIKit
#elseif os(OSX)
  import AppKit
#endif

public extension Builder {
  class FixedSpacingHorizontally: ConstraintProducer {

    let views: [View]
    let spacing: CGFloat

    public init(views: [View], spacing: CGFloat) {
      self.views = views
      self.spacing = spacing
    }

    public func constraints() -> [NSLayoutConstraint] {
      var anchors: [Anchor] = []
      views.enumerated().forEach({ i, view in
        if i < views.count - 1 {
          anchors.append(view.anchor.trailing.equal.to(views[i+1].anchor.leading).constant(-spacing))
        }
      })

      return Group(producers: anchors).constraints
    }
  }
}
