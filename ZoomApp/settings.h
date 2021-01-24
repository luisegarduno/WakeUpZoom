#ifndef SETTINGS_H
#define SETTINGS_H

#include <QDir>
#include <QDebug>
#include <QTimer>
#include <sstream>
#include <fstream>
#include <QDialog>
#include <QString>
#include <QThread>
#include <iterator>
#include <iostream>
// #include <filesystem>
#include <QFileDialog>
#include <QMessageBox>
#include <QProgressBar>
#include <unordered_set>
#include <unordered_map>
#include <QFutureWatcher>
#include <QProgressDialog>


using std::sort;
using std::copy;
using std::fopen;
using std::string;
using std::vector;
using std::fstream;
using std::ifstream;
using std::remove_if;
using std::istringstream;
using std::unordered_set;
using std::unordered_map;
using std::ostream_iterator;

// namespace filesystem = std::filesystem;

namespace Ui {
    class Settings;
}

struct wordObj{
    vector<string> theWord;
    int frequency;
    vector<string> word_Index;

};

class Settings : public QDialog{
    Q_OBJECT

    public:
        // Explicit Constructor
        explicit Settings(QWidget *parent = nullptr);

        // Member function used to parse -> HTML -> split section into words
        // -> turn into lower case -> remove stop words
        void parse(string);

        // An HTML section is sent in, removes any characters between '<' and '>'
        string& parseHTML(string&);

        QString parsePathName(string);

        // if referenced string parameter matches word on stop word list, update and
        // return string as "", else word is not a stop word and return unchanged
        string& removeStopWords(string&);

        // A string is passed as a reference parameter, the char
        // is then converted to lowerscase(if not already) then returned as reference
        string& lowerCase(string&);

        // Send string(file name) as parameter, return as Document type
        // Document parseJSON(string);

        // A document section is sent as string parameter, split into word
        string& split2Word(string&);
        unordered_map<string,int> entireMap;
        void insert(unordered_map<string,int>&,string);

        // Checks to see if string parameter matches any of stops words
        bool isStopWord(string&);

        // returns total number of valid documents
        int getTotalNumValidDocs();
        double getTotalNumOfWords();
        int& getTotalNumberOfFiles(string&);

        void setTop50Words();
        vector<string> getTop50Words();

        vector<string> getFileLocations();

        string& getCaseTitle(string&);

        vector<string> getIndex();

        int steps;

        QProgressDialog * pd;
        QTimer * theTimer;
        void cancel();

        // Maintenance Class Destructor
        ~Settings();
    private slots:

        // Clears contents in AVL Tree & Hash Table, also ~possibly~ deletes index file
        void on_ClearFile_Button_clicked();

        // Open up local file directory, and User is able to select Folder Directory Path
        void on_EditCourses_Button_clicked();

        // Closes "Maintenance" windows and returns to "Mode" (Main Menu)
        void on_MainMenu_Button_clicked();

private:
        // Maintenance UI Pointer
        Ui::Settings *ui;

        fstream persistentIndex;

        int totalNumberOfFiles;

        double totalNumOfWords;

        vector<string> top50Words;

        wordObj word_obj;

        // add word to persistent index file
        void addToPersistentIndex(const string);

        // Total number of valid documents (not denied)
        int totalNumOfValidDocs;

        // vector containing allFileLocations as string types
        vector<string> allFileLocations;

        // vector containing the name of the files
        vector<string> fileNamesOnly;

        // All words in all documents
        unordered_set<string> words;

        // Used as a flag to check if document is valid (not denied)
        bool isValidDoc;

        // Unordered set of strings containing all list of stop words
        unordered_set<string> stopWords;

        // iterates through folder and converts each directory path into a string
        void setFileLocations(string&);

};

#endif // SETTINGS_H
