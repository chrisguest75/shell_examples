#include <iostream>
#include <fstream>
#include <sstream>
#include <chrono>
#include <map>
#include <thread>
#include <iomanip>
#include <unistd.h>
#include <sys/fcntl.h>

std::map<std::string, std::string> parseArgs(int argc, char* argv[]) {
    std::map<std::string, std::string> args;

    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        size_t pos = arg.find('=');
        if (pos == std::string::npos) {
            std::cerr << "Invalid argument: " << arg << std::endl;
            continue;
        }

        std::string key = arg.substr(0, pos);
        std::string value = arg.substr(pos + 1);
        args[key] = value;
    }

    return args;
}

bool fileExists(const std::string& filename)
{
    std::ifstream ifile(filename.c_str());
    return ifile.is_open();
}

int lockFile(std::string filename) {
    std::string type = "lockFile";

    std::cout << type << ":" << filename << std::endl;    

    std::string textToWrite = "Hello, World!";

    int fd = open(filename.c_str(), O_WRONLY | O_CREAT, 0666);
    if (fd == -1) {
        std::cerr << "Unable to open " << filename << std::endl;
        return 1;
    }

    struct flock fl;
    fl.l_type   = F_WRLCK;  // F_RDLCK, F_WRLCK, F_UNLCK
    fl.l_whence = SEEK_SET; // SEEK_SET, SEEK_CUR, SEEK_END
    fl.l_start  = 0;        // Offset from l_whence
    fl.l_len    = 0;        // length, 0 = to EOF
    fl.l_pid    = getpid(); // our PID

    if (fcntl(fd, F_SETLK, &fl) == -1) {
        std::cerr << "Unable to lock " << filename << std::endl;
        close(fd);
        return 1;
    }

    int counter = 0;
    while(true) {
        // Get current time as a time_point
        auto now = std::chrono::system_clock::now();

        // Convert to a time_t
        std::time_t t = std::chrono::system_clock::to_time_t(now);

        // Convert to tm struct
        std::tm* now_tm = std::localtime(&t);

        std::stringstream ss;
        ss << getpid() << " " << std::put_time(now_tm, "%Y-%m-%d %H:%M:%S") << " - " << textToWrite << std::endl;
        std::string strSS = ss.str();  // convert stringstream to string

        write(fd, strSS.c_str(), strSS.size());
        
        std::cout << "Count:" << counter++ << std::endl;
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }

    close(fd);
    return 0;
}

int openFile(std::string filename) {
    std::string type = "openFile";

    std::cout << type << ":" << filename << std::endl;

    std::string textToWrite = "Hello, World!";
    
    if (fileExists(filename)) {
        std::cout << "Error: File already exists!" << std::endl;
    } 
    std::ofstream myfile;
    std::cout << "Open:" << filename << std::endl;
    myfile.open(filename, std::ofstream::out | std::ofstream::app );
    if (myfile.is_open()) {
        int counter = 0;
        while(true) {
            // Get current time as a time_point
            auto now = std::chrono::system_clock::now();

            // Convert to a time_t
            std::time_t t = std::chrono::system_clock::to_time_t(now);

            // Convert to tm struct
            std::tm* now_tm = std::localtime(&t);

            myfile << getpid() << " " << std::put_time(now_tm, "%Y-%m-%d %H:%M:%S") << " - " << textToWrite << std::endl;
            myfile.flush();
            std::cout << "Count:" << counter++ << std::endl;
            std::this_thread::sleep_for(std::chrono::seconds(1));
        }
        myfile.close();
    } else {
        std::cout << "Error: Unable to open file for writing!" << std::endl;
        return 1;
    }

    return 0;
}

int main(int argc, char* argv[]) {
    std::cout << "The process ID is " << getpid() << std::endl;
    std::string filename = "myFile.txt";

    auto args = parseArgs(argc, argv);

    bool showHelp = true;
    for (const auto& pair : args) {
        std::cout << pair.first << " = " << pair.second << std::endl;

        if (pair.first == "test") {
            if (pair.second == "lock") {
                lockFile(filename);
                showHelp = false;
            }
            else if (pair.second == "open") {
                openFile(filename);
                showHelp = false;
            }
        }
    }
    if (showHelp) {
        std::cout << "Usage: " << argv[0] << " test=lock|open" << std::endl;
    }

    return 0;
}

