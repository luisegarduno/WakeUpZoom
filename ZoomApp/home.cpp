#include "home.h"
#include "ui_home.h"

Home::Home(QWidget *parent): QMainWindow(parent), ui(new Ui::Home){
    ui->setupUi(this);

    QPalette welcomeLabel = ui->Welcome_Label->palette();
    welcomeLabel.setColor(ui->Welcome_Label->backgroundRole(), Qt::white);
    welcomeLabel.setColor(ui->Welcome_Label->foregroundRole(), Qt::white);
    ui->Welcome_Label->setPalette(welcomeLabel);

    QPalette selectModeLabel = ui->SelectMode_Group->palette();
    selectModeLabel.setColor(ui->SelectMode_Group->backgroundRole(), Qt::white);
    selectModeLabel.setColor(ui->SelectMode_Group->foregroundRole(), Qt::white);
    ui->SelectMode_Group->setPalette(selectModeLabel);

    /*
    QPixmap pix("../SearchEngine/Images/image.jpg");
    int w = ui->picLabel->width();
    int h = ui->picLabel->height();
    ui->picLabel->setPixmap(pix.scaled(w,h,Qt::KeepAspectRatio));
    */
    // Create new Maintenance window object on HEAP
    configureMode = new Settings(this);

    // Create new Interactive window object on HEAP
    //runMode = new Start(this);

}

void Home::on_Settings_Button_clicked(){

    configureMode->setGeometry(
        QStyle::alignedRect(
                    Qt::LeftToRight,
                    Qt::AlignCenter,
                    configureMode->size(),
                    QGuiApplication::primaryScreen()->availableGeometry()
        )
    );

    configureMode->show();
}

void Home::on_Start_Button_clicked(){
    fstream indexChecker("../Index.txt");
    if(configureMode->getTotalNumValidDocs() != 0 || indexChecker.is_open()){
        indexChecker.close();
        //runMode->numberOfOpinions = configureMode->getTotalNumValidDocs();
        //runMode->avgIndexedWords = configureMode->getTotalNumOfWords() / configureMode->getTotalNumValidDocs();
        //runMode->top50Words = configureMode->getTop50Words();

        if(configureMode->getTotalNumValidDocs() > 0){
            // Create new Interactive window object on HEAP
            opinionLocations = configureMode->getFileLocations();

            //configureMode->setGeometry(
            //    QStyle::alignedRect(
            //                Qt::LeftToRight,
            //                Qt::AlignCenter,
            //                runMode->size(),
            //                QGuiApplication::primaryScreen()->availableGeometry()
            //    )
            //);
        }

        //runMode->show();
    }

    else if(!indexChecker.is_open()){
        QString noFile = "Index not found\n";
        QString tryAgain = "Please select valid path to a folder";
        QMessageBox::warning(this,"Error", noFile + tryAgain);
    }
}

Home::~Home(){

    fstream persistentIndex;
    persistentIndex.open("../Index.txt" , fstream::in | fstream::out | fstream::app);
    vector<string> indexVector = configureMode->getIndex();
    for(size_t counter = 0; counter < indexVector.size(); counter++){
        persistentIndex << "--> "  << indexVector[counter] << " \n";
    }
    persistentIndex.close();


    delete ui;
}

