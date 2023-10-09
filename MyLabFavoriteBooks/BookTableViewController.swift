//
//  BookTableViewController.swift
//  MyLabFavoriteBooks
//
//  Created by 曹家瑋 on 2023/10/9.
//

import UIKit

class BookTableViewController: UITableViewController {

    struct PropertyKeys {
        static let unwindToBookTable = "UnwindToBookTable"
        static let bookCell = "BookCell"
    }
    
    // 存儲所有的書本的數組
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 設置單元格的佈局邊距是否跟隨可讀寬度
        self.tableView.cellLayoutMarginsFollowReadableWidth = true
    }
    
    // 每次畫面將要出現時，重載數據以確保所有變更被更新到界面上
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    // BookFormTableViewController）返回到 BookTableViewController 時，進行數據傳遞。
    @IBAction func prepareForUnwind(_ segue: UIStoryboardSegue) {
        
        // 確保來源視圖控制器是 BookFormTableViewController ，並且其中包含一個Book對象
        guard let source = segue.source as? BookFormTableViewController,
              let book = source.book else { return }
        
        // 檢查當前是否有選擇的表格行（即是否正在編輯一個現有的書籍）
        if let indextPath = tableView.indexPathForSelectedRow {
            // 如果有，從books中刪除當前書籍（移除舊書）
            books.remove(at: indextPath.row)
            // 在同一個位置插入更新後的書籍（插入更新過的書）
            books.insert(book, at: indextPath.row)
            // 取消行的選中狀態
            tableView.deselectRow(at: indextPath, animated: true)
        } else {
            // 如果沒有選擇的行（即正在創建一個新的書籍），則將新書籍添加到books中
            books.append(book)
        }
    }
    
    // 點擊cell時可以修改資料（這邊沒使用到）
    @IBSegueAction func editBook(_ coder: NSCoder, sender: Any?) -> BookFormTableViewController? {
        
        // 將 sender 轉型為 UITableViewCell，並獲取該 cell 的 indexPath。
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return nil }
        
        // 使用 indexPath 從 books 中獲取對應的 book 對象。
        let book = books[indexPath.row]
        
        // 使用所提供的 coder 和 book 來初始化一個新的 BookFormTableViewController 實例。
        // coder 參數包含了有關 segue 的資訊，而 book 參數是我們剛剛從 books 數組中獲取的。
        // 返回新的 BookFormTableViewController 實例作為 segue 的目的地視圖控制器。
        return BookFormTableViewController(coder: coder, book: book)
    }
    

    // MARK: - Table view data source

    // 設置表格視圖的行數
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    // 定義每一行（row）的單元格（cell）的內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 類型轉換為自定義的單元格 "BookTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.bookCell, for: indexPath) as? BookTableViewCell else {
            fatalError("The dequeued cell is not an instance of BookTableViewCell.")
        }

        // 根據當前的 indexPath.row 從 "books" 中取得相對應的 "book" 物件
        let book = books[indexPath.row]
        // 將 "book" 物件作為參數，以便在單元格上更新書本的資訊
        cell.update(with: book)
        
        // 回傳配置好的單元格給表格視圖
        return cell
    }
    
    
    // MARK: - Table view delegate

    // 實現滑動以刪除表格行的功能。
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 檢查是否為刪除模式
        if editingStyle == .delete {
            // 從 data source 中刪除數據
            books.remove(at: indexPath.row)
            // 從界面中刪除對應行
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}


