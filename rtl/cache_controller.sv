localparam int NUM_LINES   = 64;
localparam int OFFSET_BITS = 4;
localparam int INDEX_BITS  = 6;
localparam int TAG_BITS    = 22;

logic [127:0] data_array [0:63];
logic [21:0]  tag_array  [0:63];
logic         valid_array[0:63];