module cache_controller (
    input logic clk, 
    input logic rst_n,          //FSM back to IDLE and all VALID bits to 0

    //CPU interface (this is for communicating with the CPU)
    input logic cpu_req_valid,    //cpu wants to read something: cpu_req_valid = 1
    output logic cpu_req_ready,   //cache is ready to accept: cpu_req_ready = 1, handshake protocol happens here
    input logic [31:0] cpu_addr,   // cpu is accessing a 32 bit address, which is split apart into offset, index, and tag bits

    output logic cpu_resp_valid,          //cache controller says "hey CPU, i finished the request"
    output logic [31:0] cpu_rdata,         //the actual data word that will be delivered back to the CPU

    //Main memory interface (cache miss)
    output logic         mem_req_valid,     //when we know we have a cache miss, so we know we have to get data from main memory
    output logic [31:0]  mem_req_addr,      // what exact address we need data from in main memory

    input  logic         mem_resp_valid,    //drives this high once it has found the required data
    input  logic [127:0] mem_resp_data
);

    //main cache logic will go here

    // Cache configuration
    localparam int NUM_LINES   = 64;
    localparam int OFFSET_BITS = 4;
    localparam int INDEX_BITS  = 6;
    localparam int TAG_BITS    = 22;

    // Cache storage arrays
    logic [127:0] data_array  [0:63];
    logic [21:0] tag_array   [0:63];
    logic valid_array [0:63];


    // Address decoding
    logic [21:0] addr_tag;
    logic [5:0] addr_index;
    logic [3:0] addr_offset;

    assign addr_tag    = req_addr_q[31:10];
    assign addr_index  = req_addr_q[9:4];
    assign addr_offset = req_addr_q[3:0];


    // Cache hit detection
    logic cache_hit;

    assign cache_hit =
        valid_array[addr_index] &&
        (tag_array[addr_index] == addr_tag);


        // FSM state definitions
typedef enum logic [1:0] {
    IDLE,
    LOOKUP,
    MISS_WAIT,
    REFILL
} state_t;

state_t state, next_state;


// FSM state register
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        state <= IDLE;
    else
        state <= next_state;
end


// CPU request capture
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        req_addr_q <= 32'b0;
    else if (cpu_req_valid && cpu_req_ready)
        req_addr_q <= cpu_addr;
end




endmodule