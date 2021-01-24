#include "settings.h"
#include "ui_settings.h"

Settings::Settings(QWidget *parent) : QDialog(parent),  steps(0), ui(new Ui::Settings), totalNumberOfFiles(0), totalNumOfWords(0.0), totalNumOfValidDocs(0) {
    ui->setupUi(this);

    QPalette SettingsLabel = ui->label->palette();
    SettingsLabel.setColor(ui->label->backgroundRole(), Qt::white);
    SettingsLabel.setColor(ui->label->foregroundRole(), Qt::white);
    ui->label->setPalette(SettingsLabel);

    QPalette questLabel = ui->questionLabels->palette();
    questLabel.setColor(ui->questionLabels->backgroundRole(), Qt::white);
    questLabel.setColor(ui->questionLabels->foregroundRole(), Qt::white);
    ui->questionLabels->setPalette(questLabel);
    /*
    QPixmap pix("../SearchEngine/Images/image.jpg");
    int w = ui->picLabel->width();
    int h = ui->picLabel->height();
    ui->picLabel->setPixmap(pix.scaled(w,h,Qt::KeepAspectRatio));
    */
    {
        ifstream inputFile("../SearchEngine/StopWords.txt");        // https://countwordsfree.com/stopwords
        string stopWordString;

        while(inputFile >> stopWordString){
        stopWordString.erase(remove_if(stopWordString.begin(),stopWordString.end(), [] (char it){
                return !(it == '\'' || (it >= 'a' && it <= 'z'));
                }), stopWordString.end());
            lowerCase(stopWordString);
            stopWords.emplace(stopWordString);
        }
    }
}

void Settings::on_MainMenu_Button_clicked(){
    // Closes current window.
    this->close();
}

void Settings::on_ClearFile_Button_clicked(){
    QMessageBox::StandardButton confirmation;

    // Warning window is displayed to confirm user selection
    confirmation = QMessageBox::warning(this, "Clear", "Are you sure?", QMessageBox::Yes| QMessageBox::No);

    // If user selects "Yes", AVL Tree & Hash Table & ~possibly~ index file is cleared
    if(confirmation == QMessageBox::Yes){
        if(words.size() != 0){
            words.clear();

        }
        std::ofstream ofs;
        ofs.open("../Index.txt", std::ofstream::out | std::ofstream::trunc);
        ofs.close();
        totalNumOfWords = 0;
        totalNumberOfFiles = 0;
        totalNumOfValidDocs = 0;


        top50Words.clear();
        fileNamesOnly.clear();
        allFileLocations.clear();

        words.clear();

        word_obj.theWord.clear();
        word_obj.word_Index.clear();
        word_obj.frequency = 0;



        QMessageBox::information(this, "Clear", "Index has been cleared");
        this->close();
    }
    else{}
}

void Settings::on_EditCourses_Button_clicked(){
    QString file_name;
    // Opens local file directory, user is able to navigate to select desired folder
    // file_name = QFileDialog::getExistingDirectory(this, "Open Folder", QDir::homePath());

    // Opens local build folder
    file_name = QFileDialog::getExistingDirectory(this,"Open Folder","../");

    // QString is converted and saved as a standard string
    string fileName = file_name.toStdString();

    // If no file was selected, display warning message
    if(fileName == ""){
        QString noFile = "Nothing was selected!\n";
        QString tryAgain = "Please select valid path to a folder";
        QMessageBox::warning(this,"Error", noFile + tryAgain);
    }

    else{
        //getTotalNumberOfFiles(fileName);

        pd = new QProgressDialog("Selected Directory: " + parsePathName(fileName), "Cancel", 0, totalNumberOfFiles);

        QPalette palette1;
        QBrush brush2(QColor(78, 51, 169, 255));
        brush2.setStyle(Qt::SolidPattern);
        palette1.setBrush(QPalette::Active, QPalette::Highlight, brush2);
        palette1.setBrush(QPalette::Inactive, QPalette::Highlight, brush2);
        QBrush brush3(QColor(204, 199, 197, 255));
        brush3.setStyle(Qt::SolidPattern);
        palette1.setBrush(QPalette::Disabled, QPalette::Highlight, brush3);
        pd->setPalette(palette1);

        pd->setWindowTitle("Parsing Index");
        connect(pd,&QProgressDialog::canceled, this, &Settings::cancel);

        // A vector is created containing every path name for each file in folder
        //setFileLocations(fileName);

        QMessageBox::information(this, "Complete", "Index has been parsed succesfully");
        //myBar->close();
    }
}

// void Settings::parse(string fileName){
//     //Document currentDocument = parseJSON(fileName);
//
//     string caseTitle, html_Section, htmlLawbox_Section, plainText_Section;
//
//     int documentID = currentDocument["id"].GetInt();
//
//     caseTitle = currentDocument["absolute_url"].GetString();
//     getCaseTitle(caseTitle);
//
//     if(currentDocument.HasMember("html") && currentDocument["html"].IsString()){
//         html_Section = currentDocument["html"].GetString();
//         parseHTML(html_Section);
//         split2Word(html_Section);
//     }
//
//     if(currentDocument.HasMember("html_lawbox") && currentDocument["html_lawbox"].IsString()){
//         htmlLawbox_Section = currentDocument["html_lawbox"].GetString();
//         parseHTML(htmlLawbox_Section);
//         split2Word(htmlLawbox_Section);
//     }
//
//     plainText_Section = currentDocument["plain_text"].GetString();
//     split2Word(plainText_Section);
//
//     if(html_Section != "" && isValidDoc){
//         unordered_map<string,int> theOriginalMap;
//
//         insert(theOriginalMap,html_Section);
//         insert(theOriginalMap,htmlLawbox_Section);
//         insert(theOriginalMap,plainText_Section);
//
//         insert(entireMap,html_Section);
//         insert(entireMap,htmlLawbox_Section);
//         insert(entireMap,plainText_Section);
//
//         //for(const auto& pair : sortMap(theOriginalMap) ){
//         //    size_t count = 0;
//
//         //    if(count == 0){
//         //        if(word_obj.theWord.size() == 0){
//         //            word_obj.theWord.push_back(pair.first.get());
//
//         //            string freq = std::to_string(pair.second.get());
//         //            string newWord = pair.first.get() + " " + std::to_string(documentID) + ".json " + freq;
//         //            word_obj.word_Index.push_back(newWord);
//         //            continue;
//         //        }
//         //    }
//
//         //    while((count != word_obj.theWord.size()) && (word_obj.theWord[count] != pair.first.get())){
//         //        count++;
//         //    }
//
//         //    if((count == word_obj.theWord.size()) && (word_obj.word_Index.size() != 0)){
//         //        word_obj.theWord.push_back(pair.first.get());
//
//         //        string newWord = pair.first.get() + " " + std::to_string(documentID) + ".json " + std::to_string(pair.second.get());
//         //        word_obj.word_Index.push_back(newWord);
//         //    }
//         //    else if((count != word_obj.theWord.size()) && (word_obj.theWord.at(count) == pair.first.get()) && (word_obj.word_Index.size() != 0)){
//         //        word_obj.word_Index.at(count) += " " + std::to_string(documentID) + ".json " + std::to_string(pair.second.get()) + " ";
//         //    }
//         //}
//     }
// }

void Settings::insert(unordered_map<string,int>& theMap, string aSection){
    string aString;
    istringstream aStream(aSection);
    while(getline(aStream,aString,' ')){
        if(theMap.find(aString) != theMap.end()) {
            theMap[aString]++;
        }
        else{
            theMap.insert(unordered_map<string,int>::value_type(aString,1));
        }
    }
}

string& Settings::parseHTML(string& section){
    for(size_t start = 0; start < section.size(); start++){
        if(section[start] == '<'){
            size_t end = start;

            while(section[end] != '>' && end < section.size()){
                end++;
            }
            section.erase(start, end - start + 1);
            start--;
        }
    }
    return section;
}

QString Settings::parsePathName(string section){
    section.erase(0,2);
    for(size_t start = 0; start < section.size(); start++){
        if(section[start] == '/'){
            size_t end = start + 1;

            while(section[end] != '/' && end < section.size()){
                end++;
                if(end == section.size()){
                    return QString::fromStdString(section);
                }
            }
            section.erase(start, end - start);
            start--;
        }
    }

    return QString::fromStdString(section);
}

string& Settings::split2Word(string& section){
    string aWord;
    int flagCount = 0;
    istringstream stream(section);
    unordered_set<string> tempWords;

    while(stream >> aWord){

        removeStopWords(aWord);

        if(aWord == "certiorari" || aWord == "petition"){
            tempWords.insert(aWord);
            if(aWord == "certiorari"){
                flagCount = 1;
            }
            else{
                flagCount = 2;
            }
        }
        else if((aWord == "denied" || aWord == "for") && flagCount >= 1){
            if(aWord == "denied" && (flagCount == 1)){
                section = "";
                tempWords.clear();
                isValidDoc = false;
                return section;
            }
            flagCount = 3;
            tempWords.insert(aWord);
        }
        else if(aWord == "rehearing" && flagCount == 3){
            section = "";
            tempWords.clear();
            isValidDoc = false;
            return section;
        }

        else{
            flagCount = 0;
            isValidDoc = true;
            if(aWord != ""){
                tempWords.insert(aWord);
            }
        }
    }

    if(isValidDoc == true){
        string tempWord = section = "";
        for(auto theIterator = tempWords.begin(); theIterator != tempWords.end(); theIterator++){
            if((*theIterator).size() != 0){
                tempWord = *theIterator;
                //Porter2Stemmer::stem(tempWord);
                // Test
                // cout << *theIterator << " --> " << tempWord << endl;
                words.insert(tempWord);
                section += tempWord + " ";
                ++totalNumOfWords;
            }
        }
        return section;
    }
    return section;
}

string& Settings::getCaseTitle(string& absolute_string){
    string caseTitle;
    string opponent1;
    string opponent2;
    istringstream stream1(absolute_string);

    for(int i = 0; i < 4; i++){
        getline(stream1,opponent1,'/');
    }

    opponent1[0] = char(toupper(opponent1[0]));

    istringstream stream2(opponent1);
    while(getline(stream2,opponent2,'-')){
        if(opponent2 == "v"){
            caseTitle += "Vs.";
        }

        else{
            opponent2[0] = char(toupper(opponent2[0]));
            caseTitle += opponent2;
        }

        caseTitle += " ";
    }

    caseTitle.erase(caseTitle.size() - 1);
    absolute_string = caseTitle;

    return absolute_string;
}

string& Settings::removeStopWords(string& word){

    if(word.size() == 0){
        return word;
    }

    lowerCase(word);

    word.erase(remove_if(word.begin(),word.end(), [] (char it){
        return !((it >= 'a' && it <= 'z') || it == '\'');
    }), word.end());

    if(stopWords.count(word) > 0){
        word = "";
        return word;
    }

    return word;
}

string& Settings::lowerCase(string& word){
    for(size_t aSize = 0; aSize < word.size(); aSize++){
        word[aSize] = char(tolower(word[aSize]));
    }
    return word;
}

bool Settings::isStopWord(string& word){
    if(word.size() == 0){
        return false;
    }

    return stopWords.count(word) > 0;
}

// void Settings::setFileLocations(string& fileName){
//     //persistentIndex.open("../Index.txt" , fstream::in | fstream::out | fstream::app);
//     pd->setValue(steps);
//
//
//
//     filesystem::directory_iterator end;
//     for(filesystem::directory_iterator theIterator(fileName) ; theIterator != end; ++theIterator){
//
//         QCoreApplication::processEvents();
//         // directory iterator is first converted to a path
//         filesystem::path dirToPath = *theIterator;
//         // path directory is converted to a string
//         string pathToString = dirToPath.string();
//
//         int i = 0;
//         while(i != int(pathToString.size())){
//             if(pathToString[i] == '\\'){
//                 pathToString[i] = '/';
//             }
//             i++;
//         }
//
//         size_t counter = 0;
//
//         if(counter == 0){
//             if(allFileLocations.size() == 0){
//                 parse(pathToString);
//
//                 if(isValidDoc == true){
//                     // string is appended to end of vector
//                     allFileLocations.push_back(pathToString);
//
//                     // string is parsed to filename, and added to vector
//                     ++totalNumOfValidDocs;
//                 }
//
//                 steps++;
//                 pd->setValue(steps);
//
//                 continue;
//             }
//         }
//         bool aFlag = true;
//         while(counter != allFileLocations.size()){
//             if(parsePathName(pathToString) == parsePathName(allFileLocations[counter])){
//                 aFlag = false;
//                 break;
//             }
//             counter++;
//         }
//
//         if(aFlag == false){
//
//         }
//         else{
//             parse(pathToString);
//
//             if(isValidDoc == true){
//                 // string is appended to end of vector
//                 allFileLocations.push_back(pathToString);
//
//                 // string is parsed to filename, and added to vector
//                 ++totalNumOfValidDocs;
//             }
//         }
//
//         steps++;
//         pd->setValue(steps);
//     }
//
//     setTop50Words();
//
//    // persistentIndex.open("../Index.txt" , fstream::in | fstream::out | fstream::app);
//    // vector<string> indexVector = getIndex();
//    // for(size_t counter = 0; counter < indexVector.size(); counter++){
//      //   persistentIndex << "--> "  << indexVector[counter] << " \n";
//    // }
//     //persistentIndex.close();
// }

vector<string> Settings::getIndex(){
    return word_obj.word_Index;
}


// int& Settings::getTotalNumberOfFiles(string& fileName){
//     filesystem::directory_iterator end;
//     for(filesystem::directory_iterator theIterator(fileName) ; theIterator != end; ++theIterator){
//         ++totalNumberOfFiles;
//     }
//
//     return totalNumberOfFiles;
// }

vector<string> Settings::getTop50Words(){
    return top50Words;
}

vector<string> Settings::getFileLocations(){
        return allFileLocations;
}

int Settings::getTotalNumValidDocs(){
    if(totalNumOfValidDocs > 0){
        return totalNumOfValidDocs;
    }
    return 0;
}

double Settings::getTotalNumOfWords(){
    if(totalNumOfWords > 0.0){
        return totalNumOfWords;
    }

    return 0;
}

void Settings::cancel(){
    theTimer->stop();
}

// Destructor
Settings::~Settings(){
    delete ui;
}
