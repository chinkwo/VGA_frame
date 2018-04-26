#UART_VGA   

[TOC]  
  
  -----------   
##项目概况  
通过RS232总线实现PC端和FPGA端数据组的通信，为了防止误操作或者干扰导致的通信错误，在实现PC机和FPGA端通信中加入相应的帧协议，只有在接收端收到正确的镇协议时才会对发送来的数据进行解析处理。（帧协议是从千兆以太网的帧协议中截取的一部分作为练习）  
##结构框图  
![结构框图](VGA_frame/img-folder/结构框图.png)  
##效果描述  
上电后显示三个彩条，并在屏幕中选取一块200*200 pixel的区域，通过串口发送图片的数据，200*200pixel的区域会被图像所天聪，最后显示一张完整的图片，并在该基础上，控制200*200图片的范围，使图片移动。  
##应用案例  
由于串口的数据传输速度和VGA显示帧率不一致，所以在该项目中用到的数据的缓存，可以根据不同的帧协议将不同的图片信息发送到不同的缓存区间，然后再硬件上将不同的缓存区间连接到不同的硬件设备上，就可以通过一个PC机控制多个硬件显示不同的图片。
