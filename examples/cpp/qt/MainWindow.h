#pragma once

#include "ui_MainWindow.h"
#include <QtGui/QMainWindow>

/** 
 * The main application window
 */
class MainWindow : public QMainWindow, private Ui::MainWindow
{
	Q_OBJECT
public:
	MainWindow();
	virtual ~MainWindow();
	
	signals:
	void foo();
	
	public slots:
  void bar();   	
  
};


