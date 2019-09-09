import UIKit

class ChatRoomViewController: UIViewController {
    
    @IBOutlet weak var changeView: UIView!
    @IBOutlet weak var heightButton: UIButton!
    var height: CGFloat = 130
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tapHeightButton(_ sender: Any) {
        self.changeView.heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
        height = height + 10
        changeView.frame.size.height = height
//        self.view.setNeedsLayout()
//        self.view.layoutIfNeeded()
    }
}

extension ChatRoomViewController {
    func setupUI() {
        //tableView.keyboardDismissMode = .interactive //TableViewを下方向にスワイプした時のみキーボードを閉じる
        
        // frameを指定しないとだめ
        
        //self.view.addSubview(bottomView) //やったらだめ！！
        
    }
}


