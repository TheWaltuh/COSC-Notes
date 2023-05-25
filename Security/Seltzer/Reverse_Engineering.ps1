###############################################################################################################################################################################

                                                                                #Reverse Engineering#

###############################################################################################################################################################################

#X86_64 Assembly
    #16 general purpose 64-Bit registers
        %rax        #return the first register
        %rbp        #the base pointer that keeps track of the base of the stack
        %rsp        #the stack pointer that points to the top of the stack
    #Common Terms
        HEAP                      #Memory that can be allocated and deallocated
        STACK                     #A contiguous section of memory used for passing arguments
        GENERAL REGISTER          #A multipurpose register that can be used by either programmer or user to store data or a memory location address
        CONTROL REGISTER          #A processor register that changes or controls the behavior of a CPU
        FLAGS REGISTER            #Contains the current state of the processor
    #Memory Offset
        #there is one instruction pointer register that points to the memory offset of the next insruction in the code segment:
            64-BIT      Lower 32 bits     Lower 16 bits       Description
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            RIP         EIP               IP                  Instruction Pointer; holds address for next instruction to be executed
    #Common Instruction Pointers
        MOV               #move source to destination
        PUSH              #push source onto stack
        POP               #Pop top of stack to destination
        INC               #Increment source by 1
        DEC               #Decrement source by 1
        ADD               #Add source to destination
        SUB               #Subtract source from destination
        CMP               #Compare 2 values by subtracting them and setting the %RFLAGS register. ZeroFlag set means they are the same
        JMP               #Jump to specified location
        JLE               #Jump if less than or equal
        JE                #Jump if equal

#Reverse Engineering Workflow
    #Static
        #Determine File Type
        #Determine if file is packed/compressex (UPX)
        #Find plain text ascii and unicode strings
        #View imports/exports to get a hint of functionality/calls
        #look for encrypted sections of the binary
    #Behavorial
        #Take a snapshot of the analysis environment - Important! Taking a snapshot on an OpenStack VM takes a substantial amount of time
        #Take a snapshot of critical configurations of the analysis environment. (Things like the registry, important directories, etc)
        #Launch realtime analysis tools (Things like procmon and fakenet)
        #Execute and interact with the object/binary while taking note of observations
        #Stop the binary and view how it affected critical configurations (registry, files, etc) by comparing to previous snapshots
        #Analyze results of realtime analysis tools (did fakenet catch network calls, did procmon show it writing to a file, etc)
    #Dynamic
        #Execute binary in a debugger
        #Step through binary, setting breakpoints as approriate
        #Continuously rerun the binary and edit it’s parameters through the debugger, as you learn more about how it works
        #Document all observations and modifications
    #Disassembly
        #Disassemble binary in IDA, Ghidra, or other disassembler
        #Use notes to find artifacts within the disassembly
        #Find a good spot to work from within the binary. Then quickly browse from the top to the bottom of the disassembly to view the overall flow of the disassembly
        #Rename variables and functions as appropriate when quickly scanning top to bottom of the disassembly
        #Work your way from the bottom to the top - if there are two outcomes choose the one you want to end at, then work your way up from there to determine what needs to happen for the program to flow to the desired outcome
    #Document Finding
        #Document all discovered binary traits, capabilities, and behaviors to include the conditions they must run under
        #Document potential uses for the binary
        #Create mitigations for the binary if it is malicious
        #Create signatures and indicators of compromise to detect the binary in the future
        #Document and save the tools, scripts, code, methods used to analyze the software to better analyze related software in the future
        #Document proof of concept for exploitation of the binary if it is found to be vulnerable and a potential target. For example, if the binary is running on an adversary network, or if a friendly network may be using the binary

#Poertable Executable Patching / Software Analysis
    #Perform DEBUGGING and DISASSEMBLY
    #Find the SUCCESS/FAILURE
    #Adjust INSTRUCTIONS
    #Apply Patch and Save
    #Execute Patched Binary


























