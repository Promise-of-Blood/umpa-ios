// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum UmpaAsset {
  public enum Assets {
  public static let accentColor = UmpaColors(name: "AccentColor")
    public static let appleLoginIconCircle = UmpaImages(name: "apple_login_icon_circle")
    public static let arrowBack = UmpaImages(name: "arrow_back")
    public static let arrowTriangleDownFill = UmpaImages(name: "arrow_triangle_down_fill")
    public static let arrowTriangleUpFill = UmpaImages(name: "arrow_triangle_up_fill")
    public static let bannerSample1 = UmpaImages(name: "banner_sample1")
    public static let commentIcon = UmpaImages(name: "comment_icon")
    public static let customChevronRight = UmpaImages(name: "custom_chevron_right")
    public static let googleLogin = UmpaImages(name: "google_login")
    public static let googleLoginIconCircle = UmpaImages(name: "google_login_icon_circle")
    public static let kakaoLogin = UmpaImages(name: "kakao_login")
    public static let kakaoLoginIconCircle = UmpaImages(name: "kakao_login_icon_circle")
    public static let likeIcon = UmpaImages(name: "like_icon")
    public static let naverLogin = UmpaImages(name: "naver_login")
    public static let naverLoginIconCircle = UmpaImages(name: "naver_login_icon_circle")
    public static let notificationIcon = UmpaImages(name: "notification_icon")
    public static let profileIcon = UmpaImages(name: "profile_icon")
    public static let sampleImage = UmpaImages(name: "sample_image")
    public static let seeAllIcon = UmpaImages(name: "see_all_icon")
    public static let studentUserSymbol = UmpaImages(name: "student_user_symbol")
    public static let teacherUserSymbol = UmpaImages(name: "teacher_user_symbol")
    public static let umpaLogo = UmpaImages(name: "umpa_logo")
  }
  public enum PreviewAssets {
  public static let arrowBack = UmpaImages(name: "arrow_back")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class UmpaColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension UmpaColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: UmpaColors) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Color {
  init(asset: UmpaColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct UmpaImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: UmpaImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: UmpaImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: UmpaImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
