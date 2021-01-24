#ifndef HOME_H
#define HOME_H

#include <QStyle>
#include <QPixmap>
#include <QScreen>
#include <iostream>
#include "settings.h"
#include <QMainWindow>
#include <QDesktopWidget>
#include <QGuiApplication>

QT_BEGIN_NAMESPACE
    namespace Ui{ class Home; }
QT_END_NAMESPACE

class Home : public QMainWindow{
    Q_OBJECT

    public:
        friend class Settings;

        // Constructor
        Home(QWidget *parent = nullptr);

        // Home Class Destructor
        ~Home();

    private slots:
        // If pressed, will go to "Settings" class, and open new window
        void on_Settings_Button_clicked();

        // If pressed, will go to "Start" class, and open new windows
        void on_Start_Button_clicked();

    private:
        // Mode UI Pointer
        Ui::Home *ui;

        // Maintenance Object Pointer
        Settings * configureMode;

        // vectors containing paths & file names
        vector<string> opinionLocations;
};

#endif // HOME_H
