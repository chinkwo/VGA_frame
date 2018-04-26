module		vga_frame(
		input		wire				sclk		,
		input		wire				rst_n		, 
		input		wire				rx      ,
		output	wire					h_sync		,
		output	wire					v_sync		,
		output	wire[2:0]		r					,
		output	wire[2:0]		g					,
		output	wire[1:0]		b
);

wire					rx_bit_flag		;//to		U2 
wire[3:0]			rx_bit_cnt		;//to  	U2
wire					tx_bit_flag		;//to		U3 
wire[3:0]			tx_bit_cnt	  ;//to 	U3
wire[7:0]			po_data				;//to		U4  
wire					rx_flag				;//to 	U1
wire[7:0]			tx_data				;
wire					tx_flag1			;//to 	U3
wire					vga_clk				;
//bps例化
uart_bps_rx	U1(
.sclk					(sclk				),//from top
.rst_n				(rst_n			),//from top
.rx_flag			(rx_flag		),//from U2
.tx_flag			(tx_flag		),//from U3
.rx_bit_flag	(rx_bit_flag),//to	U2
.rx_bit_cnt		(rx_bit_cnt	),//to  U2
.tx_bit_flag	(tx_bit_flag),//to	U3
.tx_bit_cnt	  (tx_bit_cnt	) //to  U3
);

//rx例化
uart_rx	U2(
.sclk				(sclk				),//from	top
.rst_n			(rst_n			),//from	top
.rx					(rx					),//from	top
.rx_bit_cnt	(rx_bit_cnt	),//from	U1
.rx_bit_flag(rx_bit_flag),//from	U1
.po_data		(po_data		),//to		U3	 
.rx_flag		(rx_flag		),//to 		U1
.po_flag		(po_flag		)	//to 		U4
	
);
     

//frame例化               
fram_ctrl	U4(
.sclk			(sclk		),//from	top 
.rst_n		(rst_n	),//from	top 
.rx_data	(po_data),//from  U2  
.rx_flag	(po_flag),//from  U2 
.area			(area		), 
.vga_clk	(vga_clk),
.tx_data	(tx_data)//to	U1	
                   
);                 

//vga_clk_module例化
vga_clk_module	U5(
.sclk		(sclk		),
.rst_n	(rst_n	)	,
.vga_clk(vga_clk)	
);

//vga_module例化
vga_module U6(
.sclk			(sclk		),
.rst_n		(rst_n	)	,
.vga_clk	(vga_clk)	,
.dout			(tx_data		),
.h_sync		(h_sync	),
.v_sync		(v_sync	),	
.area			(area		),
.r				(r			)	,
.g				(g			)	,
.b        (b      )
);
endmodule