#include <stdio.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string>
#include <sstream>
#include <iostream>
#include <functional>
#include <tuple>

using PREPLCallback = int(const std::string&, std::stringstream& ss);
using REPLCallback = std::function<PREPLCallback>;
class REPL
{
public:
	REPL() : in(std::cin), out(std::cout) { }
	REPL(std::istream& in, std::ostream& out) : in(in), out(out) { }

	void run(REPLCallback f)
	{
		std::stringstream ss;
		while (true) 
		{
			out << "db> ";

			ss.str("");
			ss.clear();
			
			auto str = read_input();
			auto status = f(str, ss);
			if (status > 0)
				return exit(status);
			else if (status < 0)
				break;

			out << ss.str() << std::endl;
		}
	}
private:
	std::istream& in;
	std::ostream& out;

	std::string read_input() 
	{
		std::string str;
		std::getline(in, str);
		if (str.size() <= 0)
		{
			out << "Error reading input." << std::endl;
			exit(EXIT_FAILURE);
		}
		return str;
	}
};


int main(int argc, char* argv[]) 
{
	REPL repl;
	repl.run([](auto str, auto& ss) {
		if (str == ".exit") return -1;
		else 
		{
			ss << "Unrecognized command [" << str << "]";
			return 0;
		}
	});
	exit(EXIT_SUCCESS);
	return 0;
}