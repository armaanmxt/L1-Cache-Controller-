module cache_controller (
    input logic clk, 
    input logic rst_n,          //FSM back to IDLE and all VALID bits to 0

    //CPU interface (this is for communicating with the CPU)
    input logic cpu_req_valid,
    output logic cpu_req_ready,
    input logic [31:0] cpu_addr,


)