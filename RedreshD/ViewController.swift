//
//  ViewController.swift
//  RedreshD
//
//  Created by idea on 2018/8/21.
//  Copyright © 2018年 idea. All rights reserved.
//

import UIKit
import BFRefresh
class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "tableView"
        view.addSubview(tableView)
        tableView.set(loadType: .noNetwork)

        tableView.refreshBlock = { [weak self] in
            print(self ?? "")
            self?.tableView.set(loadType: .loading)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0, execute: {
                self?.tableView.set(loadType: .normal)
            })

            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "点击", style: .done, target: self, action: #selector(push))
    }
    @objc func push(){
        self.navigationController?.pushViewController(BViewController(), animated: true)

    }
}
extension ViewController :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "dequeueReusableCell";
        return cell
    }
    
}
extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(AViewController(), animated: true)
    }
}
