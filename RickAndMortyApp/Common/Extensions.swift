//
//  Extensions.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import UIKit

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension URLResponse {
    
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

extension String {
    
    func load(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: self) else {
            completion(nil)
            return
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func formattedDate() -> String? {
        
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatterInput.date(from: self) else {
            return nil
        }
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd/MM/yyyy"
        return dateFormatterOutput.string(from: date)
    }
    
    func withLink(_ text: String) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        let range = (self as NSString).range(of: text)
        attributedString.addAttribute(.link, value: "", range: range)
        return attributedString
    }
    
}
