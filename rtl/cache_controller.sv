module cache_controller (
    input logic clk, 
    input logic rst_n,          //FSM back to IDLE and all VALID bits to 0

    //CPU interface (this is for communicating with the CPU)
    input logic cpu_req_valid,    //cpu wants to read something: cpu_req_valid = 1
    output logic cpu_req_ready,   //cache is ready to accept: cpu_req_ready = 1
    input logic [31:0] cpu_addr,   // cpu is accessing a 32 bit address, which is split apart into offset, index, and tag bits

    output logic cpu_resp_valid,
    output logic cpu_rdata,         //

    //Main memory interface (cache miss)
    output logic         mem_req_valid,
    output logic [31:0]  mem_req_addr,

    input  logic         mem_resp_valid,
    input  logic [127:0] mem_resp_data
);

    //main cache logic will go here

    

endmodule