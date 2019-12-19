//Davide Pollicino -> 40401270
// 08/03/2019

#pragma once

#include "BinarySearchTree.h"
#include "Node.h"
#include <string>
#include <vector>
#include <fstream>
#include <iostream>


using namespace std;

string inorder();

// **Constructors **
struct Node* tree;

//words us is the name if the vector of strings

/*1. Make a binary search tree object.
2. Extract a word from the input file.
3. Check if that word exists in the binary search tree. If not, add it to the
tree and set the count field of the tree to 1. If the word already exists
in the tree, add one to the count field of the tree in which it occurs.
*/


BinarySearchTree::BinarySearchTree()
{
	Node *tree = new Node;
	return *tree;
}

BinarySearchTree::BinarySearchTree(string word)
{
	//create a binary search tree with an itial word to store. 
	tree * tree = new tree;
	tree->left = nullptr;
	tree->right = nullptr;
	tree->data = word;
}


tree* copyTree_helper(const tree *source)
{
	//source = root
	if (source == nullptr)
	{
		return nullptr;
	}
	
	tree->data = source->data;
	tree->left = copyTree_helper(source->left);
	tree->right = copyTree_helper(source->right);
	return result;
}

BinarySearchTree::BinarySearchTree(const BinarySearchTree &rhs)
{
	: root(copyTree_helper(rhs.root))
}

BinarySearchTree::BinarySearchTree(const vector<string> &words)
{
	//create a BST from a vector of words
	for (size_t i = 0; i < words.size(); i++)
		insert(words);
}


//destructor for a BST. It releases the memory occupied by all its tree
BinarySearchTree::~BinarySearchTree()
{
	DestroyRecursive(root);
}

void BinarySearchTree::DestroyRecursive(Node * tree)
{
	if (tree)
	{
		DestroyRecursive(tree->left);
		DestroyRecursive(tree->right);
		delete tree;
	}

}

// **Methods**





bool exists(string word)
{
	if (root == NULL) return false;
	else if (word == root->data) return true;
	else if (word < root->data) return exists_helper(word, tree->left);
	else return exists_helper(word, tree->right);
}


bool exists_helper(string word, tree *root)
{
	//write your code here to search through the tree for word

	if (root == nullptr)
	{

		root = new tree;
		tree->data = word;
		tree->left = tree->right = nullptr;
	}
	else
	{
		if (word < tree->*data)
			exists_helper(word, tree->left);
		else if (word > tree->data)
			exists_helper(word, tree->right);
		//we return if the new word to insert is equals to the data in the tree
		//and we don't have to insert it
		else
			//This is for count the accurency of the word in the file
			this->count++;

		//return true or false??????and where

	}
}
void insert(string word)
{
	//The for allows us to fiter the string, reading "language!", or "language_?" just as language. 
	/*Duble check the .size, we could have a problem, because it returns the size of the vector.
	*/

	//debugging
	cout << word.size() << endl;
	for (int i = 0; i < word.size(); ++i)
	{
		if (!((word[i] >= 'a' && word[i] <= 'z') || (word[i] >= 'A' && word[i] <= 'Z')))
		{
			word[i] = '\0';
		}
	}

	if (root == nullptr)
	{

		root = new tree;
		tree->data = word;
		tree->left = tree->right = nullptr;
	}
	else
	{
		if (word < tree->data)
			insert(tree->left, word);
		else if (word > tree->data)
			insert(tree->right, word);
		//we return if the new word to insert is equals to the data in the tree 
		//and we don't have to insert it
		else
			//This is for count the accurency of the word in the file
			tree->count++;
	}
}

string inorder() const
{
	if (tree == NULL)      //check, and eventually swap it with nullptr;
		return;
	inorder(this->left);
	cout << this->data << " : " << this->count << endl;
	inorder(this->right);

	return string(""); // change this to return a string representation of the words
	// in the tree inorder.
}

void read_file()
{
	//Read from single_word.txt and insert into the binary search tree
	string word = " ";
	ifstream in;
	in.open("single_words_test.txt");
	if (!in) {
		cout << "Unable to open file";
		exit(1); // terminate with error
	}
	while (in >> word) {
		exists(word);
	}
}


string BinarySearchTree::preorder() const
{

	if (tree == NULL)
		return 0;
	cout << this->data << " :  " << this->count << endl;
	preorder(this->left);
	preorder(this->right);

	//Gnerates a string containing the words in the tree in pre-order fashion
	return string(""); // change this to return a string representation of the words
	// in the tree preorder.
}


string BinarySearchTree::postorder() const
{
	if (tree == NULL)
		return 0;
	postorder(this->right);
	postorder(this->left);
	cout << this->data << " : " << this->count << endl;

	//Gnerates a string containing the words in the tree in pre-order fashion
	return string(""); // change this to return a string representation of the words
	// in the tree postorder.
}

// **Operator overloads**

BinarySearchTree& BinarySearchTree::operator+(string word)
{
	this->tree = tree;

	//insert a new word into the binary three
	return *this; // returns a reference to the modified tree
}

BinarySearchTree& BinarySearchTree::operator=(const BinarySearchTree &rhs)
{
	//it deteles the trees in tree, freeing memory, and then make deep copies of all
	//the trees in tree 2
	return *this;
}


