#include "home.h"
#include <cstdio>
#include <QStyle>
#include <QScreen>
#include <QApplication>
#include <QDesktopWidget>
#include <QGuiApplication>

using namespace std;

int main(int argc, char *argv[]) {
    QApplication theGUI(argc, argv);
    // Fast Icon by Taufik Ramadhan on Iconscout
    theGUI.setWindowIcon(QIcon("../WakeUpZoom/Images/fast.svg"));

    Home main_menu;
    main_menu.setGeometry(
                QStyle::alignedRect(
                    Qt::LeftToRight,
                    Qt::AlignCenter,
                    main_menu.size(),
                    QGuiApplication::primaryScreen()->availableGeometry()
                )
    );

    main_menu.show();

    return theGUI.exec();
}
