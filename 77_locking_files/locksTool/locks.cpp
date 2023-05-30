#include <iostream>
#include <fstream>
#include <chrono>
#include <thread>
#include <iomanip>
#include <unistd.h>

bool fileExists(const std::string& filename)
{
    std::ifstream ifile(filename.c_str());
    return ifile.is_open();
}

int main() {
    std::string filename = "myFile.txt";
    std::string textToWrite = "Hello, World!";
    
    std::cout << "The process ID is " << getpid() << std::endl;

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

/*
int main() {
    std::string filename = "example.txt";
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

    // Now we can safely write to the file
    std::string textToWrite = "Hello, World!\n";
    write(fd, textToWrite.c_str(), textToWrite.size());

    close(fd);
    return 0;
}
*/