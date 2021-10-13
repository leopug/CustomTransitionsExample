

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let transitionManager = TransitionDetailsManager()
    
    let data = ["square.and.arrow.up","lasso.and.sparkles", "trash.square", "folder.badge.gearshape", "list.bullet.rectangle.portrait", "person.badge.clock.fill", "person.crop.square.filled.and.at.rectangle.fill", "peacesign", "network.badge.shield.half.filled", "music.mic.circle.fill"]
    
    var tempImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: ColorTableViewCell.reuseId)
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ColorTableViewCell.reuseId) as? ColorTableViewCell else { return UITableViewCell()}
        cell.configure(imageString: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController(imageName: data[indexPath.row])
        
        let cellTapped = tableView.cellForRow(at: indexPath) as! ColorTableViewCell
        tempImageView.image = UIImage(systemName: data[indexPath.row])
        tempImageView.frame = view.convert(cellTapped.emojiImageView.frame, from: cellTapped)
        
        
        vc.transitioningDelegate = transitionManager
        vc.modalPresentationStyle = .custom
        
        present(vc, animated: true)
    }
}
