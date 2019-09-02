//
//  ResourceImage.swift
//  ImageSlideshow
//
//  Created by Nik Kov on 06.07.16.
//
//

import UIKit

/// Input Source to image
@objcMembers
public class ResourceImage: NSObject, InputSource {
    /// url to load
    public var url: URL

    /// placeholder used before image is loaded
    public var placeholder: UIImage?

    /// Initializes a new source with a URL
    /// - parameter url: a url to be loaded
    /// - parameter placeholder: a placeholder used before image is loaded
    public init(url: URL, placeholder: UIImage? = nil) {
        self.url = url
        self.placeholder = placeholder
        super.init()
    }

    /// Initializes a new source with a URL string
    /// - parameter urlString: a string url to load
    /// - parameter placeholder: a placeholder used before image is loaded
    public init?(urlString: String, placeholder: UIImage? = nil) {
        if let validUrl = URL(string: urlString) {
            self.url = validUrl
            self.placeholder = placeholder
            super.init()
        } else {
            return nil
        }
    }

    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        imageView.setImageFrom(url: self.url.absoluteString)
    }
    
    public func cancelLoad(on imageView: UIImageView) {
    }
}
