#pragma once

#include <string>

using namespace std;

// Node of a tree, stores a word
struct Node
{
	// Word stored in this node of the tree
	string word = "";
	// The left branch of the tree
	struct Node * left;
	// The right branch of the tree
	struct Node * right;
	int count = 1;
};
