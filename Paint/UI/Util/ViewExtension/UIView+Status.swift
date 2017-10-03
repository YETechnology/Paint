//
//  UIView+Status.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/1.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit
import SnapKit

let kLoadingViewTag: Int = 2017100301
let kFailedViewTag: Int = 2017100302
let kEmptyViewTag: Int = 2017100303

var kRetryCallbackKey = "retryCallbackKey"

extension UIView {
    
    var retryCallback: (()->Void)? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &kRetryCallbackKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            }
        }
        
        get {
            return objc_getAssociatedObject(self, &kRetryCallbackKey) as? ()->Void
        }
    }
    
    public func hiddenAllStatusView() {
        hiddenLoadingView()
        hiddenFailedView()
        hiddenEmptyView()
    }

    // MARK: 加载中
    public func showLoadingView(with offset: CGFloat = 0.0) {
        hiddenAllStatusView()
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.tag = kLoadingViewTag
        addSubview(view)
        view.startAnimating()
        view.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 45, height: 45));
            make.centerX.equalTo(self);
            make.top.greaterThanOrEqualTo(self).offset(0.0);
            make.centerY.equalTo(self).offset(offset).priority(.medium);
        }
    }
    
    public func hiddenLoadingView() {
        hiddenView(with: kLoadingViewTag)
    }
    
    // MARK: 失败
    public func showFailedView(
        with offset:CGFloat = 0.0,
        image: UIImage = UIImage(named:"error")!,
        title: String = "加载失败，点击屏幕重新加载",
        retryCallback: @escaping ()->Void) {
        showView(with: offset, and: kFailedViewTag, image: image, title: title, retryCallback: retryCallback)
    }
        
    public func hiddenFailedView() {
        hiddenView(with: kFailedViewTag)
    }
    
    // MARK: 空态
    public func showEmptyView(
        with offset:CGFloat = 0.0,
        image: UIImage = UIImage(named:"empty")!,
        title: String = "暂无内容") {
        showView(with: offset, and: kEmptyViewTag, image: image, title: title, retryCallback: nil)
    }
    
    public func hiddenEmptyView() {
        hiddenView(with: kEmptyViewTag)
    }
    
    // MARK: 私有
    private func hiddenView(with tag: Int) {
        for view in self.subviews {
            if view.tag == tag {
                view.removeFromSuperview()
                return
            }
        }
    }
    
    private func showView(
        with offset:CGFloat,
        and tag: Int,
        image: UIImage,
        title: String,
        retryCallback: (()->Void)?) {
        
        hiddenAllStatusView()
        
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.tag = tag
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        /// 重试button
        if let retryCallback = retryCallback {
            let button = UIButton(type:.custom)
            button.backgroundColor = UIColor.clear
            self.retryCallback = retryCallback
            button.addTarget(self, action:#selector(retryButtonClicked(_:)) , for: .touchUpInside)
            view.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.edges.equalTo(view)
            })
        }
        
        let centerView = UIView()
        centerView.backgroundColor = UIColor.clear
        centerView.isUserInteractionEnabled = false
        
        let imageView = UIImageView(image:image)
        centerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(centerView)
            make.top.equalTo(centerView)
        }
        
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.text = title
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.color(with:0xb3b3b3)
        
        centerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(centerView.snp.bottom).offset(-40.0)
            make.centerX.equalTo(centerView)
        }
        
        view.addSubview(centerView)
        centerView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.width.equalTo(view)
            make.centerX.equalTo(view)
            make.top.greaterThanOrEqualTo(view).offset(0.0)
            make.centerY.equalTo(view).offset(offset).priority(.medium)
        }
    }
    
    @objc private func retryButtonClicked(_ sender: Any) {
        if let callback = retryCallback {
            callback()
        }
    }
}
