`timescale 1ns / 1ps

//功能说明
    //NPC_Generator是用来生成Next PC值的模块，根据不同的跳转信号选择不同的新PC值
//输入
    //PCF              旧的PC值
    //JalrTarget       jalr指令的对应的跳转目标
    //BranchTarget     branch指令的对应的跳转目标
    //JalTarget        jal指令的对应的跳转目标
    //BranchE==1       Ex阶段的Branch指令确定跳转
    //JalD==1          ID阶段的Jal指令确定跳转
    //JalrE==1         Ex阶段的Jalr指令确定跳转
//输出
    //PC_In            NPC的值
//实验要求  
    //补全模块  

module NPC_Generator(
    input wire [31:0] PCF,JalrTarget, BranchTarget, JalTarget,
    input wire BranchE,JalD,JalrE,
    output reg [31:0] PC_In,
    // BTB
    input wire BRPredictedF, BRPredictedE,
    input wire [31:0] BRPredictedTargetF, PCE
    );
    
    // 请补全此处代码
    always@(*)
    begin
        //注意这里判断的顺序体现了优先级，EX阶段的优先级高于ID段
        if (JalrE)
            PC_In <= JalrTarget;
        else if(BranchE && ~BRPredictedE) // 预测不跳转，实际跳转 
            PC_In <= BranchTarget;
        else if(~BranchE && BRPredictedE) // 预测跳转，实际不跳转
            PC_In <= PCE + 4;
        else if(JalD) 
            PC_In <= JalTarget;
        else if(BRPredictedF) // 预测即跳转
            PC_In <= BRPredictedTargetF;
        else
            PC_In <= PCF + 4;
    end
    
endmodule
