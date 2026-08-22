#!/usr/bin/env python3
import sys,math,random,time
from pathlib import Path
from PySide6.QtCore import Qt,QTimer,QPointF
from PySide6.QtGui import QColor,QPainter,QPen,QFont,QPixmap,QLinearGradient,QCursor
from PySide6.QtWidgets import QApplication,QWidget
BASE=Path.home()/'.local/share/arch-pl-os'
class Wygaszacz(QWidget):
 def __init__(self,screen,nr):
  super().__init__(); self.nr=nr; self.t=random.random()*8; self.logo=QPixmap(str(BASE/'assets/logo.png')); self.setWindowTitle('ARCH PL OS — Wygaszacz'); self.setWindowFlags(Qt.FramelessWindowHint|Qt.WindowStaysOnTopHint|Qt.Tool); self.setGeometry(screen.geometry()); self.setCursor(QCursor(Qt.BlankCursor)); random.seed(100+nr); self.punkty=[(random.random(),random.random(),random.uniform(.2,.7)) for _ in range(55)]; self.timer=QTimer(self); self.timer.timeout.connect(self.tick); self.timer.start(16)
 def tick(self): self.t+=.016; self.update()
 def keyPressEvent(self,e): QApplication.quit()
 def mousePressEvent(self,e): QApplication.quit()
 def paintEvent(self,e):
  p=QPainter(self); p.setRenderHint(QPainter.Antialiasing); W,H=self.width(),self.height(); bg=QLinearGradient(0,0,W,H); bg.setColorAt(0,QColor('#07080a')); bg.setColorAt(1,QColor('#15161a')); p.fillRect(self.rect(),bg)
  p.setPen(QPen(QColor(255,255,255,9),1)); przes=(self.t*10)%72
  for x in range(int(-72+przes),W,72): p.drawLine(x,0,x,H)
  for y in range(int(-72+przes),H,72): p.drawLine(0,y,W,y)
  for x,y,s in self.punkty:
   xx=(x*W+self.t*10*s)%W; yy=y*H+math.sin(self.t*s+x*8)*20; p.setPen(Qt.NoPen); p.setBrush(QColor(220,0,52,int(45+90*s))); p.drawEllipse(QPointF(xx,yy),2+s*2,2+s*2)
  cx=W*.5+math.sin(self.t*.18+self.nr)*W*.14; cy=H*.46+math.cos(self.t*.22)*H*.05
  for i in range(5): rr=min(W,H)*(.13+i*.026); p.setPen(QPen(QColor(220,0,52,max(10,55-i*9)),2)); p.setBrush(Qt.NoBrush); p.drawEllipse(QPointF(cx,cy),rr,rr)
  logo=self.logo.scaled(int(H*.27),int(H*.27),Qt.KeepAspectRatio,Qt.SmoothTransformation); p.drawPixmap(int(cx-logo.width()/2),int(cy-logo.height()/2),logo)
  teraz=time.localtime(); zegar=time.strftime('%H:%M:%S',teraz); data=time.strftime('%d.%m.%Y',teraz); p.setPen(QColor('#f7f7f9')); p.setFont(QFont('JetBrainsMono Nerd Font',42,QFont.Light)); szer=p.fontMetrics().horizontalAdvance(zegar); p.drawText(W-szer-90,105,zegar); p.setPen(QColor('#a5a8b0')); p.setFont(QFont('JetBrainsMono Nerd Font',10)); p.drawText(W-250,140,data)
  p.setPen(QColor('#f7f7f9')); p.setFont(QFont('JetBrainsMono Nerd Font',18,QFont.Bold)); p.drawText(85,H-120,'ARCH PL OS'); p.setPen(QColor('#dc0034')); p.setFont(QFont('JetBrainsMono Nerd Font',9,QFont.Bold)); p.drawText(88,H-88,'POLSKI  •  PROSTY  •  TWÓJ')
app=QApplication(sys.argv); app.setApplicationName('arch-pl-wygaszacz'); okna=[]
for i,s in enumerate(app.screens()): w=Wygaszacz(s,i); w.showFullScreen(); okna.append(w)
sys.exit(app.exec())
