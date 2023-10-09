//
//  BookFormTableViewController.swift
//  MyLabFavoriteBooks
//
//  Created by 曹家瑋 on 2023/10/9.
//

import UIKit

class BookFormTableViewController: UITableViewController {

    struct PropertyKeys {
        static let unwindToBookTable = "UnwindToBookTable"
    }
    
    var book: Book?
    
    init?(coder: NSCoder, book: Book?) {
        self.book = book
        super.init(coder: coder)
    }
    
    // 在不提供book對象的情況下創建控制器的實例（在Storyboard中初始化時）。
    required init?(coder: NSCoder) {
        self.book = nil
        super.init(coder: coder)
    }
    
    // 文字欄位
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var lengthTextField: UITextField!
    
    // 儲存按鈕
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // 如果存在一個Book（即book不為nil）
        if let book = book {
            titleTextField.text = book.title
            authorTextField.text = book.author
            genreTextField.text = book.genre
            lengthTextField.text = book.length
            title = "Edit Book"
        } else {
            title = "Add Book"
        }
        
        // 確保在視圖加載時更新保存按鈕的狀態
        updateSaveButtonState()
    }

    
    // 當任一TextField的內容被修改時
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()     // 更新按鈕的啟用狀態。
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // 擷取文字框中的內容，並創建/更新一個Book對象
        guard let title = titleTextField.text,
              let author = authorTextField.text,
              let genre = genreTextField.text,
              let length = lengthTextField.text else { return }

        // 初始化或更新book物件
        book = Book(title: title, author: author, genre: genre, length: length)
        // 執行unwind segue返回到上一個視圖控制器
        performSegue(withIdentifier: PropertyKeys.unwindToBookTable, sender: self)
    }
    
    
    /// 確定所有TextField都有值，來啟用saveButton狀態
    func updateSaveButtonState() {
        
        let titleText = titleTextField.text ?? ""
        let authorText = authorTextField.text ?? ""
        let genreText = genreTextField.text ?? ""
        let lengthText = lengthTextField.text ?? ""

        // 檢查所有的textfield是否都有值
        saveButton.isEnabled = !titleText.isEmpty && !authorText.isEmpty && !genreText.isEmpty && !lengthText.isEmpty
    }
    
    /*
     func updateView() {
         guard let book = book else {return}
         
         titleTextField.text = book.title
         authorTextField.text = book.author
         genreTextField.text = book.genre
         lengthTextField.text = book.length
     }
     */
}
