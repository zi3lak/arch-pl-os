#!/usr/bin/env python3
import sys, math
from pathlib import Path
from PySide6.QtCore import Qt,QTimer,QRectF,QPointF
from PySide6.QtGui import QColor,QPainter,QPen,QFont,QPixmap,QLinearGradient
from PySide6.QtWidgets import QApplication,QWidget
BASE=Path.home()/'.local/share/arch-pl-os'
class Powitanie(QWidget):
 def __init__(self):
  super().__init__(); self.setWindowTitle('ARCH PL OS — Powitanie'); self.setProperty('class','arch-pl-powitanie'); self.setWindowFlags(Qt.FramelessWindowHint|Qt.Tool|Qt.WindowStaysOnTopHint); self.setAttribute(Qt.WA_TranslucentBackground); self.resize(1120,650); g=QApplication.primaryScreen().availableGeometry(); self.move(g.center()-self.rect().center()); self.t=0.; self.logo=QPixmap(str(BASE/'assets/logo.png')); self.timer=QTimer(self); self.timer.timeout.connect(self.tick); self.timer.start(16); QTimer.singleShot(6000,self.zamknij)
 def tick(self): self.t+=.016; self.update()
 def zamknij(self):
  self.fade=QTimer(self); self.fade.timeout.connect(self.zanik); self.fade.start(16)
 def zanik(self):
  self.setWindowOpacity(max(0,self.windowOpacity()-.05))
  if self.windowOpacity()<.03: QApplication.quit()
 def paintEvent(self,e):
  p=QPainter(self); p.setRenderHint(QPainter.Antialiasing); r=self.rect(); bg=QLinearGradient(0,0,r.width(),r.height()); bg.setColorAt(0,QColor(9,10,13,248)); bg.setColorAt(1,QColor(24,25,30,248)); p.setBrush(bg); p.setPen(QPen(QColor('#dc0034'),2)); p.drawRoundedRect(QRectF(r).adjusted(2,2,-2,-2),22,22)
  p.setPen(QPen(QColor(255,255,255,12),1)); off=int(self.t*12)%48
  for x in range(-48+off,r.width(),48): p.drawLine(x,0,x,r.height())
  logo=self.logo.scaled(230,230,Qt.KeepAspectRatio,Qt.SmoothTransformation); p.drawPixmap(105,125,logo)
  p.setPen(QColor('#f7f7f9')); p.setFont(QFont('JetBrainsMono Nerd Font',31,QFont.Bold)); p.drawText(405,145,'ARCH PL OS')
  p.setPen(QColor('#dc0034')); p.setFont(QFont('JetBrainsMono Nerd Font',11,QFont.Bold)); p.drawText(409,182,'POLSKI  •  PROSTY  •  TWÓJ')
  dane=[('JĘZYK SYSTEMU','POLSKI'),('ŚRODOWISKO GRAFICZNE','GOTOWE'),('USTAWIENIA PRYWATNOŚCI','AKTYWNE'),('PULPIT','URUCHOMIONY')]
  for i,(a,b) in enumerate(dane):
   y=265+i*56; post=min(1,max(0,(self.t-.3-i*.38)*2.5)); p.setPen(QColor('#a5a8b0')); p.setFont(QFont('JetBrainsMono Nerd Font',10)); p.drawText(409,y,a); p.setPen(QColor('#f7f7f9') if b!='AKTYWNE' else QColor('#58d68d')); 
   if post>.8: p.drawText(830,y,b)
  p.setPen(QColor('#58d68d')); p.drawText(409,535,'●  MOŻESZ ZACZYNAĆ')
  p.setPen(QColor(220,0,52,150)); p.drawLine(45,606,1075,606)
app=QApplication(sys.argv); app.setApplicationName('arch-pl-powitanie'); w=Powitanie(); w.show(); sys.exit(app.exec())
