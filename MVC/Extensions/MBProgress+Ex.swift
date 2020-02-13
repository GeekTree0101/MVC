import MBProgressHUD

extension MBProgressHUD {
  
  public static func messasge(_ text: String, to view: UIView, animated: Bool = true) {
    let progress = MBProgressHUD.init()
    progress.label.text = text
    progress.mode = .text
    view.addSubview(progress)
    progress.show(animated: animated)
    progress.hide(animated: animated, afterDelay: 1.0)
  }
  
}
