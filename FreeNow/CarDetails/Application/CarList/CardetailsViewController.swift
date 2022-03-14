//
//  CardetailsViewController.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 12/03/22.
//

import UIKit

class CardetailsViewController: UIViewController {
    @IBOutlet weak var viewInMapButton: UIButton!
    @IBOutlet weak var carListTableView: UITableView!
    let viewModel = CarDetailViewModel(useCase: CarDetailsRepository(with: CarDetailsService()))

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setTableView()
        registerNib()
        bindUI()
        viewModel.fetchdata()
    }

    private func setUpUI() {
        viewInMapButton.layer.borderColor = UIColor.systemBlue.cgColor
        viewInMapButton.setTitleColor(UIColor.systemBlue, for: .normal)
        viewInMapButton.layer.borderWidth = 1.0
        viewInMapButton.layer.cornerRadius = 8.0
    }

    private func registerNib() {
        carListTableView.registerCellWithNib(forCell: CarDetailsTableViewCell.self)
    }

    private func bindUI() {
        viewModel.showSpinner = { [weak self] (show) in
            guard let self = self else { return }
            show ? self.addSpinner() : self.removeSpinner()
        }

        viewModel.reloadDataHandler = { [weak self] (isSuccess) in
            guard let self = self else { return }
            guard let isSuccess = isSuccess as? Bool,
                  isSuccess else {
                      self.showErrorAlert()
                      return
                  }
                self.carListTableView.reloadData()
        }
    }

    private func setTableView() {
        carListTableView.delegate = self
        carListTableView.dataSource = self
    }

    @IBAction func didTapViewInMapButton(_ sender: UIButton) {
        let carInMapView = CarInMapViewController.instantiateFromStoryBoard(.main)
        self.viewModel.inMap = true
        carInMapView.viewModel = self.viewModel
        carInMapView.resetdata = { [weak self] (_) in
            guard let self = self else { return }
            self.viewModel.inMap = false
            self.viewModel.fetchdata()
        }
        self.present(carInMapView, animated: true, completion: nil)
    }

    func showErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Something went wrong!", preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] action in
            guard let self = self else { return }
            self.viewModel.fetchdata()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension CardetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CarDetailsTableViewCell.reuseIdentifier()
        guard let carDetCell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                         for: indexPath) as? CarDetailsTableViewCell else {
            return UITableViewCell()
        }
        carDetCell.setUpdata(with: viewModel.getCarDetailsCellModelAtIndex(index: indexPath.row))
        return carDetCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
}
