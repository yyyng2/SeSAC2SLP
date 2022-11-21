//
//  BirthCheckView.swift
//  SeSAC2SLP
//
//  Created by Y on 2022/11/10.
//

import UIKit

final class BirthCheckView: BaseView {
    let BirthViewInfoLabel: CustomSignLabel = {
       let label = CustomSignLabel()
        label.numberOfLines = 1
        label.text = """
                    생년월일을 알려주세요
                    """
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        picker.sizeToFit()
        picker.locale = Locale(identifier: "ko-KR")
//        picker.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return picker
    }()
    
    let yearTextField: CustomBirthTextField = {
       let textfield = CustomBirthTextField()
        textfield.placeholder = "1990"
        return textfield
    }()
    
    let yearLabel: CustomBirthLabel = {
       let label = CustomBirthLabel()
        label.text = "년"
        return label
    }()
    
    let monthTextField: CustomBirthTextField = {
       let textfield = CustomBirthTextField()
        textfield.placeholder = "1"
        return textfield
    }()
    
    let monthLabel: CustomBirthLabel = {
       let label = CustomBirthLabel()
        label.text = "월"
        return label
    }()
    
    let dayTextField: CustomBirthTextField = {
       let textfield = CustomBirthTextField()
        textfield.placeholder = "1"
        return textfield
    }()
    
    let dayLabel: CustomBirthLabel = {
       let label = CustomBirthLabel()
        label.text = "일"
        return label
    }()
    
    let nextButton: CustomSignButton = {
       let button = CustomSignButton()
        button.backgroundColor = Constants.brandColor.green
        button.setTitle("다음", for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
         
         view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
         view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 8
         return view
    }()
    
    override func configure() {
        backgroundColor = Constants.BaseColor.white
        
        [BirthViewInfoLabel, stackView, nextButton].forEach {
            self.addSubview($0)
        }
        
        [yearTextField, yearLabel, monthTextField, monthLabel, dayTextField, dayLabel].forEach {
              self.stackView.addArrangedSubview($0)
          }
    }
    
    override func setConstraints() {
        BirthViewInfoLabel.snp.makeConstraints { make in
            make.centerX.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
        }
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.1)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.75)
        }
        nextButton.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.9)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.07)
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1)
        }
    }
}
