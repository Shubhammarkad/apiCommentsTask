//
//  ViewController.swift
//  apiCommentsTask
//
//  Created by Mac on 16/05/23.
//

import UIKit

class ViewController: UIViewController {
    var comments : [Comment] = []

    @IBOutlet weak var commentsTabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingApiData()
        registerWithXIB()
        commentsTabelView.delegate = self
        commentsTabelView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func registerWithXIB(){
        var uiNib = UINib(nibName: "CommentsTableViewCell", bundle: nil)
        self.commentsTabelView.register(uiNib, forCellReuseIdentifier: "CommentsTableViewCell")
    }
    func fetchingApiData(){
        guard let url = URL(string:"https://gorest.co.in/public/v2/comments")else{return}
        URLSession.shared.dataTask(with: url){
            data,error,response in
            guard let okData = data else {return}
            do{
                let apiResponse = try JSONDecoder().decode([Comment].self, from:okData)
                self.comments = apiResponse
                print(self.comments.count)
                print(self.comments.self)
            }
            catch{
                print("error")
            }
            DispatchQueue.main.async {
                self.commentsTabelView.reloadData()
            }
        }.resume()
    }
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300.0
    }
    }

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let commentsTabelViewCell = self.commentsTabelView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as? CommentsTableViewCell else{return UITableViewCell()}
        commentsTabelViewCell.idLabel.text = String(comments[indexPath.row].id)
        commentsTabelViewCell.postidLabel.text = String(comments[indexPath.row].post_id)
        commentsTabelViewCell.nameLabel.text = comments[indexPath.row].name
        commentsTabelViewCell.emailLabel.text = comments[indexPath.row].email
        commentsTabelViewCell.postidLabel.text = comments[indexPath.row].body
        return commentsTabelViewCell
    }
    
    
}

