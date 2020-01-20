import sys

from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *


from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure
import matplotlib.pyplot as plt

import random

class App(QWidget):

    def __init__(self):
        super().__init__()
        self.left = 10
        self.top = 10
        self.title = 'SHOW PSD'
        self.width = 640
        self.height = 400
        self.initUI()

    def initUI(self):
        self.setWindowTitle(self.title)
        self.setGeometry(self.left, self.top, self.width, self.height)

        self.m = PlotCanvas( None , width=8, height=4 )

        labelPSD = QtWidgets.QLabel('PSD @(dofs):')
        labelPSD.setMaximumWidth(100)

        self.count2 = QtWidgets.QSpinBox(self)
        self.count2.value = 1
        self.count2.setPrefix('dof. ')
        self.count2.setRange(1, 10)    
        self.count2.setMaximumWidth(100) # Largeur de la cellule
        self.count2.valueChanged.connect(self.updateCount2)

        self.count1 = QtWidgets.QSpinBox(self)
        self.count1.value = 1
        self.count1.setPrefix('dof. ')
        self.count1.setRange(1, 10)
        self.count1.setMaximumWidth(100) # Largeur de la cellule
        self.count1.valueChanged.connect(self.updateCount1)

        layout  = QtWidgets.QVBoxLayout()
        layoutL = QtWidgets.QVBoxLayout()
        layoutR = QtWidgets.QHBoxLayout()

        layoutL.addWidget(self.m) 

        layoutR.addWidget(labelPSD)
        layoutR.addWidget(self.count1)
        layoutR.addWidget(self.count2)

        layout.addLayout(layoutL)
        layout.addLayout(layoutR)
        layoutR.addStretch(1)

        self.setLayout(layout)    
        self.setWindowTitle('SHOW PSD _GUI')    
        self.show()

    @QtCore.pyqtSlot(int)
    def updateCount2(self, value):
        self.m.actualizePlot(value)

    @QtCore.pyqtSlot(int)
    def updateCount1(self, value):
        self.m.actualizePlot(value)

class PlotCanvas(FigureCanvas):

    def __init__(self, parent=None, width=5, height=4, dpi=100):
        fig = Figure(figsize=(width, height), dpi=dpi)
        self.axes = fig.add_subplot(111)

        FigureCanvas.__init__(self, fig)
        self.setParent(parent)

        FigureCanvas.setSizePolicy(self,
                QSizePolicy.Expanding,
                QSizePolicy.Expanding)
        FigureCanvas.updateGeometry(self)
        self.plot(10)


    def plot(self, MaxRange):
        data = [random.random() for i in range(MaxRange)]
        self.ax = self.figure.add_subplot(111)
        self.ax.plot(data, 'r-')
        self.ax.set_title('PSD Nodales')
        self.ax.grid(b=bool)
        self.draw()

    def actualizePlot( self, MaxRange):
        self.ax.lines[0].remove()
        data = [random.random() for i in range(MaxRange*10)]
        self.ax.plot(data, 'r-')
        self.draw()


if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = App()
    sys.exit(app.exec_())