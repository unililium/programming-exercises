#include <linenoise.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
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
    void handle_command(const std::string&);
};

void debugger::run() {
    int wait_status;
    auto options = 0;
    waitpid(m_pid, &wait_status, options);

    char* line = nullptr;
    while ((line = linenoise("minidbg> ")) != nullptr) {
        handle_command(line);
        linenoiseHistoryAdd(line);
        linenoiseFree(line);
    }
}

void debugger::handle_command(const std::string& line) {}

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
