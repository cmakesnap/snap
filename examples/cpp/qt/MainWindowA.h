#pragma once

#include "ui_MainWindow.h"
#include <QtGui/QMainWindow>

/** 
 * The main application window
 */
class MainWindowA : public QMainWindow, private Ui::MainWindow
{
	Q_OBJECT
public:
	MainWindowA();
	virtual ~MainWindowA();
	
	signals:
	void foo();
	
	public slots:
  void bar();   	
  
};


