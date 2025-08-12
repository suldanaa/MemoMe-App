
//
//  NotesViewController.swift
//  MemoMe
//
//  Created by Suldana Afrah on 8/11/25.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    private var currentEntry: DiaryEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Set up text view
        textView.delegate = self
        // Set up save button action
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        // Check if there's an existing entry for today
        loadEntryForSelectedDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadEntryForSelectedDate()
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        loadEntryForSelectedDate()
    }
    
    @objc private func saveButtonTapped() {
        guard !textView.text.isEmpty && textView.text != "Type here..." else {
            showAlert(title: "Empty Entry", message: "Please write something before saving.")
            return
        }
        
        if let existingEntry = currentEntry {
            // Update existing entry
            var updatedEntry = existingEntry
            updatedEntry.content = textView.text
            updatedEntry.date = datePicker.date
            updatedEntry.save()
        } else {
            // Create new entry
            let newEntry = DiaryEntry(content: textView.text, date: datePicker.date)
            newEntry.save()
        }
        
        showAlert(title: "Saved!", message: "Your diary entry has been saved.")
        loadEntryForSelectedDate()
    }
    
    private func loadEntryForSelectedDate() {
        let entries = DiaryEntry.getEntries(for: datePicker.date)
        
        if let entry = entries.first {
            currentEntry = entry
            textView.text = entry.content
            textView.textColor = UIColor(red: 0.86, green: 0.65, blue: 0.71, alpha: 1.0)
        } else {
            currentEntry = nil
            textView.text = "Type here..."
            textView.textColor = UIColor(red: 0.86, green: 0.65, blue: 0.71, alpha: 1.0)
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITextViewDelegate
extension NotesViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type here..." {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type here..."
        }
    }
}
