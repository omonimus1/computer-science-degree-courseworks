#include <iostream>
#include <fstream>
#include <string>
#include "BinarySearchTree.h"
#include "Node.h"

string SINGLE_WORDS_FILE_PATH = "single_words_test.txt";
string SENTENCES_FILE_PATH = "sentences_test.txt";

// Read from file and insert the words in the BST 
void read_file(string input_file); 

void read_file(string input_file)
{
	
	ifstream input_file_object;
	input_file_object.open(input_file);
	if (!input_file_object.is_open()) return;
	char ch = ' ';
	string word_from_file = ""; 
	while (input_file_object >> word_from_file)
	{
		 ch = word_from_file.back();
		 if (ch <'A' && ch > 'Z' && ch <'a' && ch > 'z')
			 word_from_file.pop_back();
		 cout << word_from_file;
	}
}


int main(int argc, char **argv)
{

	string input_path = "";
	bool is_set_input_path = false;
	for (int i = 0; i < argc; i++)
	{
		if (argv[i] == SINGLE_WORDS_FILE_PATH || argv[i] == SENTENCES_FILE_PATH)
		{
			input_path = argv[i];
			is_set_input_path = true;
			break;
		}
	}

	if (is_set_input_path)
	{
		read_file(input_path);
	}
	else if (!is_set_input_path)
	{
		cout << "Error"; 
		return 0; 
	}


	return 0;
}


