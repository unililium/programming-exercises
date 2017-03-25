#include <sys/ptrace.h>
#include <unistd.h>
#include <cstring>
#include <iostream>
#include <string>

class debugger {
   public:
    debugger(std::string prog_name, pid_t pid)
        : m_prog_name{std::move(prog_name)}, m_pid{pid} {}

    void run();

   private:
    std::string m_prog_name;
    pid_t m_pid;
};

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Program name not specified";
        return -1;
    }

    std::string prog = argv[1];

    auto pid = fork();
    if (pid == 0) {
        ptrace(PTRACE_TRACEME, 0, nullptr, nullptr);
        execl(prog.c_str(), prog.c_str(), nullptr);
    } else if (pid >= 1) {
        debugger dbg(prog, pid);
        dbg.run();
    }
}
