/*
Davide Pollicino: 40401270
Last modification : 01/03/2019
COursework 1 -> perogramming foundamentals

gitlab: @omonimus
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

const int ARGS = 3;
const char *COMMENT_LINE_SUBSTRING = "//";
const char *EXTERNAL_LIBRARY_SUBSTRING = "#include ";
const char *NO_LIB_NAME_ERR = "error";
const char *DEFINE = "#define";

// Arguments
const char *INPUT_FILE_ARGUMENT = "-i";
const char *COMMENTS_LIST_ARGUMENT = "-c";

// File names
const char *MATH_FUNCTION_FILE_NAME = "math_functions.c";
const char *STRING_FUNCTION_FILE_NAME = "string_functions.c";

// Functions prototypes
void read_file(char *file_path, bool need_comments);
char *get_library_name(char *line);
void count_lines_and_comments(char *file_path);

int main(int argc, char **argv) {
    char *file_path;
    bool isset_input_file_argument = false;
    bool isset_comments_list_argument = false;

    if (argc < ARGS) {
        printf("I'm sorry, you need at least three arguments.\n");
        return -1;
    } else {

        for (size_t i = 0; i < argc; i++) {
            // Check for input file argument
            if (strcmp(argv[i], INPUT_FILE_ARGUMENT) == 0) {
                // Check for input file
                if (strcmp(argv[i+1], MATH_FUNCTION_FILE_NAME) == 0) {
                    file_path = argv[i+1];
                    isset_input_file_argument = true;
                }
                else if (strcmp(argv[i+1], STRING_FUNCTION_FILE_NAME) == 0) {
                    file_path = argv[i+1];
                    isset_input_file_argument = true;
                }
                else {
                    printf("File not found\n");
                    return -1;
                }
            }

            // Check for comments list argument
            if (strcmp(argv[i], COMMENTS_LIST_ARGUMENT) == 0) {
                isset_comments_list_argument = true;
            }  
        }

        if (isset_input_file_argument) {
            printf("Input file found: %s\n", file_path);
        }
		if (!isset_input_file_argument) {
			printf("-i option is compulsary");
		}
        
        if (isset_comments_list_argument) {
            printf("Comments list required\n");
        } else {
            printf("Comments list is not required\n");
        }
        
    }

	count_lines_and_comments(file_path);
    return 0;
}

void read_file(char *file_path, bool need_comments) {
    FILE *source_file = fopen(file_path, "r");
	FILE *output_file;
	//set the output file in base to the input file
	if (strcmp(file_path, "math_functions.c") == 0) {
		output_file = fopen("math_functions.o", "w");
	}
	else {
		output_file = fopen("string_functions.o", "w");
	}
   

    if (source_file != NULL) {
        // Read source content
        char source_line[128];
        while (fgets(source_line, sizeof source_line, source_file) != NULL) {
            if (strstr(source_line, EXTERNAL_LIBRARY_SUBSTRING)) {
                // Read library content
                char *library_name = get_library_name(source_line);

                if(strcmp(library_name, NO_LIB_NAME_ERR) != 0) {
                    FILE *library_file = fopen(library_name, "r");
                    if (library_file != NULL) {
                        char library_line[128];
                        while (fgets(library_line, sizeof library_line, library_file) != NULL) {
                            fprintf(output_file, "%s", library_line);
                        }
                    }
                    fclose(library_file);
                }
            }
            else if (strstr(source_line, COMMENT_LINE_SUBSTRING)) {
                if (need_comments) {
                    fprintf(output_file, "%s", source_line);
                }
            } else {
                fprintf(output_file, "%s", source_line);
            }
        }
    }
	
	//close the stream to the files
    fclose(output_file);
    fclose(source_file);
}

char *get_library_name(char *line) {
    int init_size = strlen(line);
    char delimitators[] = "\"";
    char *library_name = strtok(line, delimitators);
    while (library_name != NULL) {
        if(strcmp(library_name, EXTERNAL_LIBRARY_SUBSTRING) == 0) {
            library_name = strtok(NULL, delimitators);
        } else {
            return library_name;
        }
    }

    return 0;
}


void count_lines_and_comments(char *file_path) {
	unsigned short int number_of_lines = 0;
	unsigned short int number_of_comments = 0;
	char currentLine[200];

	FILE *file;
	char ch;
	file = fopen(file_path, "r");

	//count number of non-blank lines
	while (fgets(currentLine, 200, file)){
		int length = strlen(currentLine);
		for (unsigned short int i = 0; i < length; i++) {
			if (currentLine[i] != '\n' && currentLine[i] != '\t' && currentLine[i] != ' ') {
				number_of_lines++;
				break;
			}
		}
	}
	//reset the pointer to the file
	fseek(file, 0, 0);

	//count number of single comment -> lines that start with '//'
	while ((ch = fgetc(file))!= EOF)
	{
		if (ch == '/')
		{
			if ((ch = fgetc(file)) == '/')
			{
				number_of_comments++;
			}
		}
	}
	printf("Total no of lines: %d\n", number_of_lines);
	printf("Total no of comment line: %d\n", number_of_comments);
	fclose(file);
}

