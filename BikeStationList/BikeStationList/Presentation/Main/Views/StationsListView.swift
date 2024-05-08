//
//  StationsListView.swift
//  BikeStationList
//
//  Created by Ceboolion on 08/05/2024.
//

import UIKit
import RxSwift
import SnapKit

class StationsListView: UIView {
    
    var cellDidTappedClosure: ((StationListModel)->Void)?
    
    //MARK: - PRIVATE PROPERTIES
    private var viewModel: StationViewModel!
    private var tableView: UITableView!
    private var spinnerView: UIActivityIndicatorView!
    private let padding: CGFloat = CustomProperties.defaultPadding
    
    init(viewModel: StationViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PRIVATE METHODS
    private func setup() {
        configureTableView()
        configureSpinnerView()
        setupObservers()
        configureConstraints()
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BikeStationViewCell.self, forCellReuseIdentifier: BikeStationViewCell.reuseIdentifier)
    }
    
    private func configureSpinnerView() {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .customGreen
        spinnerView.backgroundColor = .white.withAlphaComponent(0.6)
        spinnerView.startAnimating()
    }
    
    private func configureConstraints() {
        addSubviews(tableView, spinnerView)
        tableView.snp.makeConstraints {
            $0.top.leading.equalTo(padding)
            $0.bottom.trailing.equalTo(-padding)
        }
        
        spinnerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - RX
    private func setupObservers() {
        bindTableViewList()
        bindSpinnerView()
    }
    
    private func bindTableViewList() {
        viewModel.stationListData
            .bind(to: tableView.rx.items(cellIdentifier: BikeStationViewCell.reuseIdentifier, 
                                         cellType: BikeStationViewCell.self)) { index, data, cell in
                cell.setCell(with: data)
            }
            .disposed(by: viewModel.disposeBag)
        
        tableView
            .rx
            .itemSelected
            .map(\.item)
            .bind { [weak self] row in
                guard let data = self?.viewModel.stationListData.value[row] else { return }
                self?.cellDidTappedClosure?(data)
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    private func bindSpinnerView() {
        viewModel.isSpinnerHiddenDriver
            .drive(spinnerView.rx.isHidden)
            .disposed(by: viewModel.disposeBag)
    }
    
}
