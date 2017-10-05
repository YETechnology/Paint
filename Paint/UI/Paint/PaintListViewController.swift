//
//  PaintListViewController.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/1.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

let PaintPlistName: String = "YEPaintList.plist"

class PaintListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataArray: [PaintListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        dataArray = getPaintListData()
        // register cell
        tableView.register(PaintViewListCell.self, forCellReuseIdentifier: PaintViewListCell.cellReuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Private Method
    fileprivate func paintListFilePath() -> String? {
        var filePath: String? = nil
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            filePath = url.appendingPathComponent(PaintPlistName, isDirectory: false).absoluteString
        }
        return filePath
    }
    
    fileprivate func getPaintListData() -> [PaintListItem] {
        guard let path = paintListFilePath() else {
            return []
        }
        guard let arr = NSArray(contentsOf: URL(string:path)!) as? [Dictionary<String, Any>] else {
            return []
        }
        var retArr: [PaintListItem] = []
        arr.forEach { (dict) in
            retArr.append(PaintListItem(title: dict["title"] as! String, time: dict["time"] as! Date, imageUrl: dict["imageUrl"] as! String))
        }
        return retArr
    }
    
}

extension PaintListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PaintViewListCell = tableView.dequeueReusableCell(withIdentifier: PaintViewListCell.cellReuseIdentifier, for: indexPath) as! PaintViewListCell
        let data = dataArray[indexPath.row]
        cell.update(with: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
